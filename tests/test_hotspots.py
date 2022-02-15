##https://testbook.readthedocs.io/en/latest/usage/index.html#set-up-jupyter-notebook-under-test

import pandas as pd
from sqlalchemy import true
from testbook import testbook

@testbook('hotspotsTable_explore.ipynb',execute=True)
def test_foo(tb):
    foo = tb.ref("foo")

    assert foo(2) == 3