import JQuery from 'jquery';
window.$ = window.jQuery = JQuery;

$(document).ready(function() {
  var minDateFilter = "";
  var maxDateFilter = "";

  var entryTable = $("#entries").dataTable({
    "oLanguage": {
      "sSearch": "Filter Data"
    },
    columnDefs: [
      {
        orderable: false,
        targets: 5
      }
    ]
  });

  $.fn.dataTableExt.afnFiltering.push(
  function(oSettings, aData, iDataIndex) {
    if (typeof aData._date == 'undefined') {
      aData._date = new Date(aData[3]).getTime();
    }

    if (minDateFilter && !isNaN(minDateFilter)) {
      if (aData._date < minDateFilter) {
        return false;
      }
    }

    if (maxDateFilter && !isNaN(maxDateFilter)) {
      if (aData._date > maxDateFilter) {
        return false;
      }
    }

    return true;
  });

  $('#min').change(function() {
    minDateFilter = new Date(this.value).getTime();
    entryTable.fnDraw();
  });

  $('#max').change(function() {
    maxDateFilter = new Date(this.value).getTime();
    entryTable.fnDraw();
  });

  $("#categories").dataTable({
    "oLanguage": {
      "sSearch": "Filter Data"
    },
    columnDefs: [
      {
        orderable: false,
        targets: 1
      }
    ]
  });

  $('#print').on('click', function(e) {
    $.ajax({
      url: '/prints/trigger'
    }).
    done(function(resp) {
      alert('Printed in the logs');
    });
    e.preventDefault();
  });
});