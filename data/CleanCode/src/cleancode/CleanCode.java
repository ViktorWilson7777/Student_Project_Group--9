package cleancode;

import java.io.FileWriter;
import java.io.IOException;
import java.util.Random;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class CleanCode {

    static Random rand = new Random();
    static String[] userNames;
    static String[] firstNames = {"Nguyen", "Tran", "Le", "Pham", "Hoang", "Huynh", "Vo", "Dang"};
    static String[] secondNames = {"Thanh", "Hoang", "Trong", "Nha", "Hong"};
    static String[] lastNames = {"An", "Binh", "Cuong", "Dung", "Huy", "Khanh", "Long", "Minh", "Nam", "Phuc"};
    static boolean[] userHasShop;
    static int[] endYears = {2025,2026};
//    static String[] streets = {"Le Loi", "Nguyen Hue", "Tran Hung Dao", "Vo Van Tan", "CMT8"};
//    static String[] wards = {"Ward1", "Ward3", "Ward5", "Ward7", "Ward10"};
//    static String[] districts = {"District1", "District3", "District5", "District10"};
    static String[] randomShopName = {"Fashion", "Zestie", "Saffron & Sage", "Accessories", "Lumina Studio"};
    static String[] productNames = {"TShirt", "Hoodie", "Jeans", "Sneakers", "Backpack", "Handbag", "Cap", "Jacket"};

    static String[] sizes = {"S", "M", "L", "XL"};
    static String[] colors = {"Black", "White", "Red", "Blue", "Gray"};
    static int[] productBasePrices;

    //static String[] orderStatuses = {"CREATED", "PAID", "SHIPPING", "COMPLETED"};
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
        userNames = new String[total + 1];
        userHasShop = new boolean[total + 1];

        FileWriter fw = new FileWriter("cleanUsers.csv");
        fw.write("userID,name,email,password\n");

        for (int i = 1; i <= total; i++) {
            String name = randomName();
            userNames[i] = name;

            String email = generateEmail(name, i);
            String rawPassword = generatePassword(name, i);
            String passwordHash = hashPassword(rawPassword);

            fw.write(i + "," + name + "," + email + "," + passwordHash + "\n");
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
        fw.write("shopID,shopName,ownerUserID\n");

        int userCount = userNames.length - 1;

        // ===== 30% user sẽ KHÔNG BAO GIỜ có shop =====
        boolean[] bannedUser = new boolean[userNames.length];
        for (int i = 1; i <= userCount; i++) {
            bannedUser[i] = rand.nextInt(100) < 30;
        }

        for (int shopID = 1; shopID <= total; shopID++) {

            boolean useOwnerName = rand.nextInt(100) < 40; // 40% shop mang tên owner
            int ownerUserID;

            // ===== CHỌN OWNER =====
            do {
                ownerUserID = 1 + rand.nextInt(userCount);
            } while (bannedUser[ownerUserID]);

            userHasShop[ownerUserID] = true;

            String shopName;

            if (useOwnerName) {
                // Shop trùng owner
                shopName = "Shop_" + userNames[ownerUserID].replace(" ", "_");
            } else {
                // Shop random
                shopName = "Shop_"
                        + randomShopName[rand.nextInt(randomShopName.length)]
                        + "_" + shopID;
            }

            fw.write(shopID + "," + shopName + "," + ownerUserID + "\n");
        }

        fw.close();
    }

    // ===== PRODUCTS =====
    static void generateProducts(int total) throws IOException {
        productBasePrices = new int[total + 1];

        FileWriter fw = new FileWriter("cleanProducts.csv");
        fw.write("productID,shopID,name,price\n");

        for (int i = 1; i <= total; i++) {
            int basePrice = (10 + rand.nextInt(90)) * 1000;
            productBasePrices[i] = basePrice;

            fw.write(i + ","
                    + (1 + rand.nextInt(2000)) + ","
                    + productNames[rand.nextInt(productNames.length)] + "_" + i + ","
                    + basePrice + "\n");
        }
        fw.close();
    }

    // ===== VARIANTS =====
    static void generateVariants(int products) throws IOException {
        FileWriter fw = new FileWriter("cleanProductVariants.csv");
        fw.write("variantID,productID,size,color,priceVariant,stock\n");

        int variantID = 1;

        for (int productID = 1; productID <= products; productID++) {
            int basePrice = productBasePrices[productID];

            for (String size : sizes) {
                for (String color : colors) {

                    double rate = 0.05 + rand.nextInt(10) * 0.05; // 5–10%
                    boolean increase = rand.nextBoolean();

                    int variantPrice = increase
                            ? (int) (basePrice * (1 + rate))
                            : (int) (basePrice * (1 - rate));

                   

                    fw.write(variantID++ + "," + productID + ","
                            + size + "," + color + ","
                            + variantPrice + ","
                            + (10 + rand.nextInt(50)) + ","
                            + "\n");
                }
            }
        }
        fw.close();
    }

    // ===== VOUCHERS =====
   // ===== VOUCHERS =====
static void generateVouchers(int total) throws IOException {
    FileWriter fw = new FileWriter("cleanVouchers.csv");
    fw.write("voucherID,code,discountPercent,minOrderAmount,isStackable,startDate,endDate\n");

    for (int i = 1; i <= total; i++) {

        boolean isStackable = (i % 3 == 0);

        int discount = isStackable
                ? 5 + rand.nextInt(6)      // 5–10%
                : 5 + rand.nextInt(16);   // 5–20%

        // ===== START DATE =====
        int startYear = 2024;
        int startMonth = 1 + rand.nextInt(12);
        int startDay = 1 + rand.nextInt(28);

        String startDate = startYear + "-"
                + String.format("%02d", startMonth) + "-"
                + String.format("%02d", startDay);

        // ===== END DATE (FIXED) =====
        int endMonth = 1 + rand.nextInt(12);
        int endDay = 1 + rand.nextInt(28);
        int randomEndYear = endYears[rand.nextInt(endYears.length)];

        String endDate = randomEndYear + "-"
                + String.format("%02d", endMonth) + "-"
                + String.format("%02d", endDay);

        fw.write(i + ",SALE" + i + ","
                + discount + ","
                + (1000 * rand.nextInt(60)) + ","
                + isStackable + ","
                + startDate + ","
                + endDate + "\n");
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
//        fw.write("orderItemId,orderId,variantID,quantity,price\n");
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

    static String normalizeName(String name) {
        return name.toLowerCase().replace(" ", ".");
    }

    static String generateEmail(String name, int userId) {
        return normalizeName(name) + userId + "@gmail.com";
    }

    static String generatePassword(String name, int userId) {
        String[] parts = name.split(" ");
        String firstName = parts[0];
        String lastName = parts[parts.length - 1];
        return firstName + "@" + lastName + userId;
    }

}
