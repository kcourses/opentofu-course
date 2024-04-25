run "test" {
  assert {
    condition = file(local_file.this.filename) == var.test
    error_message = "Incorrect content in file"
  }
}