assert = require 'assert'

nestedMeans = require '..'

describe 'Scale', ->
    it 'Exports a function', ->
        assert.equal(typeof nestedMeans.scale, 'function')
        assert.equal(typeof nestedMeans.scaleRounded, 'function')

    it 'Correctly maps values', ->
        scale = nestedMeans.scale(4)
            .range(["a", "b", "c", "d"])
            .domain([1, 2, 3, 4])

        assert.equal(scale(4), "d")
        assert.equal(scale(3), "c")
        assert.equal(scale(2), "b")
        assert.equal(scale(1), "a")

    it 'Maps long ranges', ->
        scale = nestedMeans.scaleRounded(4)
            .range(["a", "b", "c", "d"])
            .domain([1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3])

        assert.equal(scale(3), "d")
        assert.equal(scale(1), "b")

    it 'Maps repeated items', ->
        scale = nestedMeans.scaleRounded(2)
            .range(["a", "b"])
            .domain([1, 1, 1])

        assert.equal(scale(1), "b")
