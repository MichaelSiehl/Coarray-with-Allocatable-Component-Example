https://github.com/MichaelSiehl/Coarray-with-Allocatable-Component-Example
!***************************************************
PROGRAM Main
!
USE NonSymmetricDemo
!
IMPLICIT NONE
REAL, ALLOCATABLE, DIMENSION (:) :: reaDataArray
TYPE(NonSymmetricCoarray), CODIMENSION[*] :: Coarray_Object
INTEGER intImageNumber
INTEGER intLowerBound
INTEGER intUpperBound
!
IF (THIS_IMAGE() == 2) THEN
  ALLOCATE (reaDataArray (1:15))
  CALL CopyToCoarrayMember (Coarray_Object, reaDataArray)
  DEALLOCATE (reaDataArray)
END IF
!
SYNC ALL
!
IF (THIS_IMAGE() == 1) THEN
  intImageNumber = 2 ! to get the bounds from Image 2
  CALL GetBoundsFromCoarrayMember (Coarray_Object, intImageNumber, intLowerBound, intUpperBound)
  write(*,*) 'This example shows how to access the array bounds on Image 2 from Image 1.'
  write(*,*) 'The following output comes from image ', THIS_IMAGE()
  write(*,*) 'Lower and upper bounds on image', intImageNumber, ':', intLowerBound, intUpperBound
END IF
!
END PROGRAM Main
!***************************************************
