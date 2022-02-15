##https://testbook.readthedocs.io/en/latest/usage/index.html#set-up-jupyter-notebook-under-test

import pandas as pd
from testbook import testbook

@testbook('hotspots_cooking.ipynb',execute=True)
def test_getHotspots(tb):
    TrailheadRef = tb.ref("getTrailheadRef")
    assert TrailheadRef == pd.DataFrame()