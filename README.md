## INNOKI *C*all-To-*A*c*t*ion *s*implified -
#### beyond the point of usefulness

[![Build Status](https://travis-ci.org/innoki/cats.svg?branch=master)](https://travis-ci.org/innoki/cats)

Provides a somewhat hidden storage API with an utmost simple interface:

```
# Return a 1x1 sized pixel gif with alpha 100%
GET  /cats/{your-keywords-here}.gif?keyA=valueA&keyB=valueB

# Return 200 and empty response (post dumps the body up to 80k bytes w/ "\n"=",")
GET  /cats/{your-keywords-here}.html?keyA=valueA&keyB=valueB
POST /cats/{your-keywords-here}?keyA=valueA&keyB=valueB
```

```
# Examples
GET  /cats/my/super_great/blogpost.gif?browser=moz&tz=0
GET  /cats/2016/02/30/woopsie.html?did=you&spot=the&mistake=hell+yeah

# Will dump (note that query param ordering is not guaranteed)
my,super_great,blogpost|browser=moz,tz=0
2016,02,30,woopsie|did=you,mistake=hell yeah,spot=the
```
