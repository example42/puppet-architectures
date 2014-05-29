$users = ['al','ma']
$default_users = [ 'joe' ] 
$all_users = $users + $default_users

$all_users.each |$user| {
  notice "User: $user"
}
