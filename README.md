# MixReport

Mix tasks for reporting issues for Elixir projects.

Based on proposal by Michał Muskała: https://groups.google.com/forum/#!topic/elixir-lang-core/15iTfoo2lPs

## Usage

Run `mix report.elixir` to open up a pre-filled issue template for Elixir.

See `mix report` for help.

## Installation

On Elixir v1.4+:

    $ mix archive.install github wojtekmach/mix_report

On older Elixir versions:

    $ git clone git@github.com:wojtekmach/mix_report
    $ cd mix_report
    $ MIX_ENV=prod mix archive.build
    $ mix archive.install

## License

MIT
