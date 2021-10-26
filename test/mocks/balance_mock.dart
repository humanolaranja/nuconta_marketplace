class BalanceMock {
  static Map<String, dynamic> response = {
    "data": {
      "__typename": "QueryRoot",
      "viewer": {"__typename": "Customer", "balance": 1000000}
    }
  };
}
