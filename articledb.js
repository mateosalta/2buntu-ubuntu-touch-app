/**
 * 2buntu Article Database Manager
 * Copyright 2014 - Nathan Osman
 */

.pragma library

// TODO: cache articles in a local SQLite database for extra win

// Retrieves all recent articles from the API
function fetchArticles(callback) {

    // Recent articles can be fetched from the /articles endpoint
    var req = new XMLHttpRequest();
    req.open('GET', 'http://2buntu.com/api/1.2/articles');

    // When complete, invoke the callback with the articles
    req.onreadystatechange = function() {
        if(req.readyState === XMLHttpRequest.DONE) {
            var articles = JSON.parse(req.responseText);
            callback(articles);
        }
    }

    // Send the request - no fancy headers or anything needed!
    req.send();
}
