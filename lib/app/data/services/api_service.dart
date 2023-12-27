import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../models/surah_view_model.dart';

final apiServicesProvider = Provider<ApiService>((ref) {
  return ApiService();
});

class ApiService {
  ApiService() {
    print('=== api service constractor');
  }
  Map<String, String> headerData = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
  };
  Future<String> postUploadImage(
      {required String transType, required String imgPath}) async {
    final String apiUrl = ApiURL.postUploadImageUrl;
    print(apiUrl);
    Map<String, dynamic> bodyData = {
      "file_type": transType,
      "doc_photo": imgPath
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: json.encode(bodyData), headers: headerData);
      final result = json.decode(response.body);

      if (response.statusCode == 200 && result[AppConst.success] == true) {
        return result[AppConst.data]['url'].toString();
      } else {
        return '';
      }
    } catch (error) {
      print('upload image  failed : $error');
      return '';
    }
  }

  Future<String?> postOtpSend(RequestOtpHolder holder) async {
    final String apiUrl = ApiURL.postOtpSendUrl;
    print('postOtpSend== $apiUrl');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(holder.toJson()), headers: headerData);

      final parseResponse = jsonDecode(response.body);
      print(parseResponse);
      if (response.statusCode == 200 &&
          parseResponse[AppConst.success] == true) {
        return parseResponse[AppConst.data]['verify_id'].toString();
      }
    } catch (error) {
      print('postOtpSend error :  $error ');
      (error);
    }
  }

  Future<bool> postVerifyCode(VerifyHolder holder) async {
    final String apiUrl = ApiURL.postOtpVerifyOtherUrl;
    print('postVerifyCode ==$apiUrl');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(holder.toJson()), headers: headerData);

      final parseResponse = jsonDecode(response.body);
      print(parseResponse);
      if (response.statusCode == 200 &&
          parseResponse[AppConst.success] == true) {
        print(parseResponse[AppConst.message]);
        print('post verified code');

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('postVerifyCode error :  $error ');
      (error);
      return false;
    }
  }

  Future<String?> getSingleBalance({required String currency}) async {
    final String apiUrl = '${ApiURL.getSingleBalanceUrl}$currency';
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);
      final result = await jsonDecode(response.body);
      print('get result $result');

      if (response.statusCode == 200) {
        return result[AppConst.data]['balance'].toString();
      } else {
        return '0.0';
      }
    } catch (error) {
      print('get single balance not fund $error');
    }
  }

  Future<KycOptionModel?> getKycOption() async {
    final String apiUrl = ApiURL.getKycOptionUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);
      print(jsonDecode(response.body));
      print('get kyc options');

      if (response.statusCode == 200) {
        return kycOptionModelFromJson(response.body);
      }
    } catch (error) {
      print('get single balance not fund $error');
    }
  }

  Future<List<CountryModel>?> getCountrys() async {
    final String apiUrl = ApiURL.getCountryListUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);
      print(jsonDecode(response.body));
      print('get kyc options');

      if (response.statusCode == 200) {
        return countryModelFromJson(
            jsonDecode(response.body)[AppConst.data.toString()]);
      }
    } catch (error) {
      print('get single balance not fund $error');
    }
  }

  Future<OccupationModel?> getOccupations() async {
    final String apiUrl = ApiURL.getOccupationUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);
      print(jsonDecode(response.body));
      print('get occupation ');

      if (response.statusCode == 200) {
        return OccupationModel.fromJson(jsonDecode(response.body));
      }
    } catch (error) {
      print('get occupation not fund $error');
    }
  }

  Future<bool> postKyc(KycModel kycModel) async {
    final String apiUrl = ApiURL.postKycUrl;
    print('url $apiUrl');
    print(kycModel.pmAddressProofFileType);

    var bodyData = kycModel.foreignIdType != '2'
        ? kycModel.toJson()
        : kycModel.toJsonForPass();
    print('josn submit bodyData ==== ${bodyData}');
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(bodyData), headers: headerData);
      print(jsonDecode(response.body));
      print('response kyc submittere =========== ');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('post submited kyc errror   fund $error');
      return false;
    }
  }

  Future<bool> postProfileUpdate(KycModel kycModel) async {
    final String apiUrl = ApiURL.postUpdateProfileUrl;
    print('url $apiUrl');
    print('josn profile update data ==== ${kycModel.toJson()}');
    var bodyData = kycModel.pmAddressProofFileType != '2'
        ? kycModel.toJson()
        : kycModel.toJsonForPass();
    print('josn submit data ==== ${bodyData}');
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(bodyData), headers: headerData);
      print(jsonDecode(response.body));
      print('response profile update submittere =========== ');

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('post profile update errror   fund $error');
      return false;
    }
  }

  Future<ProfileModel?> getProfileInfo(String userId) async {
    final String apiUrl =
        "${ApiURL.getProfileInfoUrl}type=user_id&search_key=$userId";
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);

      if (response.statusCode == 200) {
        var userInfo =
            ProfileModel.fromJson(jsonDecode(response.body)[AppConst.data]);

        return userInfo;
      }
    } catch (error) {
      print('get occupation not fund $error');
    }
  }

  Future<UserModel?> getSingleUserInfo(String token) async {
    final String apiUrl = ApiURL.getSingleUserInfoUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer $token"
    };
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);

      if (response.statusCode == 200) {
        var userInfo = UserModel.fromJson(jsonDecode(response.body)['user']);
        print(
            'user info=====================================: ${userInfo.toJson()}');

        bool isSetUser = await UserProvider().setUser(userInfo);
        if (isSetUser) {
          return userInfo;
        }
      }
    } catch (error) {
      print('get single user   not fund $error');
    }
  }

  Future<ExchangeRateModel?> getExchangeRate(String currency) async {
    final String apiUrl =
        "${preferences.getString(AppKeys.exchangeExtraApi)}&base=$currency";
    print('url $apiUrl');
    print('        [[]]][[[[[================');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var exchangRates = ExchangeRateModel.fromJson(result);
        return exchangRates;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<String?> postExchangeCurrency(ExchangeCurrencyHolder holder) async {
    final String apiUrl = ApiURL.posrExchangeCurrencyUrl;
    "";
    print('url $apiUrl');
    print('url ${holder.toJson()}');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(holder.toJson()), headers: headerData);
      var result = jsonDecode(response.body);
      print('post exchange currency done $result');
      if (response.statusCode == 200) {
        print('post exchange currency done $result');

        return result[AppConst.data]["exchange_id"].toString();
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<bool> postExceptionTransa(TransactionExceptionHolder holder) async {
    final String apiUrl = ApiURL.postExceptionTransUrl;
    "";
    print('url $apiUrl');
    print('url ${holder.toJson()}');

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(holder.toJson()), headers: headerData);
      var result = jsonDecode(response.body);
      print('post exception = $result');
      if (response.statusCode == 200) {
        print('post exception ------ $result');

        return true;
      } else {
        return false;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
      return false;
    }
  }

  Future<List<TransactionModel>?> getAllTransaction() async {
    final String apiUrl = ApiURL.getAllTransactionUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        print('trans alll ${result}');

        var transationsObj = transactionModelFromJson(result[AppConst.data]);

        return transationsObj;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<List<TransactionModel>?> getAllDeposit() async {
    final String apiUrl = ApiURL.getAllDepositUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var transations = transactionModelFromJson(result[AppConst.data]);

        return transations;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<List<TransactionModel>?> getAllWithdrawUrl() async {
    final String apiUrl = ApiURL.getAllWithdrawUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var transations = transactionModelFromJson(result[AppConst.data]);

        return transations;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<bool?> postPinVerify(String pin) async {
    final String apiUrl = ApiURL.postPinVerifyUrl;
    print('url $apiUrl');
    var bodyData = {"pin": pin};
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(bodyData), headers: headerData);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(result);
        print('post pin verify result');
        return true;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<bool?> postRequestCard() async {
    final String apiUrl = ApiURL.postRequestCardUrl;
    print(apiUrl);

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headerData);
      var result = jsonDecode(response.body);
      print('result request card ${result[AppConst.success]}');
      if (response.statusCode == 200 && result[AppConst.success] == true) {
        print(result);
        print('post request card result');
        return true;
      }
    } catch (error) {
      print('card request not success $error');
    }
  }

  Future<List<SliderImgModel>?> getSliderImgs() async {
    final String apiUrl = ApiURL.getSliderImgUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var transations = sliderImgModelFromJson(result[AppConst.data]);

        return transations;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<void> getExtraApi() async {
    final String apiUrl = ApiURL.getExchangeExtraApiUrl;
    print('url $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headerData);

      if (response.statusCode == 200) {
        var result = await jsonDecode(response.body);

        var extraApiResult = ExtraApiModel.fromJson(result[AppConst.data]);
        var maps =
            ExtraApiMapsModel.fromJson(jsonDecode(extraApiResult.maps ?? ""));
        var moneyExchange = ExtraApiMapsModel.fromJson(
            await jsonDecode(extraApiResult.moneyExchanger ?? ""));
        var banTransferApi =
            await jsonDecode(extraApiResult.banTransferApi ?? "");

        await preferences.setString(
            AppKeys.mapsExtraApi, "${maps.createLink}?app_id=${maps.apiKey}&");

        await preferences.setString(AppKeys.exchangeExtraApi,
            "${moneyExchange.createLink}?${moneyExchange.apiParameter}=${moneyExchange.apiKey}");

        await preferences.setString(
            AppKeys.bnkBaseLink, "${banTransferApi["create_link"]}");
        await preferences.setString(
            AppKeys.bnkAppTypeKey, "${banTransferApi["appType"]}");
        await preferences.setString(
            AppKeys.bnkUserKey, "${banTransferApi["api_key"]}");
        await preferences.setString(
            AppKeys.bnkPassKey, "${banTransferApi["secret"]}");
        await preferences.setString(
            AppKeys.bnkCustomerIDKey, "${banTransferApi["CustomerID"]}");
        await preferences.setString(
            AppKeys.bnkProgramIdKey, "${banTransferApi["programId"]}");

        await postBnkLogin();
      }
    } catch (error) {
      print('get  extra api not fund $error');
    }
  }

  Future<void> postBnkLogin() async {
    var bnkBaseLink = preferences.getString(AppKeys.bnkBaseLink);

    var apiUrl = bnkBaseLink! + AppConst.bnkLoginCredentialUrl;
    print('api url bnkLogin $apiUrl');
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    var bodyData = {
      "appType": preferences.getString(AppKeys.bnkAppTypeKey),
      "user": preferences.getString(AppKeys.bnkUserKey),
      "pass": preferences.getString(AppKeys.bnkPassKey),
      "CustomerID": preferences.getString(AppKeys.bnkCustomerIDKey)
    };
    print(bodyData.toString());

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(bodyData), headers: headers);
      final result = jsonDecode(response.body);
      print('response bnk login $result');
      print('respons status conde ${response.statusCode}');

      if (response.statusCode == 200) {
        await preferences.setString(
            AppKeys.bnkAccessToken, result["AccessToken"]);
        print('access token for bank login');

        print(result);
        print('access token for bank login');
      }
    } catch (error) {
      print('error bnk Login  == =$error');
    }
  }

// {
//   "appType": 3,
//   "user": "CaribAPI",
//   "pass": "Qa1$JPYvla5tVRTX#d~B21KkP",
//   "CustomerID": 28
// }
  Future<void> getLanguageInfoInPref() async {
    final String apiUrl = ApiURL.getLanguageUrl;
    print('url lang $apiUrl');

    try {
      final response = await http.get(Uri.parse(apiUrl));
      final result = jsonDecode(response.body);

      if (response.statusCode == 200) {
        bool dataStore = await preferences.setString(
            AppKeys.langInfo, jsonEncode(result["data"]));
        print(" langu store done $dataStore");
      }
    } catch (error) {
      print('language pref not store fund $error');
    }
  }

  Future<List<MyNotificationModel>?> getMyNotifications() async {
    final String apiUrl = ApiURL.getNotificationsUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        var notifications = myNotificationModelFromMap(result[AppConst.data]);

        return notifications;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<List<MyNotificationModel>?> getUnreadNotifications() async {
    final String apiUrl = ApiURL.getNotificationsUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        var notifiInfo = <MyNotificationModel>[];
        var notifications = myNotificationModelFromMap(result[AppConst.data]);
        for (var item in notifications) {
          if (item.status == 0) {
            notifiInfo.add(item);
          }
        }
        return notifiInfo;
      }
    } catch (error) {
      print('get  exchange rate not fund $error');
    }
  }

  Future<String?> updateCheckNotification(int id) async {
    final String apiUrl = ApiURL.postCheckNotificationUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode({"notification_id": id}), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success]) {
        return result[AppConst.message];
      }
    } catch (error) {
      print('updateCheckNotification  not fund $error');
    }
  }

  Future<String?> updateAllCheckNotification() async {
    final String apiUrl = ApiURL.postAllCheckNotificationUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: header);
      var result = jsonDecode(response.body);
      print(result);

      if (response.statusCode == 200 && result[AppConst.success]) {
        return result[AppConst.message];
      }
    } catch (error) {
      print('updateAllCheckNotification  not fund $error');
    }
  }

  Future<List<TermsAndConditionsModel>?> getTermAndConditions(
      String lang) async {
    final String apiUrl = "${ApiURL.getTermsAndConditionUrl}english";
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success]) {
        final model = termsAndConditionsModelFromMap(result[AppConst.data]);
        return model;
      }
    } catch (error) {
      print('getTermAndConditions  not fund $error');
    }
  }

  Future<List<TermsAndConditionsModel>?> getPrivacyPolicys(String lang) async {
    final String apiUrl = "${ApiURL.getPrivacyPolicyUrl}english";
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success] == true) {
        final model = termsAndConditionsModelFromMap(result[AppConst.data]);
        return model;
      }
    } catch (error) {
      print('getTermAndConditions  not fund $error');
    }
  }

  Future<List<AboutUsModel>?> getAboutUs(String lang) async {
    final String apiUrl = "${ApiURL.getAboutUsUrl}english";
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success] == true) {
        final model = aboutUsModelFromMap(result[AppConst.data]);
        return model;
      }
    } catch (error) {
      print('getAboutUs  not fund $error');
    }
  }

  Future<TransactionDetailsModel?> postTransactionDetails(int id) async {
    final String apiUrl = ApiURL.postTransactionDetailsUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    var bodyData = {"transaction_id": id};
    try {
      final response = await http.post(Uri.parse(apiUrl),
          body: jsonEncode(bodyData), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success] == true) {
        final model = TransactionDetailsModel.fromMap(result[AppConst.data]);
        return model;
      }
    } catch (error) {
      print('postTransactionDetails  not fund $error');
    }
  }

  Future<MarchantInfoModel?> getMarchantInfo() async {
    final String apiUrl = ApiURL.getMarchantInfoUrl;
    print('url $apiUrl');
    Map<String, String> header = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };

    try {
      final response = await http.get(Uri.parse(apiUrl), headers: header);
      var result = jsonDecode(response.body);

      if (response.statusCode == 200 && result[AppConst.success] == true) {
        final model = MarchantInfoModel.fromMap(result[AppConst.data]);
        return model;
      }
    } catch (error) {
      print('getMarchantInfo  not fund $error');
    }
  }
  // api services er modde hobe
  Future surahServices(String surahNum) async {
  Uri apiUrl = Uri.parse("https://api.alquran.cloud/v1/surah/$surahNum");
  try {
    final response = await http.get(apiUrl);
    print("ResponseStatusCode == ${response.statusCode}");
    var result = json.decode(response.body);
    print("result--------- body == ${result}");
    return result;
  } on Exception catch (exception) {
    print("exception == $exception");
  } catch (error) {
    throw Exception(error);
  }
}
// Controller er modde hobe
  Future<SurahViewModel?> getSurahCon(String surahNum)async {
    try{
      var resValue = await ApiServices().surahServices(surahNum);
      if(resValue != null){
      surahViewModelData =  SurahViewModel.fromJson(resValue["data"]);
        //return surahViewModelFromJson(result);
      }else{
        print("Unsuccessful get data");
      }
    }catch(e){
      print(e);
    }
  }
  // Controller er modde call korte hobe
  SurahViewModel surahViewModelData = SurahViewModel();
  //22
  Future jsonPlaceHolderServices() async {
  Uri apiUrl = Uri.parse("https://jsonplaceholder.typicode.com/posts");
  try{
    final response = await http.get(apiUrl);
    print("ResponseStatusCode == ${response.statusCode}");
    var result = json.decode(response.body);
    print("result------json--- body == ${result}");
    return result;
  } on Exception catch (exception) {
    print("exception == $exception");
  } catch (error){
    throw Exception(error);
  }
}
//
final jsonPlaceHolList = <JsonPlaceHolderViewModel>[].obs;
    Future<List<JsonPlaceHolderViewModel>?> getJsonPlaceHolCon()async {
    try{
      var resValue = await ApiServices().jsonPlaceHolderServices();
      if(resValue != null){
      return jsonPlaceHolderViewModelFromJson(resValue);
        //return surahViewModelFromJson(result);
      }else{
        print("Unsuccessful get data");
      }
    }catch(e){
      print(e);
    }
  }
}
