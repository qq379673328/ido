mongoose = require 'mongoose'

#数据库对象
Schema = mongoose.Schema

#数据库默认配置
dbdefaultConfig =
	url: 'mongodb://localhost',
	db: 'test'

#获取数据库db
getDB = (dbconfig) ->
	#默认数据库配置
	dbconfig = dbdefaultConfig.extend dbconfig
	mongoose.connect dbconfig.url + '/' + dbconfig.db
	db = mongoose.connection
	db.on 'error', () ->
		console.error 'mongodb 获取连接失败'
		return
	db.once 'open', () ->
		console.log 'mongodb 获取连接成功'
		return conn

#数据集schema定义
personSchemaDesc =
	namecn: String
	loginname: String
	password: String
	sex: String
	age: Number

#人员schema
PersonSchema = new Schema personSchemaDesc
PersonModel = mongoose.model 'person', PersonSchema
#schema扩展方法
PersonSchema.methods.getMyDesc = () ->
	return this.namecn + "/" + this.sex + "/" + this.age

#获取model
getModel = (modelName) ->
	getDB()
	switch modelName
		when 'person'
			return PersonModel
		else
			return

#获取指定model
getPersonModel = () ->
	getDB()
	return PersonModel

exports.getPersonModel = getPersonModel
exports.getModel = getModel
exports.getDB = getDB