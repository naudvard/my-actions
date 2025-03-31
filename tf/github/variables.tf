locals {
  repos = {
    "test-tf" = {
      name : "test-tf",
      description : "Test Terraform",
      visibility : "private",
      branches : ["main"],
      main : "main",
      review_count : 0,
    },
    "pignouf-games" = {
      name : "pignouf-games",
      description : "Pignouf Games",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 0,
    },
    "MyLifeManager" = {
      name : "MyLifeManager",
      description : "My Life Manager",
      visibility : "private",
      branches : ["main"],
      main : "main",
      review_count : 0,
    },
    "blockchain-vote-svelte" = {
      name : "blockchain-vote-svelte",
      description : "Projet scolaire à 2 en nuit blanche pour le 20",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 1,
    },
    "big-cicd-back" = {
      name : "big-cicd-back",
      description : "CICD way too complex for a school projet",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 1,
    },
    "imt-framework-back" = {
      name : "imt-framework-back",
      description : "School project, basic delivery app",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 1,
    },
    "site-marineraoul" = {
      name : "marineraoul.fr",
      description : "Public website for Marine Audvard (Raoul)",
      visibility : "public",
      branches : ["main"],
      main : "main",
      review_count : 0,
    },
    "imt--isola--kotlin-bot" = {
      name : "imt--isola--kotlin-bot",
      description : "Kotlin bot for the Codingame Isola",
      visibility : "private",
      branches : ["main"],
      main : "main",
      review_count : 0,
    }
  }
}
