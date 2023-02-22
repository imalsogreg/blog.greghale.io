#! /usr/bin/env nix-shell
#! nix-shell -i python3 -p python3

import datetime

data_file = "./data/vertigo-chart.csv"

# List the csv columns.
def headers():
    words = []
    with open(data_file, 'r', encoding="utf-8") as f:
        words = [w.strip() for w in f.readline().strip("\n").split(',') ]
    return words

now =  datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
vals = [now]

cols = headers()
for col in cols[1:]:
    val = input(col + ":")
    if val == "":
        if col == "notes":
            val = "\"\""
        else:
            val = " "
    else:
        if col == "notes":
            val = "\"" + val + "\""
    vals.append(val)

print( ",".join(vals) )

with open(data_file, 'a', encoding="utf-8") as f:
    f.write(",".join(vals) + "\n")
