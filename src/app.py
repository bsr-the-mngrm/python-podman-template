# src/app.py

def greet(name: str) -> str:
    """
    Returns a greeting message.
    """
    if not name:
        raise ValueError("Name must be a non-empty string.")
    return f"Hello, {name}!"