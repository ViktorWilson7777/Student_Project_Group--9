# LAB211 Simulator (Project B)

Đây là **Project B - Simulator** cho đồ án LAB211 của bạn. Nó bắn request HTTP vào web hiện tại theo đúng flow đang có của project zip hiện tại:

1. `POST /login`
2. `POST /add-to-cart`
3. `GET /cart`
4. `POST /checkout`
5. `GET /order?status=ALL`

Simulator này được viết theo đúng các endpoint đang tồn tại trong project hiện tại của bạn.

## 1) Chuẩn bị trước khi chạy

- Bật SQL Server
- Bật Tomcat và chạy web `LAB211Web3`
- Kiểm tra web truy cập được ở:
  - `http://localhost:8080/LAB211Web3/login`
- Chuẩn bị **một số tài khoản user thường** (không phải admin)
- Chuẩn bị vài `variantId` còn hàng

## 2) Lấy variantId để test

Bạn có thể:
- mở **Product Variant List** trong admin để xem `variantId`
- hoặc chạy file `find_variant_ids.sql` trong SSMS

Sau đó sửa `config.properties`:

```properties
variantIds=18,25,41
```

## 3) Điền users.csv

Sửa file `users.csv` thành các user thật trong DB của bạn:

```csv
email,password
user01@gmail.com,12345678
user02@gmail.com,12345678
user03@gmail.com,12345678
```

## 4) Build jar

Trong thư mục này, chạy:

```bash
javac -d out src/simulator/*.java
jar --create --file LAB211Simulator.jar --main-class simulator.ShopeeSimulatorMain -C out .
```

## 5) Chạy simulator

```bash
java -jar LAB211Simulator.jar config.properties
```

## 6) File cấu hình quan trọng

`config.properties`

```properties
baseUrl=http://localhost:8080/LAB211Web3
mode=PLACE_ORDER
concurrency=10
totalTasks=50
variantIds=18,25,41
minQuantity=1
maxQuantity=1
receiverPhone=0901234567
shippingAddress=FPT University, Hoa Lac, Ha Noi
paymentMethods=COD,Bank Transfer
usersFile=users.csv
reportFile=simulator-report.csv
```

### Giải thích nhanh
- `mode=LOGIN_ONLY` → chỉ test login
- `mode=PLACE_ORDER` → test full flow login + cart + checkout + order page
- `concurrency` → số luồng chạy song song
- `totalTasks` → tổng số lần mô phỏng
- `variantIds` → danh sách variant được dùng để mô phỏng

## 7) Kết quả sau khi chạy

Simulator sẽ in:
- từng task OK / FAIL
- stage fail ở đâu: `LOGIN`, `ADD_TO_CART`, `CART`, `CHECKOUT`, `ORDER_PAGE`
- thống kê tổng kết
- file CSV `simulator-report.csv`

## 8) Cách demo với giảng viên

Bạn có thể demo theo flow:

1. Mở web user/admin bình thường
2. Chạy simulator bằng terminal
3. Cho thấy console đang bắn hàng loạt request
4. Refresh trang admin / order / stock để cho thấy dữ liệu thay đổi
5. Mở file `simulator-report.csv` để chứng minh số lượng request thành công / thất bại

## 9) Gợi ý test an toàn trước

Chạy nhỏ trước:

```properties
concurrency=3
totalTasks=10
```

Khi ổn rồi hãy nâng lên:

```properties
concurrency=10
totalTasks=100
```

## 10) Lưu ý

- Nếu login fail hàng loạt → kiểm tra lại `users.csv`
- Nếu add-to-cart fail → `variantId` hết hàng hoặc không tồn tại
- Nếu checkout fail → kiểm tra web hiện tại còn lỗi flow cart/checkout không
- Nếu base URL sai → sửa `baseUrl`
