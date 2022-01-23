     
 
$numNeurons = 1000 #, 3162 #, 10000, 31622
$numSynapses = 100 #, 200 #, 300, 400, 500, 600
$numCore=1 #, 2 #, 4
$index= 0 #, 1, 2, 3, 4, 5
$weight1=@(1.9049, 0.9524, 0.6786, 0.4911, 0.4286, 0.3274)
$weight2=@(2.1777, 1.1705, 0.7554, 0.5308, 0.4083, 0.3267)
$weight3=@(2.0816, 1.0928, 0.7286, 0.5204, 0.3838, 0.3643)

$numCore | foreach {
    $numC = $_  # $numC = 1
    "GPU number is $numC " >> "record.csv"
    $numNeurons | foreach {
        $numN = $_     #  $numN = 1000 number of neurons, which defines the workload
		for($n=0; $n -lt $numSynapses.length; $n++) { # for n in $index # number of synapse per neuron
            $s = ".\benchmark3.exe $numN 100 42 $numSyn ""record.csv"" 10 10 6.5 $($weight1[$n]) $($weight2[$n]) $($weight3[$n]) $numC 0"
            Write-Output $s
            iex $s
			#./benchmark3 $numN 100 42 $($numSynapses[$n]) "record.csv" 10 10 6.5 $($weight1[$n]) $($weight2[$n]) $($weight3[$n]) $numC 0
			#13 parameters needed
			#1, number of neurons in a group | 2, number of input neurons
			#3, randseed | 4, number of synapse per neuron |5, record File
			#6, number of simulate time |7, input fire rate 
			#8, connection weight from input to exc1
			#9, connection weight from exc1 to exc2	
			#10, connection weight from exc2 to exc3
			#11, connection weight from exc3 to exc4
			#12, number of GPU cores | 13, whether need weight tuning		
		}
	}	
}
 