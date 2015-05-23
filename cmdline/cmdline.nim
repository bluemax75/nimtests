import docopt

let usage = """
Descripcion del programa

Usage:
    cmdline list [-k] 
    cmdline add [-a] <filename> [<filename2>]
    cmdlint del <filename>...
    cmdline (-h|--help)

Options:
    Descripcion de las opciones y demas
"""

let args = docopt(usage)

echo args
