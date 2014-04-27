

$my_array = [ 'al' , 'joe' ]
$my_array.each |$x| { notice "${x} is the array value" } 
$my_array.each |$index, $value| {
    notice "${index} is the array index (Starts from 0)"
      notice "${value} is the array value"
}

$my_hash = { name => 'al' , group => 'admins' }
$my_hash.each |$x| {
  notice "${x[0]} is the hash key"
  notice "${x[1]} is the hash value"
} 
$my_hash.each |$key, $value| {
  notice "${key} is the hash key"
  notice "${value} is the hashvalue"
}
