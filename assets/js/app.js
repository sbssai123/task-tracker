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

// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

$(function() {
  $('#timeblock-button').click((ev) => {
    let task_id = $(ev.target).data('task-id');
    let d = new Date();
    let start = formatDate(d);
    console.log(start);
    let text = JSON.stringify({
    timeblock: {
        start_time: start,
        end_time: null,
        task_id: task_id,
      },
    });
    $.ajax(timeblock_path, {
      method: "post",
      dataType: "json",
      contentType: "application/json; charset=UTF-8",
      data: text,
      success: (resp) => {
        $('#start-time').text(`(your start time: ${resp.data.start_time})`);
      },
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
