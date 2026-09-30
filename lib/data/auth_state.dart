bool
_isLoggedIn = false;

// 2. GETTER: Mengambil nilai variabel private dengan aman dari file lain
bool
get globalIsLoggedIn {
  return _isLoggedIn;
}

// 3. SETTER: Mengubah nilai variabel private dengan aman dari file lain
set globalIsLoggedIn(
  bool status,
) {
  _isLoggedIn = status;
}
