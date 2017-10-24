resource "random_string" "user" {
  length = 16
  special = false
}

resource "random_string" "password" {
  length = 16
  special = true
}
