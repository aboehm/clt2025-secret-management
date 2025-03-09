#!/usr/bin/env python3

import os

with open(f"{os.environ.get('HOME')}/vault.secret") as f:
    print(str(f.read()), end='')
