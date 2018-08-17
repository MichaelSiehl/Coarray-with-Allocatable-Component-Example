! https://github.com/MichaelSiehl/Coarray-with-Allocatable-Component-Example
!**********************************************************
MODULE NonSymmetricDemo
!
IMPLICIT NONE
PRIVATE
PUBLIC :: CopyToCoarrayMember, GetBoundsFromCoarrayMember
!________________________________________________________
!
TYPE, PUBLIC :: NonSymmetricCoarray
  PRIVATE
  !*****
  REAL, DIMENSION (:), ALLOCATABLE :: reaDataArray
  LOGICAL :: logAllocationStatus = .FALSE.
  ! stores the Allocation Status of the reaDataArray member
  !*****
END TYPE NonSymmetricCoarray
!
TYPE(NonSymmetricCoarray), PUBLIC, CODIMENSION[*], SAVE :: Coarray_Object
!
!__________________________________________________________
!**********************************************************
CONTAINS !*************************************************
!**********************************************************
!**************
!
SUBROUTINE CopyToCoarrayMember (Coarray_Object, reaDataArray)
  ! copy the reaDataArray to a Coarray with allocatable component
  ! on the current image(s)
  TYPE (NonSymmetricCoarray), CODIMENSION[*], INTENT (INOUT) :: Coarray_Object
  REAL, DIMENSION (:), INTENT (IN) :: reaDataArray
  !
  ALLOCATE (Coarray_Object % reaDataArray (LBOUND (reaDataArray, DIM=1) : UBOUND (reaDataArray, DIM=1)))
  Coarray_Object % logAllocationStatus = .TRUE.
  !
  Coarray_Object % reaDataArray = reaDataArray
  !
END SUBROUTINE CopyToCoarrayMember
!**********************************************************

!
SUBROUTINE GetBoundsFromCoarrayMember (Coarray_Object, intImageNumber, intLowerBound, intUpperBound)
  !
  TYPE (NonSymmetricCoarray), CODIMENSION[*], INTENT (INOUT) :: Coarray_Object
  INTEGER, INTENT (IN) :: intImageNumber
  INTEGER, INTENT (OUT) :: intLowerBound
  INTEGER, INTENT (OUT) :: intUpperBound
  !
  IF (Coarray_Object[intImageNumber] % logAllocationStatus) THEN
    intLowerBound = LBOUND (Coarray_Object[intImageNumber] % reaDataArray, 1)
    intUpperBound = UBOUND (Coarray_Object[intImageNumber] % reaDataArray, 1)
  ELSE
    intLowerBound = 1
    intUpperBound = 0
  END IF
  !
END SUBROUTINE GetBoundsFromCoarrayMember
!
!*******
END MODULE NonSymmetricDemo

