###
StateJacket JS.
An Intuitive State Transition System for JavaScript
Based on State Jacket by hopsoft
###

'use strict'

StateJacket = {}

class StateJacket.Catalog

  constructor: ->
    @isLocked = false
    @states = {}

  add: (state, transitions...) ->
    throw 'Cannot modify locked StateJacket.Catalog object!' if @isLocked
    @states[String(state)] = (String(to) for to in transitions);

  canTransition: (from, to) ->
    key = String(from)
    if @states[key]
      return true if String(to) in @states[key]
    false

  transitioners: ->
    states = []
    for own state, transitions of @states
      states.push state if transitions.length > 0
    states

  isTransitioner: (state) ->
    String(state) in @transitioners()

  terminators: ->
    states = []
    for own state, transitions of @states
      states.push state if transitions.length == 0
    states

  isTerminator: (state) ->
    String(state) in @terminators()

  lock: ->
    for own state, transitions of @states
      for transition in transitions
        unless transition of @states
          throw "#{transition} is not a first class state."
    @isLocked = true

  each: (iterator) ->
    for own state, transitions of @states
      iterator(state, transitions)

  keys: ->
    (state for own state of @states)

  supportsState: (state) ->
    String(state) of @states

# Common JS
if typeof module == 'object' and module.exports
  module.exports = StateJacket
# AMD
else if typeof define == 'function' and this.define.amd
  define [], -> StateJacket
# Global
else
  this.StateJacket = StateJacket
