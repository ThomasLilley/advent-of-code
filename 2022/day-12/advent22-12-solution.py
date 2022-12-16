
import numpy as np
import matplotlib.pyplot as plt

with open('2022/day-12/advent22-12-input.txt') as f:
    lines = f.read()

lines = lines.split("\n")
start = [];
end = [];

grid = []

for i, line in enumerate(lines):
  line = list(line)
  for j, item in enumerate(line):
    if(item == "S"):
      line[j] = 0;
      start = [j,i]
    elif (item == "E"):
      end = [j,i]
      line[j] = 25;
    else:
       line[j] = ord(item) - 97
    
  grid.append(line)  

print(start)
print(end)

fig, ax = plt.subplots(figsize=(8,8))
current_cmap = plt.cm.Blues
current_cmap.set_bad(color='red')
ax.matshow(grid, cmap=plt.cm.Blues, vmin=0, vmax=25)
plt.show();
