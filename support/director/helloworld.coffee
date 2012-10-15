http = require("http")
director = require("director")

helloWorld = () ->
  this.res.writeHead(200, {'Content-Type': 'text/plain'})
  process.send({status: 0}) if process.send
  this.res.end("Hello World.")

router = new director.http.Router({
  "/": {
    get: helloWorld
  }
})

server = http.createServer((req, res) ->
  router.dispatch(req, res, (err) ->
    if err
      res.writeHead(404)
      res.end()
  )
)

process.send({status: 0, increment: 0}) if process.send
port = process.env.PORT || 3000
server.listen(port)