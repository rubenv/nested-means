require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// Returns the index of the middle element that's greater then or equal to the
// given value.
//
// Assumes that the data array is sorted!
module.exports = function (data, value) {
    if (!data || !data.length) {
        throw new Error("no data supplied");
    }

    var min = 0;
    var max = data.length - 1;
    var current = 0;
    var el;

    while (min <= max) {
        current = (min + max) / 2 | 0; 
        el = data[current];

        if (el === value) {
            return current;
        } else if (el < value) {
            min = current + 1;
        } else if (el > value) {
            max = current - 1;
        }
    }

    return current + (el > value ? 0 : 1);
};

},{}],"THm4GM":[function(require,module,exports){
var isArray = Array.isArray || function (obj) {
    return Object.prototype.toString.call(obj) === '[object Array]';
};

var binarySearch = require('./binarySearch');

var mean = function (data) {
    var sum = 0;
    for (var i = 0; i < data.length; i++) {
        sum += data[i];
    }
    return sum / data.length;
};

var splitVals = function (data, splits) {
    if (splits === 0 || data.length === 0) {
        return [];
    }

    var meanVal = mean(data);
    var split = binarySearch(data, meanVal);

    while (data[split] === meanVal) {
        split += 1;
    }

    var below = data.slice(0, split);
    var above = data.slice(split);

    return splitVals(below, splits - 1).concat([meanVal]).concat(splitVals(above, splits - 1));
};

var nestedMeans = function (data, ranges) {
    // Check parameters
    if (!isArray(data)) {
        throw new Error("data should be an array!");
    }

    var lg = Math.log(ranges) / Math.log(2);
    if (lg !== Math.round(lg)) {
        throw new Error("ranges should be a power of two");
    }

    // Handle edge cases
    if (data.length === 0 || ranges === 0) {
        return [];
    }

    // Sort the array
    data.sort();

    return [data[0]].concat(splitVals(data, lg)).concat(data[data.length - 1] + 1);
};

nestedMeans.rounded = function (data, ranges) {
    var result = [];
    var calculated = nestedMeans(data, ranges);
    for (var i = 0; i < calculated.length; i++) {
        result.push(Math.floor(calculated[i]));
    }
    return result;
};

module.exports = nestedMeans;

},{"./binarySearch":1}],"nested-means":[function(require,module,exports){
module.exports=require('THm4GM');
},{}]},{},["THm4GM"])
;