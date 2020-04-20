import * as functions from 'firebase-functions';

import * as admin from 'firebase-admin';
admin.initializeApp();

//const db = admin.firestore();
const fcm = admin.messaging();


export const sendToTopic = functions.firestore
  .document('avis/{avisId}')
  .onCreate(async snapshot => {
    const avis = snapshot.data();
    if (avis !== undefined) {
        avis.classes.forEach((classe: any) => {
            const payload: admin.messaging.MessagingPayload = {
                notification: {
                  title: `Classe ${classe} : Nouvel avis!`,
                  body: `Titre : ${avis.titre}`,
                  icon: 'your-icon-url',
                  click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
                }
              };
             fcm.sendToTopic(String(classe), payload);
        });
        return "";
    } else {
     const payload: admin.messaging.MessagingPayload = {
       notification: {
         title: 'New Puppy!',
         body: `Error with the notifications, sorry, get a puppy ! `,
         icon: 'your-icon-url',
         click_action: 'FLUTTER_NOTIFICATION_CLICK' // required only for onResume or onLaunch callbacks
       }
     };
     return fcm.sendToTopic('puppies', payload);
    }
  });
