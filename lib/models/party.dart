// Model for the party data fields
class Party {
  String title;
  DateTime date;
  String location;
  int population;
  String description;
  String theme;

  Party(this.title, this.date, this.location, this.population, this.description, this.theme);

  Map<String, dynamic> toJson() => {
    'title': title,
    'theme': theme,
    'date': date,
    'location': location,
    'attendance': population,
    'description': description,
  };
}