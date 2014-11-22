/**
 * 2buntu Article Database Manager
 * Copyright 2014 - Nathan Osman
 */

.pragma library

// TODO: cache articles in a local SQLite database for extra win
// TODO: better error checking

// Retrieve up to twenty articles at a time from the API
// - if before is NOT provided, clear the list and append the articles
// - if before IS provided, then simply append the new articles
// - set the "loading" property to true while the request is in progress
function loadArticles(articleList, before) {

    // Build the URL and open the request
    var max = before || parseInt(Date.now() / 1000),
        url = 'http://2buntu.com/api/1.2/articles?max=' + max,
        req = new XMLHttpRequest();
    req.open('GET', url);
    req.setRequestHeader('X-Application-Version', '0.2.3');

    // When complete, add the items to the list
    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {

            // Clear existing articles if before wasn't provided
            if(!before)
                articleList.clear();

            // Add all of the new items to the list
            var articles = JSON.parse(req.responseText);
            for(var i=0; i<articles.length; ++i)
                articleList.append(articles[i]);

            // Loading has completed
            articleList.loading = false;
        }
    }

    // Send the request and indicate that we are loading data...
    req.send();
    articleList.loading = true;
}
