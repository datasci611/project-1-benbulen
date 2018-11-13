#! /usr/bin/env nextflow

params.in_files = 'data/*.csv'

in_abs = Channel.fromPath( params.in_abs)

process build_shiny_app {
	container 'rocker/tidyverse'
	publishdir 'data', mode: 'copy'

	input;
 	file i from in_abs
	
        script:
        """
        Rscript $baseDir/bin/shiny_app.R $i
        """


