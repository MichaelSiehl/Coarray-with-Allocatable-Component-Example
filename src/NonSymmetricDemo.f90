https://github.com/MichaelSiehl/Coarray-with-Allocatable-Component-Example
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
