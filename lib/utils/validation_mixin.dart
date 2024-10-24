mixin ValidationMixin {
  String? validateFields(String? value) {
    if (value == null || value.isEmpty || value.length >= 52) {
      return 'Fields should not be empty';
    } else {
      //name regex
      // ignore: unnecessary_new
      RegExp regex = new RegExp(r'^[A-Za-z\ ]+$');
      if (regex.hasMatch(value)) {
        return 'Fields Should only contain numbers';
      } else {
        return null;
      }
    }
  }
}
