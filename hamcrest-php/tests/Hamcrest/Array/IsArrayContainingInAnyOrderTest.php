<?php
require_once 'Hamcrest/AbstractMatcherTest.php';
require_once 'Hamcrest/Array/IsArrayContainingInAnyOrder.php';

class Hamcrest_Array_IsArrayContainingInAnyOrderTest
  extends Hamcrest_AbstractMatcherTest
{
  
  protected function createMatcher()
  {
    return Hamcrest_Array_IsArrayContainingInAnyOrder::arrayContainingInAnyOrder(array(equalTo(1), equalTo(2)));
  }
  
  public function testHasAReadableDescription()
  {
    $this->assertDescription('[<1>, <2>] in any order', containsInAnyOrder(array(equalTo(1), equalTo(2))));
    $this->assertDescription('[<1>, <2>] in any order', containsInAnyOrder(array(1, 2)));
  }
  
  public function testMatchesItemsInAnyOrder()
  {
    $this->assertMatches(containsInAnyOrder(array(1, 2, 3)), array(1, 2, 3), 'in order');
    $this->assertMatches(containsInAnyOrder(array(1, 2, 3)), array(3, 2, 1), 'out of order');
    $this->assertMatches(containsInAnyOrder(array(1)), array(1), 'single');
  }
  
  public function testAppliesMatchersInAnyOrder()
  {
    $this->assertMatches(
      containsInAnyOrder(array(equalTo(1), equalTo(2), equalTo(3))),
      array(1, 2, 3),
      'in order'
    );
    $this->assertMatches(
      containsInAnyOrder(array(equalTo(1), equalTo(2), equalTo(3))),
      array(3, 2, 1),
      'out of order'
    );
    $this->assertMatches(
      containsInAnyOrder(array(equalTo(1))),
      array(1),
      'single'
    );
  }
  
  public function testMismatchesItemsInAnyOrder()
  {
    $matcher = containsInAnyOrder(array(1, 2, 3));
    
    $this->assertMismatchDescription('was null', $matcher, null);
    $this->assertMismatchDescription('No item matches: <1>, <2>, <3> in []', $matcher, array());
    $this->assertMismatchDescription('No item matches: <2>, <3> in [<1>]', $matcher, array(1));
    $this->assertMismatchDescription('Not matched: <4>', $matcher, array(4, 3, 2, 1));
  }
  
}
