const String GOOGLE_MAPS_API_KEY = 'AIzaSyB7yQz_7PZnwN1PRyDuvfq0oMuZ_qryVSE';

class PlaceAutocomplete {
  final String description;
  final String placeId;

  PlaceAutocomplete({
    required this.description,
    required this.placeId,
  });

  factory PlaceAutocomplete.fromJson(Map<String, dynamic> json) {
    return PlaceAutocomplete(
        description: json['description'], placeId: json['place_id']);
  }
}

class Food {
  final String variety;
  final String name;
  final String description;
  final double price;
  final String image;
  Restaurant? restaurant; // Reference to the parent restaurant

  Food({
    required this.variety,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.restaurant, // Update constructor to include parent restaurant
  });
}

class Restaurant {
  final String name;
  final String description;
  final String address;
  final String cuisine;
  final double latitude;
  final double longitude;
  final double rating;
  final String image;
  final List<Food> foods;

  Restaurant({
    required this.name,
    required this.description,
    required this.address,
    required this.cuisine,
    required this.latitude,
    required this.longitude,
    required this.rating,
    required this.image,
    required this.foods,
  }) {
    // Set the reference to the parent restaurant for each food item
    for (var food in foods) {
      food.restaurant = this;
    }
  }
}

final List<Restaurant> restaurants = [
  Restaurant(
    name: "Angel's Pizza",
    description: "Serving delicious pizza and pasta.",
    address: "123 Main St, Metro Manila, Philippines",
    cuisine: 'American',
    latitude: 14.5995,
    longitude: 120.9842,
    rating: 4.5,
    image: "assets/images/angels_pizza.jpg",
    foods: [
      Food(
        variety: "12-inch",
        name: "Supreme Pizza",
        description: "Loaded with assorted toppings and cheese.",
        price: 12.99, // Set price
        image: "assets/images/supreme_pizza.jpg",
      ),
      Food(
        variety: "12-inch",
        name: "Pepperoni Pizza",
        description: "Classic pizza topped with pepperoni slices.",
        price: 11.99, // Set price
        image: "assets/images/pepperoni_pizza.jpg",
      ),
      Food(
        variety: "Pasta",
        name: "Carbonara",
        description: "Creamy pasta with bacon bits and parmesan cheese.",
        price: 9.99, // Set price
        image: "assets/images/carbonara_pasta.jpg",
      ),
      Food(
        variety: "Pasta",
        name: "Spaghetti Bolognese",
        description: "Spaghetti noodles in savory meat sauce.",
        price: 8.99, // Set price
        image: "assets/images/spaghetti_bolognese.jpg",
      ),
      Food(
        variety: "Side",
        name: "Garlic Bread",
        description: "Toasted bread with garlic and butter.",
        price: 4.99, // Set price
        image: "assets/images/garlic_bread.jpg",
      ),
    ],
  ),
  Restaurant(
    name: "Jollibee",
    description: "Home of the famous Chickenjoy and Jolly Spaghetti.",
    address: "456 Oak St, Manila, Philippines",
    cuisine: 'Filipino',
    latitude: 14.6091,
    longitude: 121.0223,
    rating: 4.8,
    image: "assets/images/jollibee.jpg",
    foods: [
      Food(
        variety: "Combo",
        name: "Chickenjoy",
        description: "Crispy fried chicken served with rice and gravy.",
        price: 7.99, // Set price
        image: "assets/images/chickenjoy.jpg",
      ),
      Food(
        variety: "Combo",
        name: "Jolly Spaghetti",
        description: "Sweet-style spaghetti with hotdog slices.",
        price: 6.99, // Set price
        image: "assets/images/jolly_spaghetti.jpg",
      ),
      Food(
        variety: "Burger",
        name: "Yumburger",
        description: "Juicy burger with special sauce and cheese.",
        price: 3.99, // Set price
        image: "assets/images/yumburger.jpg",
      ),
      Food(
        variety: "Dessert",
        name: "Peach Mango Pie",
        description: "Golden pastry filled with sweet mangoes and peaches.",
        price: 2.99, // Set price
        image: "assets/images/peach_mango_pie.jpg",
      ),
      Food(
        variety: "Dessert",
        name: "Sundae",
        description: "Creamy vanilla ice cream topped with chocolate syrup.",
        price: 1.99, // Set price
        image: "assets/images/sundae.jpg",
      ),
    ],
  ),
  Restaurant(
    name: "Mang Inasal",
    description: "Home of the famous Chicken Inasal.",
    address: "789 Palm St, Cebu City, Philippines",
    cuisine: 'Filipino',
    latitude: 10.3157,
    longitude: 123.8854,
    rating: 4.7,
    image: "assets/images/mang_inasal.jpg",
    foods: [
      Food(
        variety: "Meal",
        name: "Chicken Inasal",
        description:
            "Grilled chicken marinated in vinegar, calamansi, and spices.",
        price: 8.50, // Set price
        image: "assets/images/chicken_inasal.jpg",
      ),
      Food(
        variety: "Meal",
        name: "Pork Sisig",
        description:
            "Sizzling minced pork cheeks and liver with onions and chili.",
        price: 9.99, // Set price
        image: "assets/images/pork_sisig.jpg",
      ),
      Food(
        variety: "Side",
        name: "Garlic Rice",
        description: "Steamed rice fried with garlic bits.",
        price: 1.50, // Set price
        image: "assets/images/garlic_rice.jpg",
      ),
      Food(
        variety: "Dessert",
        name: "Leche Flan",
        description: "Creamy caramel custard topped with syrup.",
        price: 2.50, // Set price
        image: "assets/images/leche_flan.jpg",
      ),
      Food(
        variety: "Dessert",
        name: "Buko Pandan",
        description: "Refreshing dessert made with coconut and pandan jelly.",
        price: 2.99, // Set price
        image: "assets/images/buko_pandan.jpg",
      ),
    ],
  ),
  Restaurant(
    name: "McDonald's",
    description: "The world's leading fast-food chain.",
    address: "890 Maple St, Quezon City, Philippines",
    cuisine: 'American',
    latitude: 14.6760,
    longitude: 121.0437,
    rating: 4.6,
    image: "assets/images/mcdonalds.jpg",
    foods: [
      Food(
        variety: "Meal",
        name: "Big Mac",
        description:
            "Iconic burger with two beef patties, special sauce, lettuce, cheese, pickles, and onions on a sesame seed bun.",
        price: 5.99, // Set price
        image: "assets/images/big_mac.jpg",
      ),
      Food(
        variety: "Meal",
        name: "McSpicy",
        description:
            "Spicy chicken fillet with lettuce and mayonnaise in a sesame seed bun.",
        price: 6.49, // Set price
        image: "assets/images/mcspicy.jpg",
      ),
      Food(
        variety: "Meal",
        name: "Chicken McNuggets",
        description: "Breaded chicken nuggets served with dipping sauces.",
        price: 4.99, // Set price
        image: "assets/images/chicken_mcnuggets.jpg",
      ),
      Food(
        variety: "Side",
        name: "French Fries",
        description: "Golden, crispy fries.",
        price: 2.49, // Set price
        image: "assets/images/french_fries.jpg",
      ),
      Food(
        variety: "Dessert",
        name: "Apple Pie",
        description: "Warm apple pie with a flaky crust.",
        price: 1.99, // Set price
        image: "assets/images/apple_pie.jpg",
      ),
    ],
  ),
  Restaurant(
    name: "Dimsum Break",
    description: "A popular destination for authentic dim sum.",
    address: "999 Bamboo St, Davao City, Philippines",
    cuisine: 'Chinese',
    latitude: 7.0712,
    longitude: 125.6129,
    rating: 4.4,
    image: "assets/images/dimsum_break.jpg",
    foods: [
      Food(
        variety: "Dim Sum",
        name: "Siomai",
        description: "Steamed pork dumplings.",
        price: 3.50, // Set price
        image: "assets/images/siomai.jpg",
      ),
      Food(
        variety: "Dim Sum",
        name: "Har Gow",
        description: "Steamed shrimp dumplings.",
        price: 4.00, // Set price
        image: "assets/images/har_gow.jpg",
      ),
      Food(
        variety: "Dim Sum",
        name: "Char Siu Bao",
        description: "Steamed barbecue pork buns.",
        price: 3.75, // Set price
        image: "assets/images/char_siu_bao.jpg",
      ),
      Food(
        variety: "Dim Sum",
        name: "Shrimp Cheong Fun",
        description: "Steamed rice noodle rolls with shrimp.",
        price: 4.25, // Set price
        image: "assets/images/shrimp_cheong_fun.jpg",
      ),
      Food(
        variety: "Dim Sum",
        name: "Egg Custard Tart",
        description: "Baked egg custard tart with flaky crust.",
        price: 2.99, // Set price
        image: "assets/images/egg_custard_tart.jpg",
      ),
    ],
  ),
];
