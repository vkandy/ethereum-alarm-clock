import click

from .main import main  # noqa
from .client import (  # noqa
    client_run,
    client_monitor,
)
from .requests import (  # noqa
    request_create,
)


@main.command()
@click.pass_context
def repl(ctx):
    """
    Drop into a debugger shell with most of what you might want available in
    the local context.
    """
    main_ctx = ctx.parent
    web3 = main_ctx.web3  # noqa
    config = main_ctx.config

    arst = config.get_transaction_request('0x39fbf5879eff2fd338f0f5ccd01a3556ec3c5fc7')
    print(arst.paymentModifier)
    print(arst)

    tracker = config.tracker  # noqa
    factory = config.factory  # noqa

    import pdb
    pdb.set_trace()  # noqa
