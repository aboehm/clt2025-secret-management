#!/usr/bin/env python3

import os

with open(f"{os.environ.get('HOME')}/.ansible-vault-pass") as f:
    print(str(f.read()), end='')
