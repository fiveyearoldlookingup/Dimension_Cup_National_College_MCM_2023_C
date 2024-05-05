import pandas as pd
import matplotlib.pyplot as plt

file_path = 'C:/Users/35274/Desktop/数维杯/第一题/当w一定时a1的值.xlsx'  # 替换为您的文件路径

data = pd.read_excel(file_path, sheet_name=11)  # 假设数据在第四个工作表

# 提取数据
cleaning_steps = data.iloc[1:, 0].tolist()
ak_values = data.columns[1:]  # 跳过第一列，提取所有ak值
selected_ak_values = ak_values[::1]  # 选择每隔5个ak值

# 创建一个空的DataFrame
df = pd.DataFrame({'Cleaning Step': cleaning_steps})

# 遍历所选的ak值，提取对应的数据
for ak in selected_ak_values:
    df[f'Dirt Removed (ak={ak})'] = data[ak].iloc[1:].tolist()

# 绘制图表
plt.figure(figsize=(10, 6))
for ak in selected_ak_values:
    plt.plot(
        'Cleaning Step', 
        f'Dirt Removed (ak={ak})', 
        data=df, 
        marker='o', 
        label=f'ak={ak}'
    )
plt.axhline(y=0.999, color='red', linestyle='--')  # 添加水平线
plt.text(x=0, y=0.999, s='y=0.999', verticalalignment='bottom', color='red')  # 添加文字
plt.title('The critical value of ak with 99.99% cleanliness')
plt.xlabel('Cleaning times')
plt.ylabel('Cleanliness')
plt.xlim(0, 20)  # 设置x轴范围
plt.ylim(0.99, 1.0)
plt.legend()
plt.grid(True)
plt.show()
