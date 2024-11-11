# Define the function my.barplot that draws a barplot with scatter points and text
my.barplot <- function(d, t, e, col='red', border=NA) {
  # Basic barplot with user-defined colors and border
  bar_heights <- barplot(d, col=col, border=border, ylim=c(0, max(d + e) * 1.2))
  
  # Add scatter points and text above the bars
  points(bar_heights, d + e, pch=16, col='blue')  # Scatter points above each bar
  text(bar_heights, d + e + 0.3, labels=t, col='black', cex=0.8)  # Text labels
  
  # Additional details
  title("Barplot with Scatter and Text")
}

# Test the my.barplot function
my.barplot(d=1:5, t=LETTERS[1:5], e=runif(5, max=3), col='red', border=NA)

# Define the function imageWithText that displays an image plot with text labels in each cell
imageWithText <- function(d, t, xlab='Cols', ylab='Rows', main='Table', col=terrain.colors(100)) {
  # Display the matrix as an image plot
  image(1:ncol(d), 1:nrow(d), t(d)[,nrow(d):1], col=col, xlab=xlab, ylab=ylab, main=main, axes=FALSE)
  
  # Add row and column names as labels on axes
  axis(1, at=1:ncol(d), labels=colnames(d), las=2)
  axis(2, at=1:nrow(d), labels=rev(rownames(d)), las=1)
  
  # Add text labels for each cell
  for (i in 1:ncol(d)) {
    for (j in 1:nrow(d)) {
      text(i, nrow(d) - j + 1, labels=t[j, i], cex=0.8)
    }
  }
}

# Test the imageWithText function
d <- matrix(1:8, ncol=2)
colnames(d) <- c('col1', 'col2')
rownames(d) <- paste0('row', 1:4)
par(mfrow=c(1, 2))  # Set up plotting layout

# Regular image plot
image(d, col=terrain.colors(100))

# Enhanced image plot with text in cells and labeled rows/columns
imageWithText(d, t = matrix(paste0('x=', d), nrow=nrow(d), ncol=ncol(d)), 
              xlab='Cols', ylab='Rows', main='Table', col=terrain.colors(100))
