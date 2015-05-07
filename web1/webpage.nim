# From http://hookrace.net/blog/what-is-special-about-nim/
import jester, asyncdispatch, json, strutils, times, sets, htmlgen, strtabs

var
  visitors = 0
  uniques = initSet[string]()
  time: TimeInfo

routes:
  get "/":
    resp body(
      `div`(id="info"),
      script(src="/client.js", `type`="text/javascript"),
      script(src="/visitors", `type`="text/javascript"))

  get "/client.js":
    const result = staticExec "nim -d:release js client"
    const clientJS = staticRead "nimcache/client.js"
    resp clientJS

  get "/visitors":
    let newTime = getTime().getLocalTime
    if newTime.monthDay != time.monthDay:
      visitors = 0
      init uniques
      time = newTime

    inc visitors
    let ip =
      if request.headers.hasKey "X-Forwarded-For":
        request.headers["X-Forwarded-For"]
      else:
        request.ip
    uniques.incl ip

    let json = %{"visitors": %visitors,
                 "uniques": %uniques.len,
                 "ip": %ip}
    resp "printInfo($#)".format(json)

runForever()