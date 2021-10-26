class BuyMock {
  static Map<String, dynamic> response = {
    "data": {
      "__typename": "MutationRoot",
      "purchase": {
        "__typename": "PurchaseMutationResponse",
        "success": true,
        "errorMessage": null,
        "customer": {"__typename": "Customer", "balance": 995000}
      }
    }
  };

  static Map<String, dynamic> responseWithError = {
    "data": {
      "__typename": "MutationRoot",
      "purchase": {
        "__typename": "PurchaseMutationResponse",
        "success": false,
        "errorMessage": "error",
        "customer": {"__typename": "Customer", "balance": 1000000}
      }
    }
  };
}
