import QtQuick 2.2
import Ubuntu.Components 1.1

import "articledb.js" as ArticleDB

MainView {
    objectName: "twobuntu"
    applicationName: "com.ubuntu.developer.nathanosman.twobuntu-app"
    useDeprecatedToolbar: false

    width: units.gu(50)
    height: units.gu(75)

    backgroundColor: "#f5f5f5"

    // Model used for accessing all of the recent articles
    // that are retrieved when the application loads
    ListModel {
        id: articleList

        // True if data has been loaded into the list for the first time
        property bool loading: true

        // Refresh the articles in the list
        function refresh() {
            ArticleDB.loadArticles(articleList);
        }

        // Load more articles
        function loadMore() {
            var lastTimestamp = articleList.get(articleList.count - 1).date;
            ArticleDB.loadArticles(articleList, lastTimestamp - 1);
        }

        // Refresh at startup
        Component.onCompleted: refresh()
    }

    // List of pages
    PageStack {
        id: pageStack
        Component.onCompleted: push(articleListPage)

        ArticleListPage {
            id: articleListPage
            articleModel: articleList

            // When an article is selected, open the article view page
            onArticleSelected: {
                articleViewPage.articleIndex = index;
                pageStack.push(articleViewPage);
            }
        }

        ArticleViewPage {
            id: articleViewPage
            articleModel: articleList
        }
    }
}
