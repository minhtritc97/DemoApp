class User {
  String gender;
  String title;
  String first;
  String last;
  String street;
  String city;
  String state;
  String zip;
  String email;
  String username;
  String password;
  String salt;
  String md5;
  String sha1;
  String sha256;
  String registered;
  String dob;
  String phone;
  String cell;
  String SSN;
  String picture;


  User({
      this.gender,
      this.title,
      this.first,
      this.last,
      this.street,
      this.city,
      this.state,
      this.zip,
      this.email,
      this.username,
      this.password,
      this.salt,
      this.md5,
      this.sha1,
      this.sha256,
      this.registered,
      this.dob,
      this.phone,
      this.cell,
      this.SSN,
      this.picture});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      gender: json['results'][0]['user']['gender'],
      title: json['results'][0]['user']['name']['title'],
      first: json['results'][0]['user']['name']['first'],
      last: json['results'][0]['user']['name']['last'],
      street: json['results'][0]['user']['location']['street'],
      city: json['results'][0]['user']['location']['city'],
      state: json['results'][0]['user']['location']['state'],
      zip: json['results'][0]['user']['location']['zip'],
      email: json['results'][0]['user']['email'],
      username: json['results'][0]['user']['username'],
      password: json['results'][0]['user']['password'],
      salt: json['results'][0]['user']['salt'],
      md5: json['results'][0]['user']['md5'],
      sha1: json['results'][0]['user']['sha1'],
      sha256: json['results'][0]['user']['sha256'],
      registered: json['results'][0]['user']['registered'],
      dob: json['results'][0]['user']['dob'],
      phone: json['results'][0]['user']['phone'],
      cell: json['results'][0]['user']['cell'],
      SSN: json['results'][0]['user']['SSN'],
      picture: json['results'][0]['user']['picture'],
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'gender': gender,
        'title': title,
        'first': first,
        'last': last,
        'street': street,
        'city':city,
        'state': state,
        'zip':zip,
        'email': email,
        'username': username,
        'password': password,
        'salt': salt,
        'md5': md5,
        'sha1': sha1,
        'sha256':sha256,
        'registered': registered,
        'dob': dob,
        'phone': phone,
        'cell': cell,
        'SSN':SSN,
        'picture': picture,
      };

}

