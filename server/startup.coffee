#Get Knox and AWS libraries
Knox = Npm.require "knox"
AWS = Npm.require "aws-sdk"

#Server side configuration variables
@S3 =
	config:{
	  key: process.env.AWS_ACCESS_KEY_ID,
	  secret: process.env.AWS_SECRET_ACCESS_KEY,
	  bucket: 'mettavr',
	  denyDelete: true,
	  region: 'us-east-1', # default
	}
	knox:{}
	aws:{}

Meteor.startup ->
	if not _.has S3.config,"key"
		console.log "S3: AWS key is undefined"

	if not _.has S3.config,"secret"
		console.log "S3: AWS secret is undefined"

	if not _.has S3.config,"bucket"
		console.log "S3: AWS bucket is undefined"

	if not _.has(S3.config,"bucket") or not _.has(S3.config,"secret") or not _.has(S3.config,"key")
		return

	_.defaults S3.config,
		region:"us-east-1" # us-standard

	S3.knox = Knox.createClient S3.config
	S3.aws = new AWS.S3
		accessKeyId:S3.config.key
		secretAccessKey:S3.config.secret
		region:S3.config.region

