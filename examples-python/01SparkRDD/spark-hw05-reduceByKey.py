

from operator import add
from pyspark import SparkContext
sc = SparkContext("local", "Simple App")
textFile = sc.textFile("hdfs:/spark/hw/test.txt")
numBs = textFile.flatMap(lambda s: s.split(','))\
	.map(lambda b: (b,1))\
	.reduceByKey(add)\
	.collect()
print(numBs)
