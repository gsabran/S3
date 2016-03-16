# make sure the npm packages have been installed (coffee has no support for ES16 import at the moment...)
`import { checkNpmVersions } from 'meteor/tmeasday:check-npm-versions';`
checkNpmVersions({
  'knox': '0.9.2',
  'aws-sdk': '2.1.14',
});

#Get Knox and AWS libraries 
`import Knox from 'knox';`
`import AWS from 'aws-sdk';`

#Server side configuration variables
@S3 =
	config:{}
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

