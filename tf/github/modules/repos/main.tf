resource "github_repository" "repo" {
  name                      = var.name
  description               = var.description
  visibility                = var.visibility
  has_issues                = var.issues
  allow_merge_commit        = var.merge_commit
  allow_rebase_merge        = var.rebase_merge
  allow_squash_merge        = var.squash_merge
  squash_merge_commit_title = var.default_merge_title
  delete_branch_on_merge    = var.delete_branch_on_merge
  auto_init                 = var.auto_init
  archive_on_destroy        = var.archive_on_destroy
}

resource "github_branch_default" "default-branch" {
  branch     = var.default_branch
  repository = github_repository.repo.name
}

resource "github_branch_protection" "protected-branch" {
  for_each = toset(var.protected_branches)

  repository_id = github_repository.repo.node_id
  pattern       = each.value

  required_linear_history         = var.linear_history
  require_conversation_resolution = var.conversation_resolution
  allows_force_pushes             = var.force_push

  required_pull_request_reviews {
    dismiss_stale_reviews           = var.dismiss_review
    required_approving_review_count = var.review_count
  }
}