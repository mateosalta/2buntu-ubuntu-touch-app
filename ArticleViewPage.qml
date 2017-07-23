import QtQuick 2.4
import com.canonical.Oxide 1.19 as Oxide
import Ubuntu.Components 1.3
import Ubuntu.Components.Themes 1.3

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

        // TODO: Oxide exposes a lot of this stuff, so we may not
        // need all of the CSS injection.

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
                    'margin: 25px;'  +
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

    Oxide.WebView {
        id: articleBody
        anchors.fill: parent

        // Ignore any navigation and instead open the browser
        onNavigationRequested: {
            request.action = Oxide.NavigationRequest.ActionReject;
            Qt.openUrlExternally(request.url);
        }
    }
}
