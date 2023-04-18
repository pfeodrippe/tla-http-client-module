clj_cmd = env clojure

.PHONY: build
build:
	mkdir -p target
	mkdir -p classes
	clojure -e "(compile 'tla-http-client-module.core)"
	$(clj_cmd) -X:depstar uberjar :jar target/tla-http-client-module.jar :sync-pom true :version '"0.3.0"' :group-id '"io.github.pfeodrippe"' :artifact-id '"tladeps-http-client-module"' :exclude '["clojure/.*", "com/.*", "javax/.*", "org/.*", "pcal/.*", "tla2sany/.*", "tla2tex/.*", "util/.*", "kaocha/.*", "CommonsMath.*", "META_INF/.*", "dynapath/.*", "babashka/.*", "tlc2/util/.*", "tlc2/tool/.*", "tlc2/value/.*", "tlc2/debug/.*", "tlc2/model/.*", "tlc2/output/.*", "tlc2/module/.*", "tlc2/pprint/.*", "cheshire/.*", "clj_http/.*", "slingshot/.*", "riddley/.*", "potemkin/.*"]'

.PHONY: deploy
deploy:
	mvn deploy:deploy-file -Dfile=target/tla-http-client-module.jar -DpomFile=pom.xml -DrepositoryId=clojars -Durl=https://clojars.org/repo/
