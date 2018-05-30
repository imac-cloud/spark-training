
from pyspark import SparkContext
sc = SparkContext("local", "Simple App")
textFile = sc.textFile("hdfs:/spark/hw/test.txt")
numBs = textFile.map(lambda s: s.split(','))\
	.map(lambda w:w[0])\
	.reduce(lambda a, b:a + b)
print(numBs)

