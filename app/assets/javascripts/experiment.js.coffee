# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
#
# =require "raphael"

# http://coffeescriptcookbook.com/chapters/arrays/shuffling-array-elements
Array::shuffle = ->
  @sort ->
    0.5 - Math.random()

# http://coffeescriptcookbook.com/chapters/arrays/concatenating-arrays
Array::merge = (other) ->
  Array::push.apply @, other

Array::random = ->
  this[Math.floor(Math.random() * this.length)]

class Position
  @jumpX = 600
  @jumpY = 200

  @offsetX: ->
    (window.innerWidth - Position.jumpX) / 2

  @offsetY: ->
    (window.innerHeight - Position.jumpY) / 2

  constructor: (x, y) ->
    this.x = Position.offsetX() + x
    this.y = Position.offsetY() + y

class Target
  @sizes =
    small: 8
    medium: 16
    large: 32

  # a   b
  # d   c
  @a = new Position 0,              0
  @b = new Position 0,              Position.jumpY
  @c = new Position Position.jumpX, Position.jumpY
  @d = new Position Position.jumpX, 0

  @positions = [@a, @b, @c, @d]

  @a.adjacents =
    short: @d
    long: @b
    diagonal: @c

  @b.adjacents =
    short: @c
    long: @a
    diagonal: @d

  @c.adjacents =
    short: @b
    long: @d
    diagonal: @a

  @d.adjacents =
    short: @a
    long: @c
    diagonal: @b

  lastClickTime: null

  constructor: (raphael) ->
    this.raphael = raphael

    this._generateTrialParameters()

    this.element = raphael.circle(0, 0, 1)
    this.element.attr
      fill: "#c00"
      stroke: 3

    this.goto Target.randomPosition()
    this.resize Target.randomSize()

    this.element.toFront()
    this.element.source = this

    this.element.click (event) =>
      this.clicked event

  advance: (trial) ->
    this.move trial.transition
    this.resize trial.size

  move: (transition) ->
    this.goto this.position.adjacents[transition]

  goto: (position) ->
    this.element.animate
      cx: position.x
      cy: position.y

  resize: (size) ->
    this.element.animate
      r: Target.sizes[size]

  clicked: (event) ->
    alert "oh hey!" # XXX debug

  @randomPosition: ->
    Target.positions.random()

  @randomSize: ->
    ["small", "medium", "large"].random()

  _generateTrialParameters: ->
    transitions = []
    sizes = []

    for index in [1..9]
      do (index) ->
        transitions.merge ["short", "long", "diagonal"]
        sizes.merge ["small", "medium", "large"]

    transitions.shuffle()
    sizes.shuffle()

    trials = []
    for index in [1..27]
      do (index) ->
        trials.push
          transition: transitions[index]
          size: sizes[index]

    this.trials = trials

viewport = ->
  width = window.innerWidth - 3
  height = window.innerHeight - 3

  leftoverX = Position.offsetX() - Target.sizes.large
  leftoverY = Position.offsetY() - Target.sizes.large

  invalid = false

  if leftoverX - 2 < 0
    width = Position.jumpX + Target.sizes.large + 3
    invalid = true

  if leftoverY - 2 < 0
    height = Position.jumpY + Target.sizes.large + 3
    invalid = true

  if invalid
    alert "Please enlarge your browser until you can at least see both the " +
          "bottom and top edges of the canvas clearly. Refresh the page when" +
          "you're done. Sorry for the inconvenience"

  return [width, height]

initialize = ->
  [width, height] = viewport()

  paper = Raphael "canvas-container", width, height

  background = paper.rect 0, 0, width, height

  background.attr "fill", "#000"
  target = new Target paper

  background.click (e) ->
    alert(e.x + " " + e.y)

$(document).ready ->
  initialize()
