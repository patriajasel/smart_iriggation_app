class WaterAmountProvider {
  final Map<int, Map<String, int>> _waterAmount = {
    50: {
      '1Node': 2,
      '2Node': 4,
      '3Node': 6,
      '4Node': 8,
    },
    100: {
      '1Node': 3,
      '2Node': 6,
      '3Node': 9,
      '4Node': 12,
    },
    150: {
      '1Node': 4,
      '2Node': 8,
      '3Node': 12,
      '4Node': 16,
    },
    200: {
      '1Node': 5,
      '2Node': 10,
      '3Node': 15,
      '4Node': 20,
    },
    250: {
      '1Node': 7,
      '2Node': 14,
      '3Node': 21,
      '4Node': 28,
    },
    300: {
      '1Node': 8,
      '2Node': 16,
      '3Node': 24,
      '4Node': 32,
    },
    350: {
      '1Node': 9,
      '2Node': 18,
      '3Node': 27,
      '4Node': 36,
    },
    400: {
      '1Node': 11,
      '2Node': 22,
      '3Node': 33,
      '4Node': 44,
    },
    450: {
      '1Node': 12,
      '2Node': 24,
      '3Node': 36,
      '4Node': 48,
    },
    500: {
      '1Node': 13,
      '2Node': 26,
      '3Node': 39,
      '4Node': 52,
    },
    550: {
      '1Node': 15,
      '2Node': 30,
      '3Node': 45,
      '4Node': 60,
    },
    600: {
      '1Node': 16,
      '2Node': 32,
      '3Node': 48,
      '4Node': 64,
    },
    650: {
      '1Node': 17,
      '2Node': 34,
      '3Node': 51,
      '4Node': 68,
    },
    700: {
      '1Node': 19,
      '2Node': 38,
      '3Node': 57,
      '4Node': 76,
    },
    750: {
      '1Node': 20,
      '2Node': 40,
      '3Node': 60,
      '4Node': 80,
    },
    800: {
      '1Node': 21,
      '2Node': 42,
      '3Node': 63,
      '4Node': 84,
    },
    850: {
      '1Node': 23,
      '2Node': 46,
      '3Node': 69,
      '4Node': 92,
    },
    900: {
      '1Node': 24,
      '2Node': 48,
      '3Node': 72,
      '4Node': 96,
    },
    950: {
      '1Node': 25,
      '2Node': 50,
      '3Node': 75,
      '4Node': 100,
    },
    1000: {
      '1Node': 27,
      '2Node': 54,
      '3Node': 81,
      '4Node': 108,
    },
  };

  Map<int, Map<String, int>> get waterAmount => _waterAmount;
}
