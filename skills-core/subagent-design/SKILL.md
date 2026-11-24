---
name: "subagent-design"
description: "Dùng khi cần thiết kế, tạo hoặc quyết định có nên giao việc cho subagent (Claude Code /agents, Agent tool): review code, viết docs, tìm kiếm diện rộng, giữ context chính gọn."
---

# Thiết kế & dùng subagent

Subagent chạy trong context window riêng, nhận đầu vào, trả về bản tóm tắt. Mục tiêu: giữ hội thoại chính sạch và tập trung.

## 1. Có nên giao không?
Giao khi:
- Việc đọc/tìm nhiều nhưng chỉ cần kết luận (quét repo, đối chiếu nhiều tài liệu).
- Cần góc nhìn độc lập, không bị ảnh hưởng bởi quá trình làm (review, kiểm chứng).
- Có nhiều nhánh việc độc lập chạy song song.

KHÔNG giao khi (anti-pattern):
- Việc nhỏ, làm trực tiếp nhanh hơn chi phí khởi động subagent.
- Kết quả bước này quyết định ngay bước sau (cần vòng lặp chặt).
- Cần toàn bộ ngữ cảnh hội thoại mà khó truyền đủ trong prompt.

## 2. Viết prompt / định nghĩa subagent
Mỗi subagent cần:
1. **Mục tiêu một câu** — việc gì, xong khi nào.
2. **Đầu vào đầy đủ** — đường dẫn, phạm vi, ràng buộc (subagent không thấy hội thoại của bạn).
3. **Giới hạn công cụ** — chỉ cấp tool cần thiết (ví dụ reviewer: chỉ đọc, không Edit/Write).
4. **Định dạng đầu ra có cấu trúc** — ví dụ:
   ```
   ## Kết luận
   ## Bằng chứng (file:dòng)
   ## Trở ngại / chưa làm được
   ## Mức tin cậy
   ```
5. **Bắt buộc báo trở ngại** — nếu bị chặn hoặc thiếu dữ liệu thì dừng và báo, không đoán.
6. **Giới hạn phạm vi/thời gian** — ví dụ "tối đa 15 file", "không sửa code".

## 3. Tạo trong Claude Code
- Dùng lệnh `/agents` để tạo subagent tuỳ chỉnh (code-reviewer, doc-writer, test-runner…).
- Có thể nối subagent với Skill để giao việc chuyên biệt, cô lập.

## 4. Sau khi nhận kết quả
- Đọc phần "Trở ngại" trước.
- Kiểm tra mẫu vài bằng chứng; mức kiểm tra tỷ lệ nghịch với mức bạn đã giám sát.
- Chỉ chuyển cho người dùng phần quan trọng, không dán nguyên báo cáo.