class FinglishConverter {
  // Basic Finglish to Farsi character mapping
  static final Map<String, String> _charMap = {
    'a': 'ا',
    'b': 'ب',
    'c': 'ک',
    'd': 'د',
    'e': 'ی',
    'f': 'ف',
    'g': 'گ',
    'h': 'ه',
    'i': 'ی',
    'j': 'ج',
    'k': 'ک',
    'l': 'ل',
    'm': 'م',
    'n': 'ن',
    'o': 'و',
    'p': 'پ',
    'q': 'ق',
    'r': 'ر',
    's': 'س',
    't': 'ت',
    'u': 'و',
    'v': 'و',
    'w': 'و',
    'x': 'خ',
    'y': 'ی',
    'z': 'ز',
    'aa': 'آ',
    'ee': 'ی',
    'oo': 'و',
    'kh': 'خ',
    'gh': 'غ',
    'sh': 'ش',
    'ch': 'چ',
    'zh': 'ژ',
    'ts': 'ث',
    'ss': 'ص',
    'zz': 'ض',
    'tt': 'ط',
    'zz': 'ظ',
    'hh': 'ح',
    'aa': 'ع',
  };

  // Common Finglish words to Farsi mapping
  static final Map<String, String> _wordMap = {
    'ghaza': 'غذا',
    'pizza': 'پیتزا',
    'sushi': 'سوشی',
    'panini': 'پنینی',
    'esfenaj': 'اسفناج',
    'peperoni': 'پپرونی',
    'dolme': 'دلمه',
    'barg': 'برگ',
    'kalam': 'کلم',
    'badamjan': 'بادمجان',
    'shokam': 'شکم',
    'por': 'پر',
    'ratatouie': 'راتاتویی',
    'ratatouii': 'راتاتویی',
    'ratatouy': 'راتاتویی',
  };

  /// Converts Finglish text to Farsi
  static String finglishToFarsi(String finglish) {
    String lower = finglish.toLowerCase().trim();
    
    // Check word map first
    if (_wordMap.containsKey(lower)) {
      return _wordMap[lower]!;
    }
    
    // Try to convert character by character
    String result = '';
    int i = 0;
    while (i < lower.length) {
      // Check for two-character combinations first
      if (i < lower.length - 1) {
        String twoChar = lower.substring(i, i + 2);
        if (_charMap.containsKey(twoChar)) {
          result += _charMap[twoChar]!;
          i += 2;
          continue;
        }
      }
      
      // Check single character
      String oneChar = lower[i];
      if (_charMap.containsKey(oneChar)) {
        result += _charMap[oneChar]!;
      } else {
        result += oneChar; // Keep original if no mapping
      }
      i++;
    }
    
    return result;
  }

  /// Checks if text contains Finglish characters (Latin alphabet)
  static bool isFinglish(String text) {
    return RegExp(r'^[a-zA-Z\s]+$').hasMatch(text.trim());
  }
}

