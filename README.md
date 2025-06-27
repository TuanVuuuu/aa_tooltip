# AATooltip

Một thư viện Flutter để hiển thị tooltip đẹp và linh hoạt với nhiều tùy chọn cấu hình.

## Tính năng

- ✅ Hiển thị tooltip đơn giản với `AATooltip.show()`
- ✅ Widget wrapper để dễ dàng thêm tooltip
- ✅ Extension method cho mọi widget
- ✅ 8 vị trí hiển thị khác nhau
- ✅ Animation mượt mà
- ✅ Tùy chỉnh màu sắc, font chữ, kích thước
- ✅ Mũi tên có thể tùy chỉnh
- ✅ Tự động ẩn hoặc ẩn thủ công
- ✅ Hỗ trợ nhiều tooltip cùng lúc với ID

## Cài đặt

Thêm vào `pubspec.yaml`:

```yaml
dependencies:
  aa_tooltip: ^0.0.1
```

## Cách sử dụng

### 1. Sử dụng cơ bản với AATooltip.show()

```dart
import 'package:aa_tooltip/aa_tooltip.dart';

ElevatedButton(
  onPressed: () {
    AATooltip.show(
      context: context,
      message: 'Đây là tooltip đơn giản!',
    );
  },
  child: Text('Hiển thị Tooltip'),
)
```

### 2. Sử dụng AATooltipWrapper

```dart
AATooltipWrapper(
  message: 'Click để xem tooltip!',
  child: Icon(Icons.info),
)
```

### 3. Sử dụng Extension Method

```dart
Icon(Icons.help).tooltip(
  message: 'Tooltip với extension',
)
```

### 4. Cấu hình tùy chỉnh

```dart
AATooltip.show(
  context: context,
  message: 'Tooltip tùy chỉnh',
  config: AATooltipConfig(
    position: AATooltipPosition.bottom,
    backgroundColor: Colors.red,
    textStyle: TextStyle(color: Colors.white, fontSize: 14),
    borderRadius: BorderRadius.circular(8),
    showArrow: true,
    arrowSize: 8.0,
    autoHide: false,
    animationDuration: Duration(milliseconds: 300),
  ),
);
```

## Cấu hình AATooltipConfig

| Thuộc tính | Mô tả | Mặc định |
|------------|-------|----------|
| `position` | Vị trí hiển thị tooltip | `AATooltipPosition.top` |
| `backgroundColor` | Màu nền | `Colors.black87` |
| `textStyle` | Style cho text | `TextStyle(color: Colors.white, fontSize: 12)` |
| `borderRadius` | Bo góc | `BorderRadius.circular(4)` |
| `padding` | Padding bên trong | `EdgeInsets.symmetric(horizontal: 8, vertical: 4)` |
| `margin` | Margin bên ngoài | `EdgeInsets.all(8)` |
| `showArrow` | Hiển thị mũi tên | `true` |
| `arrowSize` | Kích thước mũi tên | `6.0` |
| `autoHide` | Tự động ẩn | `true` |
| `hideDelay` | Thời gian delay trước khi ẩn | `Duration(seconds: 2)` |
| `animationDuration` | Thời gian animation | `Duration(milliseconds: 200)` |
| `maxWidth` | Chiều rộng tối đa | `200.0` |
| `elevation` | Độ nâng (shadow) | `2.0` |
| `waitDuration` | Thời gian chờ trước khi hiển thị | `Duration.zero` |

## Vị trí hiển thị

```dart
enum AATooltipPosition {
  top,           // Phía trên
  bottom,        // Phía dưới
  left,          // Bên trái
  right,         // Bên phải
  topLeft,       // Góc trên trái
  topRight,      // Góc trên phải
  bottomLeft,    // Góc dưới trái
  bottomRight,   // Góc dưới phải
}
```

## Quản lý Tooltip

```dart
// Hiển thị tooltip với ID
AATooltip.show(
  context: context,
  message: 'Tooltip có ID',
  id: 'my-tooltip',
);

// Ẩn tooltip theo ID
AATooltip.hide(id: 'my-tooltip');

// Ẩn tất cả tooltip
AATooltip.hideAll();

// Kiểm tra tooltip có đang hiển thị không
bool isVisible = AATooltip.isVisible(id: 'my-tooltip');
```

## Ví dụ đầy đủ

Xem file [example/main.dart](example/main.dart) để biết cách sử dụng chi tiết.

## Đóng góp

Hoan nghênh mọi đóng góp! Vui lòng tạo issue hoặc pull request.

## Giấy phép

MIT License
