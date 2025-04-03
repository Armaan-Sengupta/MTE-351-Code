import re

# File paths
input_path = 'Finer.csv'  # Input file name
output_path = 'Cleaned_Finer.csv'  # Output file name

def clean_force_value(value):
    """Extract the first number from the problematic value and remove braces."""
    # Match patterns like {100,0,0}.0 or {90.25,0,0} and extract the first number
    match = re.search(r'\{([\d\.]+),[^\}]+\}\.?0?', value)
    if match:
        return match.group(1)  # Return the first number as a string
    return value

with open(input_path, 'r') as infile, open(output_path, 'w') as outfile:
    header = infile.readline()
    outfile.write(header)

    for line in infile:
        # Fix the problematic part using regex
        cleaned_line = re.sub(r'\{([\d\.]+),[^\}]+\}\.?0?', r'\1', line)
        outfile.write(cleaned_line)

print(f"Cleaned CSV file saved at: {output_path}")
