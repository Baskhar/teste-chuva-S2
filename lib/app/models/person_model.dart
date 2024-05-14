


class Person {
   int? id;
   String? title;
   String? name;
   String? institution;
      Map<String, dynamic>? bio;
   String? picture;
   int? weight;
   Role? role;
   String? hash;

  Person({
     this.id,
     this.title,
     this.name,
     this.institution,
     this.bio,
     this.picture,
     this.weight,
     this.role,
     this.hash,
  });


}


class Role {
  final int id;
  final String label;

  Role({required this.id, required this.label});

}


