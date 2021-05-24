import time
MB = 128 * 1024
data = []

for x in range(1,6):
  data.append([None] * 256 * MB)
  print("Iteration #",x,"of another 256MB of memory tested ...", flush=True)
  time.sleep(5)
else:
  print("Memory test finished!")