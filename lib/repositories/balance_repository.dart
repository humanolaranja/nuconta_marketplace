class BalanceRepository {
  static String query = """
    query balance { 
      viewer { 
        balance 
      } 
    }
  """;
}
