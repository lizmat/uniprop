[![Actions Status](https://github.com/lizmat/uniprop/workflows/test/badge.svg)](https://github.com/lizmat/uniprop/actions)

NAME
====

uniprop - Provide uniprop- subs

SYNOPSIS
========

```raku
use uniprop;  # provide uniprop-int, uniprop-bool, unitprop-str
```

DESCRIPTION
===========

The `uniprop` distribution provides 3 subroutines that used to live in the Rakudo core, but were in fact implementation detail / used for testing by core developers only. These have since then been removed from Rakudo.

This distribution has captured the code of these subroutines and will export them in any version of Rakudo that has them removed.

No further documentation is provided, as originally no additional documentation was provided and it was never the intention to expose this functionality this way.

AUTHOR
======

Elizabeth Mattijsen <liz@raku.rocks>

Source can be located at: https://github.com/lizmat/uniprop . Comments and Pull Requests are welcome.

COPYRIGHT AND LICENSE
=====================

Copyright 2022 Elizabeth Mattijsen

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

