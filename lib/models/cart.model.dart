class Cart {
  String productId;
  String productName;
  double productAmount;
  int productQuantity;
  String productImage;

  Cart(
      {required this.productId,
      required this.productName,
      required this.productAmount,
      required this.productImage,
      this.productQuantity = 1});
}
