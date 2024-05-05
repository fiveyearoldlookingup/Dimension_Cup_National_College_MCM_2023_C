import pandas as pd
import matplotlib.pyplot as plt

# 载入数据 - 替换此处的路径为您本地文件的路径
file_path = 'C:/Users/35274/Desktop/数维杯/第一题/当w一定时a1的值.xlsx'#C:\Users\35274\Desktop\数维杯\第一题\当w一定时a1的值.xlsx
df = pd.read_excel(file_path)

# 提取数据
a1_values = df.iloc[:, 0]  # 假设第一列是 a1 的值
corresponding_values = df.iloc[:, 1]  # 假设第二列是对应的量

# 绘制完整的数据
plt.figure(figsize=(10, 6))
plt.plot(a1_values, corresponding_values, marker='o', color='blue')
plt.axvline(x=0.5, color='green', linestyle='--')  # 添加 a1=0.66667 的垂直线
# 添加文本标签
plt.text(0.5, plt.ylim()[1], 'x=0.5', color='green', verticalalignment='top')

plt.title('a1 Values and Corresponding Measures')
plt.xlabel('a1 Values')
plt.ylabel('Corresponding Measures')
plt.grid(True)
plt.show()

# 确保数据按照 a1 的值排序
df.sort_values(by=df.columns[0], inplace=True)

# 提取数据
a1_values = df.iloc[:, 0]  # 假设第一列是 a1 的值
corresponding_values = df.iloc[:, 1]  # 假设第二列是对应的量

# 分割数据
# a1=0 到 0.5 的数据
mask1 = a1_values <= 0.5
a1_values_0_to_05 = a1_values[mask1]
corresponding_values_0_to_05 = corresponding_values[mask1]

# a1=0.5 之后的数据
mask2 = a1_values > 0.5
a1_values_after_05 = a1_values[mask2]
corresponding_values_after_05 = corresponding_values[mask2]

# 绘制 a1=0 到 0.5 的数据图像
plt.figure(figsize=(10, 6))
plt.plot(a1_values_0_to_05, corresponding_values_0_to_05, marker='o', color='blue')
plt.title('a1 Values from 0 to 0.5 and Corresponding Measures')
plt.xlabel('a1 Values')
plt.ylabel('Corresponding Measures')
plt.grid(True)
plt.show()

# 绘制 a1=0.5 之后的数据图像
plt.figure(figsize=(10, 6))
plt.plot(a1_values_after_05, corresponding_values_after_05, marker='o', color='red')
plt.axvline(x=0.67, color='green', linestyle='--')  # 添加 a1=0.66667 的垂直线
# 添加文本标签
plt.text(0.67, plt.ylim()[1], 'x=0.66667', color='green', verticalalignment='top')


plt.title('a1 Values after 0.5 and Corresponding Measures')
plt.xlabel('a1 Values')
plt.ylabel('Corresponding Measures')
plt.grid(True)
plt.show()