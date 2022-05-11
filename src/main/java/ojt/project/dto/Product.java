package ojt.project.dto;

public class Product {
    private int product_number;
    private String product_name;
    private int product_price;
    private int product_count;

    public Product() {}

    public Product(int product_number, String product_name, int product_price, int product_count) {
        this.product_number = product_number;
        this.product_name = product_name;
        this.product_price = product_price;
        this.product_count = product_count;
    }

    public int getProduct_number() {
        return product_number;
    }

    public void setProduct_number(int product_number) {
        this.product_number = product_number;
    }

    public String getProduct_name() {
        return product_name;
    }

    public void setProduct_name(String product_name) {
        this.product_name = product_name;
    }

    public int getProduct_price() {
        return product_price;
    }

    public void setProduct_price(int product_price) {
        this.product_price = product_price;
    }

    public int getProduct_count() {
        return product_count;
    }

    public void setProduct_count(int product_count) {
        this.product_count = product_count;
    }
}
