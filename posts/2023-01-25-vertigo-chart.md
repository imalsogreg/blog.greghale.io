---
title: Vertigo Chart
description: Tracking vertigo symptoms and possible triggers
tags: Health
---

# Vertigo Chart

This chart tracks my ongoing vertigo symptoms and some other factors that might be triggers.

The [raw data](/data/vertigo-chart.csv) is available in csv. It is always up to date with the chart.

<div id="vertigo" style="width:700px;height:700px;"></div>

 

<div style="font-size:8pt;">

| Trace  | Description  |
|--------|--------------|
| discomfort  | How much vertigo I'm feeling   |
| hints       | Number of subtle warning signs, e.g. a little bout of nystagmus |
| sleep_deficit_8hr       | Shortage of 8 hours sleep the night prior |
| sore_throat       | Sore throat (to track if illness is related) |
| headache       | Headache (to track if illness is related) |
| stress       | Subjective 1 is a typical day, 7 is a tough prod incident |
| caffine       | Equivalent to how many caffinated teas I had that day |
| sugar       | Subjective 1-10 scale from just a bowl of cereal to 5 bowls of ice cream |
| salt       | Subjective 1-10 scale from very little to tons of salt |
| dh_left       | How much spinning is produced by doing a left Dix-Hallpike |
| dh_right       | How much spinning is produced by doing a right Dix-Hallpike |
| accel_ul       | How much does tilting my head up and left feel like it's happening too fast |
| accel_dr       | How much does tilting my head down and right feel like it's happening too fast |
| accel_ur       | How much does tilting my head up and right feel like it's happening too fast |
| accel_dl       | How much does tilting my head down and left feel like it's happening too fast |
| h_loss_l       | 0-10 scale of subjective left hearing loss and tinnitus |
| h_loss_r       | 0-10 scale of subjective right hearing loss and tinnitus |

</div>

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
  Plotly.newPlot(
    plotDiv,
    traceList,
    {
      margin: {t: 0},
      yaxis: {fixedrange: true},
      margin: { r: 50 },
      modebar: {
        orientation: 'v'
      }
    });

}

makeplot();

</script>
