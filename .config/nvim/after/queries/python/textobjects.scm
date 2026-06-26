; extends

; it won't be shown in InspectTree
; @comment != @comment.inner != @comment.outer

((function_definition
  body: (block . (expression_statement (string) @docstring)))
 (#match? @docstring "^\"\"\"") ; optional predicate to ensure it starts with triple quotes
)

; All these define the found patterns to be @comment such that it could be gray out
; Standalone triple quote string would not be captured by following patterns, so it is still highlighted as string

; Module docstring
(module . (expression_statement (string (string_content) @comment.inner) @comment.outer))

; Class docstring
(class_definition
  body: (block . (expression_statement (string (string_content) @comment.inner) @comment.outer)))

; Function/method docstring
(function_definition
  body: (block . (expression_statement (string (string_content) @comment.inner (#offset! @comment.inner 0 0 0 0)) @comment.outer)))

; Attribute docstring
((expression_statement (assignment)) . (expression_statement (string (string_content) @comment.inner) @comment.outer))
