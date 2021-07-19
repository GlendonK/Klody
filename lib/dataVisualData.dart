class DataVisualData {
  int i5OClockShadow;
  int archedEyebrows;
  int attractive;
  int bagsUnderEyes;
  int bald;
  int bangs;
  int bigLips;
  int bigNose;
  int blackHair;
  int blondHair;
  int blurry;
  int brownHair;
  int bushyEyebrows;
  int chubby;
  int doubleChin;
  int eyeglasses;
  int grayHair;
  int heavyMakeup;
  int highCheekbones;
  int mouthSlightlyOpen;
  int narrowEyes;
  int ovalFace;
  int paleSkin;
  int pointyNose;
  int recedingHairline;
  int rosyCheeks;
  int sideburns;
  int smiling;
  int straightHair;
  int wavyHair;
  int wearingEarrings;
  int wearingHat;
  int wearingLipstick;
  int wearingNecklace;
  int wearingNecktie;
  int young;

  DataVisualData(
      {this.i5OClockShadow,
      this.archedEyebrows,
      this.attractive,
      this.bagsUnderEyes,
      this.bald,
      this.bangs,
      this.bigLips,
      this.bigNose,
      this.blackHair,
      this.blondHair,
      this.blurry,
      this.brownHair,
      this.bushyEyebrows,
      this.chubby,
      this.doubleChin,
      this.eyeglasses,
      this.grayHair,
      this.heavyMakeup,
      this.highCheekbones,
      this.mouthSlightlyOpen,
      this.narrowEyes,
      this.ovalFace,
      this.paleSkin,
      this.pointyNose,
      this.recedingHairline,
      this.rosyCheeks,
      this.sideburns,
      this.smiling,
      this.straightHair,
      this.wavyHair,
      this.wearingEarrings,
      this.wearingHat,
      this.wearingLipstick,
      this.wearingNecklace,
      this.wearingNecktie,
      this.young});

  DataVisualData.fromJson(Map<String, dynamic> json) {
    i5OClockShadow = json['5_o_Clock_Shadow'];
    archedEyebrows = json['Arched_Eyebrows'];
    attractive = json['Attractive'];
    bagsUnderEyes = json['Bags_Under_Eyes'];
    bald = json['Bald'];
    bangs = json['Bangs'];
    bigLips = json['Big_Lips'];
    bigNose = json['Big_Nose'];
    blackHair = json['Black_Hair'];
    blondHair = json['Blond_Hair'];
    blurry = json['Blurry'];
    brownHair = json['Brown_Hair'];
    bushyEyebrows = json['Bushy_Eyebrows'];
    chubby = json['Chubby'];
    doubleChin = json['Double_Chin'];
    eyeglasses = json['Eyeglasses'];
    grayHair = json['Gray_Hair'];
    heavyMakeup = json['Heavy_Makeup'];
    highCheekbones = json['High_Cheekbones'];
    mouthSlightlyOpen = json['Mouth_Slightly_Open'];
    narrowEyes = json['Narrow_Eyes'];
    ovalFace = json['Oval_Face'];
    paleSkin = json['Pale_Skin'];
    pointyNose = json['Pointy_Nose'];
    recedingHairline = json['Receding_Hairline'];
    rosyCheeks = json['Rosy_Cheeks'];
    sideburns = json['Sideburns'];
    smiling = json['Smiling'];
    straightHair = json['Straight_Hair'];
    wavyHair = json['Wavy_Hair'];
    wearingEarrings = json['Wearing_Earrings'];
    wearingHat = json['Wearing_Hat'];
    wearingLipstick = json['Wearing_Lipstick'];
    wearingNecklace = json['Wearing_Necklace'];
    wearingNecktie = json['Wearing_Necktie'];
    young = json['Young'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['5_o_Clock_Shadow'] = this.i5OClockShadow;
    data['Arched_Eyebrows'] = this.archedEyebrows;
    data['Attractive'] = this.attractive;
    data['Bags_Under_Eyes'] = this.bagsUnderEyes;
    data['Bald'] = this.bald;
    data['Bangs'] = this.bangs;
    data['Big_Lips'] = this.bigLips;
    data['Big_Nose'] = this.bigNose;
    data['Black_Hair'] = this.blackHair;
    data['Blond_Hair'] = this.blondHair;
    data['Blurry'] = this.blurry;
    data['Brown_Hair'] = this.brownHair;
    data['Bushy_Eyebrows'] = this.bushyEyebrows;
    data['Chubby'] = this.chubby;
    data['Double_Chin'] = this.doubleChin;
    data['Eyeglasses'] = this.eyeglasses;
    data['Gray_Hair'] = this.grayHair;
    data['Heavy_Makeup'] = this.heavyMakeup;
    data['High_Cheekbones'] = this.highCheekbones;
    data['Mouth_Slightly_Open'] = this.mouthSlightlyOpen;
    data['Narrow_Eyes'] = this.narrowEyes;
    data['Oval_Face'] = this.ovalFace;
    data['Pale_Skin'] = this.paleSkin;
    data['Pointy_Nose'] = this.pointyNose;
    data['Receding_Hairline'] = this.recedingHairline;
    data['Rosy_Cheeks'] = this.rosyCheeks;
    data['Sideburns'] = this.sideburns;
    data['Smiling'] = this.smiling;
    data['Straight_Hair'] = this.straightHair;
    data['Wavy_Hair'] = this.wavyHair;
    data['Wearing_Earrings'] = this.wearingEarrings;
    data['Wearing_Hat'] = this.wearingHat;
    data['Wearing_Lipstick'] = this.wearingLipstick;
    data['Wearing_Necklace'] = this.wearingNecklace;
    data['Wearing_Necktie'] = this.wearingNecktie;
    data['Young'] = this.young;
    return data;
  }
}
