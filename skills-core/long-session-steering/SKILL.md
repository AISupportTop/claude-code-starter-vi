---
name: "long-session-steering"
description: "Dùng khi chạy phiên Claude Code dài hoặc tự động (headless, scheduled, GitHub Actions): lập kế hoạch, điều hướng, compaction, hooks, permission mode và kiểm chứng kết quả không giám sát."
---

# Điều hướng phiên dài & tự động hoá

## 1. Trước khi bắt đầu — khoanh phạm vi
- Dùng **Plan Mode** để Claude khám phá và đề xuất kế hoạch trước khi sửa code.
- Quy trình chuẩn: **explore → plan → code → commit**.
- Chọn chế độ: tự điều hướng từng bước (việc mơ hồ, rủi ro) hay chạy tự động theo goal/loop (việc rõ, có test kiểm chứng).

## 2. Cấu hình để Claude tuân thủ
- **CLAUDE.md gọn**: chỉ quy ước bền vững của dự án (lệnh build/test, cấu trúc, quy tắc cứng). Quy trình lặp lại → đóng gói thành **Skill**, không nhồi vào CLAUDE.md.
- **Permission mode** theo từng việc: approval (mặc định, an toàn), auto-accept (việc đã tin cậy), plan (chỉ đọc).
- **Hooks** cho luật không được bỏ qua: format sau khi sửa, chặn lệnh nguy hiểm, thông báo, và *chặn kết thúc lượt nếu test thật chưa pass*.

## 3. Trong phiên — quản lý context
- `/context` để xem context đang dùng; `/compact` kèm chỉ dẫn giữ gì (quyết định, file đang sửa, test đang fail); `/clear` khi chuyển hẳn sang việc khác.
- Dùng menu **rewind** để quay lại khi đi sai hướng thay vì chồng thêm sửa chữa.
- Giao việc đọc/tìm diện rộng cho subagent để giữ context chính sạch.

## 4. Tự động hoá việc lặp lại
- Chạy theo lịch (routines), headless mode, tích hợp GitHub Actions / review PR.
- Prompt cho lượt tự động phải tự đủ: mục tiêu, phạm vi, tiêu chí xong, việc phải làm khi bị chặn.

## 5. Kiểm chứng kết quả không giám sát
- Mức kiểm tra **tỷ lệ nghịch** với mức bạn đã theo dõi.
- Tối thiểu: chạy lại test/build, đọc diff, đối chiếu tiêu chí xong ban đầu.
- Không tuyên bố "xong" khi chưa có bằng chứng chạy thật.

## 6. Chia sẻ cho team
- Khi bộ CLAUDE.md + skills + hooks + subagents đã đáng tin, đóng gói thành **plugin** để cả team dùng.