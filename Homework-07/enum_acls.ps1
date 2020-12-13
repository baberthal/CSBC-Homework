$curdir = Get-Location
$directory = Get-ChildItem $curdir

foreach ($item in $directory) {
  Get-Acl $item
}
