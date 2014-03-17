import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.nathanosman.twobuntu-app"
    width: units.gu(40)
    height: units.gu(75)

    backgroundColor: "#a55263"

    /* Contains the articles to be displayed */
    ListModel {
        id: articles
    }

    /* Controls the display of articles in the list */
    Component {
        id: articleDelegate

        Item {
            width: parent.width
            height: childrenRect.height

            Column {
                width: parent.width
                spacing: units.gu(1)

                Text {
                    width: parent.width
                    color: "white"
                    font.pixelSize: FontUtils.sizeToPixels("large")
                    elide: Text.ElideRight
                    text: title
                }

                Text {
                    width: parent.width
                    color: "white"
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignJustify
                    maximumLineCount: 3
                    wrapMode: Text.WordWrap
                    text: body.replace(/<(?:.|\n)*?>/g, '').replace(/\n+/g, ' ')
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    articleViewPage.title = title;
                    articleBody.text = body;
                    pageStack.push(articleViewPage);
                }
            }
        }
    }

    /* Contains the pages displayed in the app */
    PageStack {
        id: pageStack
        Component.onCompleted: {
            push(articleListPage);
            refreshArticles();
        }

        /* Initial page displayed at startup */
        Page {
            id: articleListPage
            title: i18n.tr("2buntu")
            visible: false

            ListView {
                anchors.fill: parent
                anchors.margins: units.gu(2)
                model: articles
                delegate: articleDelegate
                spacing: units.gu(3)
            }
        }

        /* Article detail page */
        Page {
            id: articleViewPage
            visible: false

            Flickable {
                anchors.fill: parent
                anchors.margins: units.gu(2)
                contentHeight: childrenRect.height

                Text {
                    id: articleBody
                    width: parent.width
                    color: "white"
                    horizontalAlignment: Text.AlignJustify
                    wrapMode: Text.WordWrap
                }
            }
        }
    }

    /* Refreshes the list of articles */
    function refreshArticles() {
        var req = new XMLHttpRequest();
        req.open('GET', 'http://2buntu.com/api/1.1/articles/published/');
        req.onreadystatechange = function() {
            if(req.readyState === XMLHttpRequest.DONE) {
                articles.clear();
                var new_articles = JSON.parse(req.responseText);
                for(var i=0; i<new_articles.length; ++i)
                    articles.append(new_articles[i]);
            }
        };
        req.send();
    }
}
