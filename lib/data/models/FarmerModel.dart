class FarmerModel {
  List<Skill> skills;
  ContactDetails contactDetails;
  bool availability;

  FarmerModel({
    required this.skills,
    required this.contactDetails,
    required this.availability,
  });

  // Factory method to create FarmerModel from JSON
  factory FarmerModel.fromJson(Map<String, dynamic> json) {
    return FarmerModel(
      skills: (json['skills'] as List<dynamic>)
          .map((skill) => Skill.fromJson(skill))
          .toList(),
      contactDetails: ContactDetails.fromJson(json['contactDetails']),
      availability: json['availability'],
    );
  }

  // Method to convert FarmerModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'skills': skills.map((skill) => skill.toJson()).toList(),
      'contactDetails': contactDetails.toJson(),
      'availability': availability,
    };
  }
}

class Skill {
  String category;
  int experience;
  String description;

  Skill({
    required this.category,
    required this.experience,
    required this.description,
  });

  // Factory method to create Skill from JSON
  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      category: json['category'],
      experience: json['experience'],
      description: json['description'],
    );
  }

  // Method to convert Skill to JSON
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'experience': experience,
      'description': description,
    };
  }
}

class ContactDetails {
  String phone;
  String address;

  ContactDetails({
    required this.phone,
    required this.address,
  });

  // Factory method to create ContactDetails from JSON
  factory ContactDetails.fromJson(Map<String, dynamic> json) {
    return ContactDetails(
      phone: json['phone'],
      address: json['address'],
    );
  }

  // Method to convert ContactDetails to JSON
  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'address': address,
    };
  }
}
