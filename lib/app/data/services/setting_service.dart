import 'dart:convert';

import '../../../main.dart';
import '../../core/values/app_config.dart';
import 'package:http/http.dart' as http;

final settingProvider = Provider<SettingService>(
  (ref) => SettingService(),
);

class SettingService {
  Map<String, String> headerData = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
  };
  //
  Future<CuminAuthModel?> getCuminAuthenticator() async {
    final Map<String, String> headerDataForCumiAuth = {
      "Accept": "application/json",
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    final Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/check-cauth-status");
    print('url $apiUrl');

    try {
      final response = await http.get(apiUrl, headers: headerDataForCumiAuth);
      print("response body = ${response.body}");
      var result = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return CuminAuthModel.fromJson(result["data"]);
      } else {
        return null;
      }
    } catch (error) {
      print('get single balance not fund $error');
      return null;
    }
  }

  // enableCauthProvider
  Future<Map<String, dynamic>> enableCauthProvider(
      String secret, String auth_code) async {
    final Map<String, String> headerDataForSetPin = {
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/enable-cauth");
    print(apiUrl);
    try {
      final response = await http.post(apiUrl,
          body: {
            "secret": secret,
            "auth_code": auth_code,
          },
          headers: headerDataForSetPin);
      print('bodyResponse auth_code  status:${response.statusCode}');
      print('bodyResponse auth_code  code:${response.body}');
      var result = jsonDecode(response.body);
      return result;
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  // customerMessageProvider
  Future<String> customerMessageProvider(String message) async {
    final Map<String, String> headerDataForSetPin = {
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/customer-message");
    print(apiUrl);
    try {
      final response = await http.post(apiUrl,
          body: {
            "message": message,
          },
          headers: headerDataForSetPin);
      print('bodyResponse customerMessage  status:${response.statusCode}');
      print('bodyResponse customerMessage  code:${response.body}');
      var result = jsonDecode(response.body);
      return result["message"];
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  //
  Future<String> updateCurrency(String currency) async {
    final Map<String, String> headerDataForCurrency = {
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/update-base-currency");
    print(apiUrl);
    try {
      final response = await http.put(apiUrl,
          body: {
            "currency": currency,
          },
          headers: headerDataForCurrency);
      print('bodyResponse updateCurrency  status:${response.statusCode}');
      print('bodyResponse updateCurrency  code:${response.body}');
      var result = jsonDecode(response.body);
      return result["message"];
    } on Exception catch (error) {
      throw Exception(error);
    }
  }

  // updateBankInfo
  Future<String> updateBankInfo(
      UpdateBankInfoHolder updateBankInfoHolder) async {
    final Map<String, String> headerDataForUpdateBankInfo = {
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    Uri apiUrl =
        Uri.parse("${AppConfig.baseUrl}cumin_api_test/api/setting/update-bank");
    print('$apiUrl');

    try {
      final response = await http.put(apiUrl,
          body: updateBankInfoHolder.toJson(),
          headers: headerDataForUpdateBankInfo);
      print(' response: ${response.body}');
      var result = jsonDecode(response.body);

      if (result["success"] == true) {
        return result["message"];
      } else {
        return '';
      }
    } catch (error) {
      print('update bank info error  $error');
      return '';
    }
  }

  // get bank information
  // Future<UpdateBankInfoHolder?> getBankInfo() async {
  //   final Map<String, String> headerDataForCumiAuth = {
  //     "Accept": "application/json",
  //     "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
  //   };
  //   final Uri apiUrl = Uri.parse(
  //       "${AppConfig.baseUrl}cumin_api_test/api/setting/get-withdraw-methods");
  //   print('url $apiUrl');

  //   try {
  //     final response = await http.get(apiUrl, headers: headerDataForCumiAuth);
  //     print("response body = ${response.body}");
  //     var result = jsonDecode(response.body);
  //     print("result = $result");
  //     if (response.statusCode == 200) {
  //       return UpdateBankInfoHolder.fromJson(result["data"]["bank"]);
  //     } else {
  //       return null;
  //     }
  //   } catch (error) {
  //     print('get bank info not fund $error');
  //     return null;
  //   }
  // }

  Future<UpdateBankAndCardInfoHolder?> getBankInfo() async {
    final Map<String, String> headerDataForCumiAuth = {
      "Accept": "application/json",
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    final Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/get-withdraw-methods");
    print('url $apiUrl');

    try {
      final response = await http.get(apiUrl, headers: headerDataForCumiAuth);
      print("response body = ${response.body}");
      var result = jsonDecode(response.body);
      print("result = $result");
      if (response.statusCode == 200) {
        return UpdateBankAndCardInfoHolder.fromJson(result["data"]);
      } else {
        return null;
      }
    } catch (error) {
      print('get bank info not fund $error');
      return null;
    }
  }

  // update card information
  Future<String> updateCardInfo(UpdateCardInfoHolder holder) async {
    final Map<String, String> headerDataForUpdateCardInfo = {
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    final Uri apiUrl =
        Uri.parse("${AppConfig.baseUrl}cumin_api_test/api/setting/update-card");
    print('$apiUrl');
    try {
      final response = await http.put(apiUrl,
          body: holder.toJson(), headers: headerDataForUpdateCardInfo);
      print(' response: ${response.body}');
      final result = jsonDecode(response.body);
      return result["message"];
    } catch (error) {
      print("get bank info not found");
      return '';
    }
  }

  Future<List<FaqListModel>?> getFaqInfo() async {
    final Map<String, String> headerDataForFaq = {
      "Accept": "application/json",
      "Authorization": "Bearer ${preferences.getString(AppKeys.token)}"
    };
    final Uri apiUrl = Uri.parse(
        "${AppConfig.baseUrl}cumin_api_test/api/setting/faq-list/english");
    print('url $apiUrl');

    try {
      final response = await http.get(apiUrl, headers: headerDataForFaq);
      print("response body = ${response.body}");
      var result = jsonDecode(response.body);
      print("result = $result");
      if (response.statusCode == 200) {
        return faqListModelFromJson(result["data"]);
      }
    } catch (error) {
      print('get faq info not fund =  $error');
    }
    return null;
  }

  Future<bool?> setBiometric() async {
    Uri apiUrl = Uri.parse(ApiURL.postAddBiometricUrl);
    print(apiUrl);

    try {
      final response = await http.post(apiUrl, headers: headerData);
      var result = jsonDecode(response.body);
      if (response.statusCode == 200 && result[AppConst.success] == true) {
        print(result[AppConst.success]);
        print(result[AppConst.data]);
        await preferences.setString(
            AppKeys.biometricSecretKey, result[AppConst.data]['secret_key']);
        return true;
      }
    } on Exception catch (error) {
      print('set biometric errro $error');

      throw Exception(error);
    }
  }
}
