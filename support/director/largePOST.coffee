http = require("http")
director = require("director")

router = new director.http.Router()

server = http.createServer((req, res) ->
  req.chunks = []
  req.on('data', (chunk) ->
    req.chunks.push(chunk.toString())
  )
  
  router.dispatch(req, res, (err) ->
    if err
      res.writeHead(404)
      res.end
  )
)

router.post('/', () ->
  this.res.writeHead(200, {"Content-Type": "text/plain"})
  this.res.end(this.req.headers["content-length"])
)