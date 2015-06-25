import os
import strutils

type
  StringChannel = TChannel[string]

proc consumer(channel: ptr StringChannel) {.thread.} =
  var i = 0
  while i<100:
    echo channel[].recv()
    i += 1

proc producer(channel: ptr StringChannel) {.thread.} =
  var i = 0
  while i<100:
    sleep(1000)
    channel[].send($i)
    i += 1

proc main =
  var consumer_thr: TThread[ptr StringChannel]
  var producer_thr: TThread[ptr StringChannel]
  var channel: StringChannel
  channel.open()

  createThread(consumer_thr, consumer, addr(channel))
  createThread(producer_thr, producer, addr(channel))
  for i in 0..200:
    sleep(1000)


when isMainModule:
  main()