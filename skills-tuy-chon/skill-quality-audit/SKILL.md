---
name: "skill-quality-audit"
description: "Dùng khi viết, rà soát hoặc sửa một Agent Skill (SKILL.md): skill không kích hoạt, kích hoạt nhầm, xung đột ưu tiên, tốn context, lỗi khi chạy, hoặc chuẩn bị chia sẻ cho team."
---

# Rà soát chất lượng Skill

Nguyên tắc: dạy Claude một quy trình **một lần**, không phải nhắc lại mỗi lần.

## 1. Có nên là Skill không?
| Nhu cầu | Dùng |
|---|---|
| Quy ước luôn đúng cho cả dự án | CLAUDE.md |
| Quy trình lặp lại, chỉ cần khi gặp loại việc đó | **Skill** |
| Luật bắt buộc, không được bỏ qua | Hook |
| Việc cần context riêng, cô lập | Subagent |
| Truy cập hệ thống/dữ liệu ngoài | MCP server |

## 2. Checklist SKILL.md
- [ ] Frontmatter có `name` (kebab-case) và `description`.
- [ ] **Description** nói rõ *khi nào dùng*: loại việc, từ khoá người dùng hay nói (cả tiếng Việt & tiếng Anh), và khi nào KHÔNG dùng nếu dễ nhầm.
- [ ] Phần thân ngắn, nêu bước làm; chi tiết dài tách ra file phụ (**progressive disclosure**): `reference.md`, `examples/`, `scripts/`.
- [ ] Script chạy bằng lệnh thay vì dán code vào context — chỉ đầu ra tốn context.
- [ ] Cân nhắc `allowed-tools` để giới hạn công cụ.
- [ ] Có ví dụ đầu vào → đầu ra mong muốn.

## 3. Chẩn đoán sự cố
**Không kích hoạt** → description quá chung hoặc thiếu từ khoá; thêm tình huống cụ thể, động từ người dùng hay dùng.
**Kích hoạt nhầm / xung đột với skill khác** → thu hẹp description, thêm "không dùng cho…", phân biệt rõ phạm vi giữa hai skill.
**Tốn context** → chuyển nội dung tham khảo ra file phụ, chỉ dẫn đường đọc khi cần.
**Lỗi khi chạy** → kiểm tra đường dẫn tương đối, quyền tool (`allowed-tools`), phụ thuộc script chưa cài.

## 4. Chia sẻ
- Cá nhân → thư mục skills của người dùng.
- Team → commit vào repo dự án.
- Nhiều repo/nhóm → đóng gói qua **plugin**.
- Toàn tổ chức → managed settings của Enterprise.

## 5. Kiểm thử nhanh
Viết 3–5 câu yêu cầu thật (nên kích hoạt) và 2–3 câu gần giống (không nên kích hoạt), thử và chỉnh description đến khi phân loại đúng.