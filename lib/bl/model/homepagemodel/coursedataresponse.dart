import 'dart:convert';

class CoursesDataResponse {
  int id;
  String name;
  int? visible;
  String? summary;
  int? summaryformat;
  int? section;
  int? hiddenbynumsections;
  bool? uservisible;
  List<Modules> modules;
  CoursesDataResponse({
    required this.id,
    required this.name,
    this.visible,
    this.summary,
    this.summaryformat,
    this.section,
    this.hiddenbynumsections,
    this.uservisible,
    required this.modules,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'visible': visible,
      'summary': summary,
      'summaryformat': summaryformat,
      'section': section,
      'hiddenbynumsections': hiddenbynumsections,
      'uservisible': uservisible,
      'modules': modules.map((x) => x.toMap()).toList(),
    };
  }

  factory CoursesDataResponse.fromMap(Map<String, dynamic> map) {
    return CoursesDataResponse(
        id: map['id']?.toInt() ?? 0,
        name: map['name'] ?? '',
        visible: map['visible']?.toInt(),
        summary: map['summary'],
        summaryformat: map['summaryformat']?.toInt(),
        section: map['section']?.toInt(),
        hiddenbynumsections: map['hiddenbynumsections']?.toInt(),
        uservisible: map['uservisible'],
        modules:
            List<Modules>.from(map['modules']?.map((x) => Modules.fromMap(x))));
  }

  String toJson() => json.encode(toMap());

  factory CoursesDataResponse.fromJson(String source) =>
      CoursesDataResponse.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CoursesDataResponse(id: $id, name: $name, visible: $visible, summary: $summary, summaryformat: $summaryformat, section: $section, hiddenbynumsections: $hiddenbynumsections, uservisible: $uservisible, modules: $modules)';
  }
}

class Modules {
  int id;
  String? url;
  String name;
  int? instance;
  int? visible;
  bool? uservisible;
  int? visibleoncoursepage;
  String? modicon;
  String? modname;
  String? modplural;
  int? indent;
  String? onclick;
  String? afterlink;
  String? customdata;
  bool? noviewlink;
  int? completion;
  Modules({
    required this.id,
    this.url,
    required this.name,
    this.instance,
    this.visible,
    this.uservisible,
    this.visibleoncoursepage,
    this.modicon,
    this.modname,
    this.modplural,
    this.indent,
    this.onclick,
    this.afterlink,
    this.customdata,
    this.noviewlink,
    this.completion,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'name': name,
      'instance': instance,
      'visible': visible,
      'uservisible': uservisible,
      'visibleoncoursepage': visibleoncoursepage,
      'modicon': modicon,
      'modname': modname,
      'modplural': modplural,
      'indent': indent,
      'onclick': onclick,
      'afterlink': afterlink,
      'customdata': customdata,
      'noviewlink': noviewlink,
      'completion': completion,
    };
  }

  factory Modules.fromMap(Map<String, dynamic> map) {
    return Modules(
      id: map['id']?.toInt() ?? 0,
      url: map['url'],
      name: map['name'] ?? '',
      instance: map['instance']?.toInt(),
      visible: map['visible']?.toInt(),
      uservisible: map['uservisible'],
      visibleoncoursepage: map['visibleoncoursepage']?.toInt(),
      modicon: map['modicon'],
      modname: map['modname'],
      modplural: map['modplural'],
      indent: map['indent']?.toInt(),
      onclick: map['onclick'],
      afterlink: map['afterlink'],
      customdata: map['customdata'],
      noviewlink: map['noviewlink'],
      completion: map['completion']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Modules.fromJson(String source) =>
      Modules.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Modules(id: $id, url: $url, name: $name, instance: $instance, visible: $visible, uservisible: $uservisible, visibleoncoursepage: $visibleoncoursepage, modicon: $modicon, modname: $modname, modplural: $modplural, indent: $indent, onclick: $onclick, afterlink: $afterlink, customdata: $customdata, noviewlink: $noviewlink, completion: $completion)';
  }
}
