#!/usr/bin/env python
import json
import sys
from pprint import pprint

# Example
example = "python filter_compile_command.py compile_commands.json compile_commands_filtered.json moc_ qrc_"

def main(input_file_name, output_file_name, targets):
    print input_file_name
    print output_file_name
    print targets

    with open(input_file_name) as input_file:
        compile_commands = json.load(input_file)

    def has_targets(command):
        return any([target in command['file'] for target in targets])

    filtered_compile_commands = [command for command in compile_commands if not has_targets(command)]

    with open(output_file_name, 'w') as output_file:
        json.dump(filtered_compile_commands, output_file, indent=4)


if __name__ == '__main__':
    if len(sys.argv) > 3:
        input_file = sys.argv[1]
        output_file = sys.argv[2]
        targets = sys.argv[3:]
        main(input_file, output_file, targets)

    else:
        print "Not enough arguments: Example" + example


