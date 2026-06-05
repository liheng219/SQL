# Phân tích Hiệu suất Kinh doanh & Vận hành Sales

## Tổng quan dự án

Dự án được xây dựng nhằm hỗ trợ theo dõi hiệu suất kinh doanh của đội ngũ Sales, đánh giá mức độ hoàn thành KPI, tính toán hoa hồng và cung cấp các báo cáo phân tích phục vụ hoạt động vận hành.

Thông qua việc kết hợp SQL và Power BI, dự án giúp chuyển đổi dữ liệu giao hàng, hợp đồng và doanh thu thành các chỉ số kinh doanh trực quan, hỗ trợ nhà quản lý đưa ra quyết định dựa trên dữ liệu.

---

## Mục tiêu kinh doanh

Dự án tập trung giải quyết các bài toán:

* Theo dõi doanh thu và sản lượng thực tế của từng Sales.
* Đánh giá mức độ hoàn thành KPI theo tháng.
* Tính toán incentive và hoa hồng dựa trên kết quả thực hiện.
* Theo dõi tình trạng thực hiện hợp đồng của khách hàng.
* Phát hiện các vấn đề vận hành ảnh hưởng đến hiệu quả kinh doanh.

---

## Dữ liệu sử dụng

Dự án sử dụng bộ dữ liệu mô phỏng bao gồm:

* Hợp đồng khách hàng (Contracts)
* Dữ liệu giao hàng (Shipments)
* Nhân viên kinh doanh (Employees)
* KPI mục tiêu (Sales KPI Targets)
* Chính sách hoa hồng (Commission Rates)
  ![Database structure]

---

## Các chỉ số chính

### Hiệu suất kinh doanh

* Tổng doanh thu
* Tổng sản lượng giao hàng
* KPI thực hiện
* Tỷ lệ hoàn thành KPI (%)
* Doanh thu theo nhân viên Sales

### Hoa hồng & Incentive

* Hoa hồng phát sinh
* Tỷ lệ hoàn thành điều kiện thưởng
* Xếp hạng hiệu suất nhân viên

### Quản lý hợp đồng

* Hợp đồng đang hoạt động
* Hợp đồng sắp hết hạn
* Hợp đồng đã hết hạn
* Tỷ lệ thực hiện sản lượng cam kết

### Phân tích vận hành

* Hiệu quả khách hàng
* Xu hướng doanh thu theo thời gian
* Dự báo sản lượng
* Các trường hợp chưa đạt cam kết

---

## Dashboard

### Executive Overview

Cung cấp cái nhìn tổng quan về:

* Doanh thu
* Sản lượng
* Tỷ lệ hoàn thành KPI
* Hoa hồng
* Hiệu suất kinh doanh

## Kết quả phân tích

* Xác định các nhân viên Sales đạt và vượt KPI.
* Phát hiện khách hàng có sản lượng thấp hơn mức cam kết.
* Theo dõi các hợp đồng cần gia hạn trong thời gian tới.
* Đánh giá mức độ đóng góp doanh thu của từng khách hàng và nhân viên Sales.
* Hỗ trợ lập kế hoạch doanh thu và phân bổ chỉ tiêu cho các kỳ tiếp theo.

---

## Đề xuất

* Điều chỉnh target dựa trên hiệu suất thực tế của từng Sales.
* Ưu tiên gia hạn các hợp đồng có doanh thu cao.
* Tăng cường chăm sóc khách hàng có dấu hiệu giảm sản lượng.
* Chuẩn hóa quy trình theo dõi KPI nhằm giảm thời gian tổng hợp báo cáo thủ công.
* Ứng dụng dashboard vào hoạt động theo dõi hiệu suất và ra quyết định hàng ngày.

---

## Công cụ sử dụng

* MySQL
* SQL (CTE, Window Functions, KPI Calculation)
* Power BI
* DAX
* Power Query
* Data Modeling
