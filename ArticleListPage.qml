import QtQuick 2.1
import Ubuntu.Components 1.1

Page {
    title: i18n.tr("2buntu Articles")
    visible: false

    // These will need to be specified when the page is instantiated
    property ListModel articleModel
    signal articleSelected(int index)

    // Progress indicator displayed while articles load
    ActivityIndicator {
        id: loadingIndicator
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        running: !articleModel.loaded
        visible: running
    }

    Component {
        id: articleListDelegate

        Item {
            width: parent.width
            height: childrenRect.height
            
            // Display the image to the left of the title and content
            Row {
                width: parent.width
                spacing: units.gu(1)

                // Display the author's Gravatar
                UbuntuShape {
                    id: authorGravatar
                    radius: 'medium'

                    image: Image {
                        source: 'http://gravatar.com/avatar/' + author.email_hash + '?s=128'
                    }
                }
                
                // Display the title and content stacked vertically
                Column {
                    width: parent.width - units.gu(1) - authorGravatar.width
                    spacing: units.gu(1)

                    Text {
                        width: parent.width
                        color: "#555555"
                        font.pixelSize: FontUtils.sizeToPixels("large")
                        elide: Text.ElideRight
                        text: title
                    }

                    // Attempt to strip out anything looking like an HTML tag from the body...
                    // It would sure be nice to have a striphtml() method
                    Text {
                        width: parent.width
                        color: "#555555"
                        font.pixelSize: FontUtils.sizeToPixels("small")
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignJustify
                        maximumLineCount: 2
                        text: body.replace(/<(?:.|\n)*?>/g, '').replace(/\n+/g, ' ')
                        textFormat: Text.PlainText
                        wrapMode: Text.WordWrap
                    }
                }
            }

            // Mouse area to register clicks on articles
            MouseArea {
                anchors.fill: parent
                onClicked: articleSelected(index)
            }
        }
    }

    // The list view that actually displays the articles
    ListView {
        anchors.fill: parent
        anchors.margins: units.gu(2)
        model: articleModel
        delegate: articleListDelegate
        spacing: units.gu(3)
    }
}
