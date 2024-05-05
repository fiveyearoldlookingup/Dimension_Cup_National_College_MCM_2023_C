import pandas as pd
import matplotlib.pyplot as plt

# Data extracted from the user's table input.
ak_values = [0.51, 0.52]
cleaning_steps = [1, 2, 3, 4, 5, 6]
dirt_removed_ak_051 = [5.1, 2.55, 1.275, 0.6375, 0.31875, 0.11875]
dirt_removed_ak_052 = [5.2, 2.6, 1.3, 0.65, 0.325, 0]

# Create a DataFrame from the data
df = pd.DataFrame({
    'Cleaning Step': cleaning_steps,
    'Dirt Removed (ak=0.51)': dirt_removed_ak_051,
    'Dirt Removed (ak=0.52)': dirt_removed_ak_052
})

# Plotting the data
plt.figure(figsize=(10, 6))
for ak_value in ak_values:
    plt.plot(
        'Cleaning Step', 
        f'Dirt Removed (ak={ak_value})', 
        data=df, 
        marker='o', 
        label=f'ak={ak_value}'
    )

plt.title('Amount of Dirt Removed for Different ak Values')
plt.xlabel('Cleaning Step Number')
plt.ylabel('Amount of Dirt Removed')
plt.legend()
plt.grid(True)
plt.show()
