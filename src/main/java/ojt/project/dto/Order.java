package ojt.project.dto;

public class Order {
    private int product_number;
    private String id;
    private String request_message;
    private int order_amount;
    private int order_price;

    public Order(){}
    public Order(int product_number, String id, String request_message, int order_amount, int order_price) {
        this.product_number = product_number;
        this.id = id;
        this.request_message = request_message;
        this.order_amount = order_amount;
        this.order_price = order_price;
    }

    public int getProduct_number() {
        return product_number;
    }

    public void setProduct_number(int product_number) {
        this.product_number = product_number;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getRequest_message() {
        return request_message;
    }

    public void setRequest_message(String request_message) {
        this.request_message = request_message;
    }

    public int getOrder_amount() {
        return order_amount;
    }

    public void setOrder_amount(int order_amount) {
        this.order_amount = order_amount;
    }

    public int getOrder_price() {
        return order_price;
    }

    public void setOrder_price(int order_price) {
        this.order_price = order_price;
    }
}
