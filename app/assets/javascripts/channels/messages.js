App.messages = App.cable.subscriptions.create('MessagesChannel', {  
	connected(){
		console.log("connted to message chall");
	},
	disconnected(){
		console.log("disconnted to message chall");
	},
  received: function(data) {
  	$("#dhjdhjdfdf").append(data.message) //data show from this line 
	console.log(data);
  },
});