import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {

    io:println("Enter product details to add:");
    io:println("Name of product:");
    string name = io:readln().toString();
    io:println("Description:");
    string description = io:readln().toString();
    io:println("Price:");
    float price = check float:fromString(io:readln().toString());
    io:println("Stock Quantity:");
    int stockQuantity = check int:fromString(io:readln().toString());
    io:println("SKU:");
    string sku = io:readln().toString();
    io:println("Status:");
    string status = io:readln().toString();
    io:println("Enter the user Id");
    string userId = io:readln().toString();
    io:println("Enter the user type");

    Product addProductRequest = {name: name, description: description, price: price, stock_quantity: stockQuantity, sku: sku, status: status};
    ProductResponse addProductResponse = check ep->AddProduct(addProductRequest);
    io:println(addProductResponse);

    Product updateProductRequest = {name: name, description: description, price: price, stock_quantity: stockQuantity, sku: sku, status: status};
    ProductResponse updateProductResponse = check ep->UpdateProduct(updateProductRequest);
    io:println(updateProductResponse);

    ProductId removeProductRequest = {sku: sku};
    ProductList removeProductResponse = check ep->RemoveProduct(removeProductRequest);
    io:println(removeProductResponse);

    Empty listAvailableProductsRequest = {};
    ProductList listAvailableProductsResponse = check ep->ListAvailableProducts(listAvailableProductsRequest);
    io:println(listAvailableProductsResponse);

    ProductId searchProductRequest = {sku: sku};
    ProductResponse searchProductResponse = check ep->SearchProduct(searchProductRequest);
    io:println(searchProductResponse);

    CartRequest addToCartRequest = {user_id: userId, sku: sku};
    CartResponse addToCartResponse = check ep->AddToCart(addToCartRequest);
    io:println(addToCartResponse);

    UserId placeOrderRequest = {user_id: userId};
    OrderResponse placeOrderResponse = check ep->PlaceOrder(placeOrderRequest);
    io:println(placeOrderResponse);

    User createUsersRequest = {user_id: userId, user_type: userId};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendUser(createUsersRequest);
    check createUsersStreamingClient->complete();
    UserResponse? createUsersResponse = check createUsersStreamingClient->receiveUserResponse();
    io:println(createUsersResponse);
}

