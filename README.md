<div align="center">

# claude-code-starter-vi

**Bộ khởi động tiếng Việt cho Claude Code: làm đúng hơn, tốn ít token hơn, cài bằng 1 lệnh.**

Một dự án của [Ai-Support.Top](https://ai-support.top), nơi hỗ trợ sử dụng AI cho người Việt.

![License: MIT](https://img.shields.io/badge/license-MIT-blue)
![Platform: Windows](https://img.shields.io/badge/platform-Windows-0078D6)
![Claude Code](https://img.shields.io/badge/Claude%20Code-skills-D97757)
![Ngôn ngữ: Tiếng Việt](https://img.shields.io/badge/ng%C3%B4n%20ng%E1%BB%AF-Ti%E1%BA%BFng%20Vi%E1%BB%87t-red)

[Cài đặt nhanh](#cài-đặt-nhanh) · [Có gì bên trong](#có-gì-bên-trong) · [Cách hoạt động](#cách-hoạt-động) · [Câu hỏi thường gặp](#câu-hỏi-thường-gặp)

</div>

> [!NOTE]
> Đây là dự án cộng đồng, không phải sản phẩm của Anthropic. Mức tiết kiệm token phụ thuộc vào dự án và cách bạn làm việc; repo này không cam kết một con số cụ thể.

---

## Vấn đề

Ai dùng Claude Code lâu đều gặp ba chuyện:

- **Báo "xong" khi chưa xong.** Claude sửa lỗi theo phỏng đoán, bảo đã chạy được nhưng chưa hề chạy test.
- **Phiên dài thì quên trước quên sau.** Context càng đầy, chất lượng càng giảm (hiện tượng *context rot*), còn token thì tiêu đều.
- **Cài skill tràn lan.** Mỗi skill nạp phần mô tả vào mọi phiên. Cài nhiều thì tốn token, Claude dễ chọn nhầm, và có rủi ro dính skill độc hại.

## Giải pháp

`claude-code-starter-vi` là một bộ cấu hình **có chọn lọc**, không phải kho skill:

| Mục tiêu | Cách làm |
|---|---|
| **Làm đúng** | Bắt Claude tìm nguyên nhân gốc, sửa đúng chỗ, chạy kiểm tra rồi mới báo hoàn thành |
| **Tiết kiệm token** | Nén context ở 400K, giao việc tìm kiếm cho subagent, giữ CLAUDE.md ngắn, chỉ 8 skill lõi |
| **An toàn** | Có quy trình thẩm định trước khi cài skill, plugin hay MCP của bên thứ ba |
| **Dễ dùng** | Một script cài đặt, không ghi đè cấu hình cũ, hướng dẫn tiếng Việt |

---

## Cài đặt nhanh

**Yêu cầu:** Windows 10/11, [Claude Code](https://docs.claude.com/en/docs/claude-code/overview) bản 2.1.221 trở lên (để dùng lệnh `/autocompact`).

**1. Tải về**

```bash
git clone https://github.com/AISupportTop/claude-code-starter-vi.git
cd claude-code-starter-vi
```

Hoặc bấm **Code → Download ZIP** rồi giải nén.

**2. Chạy script cài đặt** (mở PowerShell trong thư mục vừa tải):

```powershell
# Cài 8 skill lõi + cấu hình
powershell -ExecutionPolicy Bypass -File .\cai-dat.ps1

# Cài thêm 4 skill tùy chọn
powershell -ExecutionPolicy Bypass -File .\cai-dat.ps1 -TuyChon
```

**3. Kiểm tra:** mở lại Claude Code, gõ `/skills` để xem danh sách skill và `/autocompact` để xem ngưỡng nén.

> [!TIP]
> Script **không xóa gì**. Skill trùng tên được đổi thành `<tên>.bak-<thời gian>`. File `settings.json` cũ được sao lưu trước khi sửa. Nếu bạn đã có `CLAUDE.md`, bản mới được lưu thành `CLAUDE.kit.md` để bạn tự gộp.

---

## Có gì bên trong

### Skill lõi (`skills-core`): luôn cài

| Skill | Tác dụng | Nhóm |
|---|---|---|
| `karpathy-guidelines` | Nêu rõ giả định, giữ giải pháp đơn giản, sửa đúng chỗ | Làm đúng |
| `systematic-debugging` | Tìm nguyên nhân gốc trước khi đề xuất cách sửa | Làm đúng |
| `verification-before-completion` | Phải chạy test/build và đọc kết quả rồi mới báo xong | Làm đúng |
| `long-session-steering` | Lập kế hoạch, điều hướng và nén context cho phiên dài | Token |
| `subagent-design` | Quyết định khi nào giao việc cho subagent để giữ context gọn | Token |
| `project-bootstrap` | Tạo cây thư mục và `CLAUDE.md` cho dự án mới | Token |
| `de-xuat-tu-dong-hoa-du-an` | Quét dự án (chỉ đọc), đề xuất hook, skill, MCP phù hợp | Thiết lập |
| `tham-dinh-plugin-skill` | Kiểm tra nguồn gốc, rủi ro, điều khoản trước khi cài đồ bên thứ ba | An toàn |

### Skill tùy chọn (`skills-tuy-chon`): cài khi cần

| Skill | Nên cài khi |
|---|---|
| `test-driven-development` | Dự án có test tự động (tốn thêm token, đổi lại ít lỗi hơn) |
| `thiet-ke-giao-dien` | Làm web hoặc app, muốn tránh giao diện "na ná AI" |
| `humanizer` | Viết bài, kịch bản, giáo trình bằng Claude Code |
| `skill-quality-audit` | Tự viết hoặc sửa skill |

### Cấu hình (`config`)

| File | Nội dung |
|---|---|
| `CLAUDE.md` | Luật toàn cục, nạp ở mọi phiên. Viết bằng tiếng Anh cho ít token, nhưng dặn Claude trả lời bằng tiếng Việt |
| `settings-them-vao.json` | Thêm `"autoCompactWindow": 400000` vào `settings.json` |

### Cấu trúc repo

```
claude-code-starter-vi/
├── cai-dat.ps1              # Script cài đặt
├── config/
│   ├── CLAUDE.md
│   └── settings-them-vao.json
├── skills-core/             # 8 skill lõi
├── skills-tuy-chon/         # 4 skill tùy chọn
├── README.md
├── LICENSE
└── THIRD_PARTY_NOTICES.md
```

---

## Cách hoạt động

**Nén context sớm hơn.** Với các model có context 1M token, Claude Code mặc định chờ gần đầy mới nén. Bộ này đặt ngưỡng 400K để Claude tóm tắt sớm, giữ chất lượng ổn định trong phiên dài. Với model có context nhỏ hơn 400K, thiết lập này không có tác dụng vì Claude Code lấy mức nhỏ hơn.

**Ít skill, mô tả rõ.** Claude đọc phần mô tả của mọi skill đã cài để quyết định dùng skill nào. Bộ này giữ 8 skill lõi với phạm vi không chồng chéo, và bỏ các skill kích hoạt ở "mọi phiên".

**CLAUDE.md ngắn và cụ thể.** File toàn cục chỉ chứa những luật cần ở mọi phiên: đọc tài liệu dự án trước, giao tìm kiếm rộng cho subagent, chỉ đọc đoạn file cần thiết, xác minh trước khi báo xong, giữ `PLAN.md` cho việc dài.

---

## Thói quen nên có

1. **`/clear`** khi chuyển sang việc khác. Context sạch tốt hơn context đã nén.
2. **`PLAN.md`** cho việc dài: mục tiêu, quyết định, file đã sửa, bước tiếp theo.
3. **Nén có chủ đích:** `/compact giữ lại quyết định thiết kế và danh sách file đã sửa`.
4. **`/context`** để xem cái gì đang chiếm chỗ. Tắt MCP server không dùng tới.
5. **Dự án lớn:** dùng [Graphify](https://github.com/Graphify-Labs/graphify) để dựng bản đồ tri thức, rồi để Claude đọc `GRAPH_REPORT.md` thay vì mở từng file.

## Mở rộng (đã thẩm định)

| Skill | Dùng cho | Lệnh cài |
|---|---|---|
| [Graphify](https://github.com/Graphify-Labs/graphify) | Đọc dự án lớn nhanh | `pip install graphifyy` rồi `graphify install` |
| [Emil Kowalski](https://github.com/emilkowalski/skills) | Hiệu ứng, chuyển động giao diện | `npx skills add https://github.com/emilkowalski/skills --skill emil-design-eng` |
| [Impeccable](https://github.com/pbakaus/impeccable) | Thiết kế và kiểm lỗi giao diện | `npx skills add pbakaus/impeccable --skill impeccable` |

Đừng cài cùng lúc nhiều skill có chức năng trùng nhau.

---

## Câu hỏi thường gặp

<details>
<summary><b>Có dùng được với Antigravity, Cursor hay Codex không?</b></summary>

Các skill theo chuẩn SKILL.md mở nên dùng được với nhiều công cụ. Với Antigravity, chép các thư mục trong `skills-core` vào `<dự án>\.agents\skills\`. Script `cai-dat.ps1` hiện chỉ cài cho Claude Code.
</details>

<details>
<summary><b>Có chạy trên macOS hoặc Linux không?</b></summary>

Script cài đặt hiện chỉ hỗ trợ Windows. Trên macOS/Linux, chép các thư mục skill vào `~/.claude/skills/`, chép `config/CLAUDE.md` vào `~/.claude/CLAUDE.md`, rồi thêm `"autoCompactWindow": 400000` vào `~/.claude/settings.json`.
</details>

<details>
<summary><b>Gỡ cài đặt thế nào?</b></summary>

Xóa các thư mục skill tương ứng trong `%USERPROFILE%\.claude\skills\`, xóa dòng `autoCompactWindow` trong `settings.json` (hoặc khôi phục từ file `settings.json.bak-*`), và xóa hoặc sửa `CLAUDE.md`. Gõ `/autocompact auto` trong Claude Code để trả ngưỡng nén về mặc định.
</details>

<details>
<summary><b>Repo này có an toàn không?</b></summary>

Repo chỉ gồm file markdown, một file JSON và một script PowerShell ngắn. Script không tải gì từ Internet. Bạn vẫn nên đọc `cai-dat.ps1` và các SKILL.md trước khi chạy, như với mọi skill của bên thứ ba.
</details>

---

## Đóng góp

Mọi góp ý đều được chào đón qua [Issues](https://github.com/AISupportTop/claude-code-starter-vi/issues) hoặc Pull Request. Khi đề xuất thêm skill, vui lòng nêu: skill giải quyết vấn đề gì, vì sao không trùng với skill đã có, và nguồn gốc cùng giấy phép của skill.

## Tác giả

Repo do **[Ai-Support.Top](https://ai-support.top)** thực hiện. Ai-Support.Top là dự án hỗ trợ người Việt sử dụng AI vào công việc hằng ngày.

- Website: [ai-support.top](https://ai-support.top)
- GitHub: [@AISupportTop](https://github.com/AISupportTop)

Nếu bộ skill có ích, hãy bấm ⭐ để nhiều người tìm thấy hơn.

## Ghi công và giấy phép

- Nội dung do repo này viết dùng giấy phép [MIT](LICENSE).
- Một số skill dựa trên dự án mã nguồn mở của tác giả khác, bao gồm [obra/superpowers](https://github.com/obra/superpowers) và [forrestchang/andrej-karpathy-skills](https://github.com/forrestchang/andrej-karpathy-skills). Danh sách đầy đủ nằm trong [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md). Muốn bản đầy đủ và mới nhất, hãy cài thẳng từ repo gốc.
- `karpathy-guidelines` là dự án cộng đồng lấy cảm hứng từ chia sẻ công khai của Andrej Karpathy. Andrej Karpathy không viết và không bảo trợ skill này.
