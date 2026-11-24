# claude-code-starter-vi

**Cài 1 lệnh. Claude Code làm đúng hơn, tốn ít token hơn.**

Bộ cấu hình gọn cho Claude Code, dành cho người dùng Việt: 8 skill chính, 4 skill tùy chọn, một file CLAUDE.md toàn cục và một ngưỡng nén context hợp lý. Cài bằng một lệnh trên Windows.

> Dự án cộng đồng, không phải sản phẩm của Anthropic. Mức tiết kiệm token tùy dự án và cách dùng; bộ này không cam kết một con số cụ thể.

## Gói này có gì

**skills-core**: 8 skill luôn cài. Tất cả chỉ là file markdown, không có script.

| Skill | Tác dụng | Lợi ích |
|---|---|---|
| karpathy-guidelines | Sửa đúng chỗ, không làm phức tạp, nêu rõ giả định | Chính xác |
| systematic-debugging | Tìm nguyên nhân gốc trước khi sửa lỗi | Chính xác, đỡ sửa đi sửa lại |
| verification-before-completion | Phải chạy test/build rồi mới báo xong | Chính xác |
| long-session-steering | Lập kế hoạch, compaction, hook cho phiên dài | Token |
| subagent-design | Giao việc tìm kiếm rộng cho subagent | Token |
| project-bootstrap | Tạo cây thư mục, CLAUDE.md cho dự án mới | Token (agent đọc nhanh) |
| de-xuat-tu-dong-hoa-du-an | Quét dự án, đề xuất hook/skill/MCP phù hợp | Cả hai |
| tham-dinh-plugin-skill | Kiểm tra skill/plugin bên thứ ba trước khi cài | An toàn |

**skills-tuy-chon**: chỉ cài khi cần.

| Skill | Khi nào cài |
|---|---|
| test-driven-development | Dự án có test tự động. Viết test trước tốn thêm token nhưng ít lỗi hơn |
| thiet-ke-giao-dien | Làm web/app |
| humanizer | Viết bài, kịch bản, giáo trình trong Claude Code |
| skill-quality-audit | Tự viết hoặc sửa skill |

**config**
- `CLAUDE.md` toàn cục: các luật ngắn, được nạp ở mọi phiên. File viết bằng tiếng Anh vì tốn ít token hơn tiếng Việt, nhưng có dặn Claude trả lời bằng tiếng Việt.
- `settings.json`: thêm `autoCompactWindow: 400000` (nén context ở mức 400K thay vì gần 1M).

## Vì sao không cài nhiều hơn
Mỗi skill đã cài đều nạp phần mô tả của nó vào mọi phiên. Cài càng nhiều thì càng tốn token và Claude càng dễ chọn nhầm skill. Bộ này đã bỏ các skill có lệnh kích hoạt "mọi phiên", vì chúng chạy liên tục và ngốn token.

## Cài đặt (Windows)
1. Tải về: bấm **Code → Download ZIP** trên trang https://github.com/AISupportTop/claude-code-starter-vi rồi giải nén, hoặc chạy `git clone https://github.com/AISupportTop/claude-code-starter-vi`.
2. Mở PowerShell trong thư mục đó và chạy:
   ```
   powershell -ExecutionPolicy Bypass -File .\cai-dat.ps1
   ```
   Muốn cài thêm các skill tùy chọn thì thêm `-TuyChon` vào cuối lệnh.
3. Mở lại Claude Code. Gõ `/skills` để xem danh sách, `/autocompact` để kiểm tra ngưỡng.

Script không xóa gì. Skill trùng tên được đổi tên thành `.bak-<giờ>`. `settings.json` cũ được sao lưu trước khi sửa. Nếu bạn đã có `CLAUDE.md`, bản mới được lưu thành `CLAUDE.kit.md` để bạn tự gộp.

## Cài thêm skill bên thứ ba (đã thẩm định)
- **Graphify**, để đọc dự án lớn nhanh: đã cài. Trong mỗi dự án gõ `/graphify .`
- **Emil Kowalski**, cho hiệu ứng giao diện: `npx skills add https://github.com/emilkowalski/skills --skill emil-design-eng`
- **Impeccable**, để thiết kế và kiểm lỗi giao diện: `npx skills add pbakaus/impeccable --skill impeccable`

## Thói quen tiết kiệm token
1. Gõ `/clear` khi chuyển sang việc khác.
2. Với việc dài, giữ một file `PLAN.md` (mục tiêu, quyết định, file đã sửa, bước tiếp).
3. Tự nén có chủ đích: `/compact giữ lại quyết định thiết kế và danh sách file đã sửa`.
4. Gõ `/context` để xem cái gì đang chiếm chỗ. Tắt MCP server không dùng tới.
5. Dự án lớn: chạy `/graphify .` một lần, rồi để Claude đọc `GRAPH_REPORT.md`.

## Dùng với Antigravity
Antigravity đọc skill trong `.agents/skills/` của từng dự án. Muốn dùng bộ này ở đó thì chép thư mục `skills-core` vào `<dự án>\.agents\skills\`.

## Ghi công và giấy phép
- Phần nội dung tự viết trong repo này dùng giấy phép MIT (xem `LICENSE`).
- Một số skill dựa trên dự án mã nguồn mở của người khác. Danh sách và giấy phép nằm trong `THIRD_PARTY_NOTICES.md`. Nếu muốn bản đầy đủ và mới nhất, hãy cài thẳng từ repo gốc.
- Trước khi cài skill của bất kỳ ai (kể cả repo này), hãy đọc qua SKILL.md. Bộ này chỉ gồm file markdown và một script PowerShell, không tải gì từ Internet.
