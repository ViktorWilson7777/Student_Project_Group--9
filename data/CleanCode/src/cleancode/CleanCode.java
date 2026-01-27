package cleancode;

import java.io.FileWriter;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Random;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CleanCode {

    static Random rand = new Random();

    static String[] firstNames = {"Nguyen", "Tran", "Le", "Pham", "Hoang", "Huynh", "Vo", "Dang"};
    static String[] secondNames = {"Thanh", "Hoang", "Trong", "Nha", "Hong"};
    static String[] lastNames = {"An", "Binh", "Cuong", "Dung", "Huy", "Khanh", "Long", "Minh", "Nam", "Phuc"};

    static String[] streets = {"Le Loi", "Nguyen Hue", "Tran Hung Dao", "Vo Van Tan", "CMT8"};
    static String[] wards = {"Ward1", "Ward3", "Ward5", "Ward7", "Ward10"};
    static String[] districts = {"District1", "District3", "District5", "District10"};

    static String[] categories = {"Fashion", "Shoes", "Bags", "Accessories", "Electronics"};
    static String[] productNames = {"TShirt", "Hoodie", "Jeans", "Sneakers", "Backpack", "Handbag", "Cap", "Jacket"};

    static String[] sizes = {"S", "M", "L", "XL"};
    static String[] colors = {"Black", "White", "Red", "Blue", "Gray"};

    static String[] orderStatuses = {"CREATED", "PAID", "SHIPPING", "COMPLETED"};

    public static void main(String[] args) throws IOException {

        generateUsers(10000);
//        generateAddresses(10000);
        generateShops(2000);
        generateProducts(12000);
        generateVariants(12000);
        generateVouchers(500);
//        generateOrders(15000);
//        generateOrderItems(15000);

        System.out.println("✅ FULL DATASET GENERATED");
    }

    // ===== USERS =====
    static void generateUsers(int total) throws IOException {
        FileWriter fw = new FileWriter("cleanUsers.csv");
        fw.write("userId,fullName,email,password\n");

        for (int i = 1; i <= total; i++) {
            String fullName = randomName();
            String email = generateEmail(fullName, i);
            String rawPassword = generatePassword(fullName, i);
            String hashedPassword = hashPassword(rawPassword);

            fw.write(i + "," + fullName + "," + email + "," + hashedPassword + "\n");
        }
        fw.close();
    }

    static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());

            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();

        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
