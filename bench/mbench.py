#!/usr/bin/python3

import random
import string
import os, sys
import time
import socket
from multiprocessing import Process, Manager


N=int(sys.argv[1])
graphite_host=sys.argv[2]
graphite_port=int(sys.argv[3])
time_limit=int(sys.argv[4])
tdir=sys.argv[5]

counters={
  'create-file':0,
  'create-dir':0,
  'delete-file':0,
  'delete-dir':0,
  'stat-file':0,
  'list-dir':0
}

def bench(counters, time_limit, running):
  start=time.time()
  os.chdir(tdir)
  while 1:
    try:
      dir="".join(random.choice(string.ascii_lowercase) for _ in range(10))
      dir+=".mbench"
      os.mkdir(dir)
      counters['create-dir']+=1
      os.chdir(dir)
      a=[]
      for i in range(N):
        a.append("".join(random.choice(string.ascii_lowercase) for _ in range(10))+".mbench")
      for i in a:
        with open(i, "w") as fo:
          pass
        fo.close()
        counters['create-file']+=1
      for f in os.listdir():
        info = os.stat(f)
        counters['stat-file']+=1
      counters['list-dir']+=1
      for i in a:
        os.remove(i)
        counters['delete-file']+=1
      os.chdir("..")
      os.rmdir(dir)
      counters['delete-dir']+=1
      end=time.time()
      if end-start > time_limit:
        running.value = 0
        break
    except TimeoutError:
      print('TimeoutError')
  print("Elapsed:", "{0:.5f}".format(end-start), "s")
  print(counters)

def send_graphite(d):
  sock = socket.socket()
  sock.connect((graphite_host, graphite_port))
  for k,v in d.items():
#    print(k,v)
#    print(int(time.time()))
    msg=socket.gethostname()+"."+str(k)+" "+str(v)+" "+str(int(time.time()))+"\n"
    sock.send(msg.encode())

if __name__ == '__main__':
  with Manager() as manager:
    d = manager.dict(counters)
    running = manager.Value('i', 1)
    p = Process(target=bench, args=(d,time_limit,running))
    p.start()
    i=0
    while running.value:
      time.sleep(1)
      send_graphite(d)
      i+=1
      if i>60:
        i=0
        for k,v in d.items():
          print(k,v)
          print(int(time.time()))
        sys.stdout.flush()
    p.join()
