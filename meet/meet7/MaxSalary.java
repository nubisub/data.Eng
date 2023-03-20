//Standard Java imports
import java.io.IOException;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.StringTokenizer;
//Hadoop imports
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapred.FileInputFormat;
import org.apache.hadoop.mapred.FileOutputFormat;
import org.apache.hadoop.mapred.JobClient;
import org.apache.hadoop.mapred.JobConf;
import org.apache.hadoop.mapred.MapReduceBase;
import org.apache.hadoop.mapred.Mapper;
import org.apache.hadoop.mapred.OutputCollector;
import org.apache.hadoop.mapred.Reducer;
import org.apache.hadoop.mapred.Reporter;
import org.apache.hadoop.mapred.TextInputFormat;
import org.apache.hadoop.mapred.TextOutputFormat;
public class MaxSalary {
    //The Mapper
    public static class Map extends MapReduceBase implements
    Mapper < LongWritable, Text, Text, IntWritable > {
        private static final IntWritable accumulator = new
        IntWritable(1);
        private Text word = new Text();
        public void map(LongWritable key, Text value,
            OutputCollector < Text, IntWritable > collector, Reporter reporter)
        throws IOException {
            // split with comma
            String[] line = value.toString().split(",");
            // get the salary
            int salary = Integer.parseInt(line[2]);
            // get the country
            String country = line[1];
            // emit the country and salary
            collector.collect(new Text(country), new IntWritable(salary));

        }
    }
    //The Reducer
    public static class Reduce extends MapReduceBase implements
    Reducer < Text, IntWritable, Text, IntWritable > {
        public void reduce(Text key, Iterator < IntWritable > values,
            OutputCollector < Text, IntWritable > collector, Reporter reporter)
        throws IOException {
            // get max salary each key use math.max
            int max = 0;
            while (values.hasNext()) {
                max = Math.max(max, values.next().get());
            }
            System.out.println("Max salary for " + key + " is " + max);
            collector.collect(key, new IntWritable(max));
        }
    }
    //The java main method to execute the MapReduce job
    public static void main(String[] args) throws Exception {
        //Code to create a new Job specifying the MapReduce class
        final JobConf conf = new JobConf(MaxSalary.class);
        conf.setOutputKeyClass(Text.class);
        conf.setOutputValueClass(IntWritable.class);
        conf.setMapperClass(Map.class);
        // Combiner is commented out – to be used in bonus activity
        //conf.setCombinerClass(Reduce.class);
        conf.setReducerClass(Reduce.class);
        conf.setInputFormat(TextInputFormat.class);
        conf.setOutputFormat(TextOutputFormat.class);
        //File Input argument passed as a command line argument
        FileInputFormat.setInputPaths(conf, new Path(args[0]));
        //File Output argument passed as a command line argument
        FileOutputFormat.setOutputPath(conf, new Path(args[1]));
        //statement to execute the job
        JobClient.runJob(conf);
    }
}