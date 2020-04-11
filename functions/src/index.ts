import * as functions from 'firebase-functions';

import * as admin from 'firebase-admin';
admin.initializeApp();

const db = admin.firestore();
const fcm = admin.messaging();

export const sentToTopic = functions.firestore
.document('puppies/ccc')
.onCreate(async snapshot => {
    const puppy = snapshot.data();
    
    const payload : admin.messaging.MessagingPayload = {
        notification: {
            title: 'Nouvel avis ! ',
            body: `${puppy} is ready for adoption`,
            clickAction: 'FLUTTER_NOTIFICATION_CLICK' 
        }
    };
    return fcm.sendToTopic('puppies', payload);
});
