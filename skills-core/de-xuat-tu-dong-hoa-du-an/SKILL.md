---
name: "de-xuat-tu-dong-hoa-du-an"
description: "Dùng khi người dùng muốn thiết lập Claude cho một dự án: quét dự án (chỉ đọc) rồi đề xuất hooks, skills, MCP, subagent, slash command phù hợp nhất."
---

# Đề xuất tự động hóa cho dự án

Nguyên tắc số 1: **chỉ đọc, chỉ đề xuất**. Không tạo/sửa file cấu hình nào cho đến khi người dùng chọn.

## Kích hoạt khi
"setup Claude cho dự án này", "nên dùng hook/skill/MCP gì", "tối ưu Claude Code cho repo này", "bắt đầu dự án mới với Claude".

## Bước 1 — Quét tín hiệu dự án
Đọc nhanh (không đọc hết từng file):
- Ngôn ngữ & framework: `package.json`, `pyproject.toml`, `requirements.txt`, `go.mod`, lockfile.
- Kiểm thử & chất lượng: cấu hình test, linter, formatter.
- CI/CD: `.github/workflows`, Dockerfile.
- File nhạy cảm: `.env`, thư mục `secrets`, khóa.
- Tài liệu & quy ước: README, CLAUDE.md có sẵn, `.claude/`.
- Dịch vụ ngoài: tên DB, API, Slack/Notion/Drive xuất hiện trong code hoặc tài liệu.
- Dự án không phải code (giáo trình, sách, marketing): cấu trúc thư mục, định dạng đầu ra, quy trình lặp lại.

## Bước 2 — Đối chiếu 5 nhóm
| Nhóm | Gợi ý điển hình |
|---|---|
| Hooks | tự format/lint sau khi sửa file; chặn ghi vào `.env`/file khóa; chạy test liên quan sau khi sửa |
| Skills | quy trình lặp lại riêng của dự án (viết bài giảng theo khung, review PR theo checklist, phát hành) |
| MCP / connector | DB, GitHub, Drive, Notion, Slack mà dự án thực sự dùng |
| Subagents | review code, tìm kiếm diện rộng, viết docs — giữ ngữ cảnh chính gọn |
| Slash commands | lệnh tắt cho thao tác hay gõ (`/test`, `/release`, `/bai-giang-moi`) |

## Bước 3 — Chọn lọc
- Mỗi nhóm tối đa 1–2 đề xuất, chỉ khi có bằng chứng từ bước 1.
- Bỏ nhóm không có tín hiệu — không đề xuất cho đủ.
- Ưu tiên plugin/skill chính thức hoặc đã có sẵn trước khi tự viết mới.
- Với plugin bên thứ ba: chạy skill `tham-dinh-plugin-skill` trước khi đề xuất cài.

## Bước 4 — Báo cáo
Với mỗi đề xuất:
```
[Nhóm] Tên đề xuất
- Vì sao: <tín hiệu cụ thể tìm thấy, ví dụ "có .eslintrc và prettier">
- Lợi ích: <1 dòng>
- Công sức: thấp | vừa | cao
- Cách bật: <lệnh hoặc đoạn cấu hình ngắn>
```
Kết thúc bằng: "Bạn muốn mình thiết lập mục nào?" Chỉ làm những mục được chọn.

## Lưu ý
- Không đề xuất proxy/gateway định tuyến lại lưu lượng API của Claude qua bên thứ ba.
- Hook chạy lệnh shell tự động — luôn cho người dùng xem lệnh trước khi bật.