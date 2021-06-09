
library(ggplot2)
library(dplyr)

PATH = "/Users/felipemassa/Downloads/project/"
#NAME <- "H3K27ac_SK-N-SH.ENCFF138VUT.hg38"
NAME <- "H3K27ac_SK-N-SH.ENCFF188BQP.hg38"


bed_df <- read.delim(paste0(PATH, NAME, '.bed'), as.is = TRUE, header = FALSE)
colnames(bed_df) <- c('chrom', 'start', 'end', 'name', 'score')
bed_df$len <- bed_df$end - bed_df$start

ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('len_hist.', NAME, '.pdf'), path = PATH)


bed_df <- bed_df %>%
  arrange(-len) %>%
  filter(len < 5000)



ggplot(bed_df) +
  aes(x = len) +
  geom_histogram() +
  ggtitle(NAME, subtitle = sprintf('Number of peaks = %s', nrow(bed_df))) +
  theme_bw()
ggsave(paste0('filter_peaks.', NAME, '.filtered.hist.pdf'), path = PATH)


bed_df %>%
  select(-len) %>%
  write.table(file=paste0(PATH, NAME ,'.filtered.bed'),
              col.names = FALSE, row.names = FALSE, sep = '\t', quote = FALSE)


