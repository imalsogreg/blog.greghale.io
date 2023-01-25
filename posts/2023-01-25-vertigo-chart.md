---
title: Vertigo Chart
description: Tracking vertigo symptoms and possible triggers
tags: Health
---

# Vertigo Chart

<div id="vertigo" style="width:700px;height:700px;"></div>

<script src="https://cdn.plot.ly/plotly-2.18.0.min.js"></script>
<script language="javascript">

function makeplot() {
  d3.csv("/data/vertigo-chart.csv", data => plotTransposedData(data))
}

function isATrace(propt) {
  return propt != "datetime"
}

function proptVisibility(propt) {
  if (propt == "discomfort") {
    return true
  } else {
    return 'legendonly'
  }
}
    
function plotTransposedData(allRows) {
  var traces = {};
  
  for (var propt in allRows[0]) {
    if (isATrace(propt)) {
      traces[propt] = {};
      traces[propt].name = propt;
      traces[propt].visible = proptVisibility(propt);
      traces[propt].x = [];
      traces[propt].y = [];
    }
  }
  
  for (var i=0; i < allRows.length; i++) {
    for (var propt in allRows[i] ) {
      if (isATrace(propt)) {
        traces[propt].x.push(allRows[i].datetime);
        traces[propt].y.push(allRows[i][propt]);
      }
    }
  }
  
  var traceList = [];
  for (var propt in traces) {
    traceList.push(traces[propt]);
  }
  
  var plotDiv = document.getElementById('vertigo');
  Plotly.newPlot(plotDiv, traceList, {margin: {t: 0}});

}

makeplot();

</script>
