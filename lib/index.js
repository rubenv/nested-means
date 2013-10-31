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

    return [data[0]].concat(splitVals(data, lg)).concat(data[data.length - 1]);
};

nestedMeans.rounded = function (data, ranges) {
    var result = [];
    var calculated = nestedMeans(data, ranges);
    for (var i = 0; i < data.length; i++) {
        result.push(Math.floor(calculated[i]));
    }
    return result;
};

module.exports = nestedMeans;
