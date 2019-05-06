!
!*****************************************************************************
!
SUBROUTINE READ_RESTART
!
USE MOLECS
USE GEOM
USE GAS
USE CALC
USE OUTPUT
USE MFDSMC, only:IMF,IMFS,NMFpair,NMFANG, IMFpair,IMFdia,&
  MFRMASS, NMFER0, NMFET0,NMFEV0,NMFER,&
  NMFET,NMFEV,NMFERR,NMFETR,NMFEVR,NMFVT0,NMFVT,NMFVTR, &
  MF_SET_AHO
!
IMPLICIT NONE
!
INTEGER :: ZCHECK,ZCHECK2
ZCHECK = 0; ZCHECK2 = 0
!
101 CONTINUE
OPEN (7,FILE='PARAMETERS.DAT',FORM='UNFORMATTED',ERR=101) !--isebasti: replace binary by unformatted
READ (7) NCCELLS,NCELLS,MMRM,MMVM,MNM,MNRE,MNSR,MSP,MTBP,ILEVEL,MDIV,IRECOM,MMEX,MEX,ISF,NBINS,NSNAP,ITMAX !--isebasti: included ISF,NBINS,NSAP
READ (7) IMF, IMFS, NMFpair, IMFdia, nonVHS !--han: included these for MF model
CLOSE(7)
!
IF (MMVM > 0) THEN
  ALLOCATE (PX(MNM),PTIM(MNM),PROT(MNM),IPCELL(MNM),IPSP(MNM),ICREF(MNM),IPCP(MNM),PV(3,MNM),      &
       IPVIB(0:MMVM,MNM),STAT=ERROR)
ELSE
  IF (MMRM > 0) THEN
    ALLOCATE (PX(MNM),PTIM(MNM),PROT(MNM),IPCELL(MNM),IPSP(MNM),ICREF(MNM),IPCP(MNM),PV(3,MNM),STAT=ERROR)
  ELSE
    ALLOCATE (PX(MNM),PTIM(MNM),IPCELL(MNM),IPSP(MNM),ICREF(MNM),IPCP(MNM),PV(3,MNM),STAT=ERROR)
  END IF
END IF
IF (ERROR /= 0) THEN
  WRITE (*,*) 'PROGRAM COULD NOT ALLOCATE SPACE FOR MOLECULE ARRAYS',ERROR
ENDIF
!
ALLOCATE (JDIV(0:ILEVEL,MDIV),STAT=ERROR)
IF (ERROR /= 0) THEN
  WRITE (*,*) 'PROGRAM COULD NOT ALLOCATE SPACE FOR JDIV ARRAY',ERROR
ENDIF
!
ALLOCATE (CELL(4,NCELLS),ICELL(NCELLS),CCELL(5,NCCELLS),ICCELL(3,NCCELLS),STAT=ERROR)
IF (ERROR /= 0) THEN
  WRITE (*,*) 'PROGRAM COULD NOT ALLOCATE SPACE FOR CELL ARRAYS',ERROR
ENDIF
!
ALLOCATE (COLLS(NCELLS),WCOLLS(NCELLS),CLSEP(NCELLS),REAC(MNRE),SREAC(MNSR),VAR(21,NCELLS), &
          VARSP(0:11,NCELLS,MSP),VARS(0:32+MSP,2),CS(0:8+MMVM,NCELLS,MSP),CSS(0:8,2,MSP,2), &  !--isebasti: correcting CS allocation
          CSSS(6,2),CST(0:4,NCELLS),BINS(0:NBINS,5,MSP),BIN(0:NBINS,5),EVREM(MNRE),&
          PDFS(0:NBINS,5,MSP),PDF(0:NBINS,5),NDROT(MSP,100),NDVIB(NSCELLS,0:MMVM,MSP,0:100),STAT=ERROR) !--isebasti: CST,BINS,BIN,PDFS,PDF included
