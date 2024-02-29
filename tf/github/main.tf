module "repos" {
  source   = "./modules/repos"
  for_each = local.repos

  name               = each.value.name
  description        = each.value.description
  visibility         = each.value.visibility
  protected_branches = each.value.branches
  default_branch     = each.value.main
  review_count       = each.value.review_count
}