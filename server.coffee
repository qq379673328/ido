express = require 'express'
app = express()
rootPath = process.cwd()

#模版引擎
app.set 'view engine', 'jade'
#视图
app.set 'views', rootPath + '\\static\\views'
#静态资源
app.use '/static', express.static(__dirname + '\\static')
#注册模板引擎
app.engine 'jade', require('jade').__express

app.get '/', (req, res) ->
	# Will render views/index.coffee:
	res.render 'index', foo: 'bar'

app.listen 8888, () ->
	console.log 'app start'