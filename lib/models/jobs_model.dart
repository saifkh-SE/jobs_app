
class JobsModel {
  int? jobCount;
  List<Jobs>? jobs;

  JobsModel({this.jobCount, this.jobs});

  JobsModel.fromJson(Map<String, dynamic> json) {
    jobCount = json['job-count'];
    if (json['jobs'] != null) {
      jobs = <Jobs>[];
      json['jobs'].forEach((v) {
        jobs!.add(new Jobs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job-count'] = this.jobCount;
    if (this.jobs != null) {
      data['jobs'] = this.jobs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jobs {
  int? id;
  String? url;
  String? title;
  String? companyName;
  String? companyLogo;
  String? category;
  List<String>? tags;
  String? jobType;
  String? publicationDate;
  String? candidateRequiredLocation;
  String? salary;
  String? description;
  String? companyLogoUrl;

  Jobs(
      {this.id,
      this.url,
      this.title,
      this.companyName,
      this.companyLogo,
      this.category,
      this.tags,
      this.jobType,
      this.publicationDate,
      this.candidateRequiredLocation,
      this.salary,
      this.description,
      this.companyLogoUrl});

  Jobs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    title = json['title'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    category = json['category'];
    tags = json['tags'].cast<String>();
    jobType = json['job_type'];
    publicationDate = json['publication_date'];
    candidateRequiredLocation = json['candidate_required_location'];
    salary = json['salary'];
    description = json['description'];
    companyLogoUrl = json['company_logo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['title'] = this.title;
    data['company_name'] = this.companyName;
    data['company_logo'] = this.companyLogo;
    data['category'] = this.category;
    data['tags'] = this.tags;
    data['job_type'] = this.jobType;
    data['publication_date'] = this.publicationDate;
    data['candidate_required_location'] = this.candidateRequiredLocation;
    data['salary'] = this.salary;
    data['description'] = this.description;
    data['company_logo_url'] = this.companyLogoUrl;
    return data;
  }
}