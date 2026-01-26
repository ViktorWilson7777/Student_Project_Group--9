package create.legacy.csv.more.than.pkg10000.lines;

import java.io.*;
import java.time.LocalDate;
import java.util.*;

public class CleanAll {

    static Set<String> users = new HashSet<>();
    static Set<String> shops = new HashSet<>();
    static Set<String> products = new HashSet<>();

    static Random random = new Random();

    public static void main(String[] args) throws Exception {
        cleanUsers();
        cleanShops();
        cleanProducts();
        cleanVariants();
        cleanVouchers();

        System.out.println("✅ DONE: All clean CSV generated");
    }

    // ================= USER =================
    static void cleanUsers() throws Exception {
    BufferedReader br = new BufferedReader(new FileReader("legacy_users.csv"));
    FileWriter fw = new FileWriter("clean_users.csv", false);

    fw.write("user_id,name,email,password_hash\n");
    br.readLine(); // skip header

    String line;
    while ((line = br.readLine()) != null) {
        String[] c = line.split(",");

        if (Utils.isEmpty(c[1]) || Utils.isEmpty(c[2])) continue;

        String hashedPassword = Utils.hashPassword(c[3]);

        users.add(c[0]);
        fw.write(c[0] + "," + c[1] + "," + c[2] + "," + hashedPassword + "\n");
    }

    br.close();
    fw.close();
}


    // ================= SHOP =================
    static void cleanShops() throws Exception {
        BufferedReader br = new BufferedReader(new FileReader("legacy_shops.csv"));
        FileWriter fw = new FileWriter("clean_shops.csv", false);

        fw.write("shop_id,shop_name,owner_id\n");
        br.readLine();

        String line;
        while ((line = br.readLine()) != null) {
            String[] c = line.split(",");
            if (!users.contains(c[2])) continue;

            shops.add(c[0]);
            fw.write(line + "\n");
        }
        br.close(); fw.close();
    }

    // ================= PRODUCT =================
    static void cleanProducts() throws Exception {
        BufferedReader br = new BufferedReader(new FileReader("legacy_products.csv"));
        FileWriter fw = new FileWriter("clean_products.csv", false);

        fw.write("product_id,shop_id,name,price\n");
        br.readLine();

        String line;
        while ((line = br.readLine()) != null) {
            String[] c = line.split(",");
            if (!shops.contains(c[1])) continue;

            products.add(c[0]);
            fw.write(line + "\n");
        }
        br.close(); fw.close();
    }

    // ================= PRODUCT VARIANT =================
    static void cleanVariants() throws Exception {
        BufferedReader br = new BufferedReader(new FileReader("legacy_product_variants.csv"));
        FileWriter fw = new FileWriter("clean_variants.csv", false);

        fw.write("variant_id,product_id,size,color,stock_quantity\n");
        br.readLine();

        String line;
        while ((line = br.readLine()) != null) {
            String[] c = line.split(",");
            if (!products.contains(c[1])) continue;

            int stock = Math.max(0, Integer.parseInt(c[4]));
            fw.write(c[0] + "," + c[1] + "," + c[2] + "," + c[3] + "," + stock + "\n");
        }
        br.close(); fw.close();
    }

    // ================= VOUCHER =================
    static void cleanVouchers() throws Exception {
    BufferedReader br = new BufferedReader(new FileReader("legacy_vouchers.csv"));
    FileWriter fw = new FileWriter("clean_vouchers.csv");

    fw.write("voucher_id,code,discount_value,min_order_amount,stackable,piority,start_date,end_date\n");
    br.readLine();

    String line;
    while ((line = br.readLine()) != null) {
        String[] c = line.split(",");

        if (Utils.isEmpty(c[1])) continue;
        if (!Utils.isValidDate(c[6]) || !Utils.isValidDate(c[7])) continue;
        if (!LocalDate.parse(c[7]).isAfter(LocalDate.parse(c[6]))) continue;

        int discount = Integer.parseInt(c[2]);
        boolean stackable = Boolean.parseBoolean(c[4]);

        discount = stackable
                ? Utils.clamp(discount, 5, 15)
                : Utils.clamp(discount, 10, 30);

        fw.write(c[0] + "," + c[1] + "," + discount + "," +
                 c[3] + "," + stackable + "," +
                 c[5] + "," + c[6] + "," + c[7] + "\n");
    }
    br.close(); fw.close();
}

}
    
