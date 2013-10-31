module.exports = function (nestedMeans) {
    return function (splits) {
        var lg = Math.log(splits) / Math.log(2);
        if (lg !== Math.round(lg)) {
            throw new Error("splits should be a power of two");
        }

        var ranges = [];
        var output = [];
        var range;

        function scale(x) {
            var category = ranges.length;
            while (category > 0) {
                if (x < ranges[category] && x >= ranges[category - 1]) {
                    return range[category - 1];
                }
                category -= 1;
            }
            return range[category];
        }

        scale.range = function (x) {
            if (!arguments.length) {
                return range;
            }

            if (x.length !== splits) {
                throw new Error("The number of elements in the range should equal the number of splits");
            }

            range = x;
            return scale;
        };

        scale.domain = function (x) {
            if (!arguments.length) {
                return ranges;
            }

            ranges = nestedMeans(x, splits);
            return scale;
        };

        return scale;
    };
};
