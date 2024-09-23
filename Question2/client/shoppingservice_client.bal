import ballerina/io;

ShoppingServiceClient ep = check new ("http://localhost:9091");

string currentUserId = "";
string currentUserType = "";

public function main() returns error? {
    boolean repeat = true;
    while repeat {
        io:println("Select user role:");
        io:println("1. Admin");
        io:println("2. Customer");
        string roleChoice = io:readln("Enter your choice: ");

        if roleChoice == "1" {
            currentUserType = "admin";
            currentUserId = "adminUser"; 
        } else if roleChoice == "2" {
            currentUserType = "customer";
            currentUserId = "customerUser"; 
        } else {
            io:println("Invalid choice. Exiting...");
            return;
        }

        io:println("Select an option:");
        io:println("1. Add product");
        io:println("2. Update product");
        io:println("3. Remove product");
        io:println("4. List available products");
        io:println("5. Search product");
        io:println("6. Add to cart");
        io:println("7. Place order");
        io:println("8. Create users");
        io:println("9. Exit");

        string option = io:readln("Enter a choice to perform: ");

        if option == "9" {
            io:println("Exiting...");
            break; 
        } else {
            error? err = handleOption(option);
            if err is error {
                io:println("Error: ", err.message());
            }
        }

        if repeat {
            io:println("Do you want to perform another operation? (Yes/No)");
            string response = io:readln();
            if response.toUpperAscii() == "NO" {
                repeat = false;
            }
        }
    }
}

function handleOption(string option) returns error? {
    
    return ();
}




    function addProduct() returns error? {
    io:println("Enter product name: ");
    string name = io:readln();
    io:println("Enter product description: ");
    string description = io:readln();
    io:println("Enter product price: ");
    float price = check readFloat();
    io:println("Enter product stock quantity: ");
    int stockQuantity = check readInt();
    io:println("Enter product SKU: ");
    string sku = io:readln();
    io:println("Enter product status: ");
    string status = io:readln();
    Product addProductRequest = {name: name, description: description, price: price, stock_quantity: stockQuantity, sku: sku, status: status};
    ProductResponse addProductResponse = check ep->AddProduct(addProductRequest);
    io:println(addProductResponse);
}

function readFloat() returns float|error {
    string input = io:readln();
    return float:fromString(input);
}
function readInt() returns int|error {
    string input = io:readln();
    return int:fromString(input);
}

function removeProduct() returns error? {
    io:println("Enter product SKU to remove: ");
    string removeSku = io:readln();

    ProductId removeProductRequest = {sku: removeSku};
    ProductList removeProductResponse = check ep->RemoveProduct(removeProductRequest);
    io:println(removeProductResponse);
}

    function searchProduct() returns error? {
    io:println("Enter product SKU to search: ");
    string searchSku = io:readln();

    ProductId searchProductRequest = {sku: searchSku};
    ProductResponse searchProductResponse = check ep->SearchProduct(searchProductRequest);
    io:println(searchProductResponse);
}

function listAvailableProducts() returns error? {
    Empty listAvailableProductsRequest = {};
    ProductList listAvailableProductsResponse = check ep->ListAvailableProducts(listAvailableProductsRequest);
    io:println(listAvailableProductsResponse);
}


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
function addToCart() returns error? {
io:println(&quot;Enter user ID: &quot;);
string userId = io:readln();
io:println(&quot;Enter product SKU to add to cart: &quot;);
string cartSku = io:readln();
CartRequest addToCartRequest = {user_id: userId, sku: cartSku};
CartResponse addToCartResponse = check ep-&gt;AddToCart(addToCartRequest);
io:println(addToCartResponse);

}

function placeOrder() returns error? {
io:println(&quot;Enter user ID: &quot;);
string placeOrderUserId = io:readln();
UserId placeOrderRequest = {user_id: placeOrderUserId};
io:println(&quot;Order placed successfully&quot;);
OrderResponse placeOrderResponse = check ep-&gt;PlaceOrder(placeOrderRequest);
io:println(placeOrderResponse);
}
