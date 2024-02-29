locals {
  repos = {
    "test-tf" = {
      name : "test-tf",
      description : "Test Terraform",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 2,
    }
  }
}