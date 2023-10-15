proc sleep {N} {
  after [expr {int($N*100)}]
}
