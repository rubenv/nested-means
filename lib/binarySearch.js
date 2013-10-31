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