//    // ===== ADDRESSES =====
//    static void generateAddresses(int users) throws IOException {
//        FileWriter fw = new FileWriter("CleanUserAddresses.csv");
//        fw.write("addressId,userId,street,ward,district,city\n");
//        int id = 1;
//        for (int userId = 1; userId <= users; userId++) {
//            int count = 1 + rand.nextInt(3);
//            for (int i = 0; i < count; i++) {
//                fw.write(id++ + "," + userId + ","
//                        + streets[rand.nextInt(streets.length)] + ","
//                        + wards[rand.nextInt(wards.length)] + ","
//                        + districts[rand.nextInt(districts.length)] + ",HCM\n");
//            }
//        }
//        fw.close();
//    }

    // ===== SHOPS =====
    static void generateShops(int total) throws IOException {
        FileWriter fw = new FileWriter("cleanShops.csv");
        fw.write("shopId,shopName,ownerUserId\n");
        for (int i = 1; i <= total; i++) {
            fw.write(i + ",Shop_" + randomName().replace(" ", "_") + ","
                    + (1 + rand.nextInt(10000)) + "\n");
        }
        fw.close();
    }

    // ===== PRODUCTS =====
    static void generateProducts(int total) throws IOException {
        FileWriter fw = new FileWriter("cleanProducts.csv");
        fw.write("productId,shopId,productName,category,basePrice\n");
        for (int i = 1; i <= total; i++) {
            int basePrice = (10 + rand.nextInt(90)) * 1000;
            fw.write(i + ","
                    + (1 + rand.nextInt(2000)) + ","
                    + productNames[rand.nextInt(productNames.length)] + "_" + i + ","
                    + categories[rand.nextInt(categories.length)] + ","
                    + basePrice + "\n");
        }
        fw.close();
    }

    // ===== VARIANTS =====
    static void generateVariants(int products) throws IOException {
        FileWriter fw = new FileWriter("cleanProductVariants.csv");
        fw.write("variantId,productId,size,color,price,stock\n");
        int id = 1;
        for (int productId = 1; productId <= products; productId++) {
            int basePrice = (10 + rand.nextInt(90)) * 1000;
            for (String size : sizes) {
                for (String color : colors) {
                    fw.write(id++ + "," + productId + ","
                            + size + "," + color + ","
                            + (basePrice + rand.nextInt(5) * 1000) + ","
                            + (10 + rand.nextInt(50)) + "\n");
                }
            }
        }
        fw.close();
    }

    // ===== VOUCHERS =====
    static void generateVouchers(int total) throws IOException {
        FileWriter fw = new FileWriter("cleanVouchers.csv");
        fw.write("voucherId,code,discountType,discountValue,minOrderValue,maxDiscount,isStackable\n");
        for (int i = 1; i <= total; i++) {
            fw.write(i + ",SALE" + i + ","
                    + (i % 2 == 0 ? "PERCENT" : "FIXED") + ","
                    + (i % 2 == 0 ? 10 : 50000) + ","
                    + 100000 + ","
                    + 200000 + ","
                    + (i % 3 == 0) + "\n");
        }
        fw.close();
    }

//    // ===== ORDERS =====
//    static void generateOrders(int total) throws IOException {
//        FileWriter fw = new FileWriter("cleanOrders.csv");
//        fw.write("orderId,userId,shopId,totalAmount,orderStatus,createdAt\n");
//        for (int i = 1; i <= total; i++) {
//            fw.write(i + ","
//                    + (1 + rand.nextInt(10000)) + ","
//                    + (1 + rand.nextInt(2000)) + ","
//                    + ((50 + rand.nextInt(200)) * 1000) + ","
//                    + orderStatuses[rand.nextInt(orderStatuses.length)] + ","
//                    + LocalDateTime.now().minusDays(rand.nextInt(30)) + "\n");
//        }
//        fw.close();
//    }
//    // ===== ORDER ITEMS =====
//    static void generateOrderItems(int orders) throws IOException {
//        FileWriter fw = new FileWriter("cleanOrderItems.csv");
//        fw.write("orderItemId,orderId,variantId,quantity,price\n");
//        int id = 1;
//        for (int orderId = 1; orderId <= orders; orderId++) {
//            int itemCount = 1 + rand.nextInt(4);
//            for (int i = 0; i < itemCount; i++) {
//                fw.write(id++ + "," + orderId + ","
//                        + (1 + rand.nextInt(240000)) + ","
//                        + (1 + rand.nextInt(3)) + ","
//                        + ((20 + rand.nextInt(80)) * 1000) + "\n");
//            }
//        }
//        fw.close();
//    }
    static String randomName() {
        return firstNames[rand.nextInt(firstNames.length)] + " "
                + secondNames[rand.nextInt(secondNames.length)] + " "
                + lastNames[rand.nextInt(lastNames.length)];
    }
    // ===== EMAIL & PASSWORD UTILS =====

    static String normalizeName(String fullName) {
        return fullName.toLowerCase().replace(" ", ".");
    }

    static String generateEmail(String fullName, int userId) {
        return normalizeName(fullName) + userId + "@gmail.com";
    }

    static String generatePassword(String fullName, int userId) {
        String[] parts = fullName.split(" ");
        String firstName = parts[0];
        String lastName = parts[parts.length - 1];
        return firstName + "@" + lastName + userId;
    }

}
