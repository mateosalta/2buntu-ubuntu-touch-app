import QtQuick 2.2
import Ubuntu.Components 1.1
import Ubuntu.Components.Themes 0.1
import Ubuntu.Web 0.2

Page {
    visible: false

    // This will need to be specified when the page is instantiated
    property ListModel articleModel

    // The specified index is retrieved from the model and displayed
    // when this property's value is changed
    property int articleIndex: -1

    onArticleIndexChanged: {

        // Obtain the article from the model
        var article = articleModel.get(articleIndex);

        // Set the title to that of the article
        title = article.title;

        // Build the long string of HTML (eek!) and insert it into the WebView
        articleBody.loadHtml(
            '<!DOCTYPE html>' +
            '<html>' +
              '<head>' +
                '<meta charset="utf-8">' +
                '<meta name="viewport" content="width=' + articleBody.width + '">' +
                '<style>' +
                  'body {' +
                    'background-color: ' + Theme.palette.normal.background + ';' +
                    'color: ' + Theme.palette.selected.backgroundText + ';' +
                    'font-family: "Ubuntu Light";' +
                    'font-size: ' + FontUtils.sizeToPixels('medium') + 'px;' +
                    'font-weight: 100;' +
                  '}' +
                  'code, pre { white-space: pre-wrap; word-wrap: break-word; }' +
                  'img { display: block; margin: auto; max-width: 100%; }' +
                  'p { text-align: justify; }' +
                '</style>' +
              '</head>' +
              '<body>' +
                article.body +
              '</body>' +
            '</html>'
        );
    }

    WebView {
        id: articleBody
        anchors.fill: parent
    }
}
