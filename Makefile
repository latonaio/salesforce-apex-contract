.DEFAULT_GOAL := help

.PHONY: sf-login
sf-login: ## sandbox 環境にログインします。
	sfdx force:auth:web:login -r https://test.salesforce.com -a sand1
	sfdx config:set defaultusername=xxxxxx

.PHONY: sf-all-retrieve
sf-all-retrieve: ## 全ての Apex code を取得します。
	sfdx force:source:retrieve -x manifest/package.xml

.PHONY: sf-class-retrieve
sf-class-retrieve: ## クラス単位で Apex code を取得します。
ifdef class
	sfdx force:source:retrieve -m "ApexClass:${class}"
else
	@bash -c "echo -e '\033[36mUsage: make sf-class-retrieve class=TargetClassName\033[0m'"
endif

.PHONY: sf-all-deploy
sf-all-deploy: ## 全ての Apex code をデプロイします。
	sfdx force:source:deploy -x manifest/package.xml

.PHONY: sf-class-deploy
sf-class-deploy: ## クラス単位で Apex code をデプロイします。
ifdef class
	sfdx force:source:deploy -m "ApexClass:${class}"
else
	@bash -c "echo -e '\033[36mUsage: make sf-class-deploy class=TargetClassName\033[0m'"
endif

# See "Self-Documented Makefile" article
# https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'