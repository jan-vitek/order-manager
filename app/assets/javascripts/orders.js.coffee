# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@Order = {}

Order.id = null;
Order.userId = null;
Order.lastTry = null;
Order.lastSuccessfulTry = null; 
Order.active = false
Order.intervalId = null

Order.setButton = (target_class) ->
  $('#order_control').removeClass()
  $('#order_control').addClass('glyphicon')
  $('#order_control').addClass(target_class)
  if (target_class == "glyphicon-play")
    $('#order_control').addClass('text-success')
  else
    $('#order_control').addClass('text-danger')

Order.loadTimeEntriesTable = () ->
  $('#time_entries_table').load("/orders/" + Order.id + "/time_entries")

Order.startTimeLogging = () ->
  console.log("Logging time for order " + Order.id)
  Order.setButton('glyphicon-pause')
  Order.lastSuccessfulTry = Date.now()
  Order.intervalId = setInterval(Order.increaseRequest, 5000);  
  setTimeout(Order.loadTimeEntriesTable, 10000)
  $.post("/orders/" + Order.id + "/assign_to_user", { user_id: Order.userId }, 
    function(returnedData){
    });

Order.increaseRequest = () ->
  Order.lastTry = Date.now()
  seconds = (Order.lastTry - Order.lastSuccessfulTry)/1000
  $.getJSON "/time_entries/log_time", 
            {order_id: Order.id, user_id: Order.userId, seconds: seconds, sent_time: Order.lastTry},
            (data, response) -> Order.processResponse(data, response)

Order.processResponse = (data, response) ->
  if (response == "success")
    Order.lastSuccessfulTry = data.sent_time
    $('#time_entry_' + data.time_entry_id)[0].innerHTML = data.spent_time
    $('#spent_time')[0].innerHTML = data.order_spent_time

Order.pauseTimeLogging = (reason = "") ->
  console.log("Logging paused for order " + Order.id + ": " + reason)
  Order.setButton('glyphicon-play')
  clearInterval(Order.intervalId)

Order.controlButtonListener = (obj) ->
  if (obj.className == "glyphicon glyphicon-play text-success")
    Order.startTimeLogging()
  else
    Order.pauseTimeLogging("pause button")

