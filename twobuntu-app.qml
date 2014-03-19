import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.Extras.Browser 0.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.nathanosman.twobuntu-app"
    width: units.gu(40)
    height: units.gu(75)

    backgroundColor: "#a55263"

    /* Contains the articles to be displayed */
    ListModel { id: articleList }

    /* Controls the display of articles in the list */
    Component {
        id: articleListDelegate

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
                    text: body.replace(/<(?:.|\n)*?>/g, '').replace(/\n+/g, ' ')
                    wrapMode: Text.WordWrap
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    articleViewPage.title = title;
                    articleView.loadHtml('<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">' +
                                         '<style>html { color: white; font-family: Ubuntu; margin: ' + units.gu(1) +
                                         '; text-align: justify} img { max-width: 100% }</style>' + body,
                                         'http://2buntu.com/');
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
                model: articleList
                delegate: articleListDelegate
                spacing: units.gu(3)
            }
        }

        /* Article detail page */
        Page {
            id: articleViewPage
            visible: false

            UbuntuWebView {
                id: articleView
                anchors.fill: parent
                experimental.transparentBackground: true
            }
        }
    }

    /* Refreshes the list of articles */
    function refreshArticles() {
        var req = new XMLHttpRequest();
        req.open('GET', 'http://2buntu.com/api/1.1/articles/published/');
        req.onreadystatechange = function() {
            if(req.readyState === XMLHttpRequest.DONE) {
                articleList.clear();
                var new_articles = JSON.parse(req.responseText);
                for(var i=0; i<new_articles.length; ++i)
                    articleList.append(new_articles[i]);
            }
        };
        req.send();
    }
}
