Catalog = require('./../lib/state-jacket.coffee').Catalog

describe 'A StateJacket.Catalog', ->

  states = undefined

  beforeEach ->
    states = new Catalog()
    states.add 'foo', 'bar'
    states.add 'bar'

  it 'can add a state', ->
    expect(states.states.foo).toBeDefined()
    expect(states.states.bar).toBeDefined()

  it 'cannot add a state after locked', ->
    states.lock();
    addState = ->
      states.add('baz')
    expect(addState).toThrow();

  it 'should identify a transitioner', ->
    expect(states.isTransitioner('foo')).toBe true
    expect(states.isTransitioner('bar')).toBe false
    expect(states.isTransitioner('baz')).toBe false

  it 'should list all transitioners', ->
    expect(states.transitioners()).toContain 'foo'
    expect(states.transitioners()).not.toContain 'bar'

  it 'should identify a terminator', ->
    expect(states.isTerminator('bar')).toBe true
    expect(states.isTerminator('foo')).toBe false
    expect(states.isTerminator('baz')).toBe false

  it 'should list all terminators', ->
    expect(states.terminators()).not.toContain 'foo'
    expect(states.terminators()).toContain 'bar'

  it 'should identify supported states', ->
    expect(states.supportsState('foo')).toBe true
    expect(states.supportsState('baz')).toBe false

  it 'should identify supported state transitions', ->
    expect(states.canTransition('foo', 'bar')).toBe true
    expect(states.canTransition('bar', 'foo')).toBe false

  it 'cannot lock if all transitioners are not first class states', ->
    states.add 'baz', 'boo'
    lock = ->
      states.lock()
    expect(lock).toThrow()

