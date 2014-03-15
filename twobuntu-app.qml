import QtQuick 2.0
import Ubuntu.Components 0.1

MainView {
    objectName: "mainView"
    applicationName: "com.ubuntu.developer.nathanosman.twobuntu-app"
    width: units.gu(40)
    height: units.gu(75)

    ListModel {
        id: articles

        ListElement {
            title: "Gnome 4 Is Here"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "Hands-on with Ubuntu Touch Emulator"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "Office 2014 for Linux?"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "Unity 9 Seen in the Wild"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "User @iospwn Runs iOS on Nexus 5"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "Nvidia to Support Mir"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
        ListElement {
            title: "What's New in OpenGL 5"
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent ullamcorper ante non tincidunt volutpat. Fusce nulla risus, mollis non eros id, condimentum scelerisque dolor. Nullam vehicula gravida risus vel commodo. Aliquam at felis at lacus varius feugiat. Curabitur laoreet metus quam. Donec eu suscipit sem. Vivamus at lectus tristique, adipiscing purus eu, luctus risus. Donec varius, neque in malesuada pulvinar, neque metus bibendum sem, in mattis sem lorem tempus quam."
        }
    }

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
                    font.pixelSize: FontUtils.sizeToPixels("large")
                    elide: Text.ElideRight
                    text: title
                }
                Text {
                    width: parent.width
                    elide: Text.ElideRight
                    horizontalAlignment: Text.AlignJustify
                    maximumLineCount: 3
                    wrapMode: Text.WordWrap
                    text: body
                }
            }
        }
    }

    Page {
        title: i18n.tr("2buntu")

        ListView {
            anchors.fill: parent
            anchors.margins: units.gu(2)
            model: articles
            delegate: articleDelegate
            spacing: units.gu(2)
        }
    }
}
