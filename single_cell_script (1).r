# working directory ----

#Setting the working directory

#setwd("/Users/rima/Library/CloudStorage/OneDrive-NortheasternUniversity/Decode Life/Decode Life Workshope1/Session 11")

# Initialize PDF device to save plots
pdf(file="Plots.pdf")


# Load required packages ----
# Check if BiocManager is installed; if not, install it.
if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
 
BiocManager::install("AnnotationDbi")
library("AnnotationDbi") 

# Install and load the org.Hs.eg.db package for human gene annotations
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
 
BiocManager::install("org.Hs.eg.db")
library("org.Hs.eg.db")

# Install and load data manipulation packages
install.packages("dplyr")
library("dplyr")

install.packages("tidyr")
library(tidyr)

install.packages("data.table")
library(data.table)

# Install and load the Seurat package for single-cell RNA-seq analysis
install.packages("Seurat")
library(Seurat)

# Importing data ----
# Read the gene expression data from a text file, using tab as the separator and setting the first column as row names
f <- read.csv("EXP0001_PCG_beforeQC.txt", sep="\t", row.names = 1)
View(f[1:10,1:10]) # View the first 10 rows and columns of the dataset

# Remove the first row of the dataset (often contains unwanted headers or metadata)
f <- f[-1,]
View(f[1:10,1:10])

# Ensure BiocManager is installed to manage Bioconductor packages ----
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Install the org.Hs.eg.db package for human gene annotations, if not already installed
BiocManager::install("org.Hs.eg.db")

# Load the org.Hs.eg.db package
library(org.Hs.eg.db)


# Map ENSEMBL gene IDs to gene symbols
f$Gene <- mapIds(org.Hs.eg.db,
                   keys=row.names(f),
                   column="SYMBOL", 
                   keytype="ENSEMBL", 
                   multiVals="first")

# Use dplyr's select function explicitly to avoid conflicts with other packages' select functions
f <- f %>% dplyr::select(Gene, everything())
#f <- f %>% select(Gene, everything())
View(f[1:10,1:10])
View(f$Gene)

# Remove duplicate genes while keeping all associated data
f <- distinct(f,Gene, .keep_all= TRUE)

# Drop rows with missing gene names
f <- f %>% drop_na(Gene)

# Set the row names of the data frame to the Gene names and remove the Gene column
row.names(f)<-f$Gene
f$Gene <- NULL

# Create a Seurat object from the data
pb <- CreateSeuratObject(counts = f, 
                         min.cells = 3,
                         min.features = 200)
pb # Print the Seurat object summary

# Calculate the percentage of mitochondrial genes
pb[["percent.mt"]] <- PercentageFeatureSet(pb, pattern = "^MT-")
pb[["percent.mt"]]

# ---- Visualize QC metrics as a violin plot ----
pdf(file="Plot1.pdf")
VlnPlot(pb, features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
dev.off() # Close the PDF device to save the plot

# Normalization
pb <- NormalizeData(pb)

# Variable features
pb <- FindVariableFeatures(pb, selection.method = "vst", nfeatures = 2000)

# Get a list of variable features and convert it to a data frame
list_of_variable_features <- VariableFeatures(pb)
list_of_variable_features <- as.data.frame(list_of_variable_features)


# Identify the 10 most highly variable genes
top10 <- head(VariableFeatures(pb), 10)


# plot variable features with and without labels
plot1 <- VariableFeaturePlot(pb)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
plot1 + plot2

# Scale data for PCA
all.genes <- rownames(pb)
pb <- ScaleData(pb, features = all.genes)

# Run PCA on the variable features
pb <- RunPCA(pb, features = VariableFeatures(object = pb))

# Visualize PCA loadings and plot the PCA results
VizDimLoadings(pb, dims = 1:2, reduction = "pca")
DimPlot(pb, reduction = "pca")

# Heatmap of the top PCA components
DimHeatmap(pb, dims = 1:15, cells = 500, balanced = TRUE)

# Perform JackStraw analysis for significance of PCA components
pb <- JackStraw(pb, num.replicate = 100)
pb <- ScoreJackStraw(pb, dims = 1:20)

# JackStraw plot to visualize the significance
JackStrawPlot(pb, dims = 1:15)

# Elbow plot to determine optimal dimensions for clustering
ElbowPlot(pb)

# ---- Clustering ----
pb <- FindNeighbors(pb, dims = 1:10)
pb <- FindClusters(pb, resolution = 0.5)
head(Idents(pb), 5)

# Run UMAP for dimensionality reduction and visualize
pb <- RunUMAP(pb, dims = 1:10)
DimPlot(pb, reduction = "umap")

# ---- Marker identification ----
pb.markers <- FindAllMarkers(pb, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)
# Save the markers to a CSV file
write.table(pb.markers,file="Markers_info.csv",
            sep=",",row.names=FALSE,col.names = TRUE,quote = FALSE)

# Open a PDF file to save the plots
#pdf(file = "ViolinPlots.pdf")
# Visualize specific features with violin plots
VlnPlot(pb, features = c("FTL","RAP1A","ISG15"))
VlnPlot(pb, features = c("ISG15"))
# Close the PDF device to save the plots
dev.off()

# Open a PDF file to save the plots
#pdf(file = "FeaturePlots.pdf")
# Feature plots for individual genes
FeaturePlot(pb, features = "STATH")
FeaturePlot(pb, features = "ISG15")
FeaturePlot(pb, features = "ISG15", pt.size = 2)
# Close the PDF device to save the plots
dev.off()

# Check cluster identities and convert to data frame
check <- Idents(pb)
check <- as.data.frame(check)

# Convert to data.table format for easier manipulation
check<-setDT(check, keep.rownames = TRUE)[]
colnames(check) <- c("Cell_Id", "Cluster") # Rename columns

# View the resulting data.table (optional)
print(check)
