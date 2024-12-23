function load_para

global ppq_Body ppq_Lhip ppq_Rhip ppq_Lknee ppq_Rknee ppq_Lankle ppq_Rankle;
global ppq_Torq_Lhip ppq_Torq_Rhip ppq_Torq_Lknee ppq_Torq_Rknee ppq_Torq_Lankle ppq_Torq_Rankle

ppq_Body = load('ppq_Body'); ppq_Body = ppq_Body.ppq_Body;
ppq_Lhip = load('ppq_Lhip'); ppq_Lhip = ppq_Lhip.ppq_Lhip;
ppq_Rhip = load('ppq_Rhip'); ppq_Rhip = ppq_Rhip.ppq_Rhip;
ppq_Lknee = load('ppq_Lknee'); ppq_Lknee = ppq_Lknee.ppq_Lknee;
ppq_Rknee = load('ppq_Rknee'); ppq_Rknee = ppq_Rknee.ppq_Rknee;
ppq_Lankle = load('ppq_Lankle'); ppq_Lankle = ppq_Lankle.ppq_Lankle;
ppq_Rankle = load('ppq_Rankle'); ppq_Rankle = ppq_Rankle.ppq_Rankle;
ppq_Torq_Lhip = load('ppq_Torq_Lhip'); ppq_Torq_Lhip = ppq_Torq_Lhip.ppq_Torq_Lhip;
ppq_Torq_Rhip = load('ppq_Torq_Rhip'); ppq_Torq_Rhip = ppq_Torq_Rhip.ppq_Torq_Rhip;
ppq_Torq_Lknee = load('ppq_Torq_Lknee'); ppq_Torq_Lknee = ppq_Torq_Lknee.ppq_Torq_Lknee;
ppq_Torq_Rknee = load('ppq_Torq_Rknee'); ppq_Torq_Rknee = ppq_Torq_Rknee.ppq_Torq_Rknee;
ppq_Torq_Lankle = load('ppq_Torq_Lankle'); ppq_Torq_Lankle = ppq_Torq_Lankle.ppq_Torq_Lankle;
ppq_Torq_Rankle = load('ppq_Torq_Rankle'); ppq_Torq_Rankle = ppq_Torq_Rankle.ppq_Torq_Rankle;

end