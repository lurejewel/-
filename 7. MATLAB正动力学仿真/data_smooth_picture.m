h_f=figure(1);
h_p1=plot(t0,q_Lhip,'r',t0,q_Lhip_Denoising,'b');
xlim([10,18])

h_f=figure(2);
h_p1=plot(t0,q_Rhip,'r',t0,q_Rhip_Denoising,'b');
xlim([10,18])

h_f=figure(3);
h_p1=plot(t0,q_Lknee,'r',t0,q_Lknee_Denoising,'b');
xlim([10,18])

h_f=figure(4);
h_p1=plot(t0,q_Rknee,'r',t0,q_Rknee_Denoising,'b');
xlim([10,18])

h_f=figure(5);
h_p1=plot(t0,q_Lankle,'r',t0,q_Lankle_Denoising,'b');
xlim([10,18])

h_f=figure(6);
h_p1=plot(t0,q_Rankle,'r',t0,q_Rankle_Denoising,'b');
xlim([10,18])

h_f=figure(7);
h_p1=plot(t0,q_Body,'r',t0,q_Body_Denoising,'b');
xlim([10,18])

h_f=figure(8);
h_p1=plot(t1,Torq_Lhip,'r',t1,Torq_Lhip_Denoising,'b');
xlim([10,18])

h_f=figure(9);
h_p1=plot(t1,Torq_Rhip,'r',t1,Torq_Rhip_Denoising,'b');
xlim([10,18])

h_f=figure(10);
h_p1=plot(t1,Torq_Lknee,'r',t1,Torq_Lknee_Denoising,'b');
xlim([10,18])

h_f=figure(11);
h_p1=plot(t1,Torq_Rknee,'r',t1,Torq_Rknee_Denoising,'b');
xlim([10,18])

h_f=figure(12);
h_p1=plot(t1,Torq_Lankle,'r',t1,Torq_Lankle_Denoising,'b');
xlim([10,18])

h_f=figure(13);
h_p1=plot(t1,Torq_Rankle,'r',t1,Torq_Rankle_Denoising,'b');
xlim([10,18])
