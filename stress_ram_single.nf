params.memoryLimit="4 GB"
params.secondLim="30 GB"
params.thirdLim="10 GB"
params.fourthLim="24 GB"


process ram_test_1 {

  memory params.memoryLimit

  input:
    val x

  shell:
  '''
  stress-ng --vm 1 --vm-bytes $(echo "!{task.memory}" | cut -f 1 -d ' ')G --timeout 10s
  sleep 30
  stress-ng --vm 1 --vm-bytes $(echo "!{params.secondLim}" | cut -f 1 -d ' ')G --timeout 10s
  sleep 10
  stress-ng --vm 1 --vm-bytes $(echo "!{params.thirdLim}" | cut -f 1 -d ' ')G --timeout 20s
  sleep 10
  stress-ng --vm 1 --vm-bytes $(echo "!{params.fourthLim}" | cut -f 1 -d ' ')G --timeout 120s
  '''
}

workflow {
  channel.from(0..0) | (ram_test_1)
}
