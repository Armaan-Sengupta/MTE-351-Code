# Corrected generation of beta and force values according to the specified pattern
betas = [11]

# Prepare output lines for the file
output_lines = ["beta = {" + ", ".join(str(b) for b in betas) + "};\n"]
output_lines.append("force = {")

# Generate force values correctly, iterating over betas for each force value
force_entries = []

# Calculate the force range
start_force = 100  # Minimum force value (based on beta=5)
end_force = 120    # Maximum force value (based on beta=5 + 10)
forces = [start_force + 0.5 * i for i in range(int((end_force - start_force) / 0.5) + 1)]

# Iterate through force values first, then beta values
for force in forces:
    for beta in betas:
        force_entries.append(f"{{{force},0,0}}")

# Combine force arrays into one line and add closing bracket
output_lines.append(", ".join(force_entries) + "};\n")

# Save to a text file
with open("ordered_beta_force.txt", "w") as file:
    file.writelines(output_lines)

print("File 'ordered_beta_force.txt' saved successfully.")
