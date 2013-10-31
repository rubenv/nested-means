assert = require 'assert'

binarySearch = require '../lib/binarySearch'

describe 'Binary search', ->
    it 'Throws an error on empty arrays', ->
        error = "no data supplied"
        assert.throws (-> binarySearch()), error
        assert.throws (-> binarySearch([])), error

    it 'Returns index for match', ->
        assert.equal(binarySearch([1], 1), 0)
        assert.equal(binarySearch([1, 2], 2), 1)
        assert.equal(binarySearch([1, 1, 1, 2, 3], 2), 3)

    it 'Returns the middle index for repeated matches', ->
        assert.equal(binarySearch([1, 2, 2, 2, 3], 2), 2)

    it 'Returns the higher index when no match is found', ->
        assert.equal(binarySearch([1, 2], 3), 2)
        assert.equal(binarySearch([1, 3, 5], 2), 1)
        assert.equal(binarySearch([1, 1, 1, 3, 3], 2), 3)
        assert.equal(binarySearch([1, 1, 1, 3, 3], 8), 5)
