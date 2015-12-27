assert = require 'assert'
{convertVersion} = require '../src/utils'

describe 'convertVersion', ->
  it 'makes semver versions into valid NuGet versions', ->
    assert.equal convertVersion('1'), '1'
    assert.equal convertVersion('1.2'), '1.2'
    assert.equal convertVersion('1.2.3'), '1.2.3'
    assert.equal convertVersion('1.2.3-alpha'), '1.2.3-alpha'
    assert.equal convertVersion('1.2.3-alpha.1'), '1.2.3-alpha1'
    assert.equal convertVersion('1.2.3-alpha.1.2'), '1.2.3-alpha12'
    assert.equal convertVersion('1.2.3-alpha-1-2'), '1.2.3-alpha-1-2'
