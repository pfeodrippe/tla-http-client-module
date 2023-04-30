(ns tla-http-client-module.core
  (:gen-class)
  (:require
   [clojure.edn :as edn]
   [clj-http.client :as http]
   [tla-edn.core :as tla-edn]
   [tla-edn.spec :as spec]))

(spec/defop HttpRequest {:module "HttpClient"}
  [options]
  (-> (->> (tla-edn/to-edn options)
           (mapv (fn [[k v]]
                   [(keyword k) v]))
           (mapv (fn [[k v]]
                   (if (= k :as)
                     [k (keyword v)]
                     [k v])))
           (into {}))
      (assoc :throw-exceptions? false)
      (update :method keyword)
      http/request
      (select-keys [:status :length :body :headers])
      pr-str
      edn/read-string
      tla-edn/to-tla-value))

(comment

  ;; Run tests.
  (spec/run
    (str (System/getProperty "user.dir") "/test/HttpClientTests.tla")
    (str (System/getProperty "user.dir") "/test/HttpClientTests.tla"))

  ())

;; TODO:
;; - [ ] Check without the new overrides class
;; - [ ] Do we need tladeps.edn?
;; - [ ] Multiple overrides
