const assert = require('assert');
// Basic smoke test
assert.strictEqual(typeof require('./app'), 'object');
console.log('Tests passed');
