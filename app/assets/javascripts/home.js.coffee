# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("button#mouse").click ->
    $.cookie("pointer", "mouse")

  $("button#trackpad").click ->
    $.cookie("pointer", "trackpad")

  $("button#tablet").click ->
    $.cookie("pointer", "tablet")
