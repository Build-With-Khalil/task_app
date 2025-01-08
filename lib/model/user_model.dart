class User {
  final String id;
  final String name; // Optional, use default value
  final String email;
  final String profilePicture;

  User({
    required this.id,
    this.name = "Unknown User", // Default name
    this.email = "No email available", // Default email
    this.profilePicture =
        "https://via.placeholder.com/150", // Default profile picture
  });
}
