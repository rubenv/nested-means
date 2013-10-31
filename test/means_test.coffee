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
        assert.deepEqual(nestedMeans([1, 2, 3], 1), [1, 3])

    it 'Calculates a degenerate range for 1-length data', ->
        assert.deepEqual(nestedMeans([1], 1), [1, 1])

    it 'Calculates only distinct ranges', ->
        assert.deepEqual(nestedMeans([1], 4), [1, 1])

    it 'Calculates a correct range for 2', ->
        assert.deepEqual(nestedMeans([1, 2, 3], 2), [1, 2, 3])

    it 'Calculates a correct range for 4', ->
        assert.deepEqual(nestedMeans([1, 2, 3, 4, 5], 4), [1, 2, 3, 4.5, 5])

    it 'Calculates ranges for repeated items', ->
        assert.deepEqual(nestedMeans([1, 1, 1], 2), [1, 1, 1])

describe 'Nested means (rounded)', ->
    it 'Calculates a correct range for 4', ->
        assert.deepEqual(nestedMeans.rounded([1, 2, 3, 4, 5], 4), [1, 2, 3, 4, 5])
