Description
========

Mes recettes pour configurer mon poste avec chef-solo

Description du contenu

	├── README.md				# ce fichier
	├── install.sh				# script pour installer chef
	├── deploy.sh				# script pour déployer vers une machine distante
	├── run.sh				# script pour démarrer chef-solo
	├── config
	│   ├── attributes.json			# Liste des attributs à utiliser (liste des recettes et paramétres)
	│   └── solo.rb				# Configuration de chef-solo 
	├── cookbooks
	│   └── toutantic
	│       ├── recipes
	│       │   ├── default.rb		# recette par défault
