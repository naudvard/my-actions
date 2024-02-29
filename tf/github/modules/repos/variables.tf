variable "name" {
  type    = string
  default = ""
}

variable "description" {
  type    = string
  default = ""
}

variable "visibility" {
  type    = string
  default = "private"
}

variable "issues" {
  type    = bool
  default = true
}

variable "merge_commit" {
  type    = bool
  default = false
}

variable "squash_merge" {
  type    = bool
  default = true
}

variable "rebase_merge" {
  type    = bool
  default = false
}

variable "default_merge_title" {
  type    = string
  default = "PR_TITLE"
}

variable "delete_branch_on_merge" {
  type    = bool
  default = true
}

variable "auto_init" {
    type    = bool
    default = true
}

variable "archive_on_destroy" {
  type    = bool
  default = true
}

variable "protected_branches" {
  type    = list(string)
  default = ["main"]
}

variable "default_branch" {
  type    = string
  default = "main"
}

variable "linear_history" {
  type    = bool
  default = true
}

variable "conversation_resolution" {
  type    = bool
  default = true
}

variable "force_push" {
  type    = bool
  default = false
}

variable "dismiss_review" {
  type    = bool
  default = true
}

variable "review_count" {
  type    = number
  default = 1
}