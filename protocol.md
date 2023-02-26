# Building Phylogenetic Trees with IQ-TREE

Create a new folder on your Desktop titled “phylogenetics_lab”

Download IQ-TREE v2.2.0 from http://www.iqtree.org/

Move the “iqtree-2.2.0-MacOSX” folder into your “phylogenetics_lab” folder

Open terminal and test the following command:

```
iqtree-2.2.0-MacOSX/bin/iqtree2
```

Download Clustal Omega from http://www.clustal.org/omega/
Choose the "Standalone Mac binary (PowerPC/64-bit Intel) (1.2.3)" option
Move the file “clustal-omega-1.2.3-macosx” into your “phylogenetics_lab” folder 
Open terminal and run the following commands:

```
cd Desktop/phylogenetics_lab/
chmod a+x clustal-omega-1.2.3-macosx
./clustal-omega-1.2.3-macosx
```

# Protocol
Open the NCBI website https://www.ncbi.nlm.nih.gov/

Search “Strongylocentrotus” 

Under “Genomes,” Click “Nucleotide”

On the filter bar on the left side of the screen, select “Mitochondrion”

At the top of the screen, under the “Sort by” menu, select “Sequence Length”

Select all the records that say “complete genome” in the name. Do not select the record “UNVERIFIED: Strongylocentrotus intermedius mitochondrion sequence, sequence”

Scroll back to the top of the bag. In the top right corner, select “Send to”
1) Select “Complete record”
2) Under “Choose Destination,” select  “File”
3) Under “Format”,choose “FASTA”
4) Under “Sort by,” select “Taxonomy ID” 
5) Click “Create File”
 
<img width="258" alt="ncbi" src="https://user-images.githubusercontent.com/60276545/221434645-19b97334-1c7d-4261-9aca-768a4018d2a1.png">

Move the file to your phylogenetics_lab folder and rename it “sequences.fasta”. Open the file using a text editor such as TextEdit. This file contains all of the unaligned mitochondrial genomes in FASTA format. 

There is one more sequence we need to add. It is on Canvas, named “fragilis.fasta.” Download this file from Canvas to your phylogenetics_lab folder. Open terminal and run the following command:

```
cat fragilis.fasta >> sequences.fasta
```

We are going to reformat this file slightly to change the names of the sequences. This will help later during visualization. 

Download the “reformat.sh” file from Canvas and move it to your phylogenetics_lab folder. Run the following commands:

```
chmod a+x reformat.sh
./reformat.sh 
```

The reformat.sh script changes the sequence names slightly to be more readable and outputs a new file called “reformatted_sequences.fasta.”

Before we can make a phylogenetic tree from the sequences, we need to align them. We will use a program called Clustal Omega. Align the sequences with the following command. 

```
clustalo -i reformatted_sequences.fasta -o aligned_sequences.fasta --threads=6 -v
```

Command Options Explained:
```
-i, --in, --infile={<file>,-} Multiple sequence input file
-o, --out, --outfile={file,-} Multiple sequence alignment output file (default: stdout)
--threads=<n> Number of processors to use
-v, --verbose Verbose output (increases if given multiple times)
```

Open the new file, aligned_sequences.fasta in a text editor. How is this new file different from the original sequence file downloaded from NCBI?

Now that we’ve aligned the sequences, let’s build a phylogenetic tree and see how they’re related. Run the following command:

```
iqtree -s aligned_sequences.fasta -m MFP -B 1000 -T 6
```

Command Options Explained:
```
-s FILE[,...,FILE]   PHYLIP/FASTA/NEXUS/CLUSTAL/MSF alignment file(s)
-m MFP               Extended model selection followed by tree inference
-B, --ufboot NUM     Replicates for ultrafast bootstrap (>=1000)
-T NUM|AUTO          No. cores/threads or AUTO-detect (default: 1)
```

Now look at your phylogenetics_lab folder in Finder. IQ-TREE creates a lot of output files. The main file we are interested in is “aligned_sequences.fasta.treefile.” This file contains the phylogenetic tree in newick format. 

Let’s visualize the tree. We will use a web browser tool called Interactive Tree of Life (iTOL). Go to https://itol.embl.de/upload.cgi. Click “Choose File” and find your tree file “aligned_sequences.fasta.treefile.” Select upload.

The tree looks funky because it is not rooted. Let's make some formatting changes

1) We will have iTOL root the tree at the midpoint (on the longest branch). On the menu bar on the right, click the “Advanced” tab. At the bottom of the menu bar, select “Midpoint root.” 
2) Let’s display our bootstrap values and make the tree easier to read. While still on the “Advanced” tab, under “Boostraps / metada:” select “Display.” A new menu bar will pop up. Change “Symbol” to “Text” and increase the font size. 
3) Under the “Basic” tab, under “Label options,” for “Position,” select “At tips.”

A phylogenetic tree built from nuclear protein-coding genes is shown below:
![figure_1](https://user-images.githubusercontent.com/60276545/221434462-fb302fbf-b575-4668-908e-a7c985f9a8af.svg)

# Discussion Questions
1)	Are there any differences between the tree built from nuclear DNA and the tree built from mitochondrial DNA? 
2)	Which tree is more trustworthy? Why?
3)	Why do you think these differences between trees exist? Do you think this is the result of error in tree estimation, or is there a biological process that can produce this pattern?
4)	What are bootstrap support values? How are these estimated?
