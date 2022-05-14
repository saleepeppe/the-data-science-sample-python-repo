from dagster import op, job


@op
def get_name() -> str:
    return "dagster"


@op
def hello(name: str) -> None:
    print(f"Hello, {name}!")


@job
def hello_dagster() -> None:
    hello(get_name())


if __name__ == "__main__":
    result = hello_dagster.execute_in_process()
