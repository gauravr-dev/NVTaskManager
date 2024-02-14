enum ButtonThemes {
  black,
  white,
  transparent,
  gray,
  lightGray,
  primaryBlue,
  disabled
}

enum PassowrdCriteria {
  hasMinLength,
  hasUpperCase,
  hasDigits,
  hasSpecialCharacters
}

enum SocialAuthProviderIds {
  apple("apple.com"),
  google("google.com"),
  facebook("facebook.com");

  final String name;

  const SocialAuthProviderIds(this.name);
}

enum EventState { active, draft, archived, cancelled }

enum EventFormState { creating, editing, copying, posting }

enum UserRole { user, admin }
