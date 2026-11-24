---
name: "thiet-ke-giao-dien"
description: "Dùng khi làm, sửa hoặc review giao diện web/app (landing page, trang khoá học, dashboard, component): tránh kiểu giao diện 'na ná AI', chọn bố cục, chữ, màu, hiệu ứng chuyển động có chủ đích."
---

# Thiết kế giao diện có chủ đích

Skill này tổng hợp ý tưởng từ ba bộ skill mã nguồn mở: Impeccable (pbakaus/impeccable, Apache-2.0), Taste Skill (Leonxlnx/taste-skill, MIT) và skill thiết kế của Emil Kowalski (emilkowalski/skills, MIT). Nội dung dưới đây được viết lại, không chép nguyên văn. Khi làm dự án trong Claude Code hoặc Antigravity, nên cài bản gốc vì bản gốc đầy đủ hơn. Skill này là bản gọn để dùng trong chat.

## Bước 1: Đọc đề bài trước khi vẽ
Viết ra 3 dòng trước khi code:
- **Ai dùng, dùng để làm gì?** Ví dụ: học viên lớn tuổi xem lịch học trên điện thoại.
- **Cảm giác cần có:** chọn 1–2 tính từ cụ thể (tin cậy, ấm, gọn, sôi động). Không dùng "hiện đại, đẹp".
- **Ba núm chỉnh, mỗi núm từ 1 đến 5:**
  - Độ phá cách của bố cục: 1 là lưới chuẩn, 5 là bố cục lệch, táo bạo.
  - Mức chuyển động: 1 là gần như tĩnh, 5 là nhiều hiệu ứng.
  - Mật độ thông tin: 1 là thoáng, 5 là dày như dashboard.

Trang bán khoá học thường hợp với khoảng 3/2/2. Dashboard quản trị thường hợp với khoảng 1/1/4.

## Bước 2: Tránh các dấu hiệu giao diện "do AI làm"
- Font Inter hay system cho mọi thứ. Hãy chọn một cặp font có cá tính và hỗ trợ tốt tiếng Việt, ví dụ Be Vietnam Pro, Lexend hoặc Montserrat kết hợp với một font serif cho tiêu đề.
- Gradient tím xanh, nền be nhạt chung chung, viền trái nhiều màu trên thẻ.
- Mọi thứ căn giữa. Lưới 3 thẻ giống hệt nhau, mỗi thẻ có icon tròn ở trên.
- Dòng chữ nhỏ in hoa phía trên tiêu đề hero, đánh số 01/02/03 kiểu trang trí.
- Giả lập giao diện bằng div (cửa sổ giả, biểu đồ giả) thay vì dùng ảnh hay nội dung thật.
- Câu chữ rỗng: "Nâng tầm", "Giải pháp toàn diện", "Khám phá ngay". Viết lời cụ thể theo skill humanizer.
- Bóng đổ, bo góc, khoảng cách đặt tuỳ tiện. Hãy dùng thang cố định, ví dụ khoảng cách 4/8/12/16/24/32/48/64.

## Bước 3: Nền tảng phải đúng
- **Chữ:** cỡ chữ theo một tỉ lệ cố định (ví dụ 1,25). Thân bài 16–18px. Độ dài dòng 60–75 ký tự. Line-height 1,5–1,7 cho tiếng Việt vì có dấu.
- **Màu:** một màu chủ đạo, một màu nhấn. Màu xám ngả theo màu chủ đạo thay vì xám thuần. Độ tương phản chữ đạt WCAG AA (từ 4,5:1).
- **Bố cục:** có thứ bậc rõ. Mỗi màn hình chỉ có một hành động chính.
- **Di động trước:** kiểm tra ở chiều rộng 375px. Vùng bấm tối thiểu 44px.
- **Trạng thái:** đủ các trạng thái hover, focus (thấy được khi dùng bàn phím), đang tải, trống và lỗi.

## Bước 4: Chuyển động (theo cách làm của Emil Kowalski)
- Trước hết hỏi: hiệu ứng này giúp người dùng hiểu gì? Nếu không giúp gì thì bỏ.
- Thao tác lặp lại nhiều lần (bấm nút, mở menu) cần thật nhanh hoặc không có hiệu ứng.
- Thời lượng: phản hồi nhỏ 100–200ms. Mở hoặc đóng panel 200–300ms. Hiếm khi cần quá 400ms.
- Kiểu chuyển động: dùng ease-out cho phần tử xuất hiện. Không dùng ease-in cho giao diện vì nó làm cảm giác chậm.
- Không phóng to từ scale(0). Bắt đầu từ khoảng 0,95 kết hợp với độ mờ.
- Hiệu ứng xuất hiện lần lượt: mỗi phần tử cách nhau 30–80ms, và không được chặn thao tác của người dùng.
- Ưu tiên animate transform và opacity. Luôn tôn trọng `prefers-reduced-motion`.

## Bước 5: Tự kiểm tra trước khi giao
1. Lướt qua các dấu hiệu ở Bước 2.
2. Chụp hoặc mở bản xem trước ở 375px và 1440px.
3. Kiểm tra độ tương phản và focus khi dùng bàn phím.
4. Khi sửa giao diện có sẵn, báo cáo bằng bảng ba cột: **Trước / Sau / Lý do**.

## Khi review giao diện của người khác
Chỉ ra lỗi theo thứ tự mức độ: không dùng được, rồi khó dùng, rồi xấu. Mỗi lỗi kèm cách sửa cụ thể (giá trị CSS, tên font, khoảng cách). Không nhận xét chung chung kiểu "cần hiện đại hơn".