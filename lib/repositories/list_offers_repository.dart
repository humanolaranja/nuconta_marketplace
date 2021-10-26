class ListOffersRepository {
  static String query = """
    query list_offers {
      viewer {
        offers {
          id
          price
          product { 
            id
            name
            description
            image
          }
        }
      }
    }
  """;
}
