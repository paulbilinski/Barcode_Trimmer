use warnings;

## usage:  barcodecount.pl <reverse complimented barcodes file> <fastq file> 

open FILE, "<$ARGV[0]";
my %barcodes;
while(<FILE>){
	chomp;
	my @bc=split(/\t/,$_);
	$barcodes{$bc[0]}=$bc[1];
}
#This has to be the names of all of your lines
my @accession = ("ADD.FILE.NAMES","Here.like.this")
for my $i (0..95){
	my $file="$accession[$i]";
	open( $file, ">", "$file"); 
}
$file="UNMATCHED_READS"; # arbitrary name, but make sure it matches other files
open $file, ">UNMATCHED_READS";

close FILE;

open FILE, "$ARGV[1]";
my $title="";
my $which="";
while(<FILE>){
	chomp;
	if ( $_=~m/\@DJB/ ){ $title=$_; next; } #This is the regex that must match the 
	else{ 
		if( $title ){
			my $barcode=substr $_, 0, 5;
#			print STDERR "$barcode\n";
			if( $barcodes{$barcode} ){ 
				$which=$barcodes{$barcode};
			}
			else {
				$which="UNMATCHED_READS";
			}
			print $which "$title\n$_\n";
			$title="";
		} 
		else{
			print $which "$_\n"; 
		}
	}
}
