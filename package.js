Package.describe({
	name:"lepozepo:s3",
	summary: "Upload files to S3. Allows use of Knox Server-Side.",
	version:"5.1.6",
	git:"https://github.com/Lepozepo/S3"
});

Package.onUse(function (api) {
	api.versionsFrom('METEOR@1.0');

	api.use(["meteor-base@1.0.1-beta.16","coffeescript","service-configuration", "ecmascript"], ["client", "server"]);
	api.use(["check","random"], ["client","server"]);
	api.use(["tmeasday:check-npm-versions"], ["server"]);
	

	// Client
	api.mainModule("client/functions.coffee", "client");

	// Server
	api.mainModule("server/startup.coffee", "server");
	api.mainModule("server/sign_request.coffee", "server");
	api.mainModule("server/delete_object.coffee", "server");

	//Allows user access to Knox
	api.export("Knox","server");

	//Allows user access to AWS-SDK
	api.export("AWS","server");
});
