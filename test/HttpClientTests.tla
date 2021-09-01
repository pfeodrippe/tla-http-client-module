------------- CONFIG HttpClientTests ---------

===================

-------------------------------- MODULE HttpClientTests --------------------------------

EXTENDS HttpClient, Integers, Sequences, TLC, TLCExt

ASSUME(AssertEq(HttpRequest([url |-> "https://httpbin.org/get",
                             method |-> "get",
                             as |-> "json"]).status,
                            200))

=============================================================================
