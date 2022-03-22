import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:jobs_app/models/jobs_model.dart';

class APIManager {
  String jobsUrl = 'https://remotive.io/api/remote-jobs';

  Future<JobsModel> getJobs() async {
    var client = http.Client();
    late JobsModel jobsModel;

    try {
      var response = await client.get(Uri.parse(jobsUrl));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);
        //return jsonMap;
        jobsModel = JobsModel.fromJson(jsonMap);
      }
    } catch (exception) {
      // ignore: avoid_print
      print(exception);
    }
    return jobsModel;
  }
}
