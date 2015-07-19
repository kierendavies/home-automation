# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  if $("#devices").length
    new DeviceListBehaviour().addBehaviour()

class DeviceListBehaviour
  addBehaviour: ->
    $(".edit-show").hide()
    $(".device-edit").on "click", @editDevice
    $(".device-submit").on "click", @submitDevice
    $(".device-cancel").on "click", @cancelEditDevice

  editDevice: (event) =>
    @cancelEditDevice()
    device = $(event.target).closest(".device")
    device.find(".edit-hide").hide()
    device.find(".edit-show").show()

  submitDevice: (event) ->
    device = $(event.target).closest(".device")
    form = $("form#form-update-device")
    form.find("#id").val(device.data("id"))
    form.find("#owner").val(device.find("input[name='owner']").val())
    form.find("#name").val(device.find("input[name='name']").val())
    form.find("#mobile").val(device.find("input[name='mobile']").prop("checked"))
    form.submit()

  cancelEditDevice: ->
    $(".edit-hide").show()
    $(".edit-show").hide()

