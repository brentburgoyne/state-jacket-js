# StateJacket JS

Based on [StateJacket](https://github.com/hopsoft/state_jacket) by [hopsoft](https://github.com/hopsoft).

## An Intuitive [State Transition System](http://en.wikipedia.org/wiki/State_transition_system) for JavaScript

[State machines](http://en.wikipedia.org/wiki/Finite-state_machine) are awesome
but can be pretty daunting as a system grows.
Keeping states, transitions, & events straight can be tricky.
StateJacket simplifies things by isolating the management of states & transitions.
Events are left out, making it much easier to reason about what states exist
and how they transition to other states.

*The examples below are somewhat contrived, but should clearly illustrate the usage.*

## The Basics

#### Install

```
$ npm install state-jacket
```

#### Define states &amp; transitions for a simple [turnstyle](http://en.wikipedia.org/wiki/Finite-state_machine#Example:_a_turnstile).

![Turnstyle](https://raw.github.com/brentburgoyne/state_jacket_js/master/doc/turnstyle.png)

```js
var StateJacket = require('state-jacket');
var states = new StateJacket.Catalog();

states.add('open', 'closed', 'error');
states.add('closed', 'open', 'error');
states.add('error');
states.lock();

states.transitioners(); // => ['open', 'closed']
states.terminators(); // => ['error']

states.canTransition('open', 'closed'); // => true
states.canTransition('closed', 'open'); // => true
states.canTransition('error', 'open'); // => false
states.canTransition('error', 'closed'); // => false
```