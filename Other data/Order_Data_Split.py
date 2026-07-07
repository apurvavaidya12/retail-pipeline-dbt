import pandas as pd

df = pd.read_csv('Dataset/olist_orders_dataset.csv')
df = df.sort_values('order_purchase_timestamp').reset_index(drop=True)

n = len(df)
size = n // 3

batch_1 = df.iloc[0:size]
batch_2 = df.iloc[size:2*size]
batch_3 = df.iloc[2*size:]

batch_1.to_csv('orders_batch_1.csv', index=False)
batch_2.to_csv('orders_batch_2.csv', index=False)
batch_3.to_csv('orders_batch_3.csv', index=False)

print(len(batch_1), len(batch_2), len(batch_3))