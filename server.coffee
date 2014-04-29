express = require 'express'
db = require './app_modules/common/db'
require './app_modules/common/ext'

app = express()
rootPath = process.cwd()
#系统配置
appconfig =
	port: 80

#模版引擎
app.set 'view engine', 'jade'
#视图
app.set 'views', rootPath + '\\static\\views'
#静态资源
app.use '/static', express.static(__dirname + '\\static')
#注册模板引擎
app.engine 'jade', require('jade').__express

#首页
app.get '/', (req, res) ->
	PersonModel = db.getPersonModel()
	PersonModel.find {},successHandler
	successHandler = (err, data) ->
		allPerson = []
		if err
			log.error err
		else
			allPerson = data
		res.render 'index', allPerson

#新增一个人页面
app.get '/toAddPerson', (req, res) ->
	res.render 'test/person/personAdd'

#新增一个人
app.post '/addPerson', (req, res) ->
	PersonModel = db.getPersonModel()
	newPersonInfo =
		namecd: req.param 'namecn'
		age: req.param 'age'
		sex: req.param 'sex'
	newPerson = new PersonModel newPersonInfo
	newPerson.save()
	res.redirect '/'

app.listen appconfig.port, () ->
	console.log 'app start @' + appconfig.port