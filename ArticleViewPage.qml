import QtQuick 2.1
import Ubuntu.Components 1.1

Page {
    visible: false

    // This will need to be specified when the page is instantiated
    property ListModel articleModel

    // The specified index is retrieved from the model and displayed
    // when this property's value is changed
    property int articleIndex: -1
    onArticleIndexChanged: {
        var article = articleModel.get(articleIndex);
        title = article.title;
        articleBody.text = article.body;
        flickable.contentY = 0;
    }

    Flickable {
        id: flickable
        anchors.fill: parent
        contentWidth: parent.width
        contentHeight: articleBody.height

        // Text supports HTML formatting, so we'll use it for now
        Text {
            id: articleBody
            anchors.left: parent.left
            anchors.margins: units.gu(2)
            anchors.right: parent.right
            color: "#555555"
            horizontalAlignment: Text.AlignJustify
            verticalAlignment: Text.AlignTop
            wrapMode: Text.WordWrap
        }
    }
}
