; extends

; All these define the found patterns to be @comment such that it could be gray out
; Standalone triple quote string would not be captured by following patterns, so it is still highlighted as string

; Module docstring
(module . (expression_statement (string) @comment))

; Class docstring
(class_definition
  body: (block . (expression_statement (string) @comment)))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string) @comment)))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string) @comment))
