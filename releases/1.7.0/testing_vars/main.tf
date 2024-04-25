variable "test" {
  type = string
}

resource "local_file" "this" {
  filename = "${path.module}/test.txt"
  content = var.test
}