# tests/test_app.py

import pytest
from src.app import greet

def test_greet_valid_name():
    assert greet("Alice") == "Hello, Alice!"

def test_greet_empty_name():
    with pytest.raises(ValueError):
        greet("")