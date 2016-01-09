import Foundation

// Day	High	Low	High	Low	High	Moon
public let header: String = "Day\tHigh\tLow\tHigh\tLow\tHigh\tMoon"

public let headers: [String]  = header.split("\t")

public let info: String =
"Sun 1\t6:29 AM EST / 3.11 ft\t12:50 PM EST / 0.77 ft\t6:41 PM EST / 2.69 ft\t\t\t\n" +
  "Mon 2\t\t12:42 AM EST / 0.66 ft\t7:11 AM EST / 3.14 ft\t1:30 PM EST / 0.74 ft\t7:23 PM EST / 2.77 ft\t\n" +
  "Tue 3\t\t1:24 AM EST / 0.66 ft\t7:48 AM EST / 3.16 ft\t2:07 PM EST / 0.73 ft\t8:01 PM EST / 2.83 ft\tFull Moon\n" +
  "Wed 4\t\t2:03 AM EST / 0.68 ft\t8:22 AM EST / 3.15 ft\t2:40 PM EST / 0.74 ft\t8:37 PM EST / 2.87 ft\t\n" +
  "Thu 5\t\t2:41 AM EST / 0.73 ft\t8:54 AM EST / 3.12 ft\t3:12 PM EST / 0.77 ft\t9:11 PM EST / 2.89 ft\t\n" +
  "Fri 6\t\t3:16 AM EST / 0.80 ft\t9:25 AM EST / 3.07 ft\t3:43 PM EST / 0.81 ft\t9:44 PM EST / 2.90 ft\t\n" +
  "Sat 7\t\t3:51 AM EST / 0.89 ft\t9:56 AM EST / 3.00 ft\t4:13 PM EST / 0.86 ft\t10:17 PM EST / 2.90 ft\t\n" +
  "Sun 8\t\t4:27 AM EST / 0.98 ft\t10:28 AM EST / 2.92 ft\t4:43 PM EST / 0.91 ft\t10:51 PM EST / 2.89 ft\t\n" +
  "Mon 9\t\t5:05 AM EST / 1.08 ft\t11:03 AM EST / 2.84 ft\t5:17 PM EST / 0.96 ft\t11:29 PM EST / 2.89 ft\t\n" +
  "Tue 10\t\t5:48 AM EST / 1.17 ft\t11:43 AM EST / 2.76 ft\t5:56 PM EST / 0.99 ft\t\t\n" +
  "Wed 11\t12:14 AM EST / 2.89 ft\t6:38 AM EST / 1.23 ft\t12:31 PM EST / 2.68 ft\t6:43 PM EST / 1.01 ft\t\tLast Quarter\n" +
  "Thu 12\t1:08 AM EST / 2.91 ft\t7:39 AM EST / 1.26 ft\t1:28 PM EST / 2.62 ft\t7:40 PM EST / 1.00 ft\t\t\n" +
  "Fri 13\t2:11 AM EST / 2.96 ft\t8:48 AM EST / 1.23 ft\t2:34 PM EST / 2.62 ft\t8:45 PM EST / 0.94 ft\t\t\n" +
  "Sat 14\t3:18 AM EST / 3.06 ft\t9:56 AM EST / 1.11 ft\t3:43 PM EST / 2.69 ft\t9:53 PM EST / 0.82 ft\t\t\n" +
  "Sun 15\t4:24 AM EST / 3.21 ft\t10:58 AM EST / 0.94 ft\t4:49 PM EST / 2.83 ft\t10:57 PM EST / 0.65 ft\t\t\n" +
  "Mon 16\t5:26 AM EST / 3.37 ft\t11:55 AM EST / 0.73 ft\t5:49 PM EST / 3.02 ft\t11:58 PM EST / 0.47 ft\t\t\n" +
  "Tue 17\t6:22 AM EST / 3.53 ft\t12:47 PM EST / 0.52 ft\t6:45 PM EST / 3.22 ft\t\t\t\n" +
  "Wed 18\t\t12:55 AM EST / 0.31 ft\t7:15 AM EST / 3.63 ft\t1:36 PM EST / 0.35 ft\t7:39 PM EST / 3.39 ft\tNew Moon\n" +
  "Thu 19\t\t1:50 AM EST / 0.20 ft\t8:06 AM EST / 3.67 ft\t2:24 PM EST / 0.24 ft\t8:30 PM EST / 3.51 ft\t\n" +
  "Fri 20\t\t2:43 AM EST / 0.16 ft\t8:56 AM EST / 3.62 ft\t3:12 PM EST / 0.20 ft\t9:21 PM EST / 3.56 ft\t\n" +
  "Sat 21\t\t3:36 AM EST / 0.21 ft\t9:45 AM EST / 3.50 ft\t3:59 PM EST / 0.23 ft\t10:12 PM EST / 3.53 ft\t\n" +
  "Sun 22\t\t4:30 AM EST / 0.33 ft\t10:36 AM EST / 3.33 ft\t4:48 PM EST / 0.33 ft\t11:06 PM EST / 3.43 ft\t\n" +
  "Mon 23\t\t5:26 AM EST / 0.50 ft\t11:28 AM EST / 3.12 ft\t5:39 PM EST / 0.47 ft\t\t\n" +
  "Tue 24\t12:02 AM EST / 3.29 ft\t6:25 AM EST / 0.70 ft\t12:23 PM EST / 2.91 ft\t6:34 PM EST / 0.64 ft\t\t\n" +
  "Wed 25\t1:03 AM EST / 3.14 ft\t7:29 AM EST / 0.88 ft\t1:24 PM EST / 2.73 ft\t7:34 PM EST / 0.79 ft\t\tFirst Quarter\n" +
  "Thu 26\t2:09 AM EST / 3.01 ft\t8:37 AM EST / 1.01 ft\t2:29 PM EST / 2.62 ft\t8:38 PM EST / 0.90 ft\t\t\n" +
  "Fri 27\t3:18 AM EST / 2.95 ft\t9:44 AM EST / 1.07 ft\t3:36 PM EST / 2.59 ft\t9:43 PM EST / 0.95 ft\t\t\n" +