! IF (MNRE > 0) THEN
!   ALLOCATE (NPVIB(2,MNRE,3,3,0:100),FPVIB(MNRE,ITMAX,3,3,0:100),FPTEMP(ITMAX),STAT=ERROR)
!   ALLOCATE (NEVIB(MNRE,2,0:100),FEVIB(MNRE,ITMAX,2,0:100),STAT=ERROR) !--isebasti: included
! ELSE
!   ALLOCATE (NPVIB(1,1,1,1,1),FPVIB(1,1,1,1,1),FPTEMP(1),NEVIB(1,1,1),FEVIB(1,1,1,1),STAT=ERROR) !--isebasti: included
!   ALLOCATE (EVREM(MNRE),STAT=ERROR)
! END IF
! IF (ERROR /= 0) THEN
!   WRITE (*,*) 'PROGRAM COULD NOT ALLOCATE SPACE FOR SAMPLING ARRAYS',ERROR
! ENDIF
!
!
CALL ALLOCATE_GAS
!
102 CONTINUE
OPEN (7,FILE='RESTART.DAT',FORM='UNFORMATTED',ERR=102) !--isebasti: replace binary by unformatted
READ (7) AC,AE,AVDTM,BC,BOLTZ,EVOLT,CCELL,CELL,CI,CLSEP,COLLS, &
         CPDTM,CR,CS,CSS,CSSS,CTM,CXSS,CST,BINS,BIN,PDFS,PDF,NSPDF,NDROT,NDVIB,DDIV,DPI,DTM,DTSAMP,DTOUT, &
         ENTMASS,ENTR,ER,ERROR,ERS,FDEN,FMA,FND,FNUM,FRACSAM,FSP,FP,FPR,FREM,FSPEC, &
         FTMP,FTIME,FRTMP,FVTMP,GASCODE,ICCELL,ICELL,ICREF,IFX,IMTS,IPCELL,IPCP, &
         IPSP,IPVIB,IRCD,IREA,IREM,ISECS,ISF,ISPEX,ISPR,ISPRC,ISPV,ISPVM,ISRCD,ITYPE,IVB,IWF,JCD, &
         JDIV,JREA,KP,LE,LIS,LP,LRS,ME,MOLSC,MP,MVER,NCCELLS,NCELLS, &
         NCIS,NDIV,NEX,NM,NMISAMP,NNC,NOUT,NREA,NRSP,NSAMP,NSPEX,NVER,OUTRAT,SAMPRAT,PI,PROT,PTIM,PV,PX, &
         REAC,RGFS,RMAS,REA,SP,SPEX,SPI,SPM,SPR,SPRC,SPV,SPVM,IDL,CPER,DPER,ENERS,ENERS0,IREV,SREAC,NPVIB,FPVIB,FPTEMP,IRM, &
         TCOL,CSCR,TDISS,TFOREX,TRECOMB,TREVEX,THBP,TISAMP,TPOUT,TREF,TLIM,TOTCOL,PCOLLS,TOTDUP,TOTMOV,     &
         TREACG,TREACL,TOUT,TPDTM,TREF,TSAMP,TSURF,VAR,VARS,VARSP,VELOB,VFX,VFY,UVFX,UFND,UFTMP,UVMP,VMP, &
         VMPM,VNMAX,VSURF,WCOLLS,WFM,XB,XREM,XVELS,YVELS,TNEX,NEVIB,FEVIB,QCTMODEL,IVMODEL,VIBEN,IGS,AMEG,EVREM,ZCHECK
!--isebasti: CST,BINS,BIN,PDFS,PDF,UVFX,UFND,UFTMP,UVMP,IDL,CPER,DPER,ENERS,ENERS0,IREV,NPVIB,FPVIB,FPTEMP included
IF (ZCHECK /= 1234567) THEN
  WRITE (9,*) 'Wrong', NM,' Molecules, Check integer =',ZCHECK
  STOP
END IF

IF (MNRE >0 .AND. IMF .ne. 0) THEN
  READ(7) NMFANG, MFRMASS
  IF (IMFS == 1 .AND. NMFpair > 0)THEN
    READ(7) IMFpair,NMFER0,NMFET0,NMFEV0,NMFER,NMFET,NMFEV,&
      NMFERR,NMFETR,NMFEVR,NMFVT0,NMFVT,NMFVTR
  END IF
  READ(7) ZCHECK2
  IF (ZCHECK2 /= 1234567) THEN
    WRITE (9,*) 'WrongIMFpair, Check integer =',ZCHECK2
    STOP
  END IF
  IF (IMF == 2 .or. IMF == 3) THEN
    CALL MF_SET_AHO()
  END IF
END IF
CLOSE(7)
!
RETURN
END SUBROUTINE READ_RESTART
