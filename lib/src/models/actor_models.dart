class Cast {
  List<Actor> actors = new List();

  Cast(this.actors);

  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((actor) {
      final item = new Actor.fromJsonMap(actor);
      actors.add(item);
    });
  }
}

class Actor {
  String credit_id;
  String department;
  int gender;
  int id;
  String job;
  String name;
  String profile_path;

  Actor(
      {this.credit_id,
      this.department,
      this.gender,
      this.id,
      this.job,
      this.name,
      this.profile_path});

  Actor.fromJsonMap(Map<String, dynamic> json) {
    credit_id = json['credit_id'];
    department = json['department'];
    gender = json['gender'];
    id = json['id'];
    job = json['job'];
    name = json['name'];
    profile_path = json['profile_path'];
  }

  getAvatar() {
    var retorno = 'https://www.driven-u.com/wp-content/members/avatar_none.gif';
    if (profile_path != null) {
      retorno = 'https://image.tmdb.org/t/p/w500/$profile_path';
    }
    return retorno;
  }
}
