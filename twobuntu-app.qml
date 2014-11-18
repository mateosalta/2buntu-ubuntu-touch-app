import QtQuick 2.1
import Ubuntu.Components 1.1

import "articledb.js" as ArticleDB

MainView {
    objectName: "twobuntu"
    applicationName: "com.ubuntu.developer.nathanosman.twobuntu-app"

    width: units.gu(50)
    height: units.gu(75)

    backgroundColor: "#f5f5f5"

    // Model used for accessing all of the recent articles
    // that are retrieved when the application loads
    ListModel {
        id: articleList
        property bool loaded: false
        property bool refreshing: false

        // Load the articles and populate the model
        function refresh() {
            if(loaded)
                refreshing = true;
            ArticleDB.fetchArticles(function(articles) {
                clear();
                for(var i=0; i<articles.length; ++i)
                    append(articles[i]);
                loaded = true;
                refreshing = false;
            });
        }

        // Refresh at startup
        Component.onCompleted: {
            refresh();
        }
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
