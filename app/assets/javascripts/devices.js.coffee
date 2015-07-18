# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@editDevice = (id) ->
  row = $("#device_" + id + ":first")
  row.prepend("<input type='hidden' name='id' value='" + id + "' />")
  owner = row.children(".owner")
  if owner.length
    owner.html("<input type='text' name='owner' value='" + owner.text() + "' />")
  name = row.children(".name")
  name.html("<input type='text' name='name' value='" + name.text() + "' />")
  mobile = row.children(".mobile")
  mobile.html("<input type='checkbox' name='mobile'/>")
  buttons = row.children(".buttons")
  buttons.html("<a href='javascript:void(0);' onclick='submitUpdate()'><span class='glyphicon glyphicon-ok' /></a>")

@submitUpdate = ->
  $("#form-update").submit()