"Sat 28\t4:23 AM EST / 2.96 ft\t10:45 AM EST / 1.07 ft\t4:38 PM EST / 2.64 ft\t10:43 PM EST / 0.94 ft\t\t"

public let header2: String = "Day\tHigh\tLow\tHigh\tLow\tHigh\tMoon\tSunrise\tSunset"

public let headers2: [String]  = header2.split("\t")

public let westFeb2016 = [
  "Mon 1\t3:23 AM EST / 2.84 ft\t10:07 AM EST / 1.22 ft\t3:38 PM EST / 2.63 ft\t10:07 PM EST / 1.00 ft\t\t\t6:48 AM EST\t5:49 PM EST",
  "Tue 2\t4:18 AM EST / 2.87 ft\t11:07 AM EST / 1.23 ft\t4:35 PM EST / 2.60 ft\t11:02 PM EST / 0.99 ft\t\t\t6:47 AM EST\t5:50 PM EST",
  "Wed 3\t5:16 AM EST / 2.94 ft\t12:07 PM EST / 1.16 ft\t5:34 PM EST / 2.63 ft\t11:58 PM EST / 0.93 ft\t\t\t6:47 AM EST\t5:50 PM EST",
  "Thu 4\t6:14 AM EST / 3.07 ft\t1:03 PM EST / 1.05 ft\t6:33 PM EST / 2.71 ft\t\t\t\t6:46 AM EST\t5:51 PM EST",
  "Fri 5\t\t12:53 AM EST / 0.81 ft\t7:09 AM EST / 3.22 ft\t1:53 PM EST / 0.89 ft\t7:28 PM EST / 2.84 ft\t\t6:46 AM EST\t5:52 PM EST",
  "Sat 6\t\t1:46 AM EST / 0.67 ft\t8:00 AM EST / 3.39 ft\t2:41 PM EST / 0.72 ft\t8:21 PM EST / 2.99 ft\t\t6:45 AM EST\t5:52 PM EST",
  "Sun 7\t\t2:37 AM EST / 0.52 ft\t8:49 AM EST / 3.53 ft\t3:25 PM EST / 0.55 ft\t9:10 PM EST / 3.15 ft\t\t6:45 AM EST\t5:53 PM EST",
  "Mon 8\t\t3:26 AM EST / 0.39 ft\t9:36 AM EST / 3.63 ft\t4:09 PM EST / 0.41 ft\t9:58 PM EST / 3.29 ft\tNew Moon\t6:44 AM EST\t5:54 PM EST",
  "Tue 9\t\t4:15 AM EST / 0.30 ft\t10:23 AM EST / 3.68 ft\t4:53 PM EST / 0.31 ft\t10:46 PM EST / 3.40 ft\t\t6:44 AM EST\t5:54 PM EST",
  "Wed 10\t\t5:05 AM EST / 0.25 ft\t11:10 AM EST / 3.65 ft\t5:38 PM EST / 0.25 ft\t11:35 PM EST / 3.46 ft\t\t6:43 AM EST\t5:55 PM EST",
  "Thu 11\t\t5:56 AM EST / 0.28 ft\t11:57 AM EST / 3.55 ft\t6:23 PM EST / 0.25 ft\t\t\t6:42 AM EST\t5:56 PM EST",
  "Fri 12\t12:25 AM EST / 3.47 ft\t6:50 AM EST / 0.36 ft\t12:47 PM EST / 3.39 ft\t7:12 PM EST / 0.30 ft\t\t\t6:42 AM EST\t5:56 PM EST",
  "Sat 13\t1:18 AM EST / 3.42 ft\t7:48 AM EST / 0.48 ft\t1:39 PM EST / 3.20 ft\t8:05 PM EST / 0.39 ft\t\t\t6:41 AM EST\t5:57 PM EST",
  "Sun 14\t2:14 AM EST / 3.34 ft\t8:49 AM EST / 0.61 ft\t2:36 PM EST / 3.01 ft\t9:02 PM EST / 0.49 ft\t\t\t6:40 AM EST\t5:58 PM EST",
  "Mon 15\t3:16 AM EST / 3.24 ft\t9:56 AM EST / 0.72 ft\t3:39 PM EST / 2.84 ft\t10:04 PM EST / 0.57 ft\t\tFirst Quarter\t6:40 AM EST\t5:58 PM EST",
  "Tue 16\t4:23 AM EST / 3.17 ft\t11:05 AM EST / 0.77 ft\t4:46 PM EST / 2.74 ft\t11:10 PM EST / 0.61 ft\t\t\t6:39 AM EST\t5:59 PM EST",
  "Wed 17\t5:33 AM EST / 3.15 ft\t12:12 PM EST / 0.77 ft\t5:55 PM EST / 2.72 ft\t\t\t\t6:38 AM EST\t6:00 PM EST",
  "Thu 18\t\t12:14 AM EST / 0.61 ft\t6:40 AM EST / 3.17 ft\t1:13 PM EST / 0.72 ft\t6:59 PM EST / 2.76 ft\t\t6:37 AM EST\t6:00 PM EST",
  "Fri 19\t\t1:15 AM EST / 0.57 ft\t7:39 AM EST / 3.23 ft\t2:07 PM EST / 0.65 ft\t7:55 PM EST / 2.85 ft\t\t6:37 AM EST\t6:01 PM EST",
  "Sat 20\t\t2:09 AM EST / 0.52 ft\t8:30 AM EST / 3.28 ft\t2:54 PM EST / 0.59 ft\t8:45 PM EST / 2.95 ft\t\t6:36 AM EST\t6:01 PM EST",
  "Sun 21\t\t2:58 AM EST / 0.48 ft\t9:14 AM EST / 3.31 ft\t3:37 PM EST / 0.56 ft\t9:29 PM EST / 3.04 ft\t\t6:35 AM EST\t6:02 PM EST",
  "Mon 22\t\t3:43 AM EST / 0.48 ft\t9:53 AM EST / 3.32 ft\t4:16 PM EST / 0.56 ft\t10:08 PM EST / 3.11 ft\tFull Moon\t6:34 AM EST\t6:03 PM EST",
  "Tue 23\t\t4:25 AM EST / 0.52 ft\t10:29 AM EST / 3.30 ft\t4:53 PM EST / 0.59 ft\t10:45 PM EST / 3.15 ft\t\t6:33 AM EST\t6:03 PM EST",
  "Wed 24\t\t5:05 AM EST / 0.59 ft\t11:03 AM EST / 3.25 ft\t5:28 PM EST / 0.65 ft\t11:21 PM EST / 3.16 ft\t\t6:33 AM EST\t6:04 PM EST",
  "Thu 25\t\t5:44 AM EST / 0.69 ft\t11:37 AM EST / 3.18 ft\t6:01 PM EST / 0.74 ft\t11:55 PM EST / 3.15 ft\t\t6:32 AM EST\t6:04 PM EST",
  "Fri 26\t\t6:22 AM EST / 0.82 ft\t12:11 PM EST / 3.10 ft\t6:34 PM EST / 0.83 ft\t\t\t6:31 AM EST\t6:05 PM EST",
  "Sat 27\t12:31 AM EST / 3.13 ft\t7:00 AM EST / 0.96 ft\t12:46 PM EST / 3.02 ft\t7:08 PM EST / 0.93 ft\t\t\t6:30 AM EST\t6:05 PM EST",
  "Sun 28\t1:08 AM EST / 3.09 ft\t7:41 AM EST / 1.09 ft\t1:24 PM EST / 2.92 ft\t7:44 PM EST / 1.02 ft\t\t\t6:29 AM EST\t6:06 PM EST",
  "Mon 29\t1:48 AM EST / 3.05 ft\t8:26 AM EST / 1.21 ft\t2:07 PM EST / 2.84 ft\t8:26 PM EST / 1.09 ft\t\t\t6:28 AM EST\t6:07 PM EST"
]

