class CategoryModel {
  static String sportsId = 'sports';
  static String musicId = 'music';
  static String moviesId = 'movies';
  static String gamesId = 'games';

  String id;
  late String name;
  late String image;

  CategoryModel(this.id, this.name, this.image);
  CategoryModel.fromId(this.id) {
    image = 'assets/images/rooms/$id.png';
    name = id;
  }

  static List<CategoryModel> getCategories() {
    return [
      CategoryModel.fromId(sportsId),
      CategoryModel.fromId(musicId),
      CategoryModel.fromId(moviesId),
      CategoryModel.fromId(gamesId),
    ];
  }
}
