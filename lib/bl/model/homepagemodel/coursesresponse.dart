import 'dart:convert';

class CoursesResponse {
  List<Coursedata> coursedata;
  CoursesResponse({
    required this.coursedata,
  });

  Map<String, dynamic> toMap() {
    return {
      'coursedata': coursedata.map((x) => x.toMap()).toList(),
    };
  }

  factory CoursesResponse.fromMap(Map<String, dynamic> map) {
    return CoursesResponse(
      coursedata: List<Coursedata>.from(
          map['coursedata']?.map((x) => Coursedata.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CoursesResponse.fromJson(String source) =>
      CoursesResponse.fromMap(json.decode(source));

  @override
  String toString() => 'CoursesResponse(coursedata: $coursedata)';
}

class Coursedata {
  int courseid;
  String coursename;
  String coursefullname;
  String coursetype;
  int accessvalue;
  String? accesstype;
  int? progress;
  String? value;
  int? activityid;
  String? image;
  String? lpshortname;
  String? lpfullname;
  String? status;
  String? email;
  String? city;
  String? state;
  String? country;
  int userid;
  Coursedata({
    required this.courseid,
    required this.coursename,
    required this.coursefullname,
    required this.coursetype,
    required this.accessvalue,
    this.accesstype,
    this.progress,
    this.value,
    this.activityid,
    this.image,
    this.lpshortname,
    this.lpfullname,
    this.status,
    this.email,
    this.city,
    this.state,
    this.country,
    required this.userid,
  });

  Map<String, dynamic> toMap() {
    return {
      'courseid': courseid,
      'coursename': coursename,
      'coursefullname': coursefullname,
      'coursetype': coursetype,
      'accessvalue': accessvalue,
      'accesstype': accesstype,
      'progress': progress,
      'value': value,
      'activityid': activityid,
      'image': image,
      'lpshortname': lpshortname,
      'lpfullname': lpfullname,
      'status': status,
      'email': email,
      'city': city,
      'state': state,
      'country': country,
      'userid': userid,
    };
  }

  factory Coursedata.fromMap(Map<String, dynamic> map) {
    return Coursedata(
      courseid: map['courseid']?.toInt() ?? 0,
      coursename: map['coursename'] ?? '',
      coursefullname: map['coursefullname'] ?? '',
      coursetype: map['coursetype'] ?? '',
      accessvalue: map['accessvalue']?.toInt() ?? 0,
      accesstype: map['accesstype'],
      progress: map['progress']?.toInt(),
      value: map['value'],
      activityid: map['activityid']?.toInt(),
      image: map['image'],
      lpshortname: map['lpshortname'],
      lpfullname: map['lpfullname'],
      status: map['status'],
      email: map['email'],
      city: map['city'],
      state: map['state'],
      country: map['country'],
      userid: map['userid']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Coursedata.fromJson(String source) =>
      Coursedata.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Coursedata(courseid: $courseid, coursename: $coursename, coursefullname: $coursefullname, coursetype: $coursetype, accessvalue: $accessvalue, accesstype: $accesstype, progress: $progress, value: $value, activityid: $activityid, image: $image, lpshortname: $lpshortname, lpfullname: $lpfullname, status: $status, email: $email, city: $city, state: $state, country: $country, userid: $userid)';
  }
}