public let eastFeb2016 = [
  "Mon 1\t1:23 AM EST / 2.73 ft\t7:50 AM EST / 1.31 ft\t1:35 PM EST / 2.51 ft\t7:49 PM EST / 1.08 ft\t\t\t6:47 AM EST\t5:49 PM EST",
  "Tue 2\t2:19 AM EST / 2.76 ft\t8:52 AM EST / 1.33 ft\t2:34 PM EST / 2.49 ft\t8:45 PM EST / 1.07 ft\t\t\t6:46 AM EST\t5:49 PM EST",
  "Wed 3\t3:19 AM EST / 2.83 ft\t9:54 AM EST / 1.27 ft\t3:35 PM EST / 2.51 ft\t9:43 PM EST / 1.01 ft\t\t\t6:46 AM EST\t5:50 PM EST",
  "Thu 4\t4:17 AM EST / 2.96 ft\t10:52 AM EST / 1.15 ft\t4:35 PM EST / 2.60 ft\t10:40 PM EST / 0.90 ft\t\t\t6:45 AM EST\t5:51 PM EST",
  "Fri 5\t5:11 AM EST / 3.12 ft\t11:44 AM EST / 1.00 ft\t5:30 PM EST / 2.73 ft\t11:34 PM EST / 0.76 ft\t\t\t6:45 AM EST\t5:52 PM EST",
  "Sat 6\t6:02 AM EST / 3.28 ft\t12:31 PM EST / 0.82 ft\t6:21 PM EST / 2.88 ft\t\t\t\t6:44 AM EST\t5:52 PM EST",
  "Sun 7\t\t12:26 AM EST / 0.61 ft\t6:50 AM EST / 3.42 ft\t1:16 PM EST / 0.66 ft\t7:10 PM EST / 3.04 ft\t\t6:44 AM EST\t5:53 PM EST",
  "Mon 8\t\t1:16 AM EST / 0.48 ft\t7:36 AM EST / 3.53 ft\t2:00 PM EST / 0.51 ft\t7:58 PM EST / 3.18 ft\tNew Moon\t6:43 AM EST\t5:54 PM EST",
  "Tue 9\t\t2:05 AM EST / 0.38 ft\t8:22 AM EST / 3.57 ft\t2:44 PM EST / 0.40 ft\t8:46 PM EST / 3.29 ft\t\t6:43 AM EST\t5:54 PM EST",
  "Wed 10\t\t2:55 AM EST / 0.34 ft\t9:09 AM EST / 3.54 ft\t3:28 PM EST / 0.35 ft\t9:34 PM EST / 3.35 ft\t\t6:42 AM EST\t5:55 PM EST",
  "Thu 11\t\t3:46 AM EST / 0.36 ft\t9:56 AM EST / 3.44 ft\t4:14 PM EST / 0.34 ft\t10:24 PM EST / 3.36 ft\t\t6:41 AM EST\t5:56 PM EST",
  "Fri 12\t\t4:40 AM EST / 0.45 ft\t10:46 AM EST / 3.28 ft\t5:02 PM EST / 0.39 ft\t11:17 PM EST / 3.31 ft\t\t6:41 AM EST\t5:56 PM EST",
  "Sat 13\t\t5:37 AM EST / 0.57 ft\t11:39 AM EST / 3.09 ft\t5:54 PM EST / 0.48 ft\t\t\t6:40 AM EST\t5:57 PM EST",
  "Sun 14\t12:15 AM EST / 3.23 ft\t6:39 AM EST / 0.71 ft\t12:37 PM EST / 2.90 ft\t6:51 PM EST / 0.58 ft\t\t\t6:39 AM EST\t5:57 PM EST",
  "Mon 15\t1:19 AM EST / 3.14 ft\t7:47 AM EST / 0.83 ft\t1:41 PM EST / 2.74 ft\t7:53 PM EST / 0.67 ft\t\tFirst Quarter\t6:39 AM EST\t5:58 PM EST",
  "Tue 16\t2:28 AM EST / 3.08 ft\t8:59 AM EST / 0.89 ft\t2:51 PM EST / 2.64 ft\t9:00 PM EST / 0.72 ft\t\t\t6:38 AM EST\t5:59 PM EST",
  "Wed 17\t3:39 AM EST / 3.07 ft\t10:09 AM EST / 0.88 ft\t4:01 PM EST / 2.64 ft\t10:07 PM EST / 0.72 ft\t\t\t6:37 AM EST\t5:59 PM EST",
  "Thu 18\t4:46 AM EST / 3.11 ft\t11:12 AM EST / 0.83 ft\t5:05 PM EST / 2.69 ft\t11:09 PM EST / 0.68 ft\t\t\t6:36 AM EST\t6:00 PM EST",
  "Fri 19\t5:44 AM EST / 3.17 ft\t12:06 PM EST / 0.76 ft\t6:01 PM EST / 2.79 ft\t\t\t\t6:36 AM EST\t6:00 PM EST",
  "Sat 20\t\t12:04 AM EST / 0.63 ft\t6:34 AM EST / 3.22 ft\t12:53 PM EST / 0.71 ft\t6:49 PM EST / 2.89 ft\t\t6:35 AM EST\t6:01 PM EST",
  "Sun 21\t\t12:53 AM EST / 0.60 ft\t7:18 AM EST / 3.25 ft\t1:35 PM EST / 0.68 ft\t7:33 PM EST / 2.97 ft\t\t6:34 AM EST\t6:02 PM EST",
  "Mon 22\t\t1:37 AM EST / 0.60 ft\t7:57 AM EST / 3.24 ft\t2:12 PM EST / 0.68 ft\t8:12 PM EST / 3.03 ft\tFull Moon\t6:33 AM EST\t6:02 PM EST",
  "Tue 23\t\t2:18 AM EST / 0.63 ft\t8:33 AM EST / 3.21 ft\t2:47 PM EST / 0.71 ft\t8:49 PM EST / 3.06 ft\t\t6:33 AM EST\t6:03 PM EST",
  "Wed 24\t\t2:57 AM EST / 0.70 ft\t9:07 AM EST / 3.16 ft\t3:19 PM EST / 0.76 ft\t9:23 PM EST / 3.06 ft\t\t6:32 AM EST\t6:03 PM EST",
  "Thu 25\t\t3:34 AM EST / 0.80 ft\t9:39 AM EST / 3.08 ft\t3:50 PM EST / 0.84 ft\t9:57 PM EST / 3.04 ft\t\t6:31 AM EST\t6:04 PM EST",
  "Fri 26\t\t4:10 AM EST / 0.92 ft\t10:11 AM EST / 2.99 ft\t4:22 PM EST / 0.92 ft\t10:30 PM EST / 3.01 ft\t\t6:30 AM EST\t6:04 PM EST",
  "Sat 27\t\t4:47 AM EST / 1.05 ft\t10:44 AM EST / 2.90 ft\t4:54 PM EST / 1.00 ft\t11:05 PM EST / 2.97 ft\t\t6:29 AM EST\t6:05 PM EST",
  "Sun 28\t\t5:25 AM EST / 1.17 ft\t11:20 AM EST / 2.81 ft\t5:29 PM EST / 1.08 ft\t11:44 PM EST / 2.93 ft\t\t6:28 AM EST\t6:06 PM EST",
  "Mon 29\t\t6:09 AM EST / 1.29 ft\t12:01 PM EST / 2.72 ft\t6:10 PM EST / 1.15 ft\t\t\t6:27 AM EST\t6:06 PM EST"
]