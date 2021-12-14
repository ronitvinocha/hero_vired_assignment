import 'dart:convert';

class UserResponse {
  User user;
  String? userToken;
  String? userTokenLocalMobile;
  String? status;
  String? usertype;
  UserResponse({
    required this.user,
    this.userToken,
    this.userTokenLocalMobile,
    this.status,
    this.usertype,
  });

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(),
      'userToken': userToken,
      'userTokenLocalMobile': userTokenLocalMobile,
      'status': status,
      'usertype': usertype,
    };
  }

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      user: User.fromMap(map['user']),
      userToken: map['user_token'],
      userTokenLocalMobile: map['user_token_local_mobile'],
      status: map['status'],
      usertype: map['usertype'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserResponse.fromJson(String source) =>
      UserResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserResponse(user: $user, userToken: $userToken, userTokenLocalMobile: $userTokenLocalMobile, status: $status, usertype: $usertype)';
  }
}

class User {
  String id;
  String? auth;
  String? confirmed;
  String? policyagreed;
  String? deleted;
  String? suspended;
  String? mnethostid;
  String username;
  String? password;
  String? idnumber;
  String? firstname;
  String? lastname;
  String? email;
  String? emailstop;
  String? icq;
  String? skype;
  String? yahoo;
  String? aim;
  String? msn;
  String? phone1;
  String? phone2;
  String? institution;
  String? department;
  String? address;
  String? city;
  String? country;
  String? lang;
  String? calendartype;
  String? theme;
  String? timezone;
  String? firstaccess;
  String? lastaccess;
  String? lastlogin;
  String? currentlogin;
  String? lastip;
  String? secret;
  String? picture;
  String? url;
  String? description;
  String? descriptionformat;
  String? mailformat;
  String? maildigest;
  String? maildisplay;
  String? autosubscribe;
  String? trackforums;
  String? timecreated;
  String? timemodified;
  String? trustbitmask;
  String? imagealt;
  String? lastnamephonetic;
  String? firstnamephonetic;
  String? middlename;
  String? alternatename;
  String? moodlenetprofile;
  String? registered;
  User({
    required this.id,
    this.auth,
    this.confirmed,
    this.policyagreed,
    this.deleted,
    this.suspended,
    this.mnethostid,
    required this.username,
    this.password,
    this.idnumber,
    this.firstname,
    this.lastname,
    this.email,
    this.emailstop,
    this.icq,
    this.skype,
    this.yahoo,
    this.aim,
    this.msn,
    this.phone1,
    this.phone2,
    this.institution,
    this.department,
    this.address,
    this.city,
    this.country,
    this.lang,
    this.calendartype,
    this.theme,
    this.timezone,
    this.firstaccess,
    this.lastaccess,
    this.lastlogin,
    this.currentlogin,
    this.lastip,
    this.secret,
    this.picture,
    this.url,
    this.description,
    this.descriptionformat,
    this.mailformat,
    this.maildigest,
    this.maildisplay,
    this.autosubscribe,
    this.trackforums,
    this.timecreated,
    this.timemodified,
    this.trustbitmask,
    this.imagealt,
    this.lastnamephonetic,
    this.firstnamephonetic,
    this.middlename,
    this.alternatename,
    this.moodlenetprofile,
    this.registered,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'auth': auth,
      'confirmed': confirmed,
      'policyagreed': policyagreed,
      'deleted': deleted,
      'suspended': suspended,
      'mnethostid': mnethostid,
      'username': username,
      'password': password,
      'idnumber': idnumber,
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'emailstop': emailstop,
      'icq': icq,
      'skype': skype,
      'yahoo': yahoo,
      'aim': aim,
      'msn': msn,
      'phone1': phone1,
      'phone2': phone2,
      'institution': institution,
      'department': department,
      'address': address,
      'city': city,
      'country': country,
      'lang': lang,
      'calendartype': calendartype,
      'theme': theme,
      'timezone': timezone,
      'firstaccess': firstaccess,
      'lastaccess': lastaccess,
      'lastlogin': lastlogin,
      'currentlogin': currentlogin,
      'lastip': lastip,
      'secret': secret,
      'picture': picture,
      'url': url,
      'description': description,
      'descriptionformat': descriptionformat,
      'mailformat': mailformat,
      'maildigest': maildigest,
      'maildisplay': maildisplay,
      'autosubscribe': autosubscribe,
      'trackforums': trackforums,
      'timecreated': timecreated,
      'timemodified': timemodified,
      'trustbitmask': trustbitmask,
      'imagealt': imagealt,
      'lastnamephonetic': lastnamephonetic,
      'firstnamephonetic': firstnamephonetic,
      'middlename': middlename,
      'alternatename': alternatename,
      'moodlenetprofile': moodlenetprofile,
      'registered': registered,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      auth: map['auth'],
      confirmed: map['confirmed'],
      policyagreed: map['policyagreed'],
      deleted: map['deleted'],
      suspended: map['suspended'],
      mnethostid: map['mnethostid'],
      username: map['username'],
      password: map['password'],
      idnumber: map['idnumber'],
      firstname: map['firstname'],
      lastname: map['lastname'],
      email: map['email'],
      emailstop: map['emailstop'],
      icq: map['icq'],
      skype: map['skype'],
      yahoo: map['yahoo'],
      aim: map['aim'],
      msn: map['msn'],
      phone1: map['phone1'],
      phone2: map['phone2'],
      institution: map['institution'],
      department: map['department'],
      address: map['address'],
      city: map['city'],
      country: map['country'],
      lang: map['lang'],
      calendartype: map['calendartype'],
      theme: map['theme'],
      timezone: map['timezone'],
      firstaccess: map['firstaccess'],
      lastaccess: map['lastaccess'],
      lastlogin: map['lastlogin'],
      currentlogin: map['currentlogin'],
      lastip: map['lastip'],
      secret: map['secret'],
      picture: map['picture'],
      url: map['url'],
      description: map['description'],
      descriptionformat: map['descriptionformat'],
      mailformat: map['mailformat'],
      maildigest: map['maildigest'],
      maildisplay: map['maildisplay'],
      autosubscribe: map['autosubscribe'],
      trackforums: map['trackforums'],
      timecreated: map['timecreated'],
      timemodified: map['timemodified'],
      trustbitmask: map['trustbitmask'],
      imagealt: map['imagealt'],
      lastnamephonetic: map['lastnamephonetic'],
      firstnamephonetic: map['firstnamephonetic'],
      middlename: map['middlename'],
      alternatename: map['alternatename'],
      moodlenetprofile: map['moodlenetprofile'],
      registered: map['registered'],
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
