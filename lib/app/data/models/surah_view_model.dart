// To parse this JSON data, do
//
//     final surahViewModel = surahViewModelFromJson(jsonString);

import 'dart:convert';

SurahViewModel surahViewModelFromJson(String str) => SurahViewModel.fromJson(json.decode(str));

String surahViewModelToJson(SurahViewModel data) => json.encode(data.toJson());

class SurahViewModel {
    final int? number;
    final String? name;
    final String? englishName;
    final String? englishNameTranslation;
    final String? revelationType;
    final int? numberOfAyahs;
    final List<Ayah>? ayahs;
    final Edition? edition;

    SurahViewModel({
        this.number,
        this.name,
        this.englishName,
        this.englishNameTranslation,
        this.revelationType,
        this.numberOfAyahs,
        this.ayahs,
        this.edition,
    });

    factory SurahViewModel.fromJson(Map<String, dynamic> json) => SurahViewModel(
        number: json["number"],
        name: json["name"],
        englishName: json["englishName"],
        englishNameTranslation: json["englishNameTranslation"],
        revelationType: json["revelationType"],
        numberOfAyahs: json["numberOfAyahs"],
        ayahs: json["ayahs"] == null ? [] : List<Ayah>.from(json["ayahs"]!.map((x) => Ayah.fromJson(x))),
        edition: json["edition"] == null ? null : Edition.fromJson(json["edition"]),
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "englishName": englishName,
        "englishNameTranslation": englishNameTranslation,
        "revelationType": revelationType,
        "numberOfAyahs": numberOfAyahs,
        "ayahs": ayahs == null ? [] : List<dynamic>.from(ayahs!.map((x) => x.toJson())),
        "edition": edition?.toJson(),
    };
}

class Ayah {
    final int? number;
    final String? text;
    final int? numberInSurah;
    final int? juz;
    final int? manzil;
    final int? page;
    final int? ruku;
    final int? hizbQuarter;
    final bool? sajda;

    Ayah({
        this.number,
        this.text,
        this.numberInSurah,
        this.juz,
        this.manzil,
        this.page,
        this.ruku,
        this.hizbQuarter,
        this.sajda,
    });

    factory Ayah.fromJson(Map<String, dynamic> json) => Ayah(
        number: json["number"],
        text: json["text"],
        numberInSurah: json["numberInSurah"],
        juz: json["juz"],
        manzil: json["manzil"],
        page: json["page"],
        ruku: json["ruku"],
        hizbQuarter: json["hizbQuarter"],
        sajda: json["sajda"],
    );

    Map<String, dynamic> toJson() => {
        "number": number,
        "text": text,
        "numberInSurah": numberInSurah,
        "juz": juz,
        "manzil": manzil,
        "page": page,
        "ruku": ruku,
        "hizbQuarter": hizbQuarter,
        "sajda": sajda,
    };
}

class Edition {
    final String? identifier;
    final String? language;
    final String? name;
    final String? englishName;
    final String? format;
    final String? type;
    final String? direction;

    Edition({
        this.identifier,
        this.language,
        this.name,
        this.englishName,
        this.format,
        this.type,
        this.direction,
    });

    factory Edition.fromJson(Map<String, dynamic> json) => Edition(
        identifier: json["identifier"],
        language: json["language"],
        name: json["name"],
        englishName: json["englishName"],
        format: json["format"],
        type: json["type"],
        direction: json["direction"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "language": language,
        "name": name,
        "englishName": englishName,
        "format": format,
        "type": type,
        "direction": direction,
    };
}
