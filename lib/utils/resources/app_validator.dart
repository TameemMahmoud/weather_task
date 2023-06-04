class AppValidator {
  static bool isImage(String url) {
    if (url.contains('.apng') || url.contains('.avif') ||
        url.contains('.gif') || url.contains('.jpg') ||
        url.contains('.jpeg') || url.contains('.jfif')||
        url.contains('.pjpeg') || url.contains('.pjp') ||
        url.contains('.png') || url.contains('.svg') ||
        url.contains('.webp') || url.contains('.jfif')) {
      return true;
    } else {
      return false;
    }
  }

  static String? isValidReport(dynamic value) {
    if (value!.isNotEmpty) {
      if (value.length <= 10) {
        return 'برجاء كتابة التقرير كاملا';
      }
    } else {
      return 'برجاء املاء الحقل';
    }

    return null;
  }

  static String? nameAddress(dynamic value) {
    if (value!.isNotEmpty) {
      if (value.length <= 5) {
        return 'برجاء كتابة الاسم كامل';
      }
    } else {
      return 'برجاء املاء الحقل';
    }

    return null;
  }

  static String? detailsAddress(dynamic value) {
    if (value!.isNotEmpty) {
      if (value.length <= 10) {
        return 'برجاء كتابة التفاصيل كاملة كامل';
      }
    } else {
      return 'برجاء املاء الحقل';
    }

    return null;
  }


  static String? isValidphone(dynamic value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'برجاء املاء الحقل';
      } else if (value.length < 9) {
        return 'من فضلك ادخل رقم صحيح';
      }
    }
    return null;
  }


  static String? isValidEmail(dynamic value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'برجاء املاء الحقل';
      }
      // else if (!value.contains('@') || !value.contains('.')) {
      //   return 'من فضلك ادخل اميل صحيح';
      // }
    }
    return null;
  }

  static String? isValidName(dynamic value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'برجاء املاء الحقل';
      } else if (value.length < 4) {
        return 'من فضلك اسمك كاملا';
      }
    }
    return null;
  }

  static String? isValidEmpty(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'برجاء املاء الحقل';
      }
    }
    return null;
  }

  static String? isValidPassword(dynamic value) {
    if (value != null) {
      if (value.isEmpty || value.length <= 5) {
        return 'برجاء املاء الحقل';
      }
    }
    return null;
  }

  static String? isNotLowerThan5(String? value) {
    if (value != null) {
      if (value.isEmpty && value.length < 4) {
        return 'برجاء املاء الحقل';
      }
    }
    return null;
  }

  static String? isValidLocation(String? value) {
    if (value != null) {
      if (value.isEmpty || value.length < 15) {
        return 'برجاء ادخال العنوان كامل';
      }
    }
    return null;
  }

}