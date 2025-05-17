# Bash scripts basic

### string replacement
${variable/pattern/replacement}

| Syntax            | Description                                                                      |
| ----------------- | -------------------------------------------------------------------------------- |
| `${var/pat/rep}`  | Replaces **first** match of `pat` with `rep`.                                    |
| `${var//pat/rep}` | Replaces **all** matches of `pat` with `rep`.                                    |
| `${var/#pat/rep}` | Replaces `pat` with `rep` **only if** `pat` matches the **start** of the string. |
| `${var/%pat/rep}` | Replaces `pat` with `rep` **only if** `pat` matches the **end** of the string.   |



