class ListOffersMock {
  static Map<String, dynamic> response = {
    "data": {
      "__typename": "QueryRoot",
      "viewer": {
        "__typename": "Customer",
        "offers": [
          {
            "__typename": "Offer",
            "id": "offer/portal-gun",
            "price": 5000,
            "product": {
              "__typename": "Product",
              "id": "product/portal-gun",
              "name": "Portal Gun",
              "description": "The Portal Gun is a gadget that allows the user(s) to travel between different universes/dimensions/realities.",
              "image": "https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest/scale-to-width-down/310?cb=20140509065310"
            }
          }
        ]
      }
    }
  };
}
