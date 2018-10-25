// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss";


// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
import "phoenix_html";
import jQuery from 'jquery';
window.jQuery = window.$ = jQuery; // Bootstrap requires a global "$" object.
import "bootstrap";
// import _ from "lodash";

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(function() {
  $('.delete-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let text = JSON.stringify({

    });
    $.ajax(`${timeblock_path}/${task_id}`, {
      type: "DELETE",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        location.reload()
      },
    });
  });
});

$(function() {
  function update_timeblocks(task_id) {
    $.ajax(`${timeblock_path}?task_id=${task_id}`, {
      method: "get",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: "",
      success: (resp) => {
        location.reload()
      },
    });
  }

  $('#start-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let start_d = new Date();
    let start = formatDate(start_d);
    $('#start-button').prop('disabled', true);
    $('#end-button').prop('disabled', false);
    $('#end-button').click((ev) => {
      let end_d = new Date();
      let end = formatDate(end_d);
      let text = JSON.stringify({
        timeblock: {
          start_time: start,
          end_time: end,
          task_id: task_id,
        },
      });
      $.ajax(timeblock_path, {
        method: "post",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        data: text,
        success: (resp) => {
          $('#start-button').prop('disabled', false);
          $('#end-button').prop('disabled', true);
          update_timeblocks(task_id);
        },
      });
    });
  });
});


function formatDate(d) {
  var year = d.getFullYear();
  var month = d.getMonth() + 1;
  month = month < 10 ? '0'+month : month;
  var date = d.getDate();
  date = date < 10 ? '0'+date : date;
  var full_date = year + '-' + month + '-' + date;
  var hours = d.getHours();
  hours = hours < 10 ? '0'+hours : hours;
  var minutes = d.getMinutes();
  minutes = minutes < 10 ? '0'+minutes : minutes;
  var seconds = d.getSeconds();
  seconds = seconds < 10 ? '0'+seconds : seconds;
  var full_time = hours + ':' + minutes + ':' + seconds;
  return full_date + ' ' + full_time;
}
