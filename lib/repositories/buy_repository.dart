class BuyRepository {
  static String query = r"""
    mutation buy_product($offerId: ID!) {
      purchase(offerId: $offerId)  { 
        success 
        errorMessage
        customer {
          balance
        }
      }
    }
  """;
}
