# Danh mục dữ liệu cho lớp Vàng (Gold Layer)

## Tổng quan 
Gold Layer là biểu diễn dữ liệu ở cấp doanh nghiệp, được xây dựng để hỗ trợ các trường hợp sử dụng phân tích và báo cáo. Nó bao gồm **dimension tables** và **fact tables** cho các số liệu kinh doanh cụ thể.

---

### 1. **gold.dim_customers**
- **Mục đích:** Lưu trữ thông tin chi tiết về khách hàng được làm phong phú thêm với dữ liệu nhân khẩu học và địa lý.
- **Các cột:**

| Tên Cột          | Kiểu dữ liệu  | Mô tả                                                                                         |
|------------------|---------------|-----------------------------------------------------------------------------------------------|
| customer_key     | INT           | Khóa thay thế xác định duy nhất từng bản ghi khách hàng trong bảng dimension.               |
| customer_id      | INT           | Mã định danh số duy nhất được gán cho từng khách hàng.                                        |
| customer_number  | NVARCHAR(50)  | Mã định danh chữ số địa diện cho khách hàng, được sử dụng để theo dõi và tham chiếu.         |
| first_name       | NVARCHAR(50)  | Tên của khách hàng được ghi lại trong hệ thống.                                         |
| last_name        | NVARCHAR(50)  | Họ hoặc tên đệm của khách hàng.                                                     |
| country          | NVARCHAR(50)  | Quốc gia cư trú của khách hàng (vd: 'Australia').                               |
| marital_status   | NVARCHAR(50)  | Tình trạng hôn nhân của khách hàng (vd: 'Married', 'Single').                              |
| gender           | NVARCHAR(50)  | Giới tính của khách hàng (vd: 'Male', 'Female', 'n/a').                                  |
| birthdate        | DATE          | Ngày sinh của khách hàng, được định dạng là YYYY-MM-DD (vd: 1971-10-06).               |
| create_date      | DATE          | Ngày và giờ tạo hồ sơ khách hàng trong hệ thống|

---

### 2. **gold.dim_products**
- **Mục đích:** ung cấp thông tin về sản phẩm và các thuộc tính của chúng.
- **Các Cột:**

| Tên Cột         | Kiểu dữ liệu     | Mô tả                                                                                   |
|---------------------|---------------|-----------------------------------------------------------------------------------------------|
| product_key         | INT           | Khóa thay thế xác định duy nhất từng bản ghi sản phẩm trong bảng chiều sản phẩm.         |
| product_id          | INT           | Mã định danh duy nhất được gán cho sản phẩm để theo dõi và tham chiếu nội bộ.            |
| product_number      | NVARCHAR(50)  | Mã chữ số có cấu trúc biểu thị sản phẩm, thường được sử dụng để phân loại hoặc kiểm kê. |
| product_name        | NVARCHAR(50)  | Tên mô tả của sản phẩm, bao gồm các chi tiết chính như loại, màu sắc và kích thước.         |
| category_id         | NVARCHAR(50)  | Mã định danh duy nhất cho danh mục sản phẩm, liên kết đến phân loại cấp cao của sản phẩm.     |
| category            | NVARCHAR(50)  | Phân loại sản phẩm rộng hơn (vd: Bikes, Components) để nhóm các mặt hàng liên quan.  |
| subcategory         | NVARCHAR(50)  | Phân loại chi tiết hơn về sản phẩm trong danh mục, chẳng hạn như loại sản phẩm.      |
| maintenance_required| NVARCHAR(50)  | Chỉ ra liệu sản phẩm có cần bảo trì hay không (vd: 'Yes', 'No').                       |
| cost                | INT           | Giá gốc hoặc giá thành của sản phẩm, được đo bằng đơn vị tiền tệ.                            |
| product_line        | NVARCHAR(50)  | | product_line | NVARCHAR(50) | Dòng sản phẩm hoặc sê-ri cụ thể mà sản phẩm thuộc về (vd: Road, Mountain).      |
| start_date          | DATE          | Ngày sản phẩm có sẵn để bán hoặc sử dụng, được lưu trữ trong cơ sở dữ liệu.|

---

### 3. **gold.fact_sales**
- **Mục đích:** Lưu trữ dữ liệu bán hàng giao dịch cho mục đích phân tích.
- **Các Cột:**

| Tên Cột         | Kiểu dữ liệu     | Mô tả                                                                                   |
|-----------------|---------------|-----------------------------------------------------------------------------------------------|
| order_number    | NVARCHAR(50)  | Mã định danh chữ và số duy nhất cho mỗi đơn hàng bán (vd: 'SO54496').                      |
| product_key     | INT           | Khóa thay thế liên kết đơn hàng với bảng kích thước sản phẩm.                               |
| customer_key    | INT           | Khóa thay thế liên kết đơn hàng với bảng kích thước khách hàng.                              |
| order_date      | DATE          | Ngày đặt hàng.                                                           |
| shipping_date   | DATE          | Ngày đơn hàng được chuyển đến khách hàng.                                          |
| due_date        | DATE          | Ngày thanh toán đơn hàng.                                                      |
| sales_amount    | INT           | Tổng giá trị tiền tệ của doanh số bán hàng cho mặt hàng, theo đơn vị tiền tệ nguyên (vd: 25).   |
| quantity        | INT           | Số lượng đơn vị sản phẩm đã đặt hàng cho mặt hàng (vd: 1).                       |
| price           | INT           | Giá cho mỗi đơn vị sản phẩm của một mặt hàng, tính theo đơn vị tiền tệ nguyên (vd: 25).      |



