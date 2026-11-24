---
name: "tham-dinh-plugin-skill"
description: "Dùng trước khi cài hoặc giới thiệu một plugin, skill, MCP server, proxy hay repo GitHub của bên thứ ba cho Claude: kiểm tra nguồn gốc, rủi ro, điều khoản và mức trùng lặp."
---

# Thẩm định plugin / skill trước khi cài

Dùng khi người dùng gửi link reel, bài viết, repo kiểu "5 plugin phải cài" và muốn biết có nên dùng không.

## Bước 1 — Xác định đúng thứ cần thẩm định
- Nếu nguồn là video/ảnh: đọc tên từ ảnh chụp, tìm repo gốc bằng web search.
- Phân loại: plugin Claude Code | skill (SKILL.md) | MCP server | proxy/gateway | công cụ CLI.
- Tìm **repo gốc**, không lấy bản fork. Dấu hiệu bản gốc: nhiều sao nhất, lịch sử commit dài, được trang tin/registry dẫn link.

## Bước 2 — Checklist 8 điểm
1. **Nguồn gốc**: chính thức Anthropic (thư mục `/plugins` của `anthropics/claude-plugins-official`) > đối tác/cộng đồng đã kiểm duyệt > cá nhân. Có trong marketplace chính thức không đồng nghĩa với "do Anthropic làm".
2. **Độ tin cậy**: số sao, ngày cập nhật, số người đóng góp, issue bảo mật đang mở.
3. **Thứ nó thực thi**: hooks, script cài đặt, `curl | bash`, `npx`, tiến trình chạy nền.
4. **Luồng dữ liệu**: code/prompt có rời khỏi máy không? Có đi qua proxy hoặc nhà cung cấp bên thứ ba không? Có đòi API key/token đăng nhập không?
5. **Điều khoản sử dụng**: dùng chung gói đăng ký Claude qua proxy, lách giới hạn, "Claude miễn phí" → rủi ro khóa tài khoản. Loại này mặc định KHÔNG khuyên dùng.
6. **Giấy phép**: MIT/Apache thoải mái; AGPL cần lưu ý nếu dùng thương mại.
7. **Dấu hiệu lạ**: gắn token crypto, quảng cáo phóng đại, yêu cầu quyền rộng không cần thiết.
8. **Trùng lặp**: so với skill/tính năng người dùng đã có (memory sẵn có, skill tiết kiệm token, skill debug...). Trùng thì nói rõ.

## Bước 3 — Kết luận
Mỗi mục cho một trong ba mức:
- ✅ **Nên cài** — nguồn tin cậy, chỉ đọc hoặc rủi ro thấp, có ích rõ.
- ⚠️ **Cài có điều kiện** — hữu ích nhưng cần lưu ý (dữ liệu, giấy phép, trùng lặp).
- ⛔ **Không nên cài** — rủi ro bảo mật, vi phạm điều khoản, nguồn không rõ.

Định dạng trả lời (gọn cho điện thoại):
```
**Tên** (mức) — làm gì trong 1 câu.
Lưu ý: <rủi ro chính, nếu có>
Cài: <lệnh chính xác từ repo gốc>
```
Cuối cùng: thứ tự ưu tiên cài, và nguồn tham khảo.

## Ví dụ tham chiếu (đã thẩm định 11/2026)
| Tên | Mức | Lý do |
|---|---|---|
| claude-code-setup | ✅ | Chính thức Anthropic, chỉ đọc, chỉ đề xuất |
| task-observer | ✅ | Rút kinh nghiệm thành skill, chạy được cả mobile |
| Headroom | ⚠️ | Nén context tốt, nhưng là proxy chạy cục bộ — kiểm tra cấu hình |
| claude-mem | ⚠️ | Hữu ích, nhưng gắn token crypto, AGPL, trùng memory sẵn có |
| OmniRoute | ⛔ | Định tuyến code qua nhiều bên thứ ba, rủi ro điều khoản, nhiều fork |

## Không làm
- Không tự cài, không chạy script cài đặt khi chưa được người dùng đồng ý.
- Không chép nội dung bài viết/video nguyên văn; tóm tắt bằng lời của mình.