const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);
exports.sendAdminNotification = functions.database.ref('/News/{pushId}').onWrite(event => {
const news= event.data.val();
     if(news.priority==1){
     const payload = {notification: {
         title: 'New news',
         body: `${news.title}`
         }
     };
return admin.messaging().sendToTopic("News",payload)
    .then(function(response){
         console.log('Notification sent successfully:',response);
}) .catch(function(error){
         console.log('Notification sent failed:',error);
    });
     }})