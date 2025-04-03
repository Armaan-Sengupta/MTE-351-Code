import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import griddata
from mpl_toolkits.mplot3d import Axes3D

# Load the cleaned CSV file
cleaned_file_path = 'Cleaned_Finer.csv'  # Replace with the correct file path
df = pd.read_csv(cleaned_file_path)

# Extract the necessary columns for plotting
x = df['constParams1.beta deg']
y = df['globalForce1.F N']
z = df['prismaticJoint1.xRel m']

# Find the maximum point in z
max_index = z.idxmax()
max_x = x[max_index]
max_y = y[max_index]
max_z = z[max_index]

# Create a grid for the surface plot
xi = np.linspace(min(x), max(x), 100)
yi = np.linspace(min(y), max(y), 100)
xi, yi = np.meshgrid(xi, yi)

# Interpolate the data for a smooth surface
zi = griddata((x, y), z, (xi, yi), method='cubic')

# Create the 3D surface plot
fig = plt.figure(figsize=(10, 8))
ax = fig.add_subplot(111, projection='3d')

# Plot the surface
surface = ax.plot_surface(xi, yi, zi, cmap='viridis', edgecolor='none', alpha=0.8)

# Plot the line y = 10x
line_x = np.linspace(min(x), max(x), 100)
line_y = 10 * line_x
line_z = np.full_like(line_x, min(z))  # Use the minimum z value for line height
ax.plot(line_x, line_y, line_z, color='red', label='y = 10x', linewidth=2)

# Plot the maximum point with adjusted z-coordinate
ax.scatter(max_x, max_y, max_z, color='red', s=100, label='Max Point')

# Add the original data points to compare
ax.scatter(x, y, z, color='black', s=20, alpha=0.5, label='Original Data Points')

# Explicitly set axis limits to cover the data range
ax.set_xlim([min(x), max(x)])
ax.set_ylim([min(y), max(y)])
ax.set_zlim([min(z), max(z)])

# Annotate the maximum point with accurate coordinates
annotation = f'Max: Beta={max_x}, Force={max_y}, Position={max_z:.2f}'
ax.text(max_x, max_y, max_z, annotation, color='red', fontsize=10)


# Add color bar
fig.colorbar(surface, ax=ax, shrink=0.5, aspect=5, label='Prismatic Joint Position (m)')

# Set labels and title
ax.set_xlabel('Beta Angle (deg)')
ax.set_ylabel('Global Force (N)')
ax.set_zlabel('Prismatic Joint Position (m)')
ax.set_title('3D Surface Plot: Prismatic Joint Position vs Beta Angle and Global Force')

# Display legend
ax.legend()

# Show the plot
plt.show()
