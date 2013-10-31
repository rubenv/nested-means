assert = require 'assert'

nestedMeans = require '..'

describe 'Nested means', ->
    it 'Exports a function', ->
        assert.equal(typeof nestedMeans, 'function')

    it 'Requires an array to be passed', ->
        error = "data should be an array!"
        assert.throws (-> nestedMeans()), error
        assert.throws (-> nestedMeans(null)), error
        assert.throws (-> nestedMeans({})), error
        assert.throws (-> nestedMeans(3)), error
        assert.throws (-> nestedMeans("test")), error

    it 'Ranges parameter should be a power of two', ->
        error = "ranges should be a power of two"
        assert.throws (-> nestedMeans([])), error
        assert.throws (-> nestedMeans([], 3)), error
        assert.throws (-> nestedMeans([], 15)), error

    it 'Accepts empty arrays', ->
        assert.deepEqual(nestedMeans([], 0), [])
        assert.deepEqual(nestedMeans([], 2), [])
        assert.deepEqual(nestedMeans([], 16), [])

    it 'Accepts a ranges parameter of 1', ->
        assert.deepEqual(nestedMeans([], 1), [])

    it 'Calculates a correct range for 0', ->
        assert.deepEqual(nestedMeans([1, 2, 3], 0), [])

    it 'Calculates a correct range for 1', ->
        assert.deepEqual(nestedMeans([1, 2, 3], 1), [1, 4])

    it 'Calculates a degenerate range for 1-length data', ->
        assert.deepEqual(nestedMeans([1], 1), [1, 2])

    it 'Calculates a correct range for 2', ->
        assert.deepEqual(nestedMeans([1, 2, 3], 2), [1, 2, 4])

    it 'Calculates a correct range for 4', ->
        assert.deepEqual(nestedMeans([1, 2, 3, 4, 5], 4), [1, 2, 3, 4.5, 6])

    it 'Calculates ranges for repeated items', ->
        assert.deepEqual(nestedMeans([1, 1, 1], 2), [1, 1, 2])

    it 'Maps a long range', ->
        assert.deepEqual(nestedMeans([1, 1, 1, 1, 1, 3, 3, 3, 3, 3, 3], 4), [1, 1, 2.090909090909091, 3, 4])

    it 'Calculates a linear scale for linear values', ->
        assert.deepEqual(nestedMeans([1, 2, 3, 4], 4), [1, 1.5, 2.5, 3.5, 5])

    it 'Correctly sorts items', ->
        assert.deepEqual(nestedMeans([9, 80], 1), [9, 81])

describe 'Nested means (rounded)', ->
    it 'Calculates a correct range for 4', ->
        assert.deepEqual(nestedMeans.rounded([1, 2, 3, 4, 5], 4), [1, 2, 3, 4, 6])

    it 'Calculates a linear scale for linear values', ->
        assert.deepEqual(nestedMeans.rounded([1, 2, 3, 4], 4), [1, 1, 2, 3, 5])
