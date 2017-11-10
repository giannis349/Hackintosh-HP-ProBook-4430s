/*
 * Intel ACPI Component Architecture
 * AML Disassembler version 20140424-64 [Jun 25 2014]
 * Copyright (c) 2000 - 2014 Intel Corporation
 * 
 * Disassembly of DSDT.aml, Tue Nov  7 22:39:44 2017
 *
 * Original Table Header:
 *     Signature        "DSDT"
 *     Length           0x0000A86F (43119)
 *     Revision         0x02
 *     Checksum         0x1F
 *     OEM ID           "Apple "
 *     OEM Table ID     "167E    "
 *     OEM Revision     0x00000001 (1)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20140424 (538182692)
 */
DefinitionBlock ("DSDT.aml", "DSDT", 2, "Apple ", "167E    ", 0x00000001)
{
    /*
     * iASL Warning: There were 1 external control methods found during
     * disassembly, but only 0 was resolved (1 unresolved). Additional
     * ACPI tables may be required to properly disassemble the code. This
     * resulting disassembler output file may not compile because the
     * disassembler did not know how many arguments to assign to the
     * unresolved methods.
     *
     * If necessary, the -fe option can be used to specify a file containing
     * control method external declarations with the associated method
     * argument counts. Each line of the file must be of the form:
     *     External (<method pathname>, MethodObj, <argument count>)
     * Invocation:
     *     iasl -fe refs.txt -d dsdt.aml
     *
     * The following methods were unresolved and many not compile properly
     * because the disassembler had to guess at the number of arguments
     * required for each:
     */
    External (WMAB, MethodObj)    // Warning: Unresolved method, guessing 1 arguments

    External (_PR_.CPU0._PPC, IntObj)
    External (_PR_.CPU0._PSS, PkgObj)
    External (_SB_.PCI0.PEGP.DGFX.DD02, UnknownObj)
    External (_SB_.PCI0.PEGP.DGFX.SVID, UnknownObj)
    External (CFGD, IntObj)
    External (PDC0, IntObj)

    Name (FMBL, One)
    Name (LSTA, Zero)
    Name (IDPM, Zero)
    Method (HPTS, 1, NotSerialized)
    {
        Store (Arg0, SLPT) /* \SLPT */
        \_SB.ODGW (Or (0x5400, Arg0))
        If (LEqual (Arg0, 0x05))
        {
            \_SB.SSMI (0xEA82, Arg0, Zero, Zero, Zero)
        }

        If (LGreater (Arg0, Zero))
        {
            \_SB.SSMI (0xEA83, Zero, Zero, Zero, Zero)
            If (LNotEqual (Arg0, 0x03))
            {
                Store (Zero, \_SB.PCI0.LPCB.EC0.HSST)
            }

            PPTS (Arg0)
            If (LNotEqual (Arg0, 0x05))
            {
                \_SB.PCI0.LPCB.EC0.BTDR (Zero)
                Store (One, \_SB.NFBS)
                If (LEqual (Arg0, 0x03))
                {
                    Store (\_SB.LID._LID (), LSTA) /* \LSTA */
                    If (LNotEqual (And (PNHM, 0x000F0FF0), 0x000106E0))
                    {
                        Store (APMC, IDPM) /* \IDPM */
                    }
                }
            }
        }
    }

    Method (HWAK, 1, NotSerialized)
    {
        Store (Zero, SLPT) /* \SLPT */
        \_SB.ODGW (Or (0x5600, Arg0))
        If (LEqual (Arg0, 0x03))
        {
            \_SB.SSMI (0xEA80, Zero, Zero, Zero, Zero)
        }

        \_SB.PCI0.LPCB.EC0.ITLB ()
        \_SB.PCI0.LPCB.EC0.RPPC (One)
        If (\_SB.PCI0.LPCB.EC0.ECRG)
        {
            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
            Store (One, \_SB.PCI0.LPCB.EC0.ACPI)
            Store (Zero, \_SB.PCI0.LPCB.EC0.SLPT)
            Release (\_SB.PCI0.LPCB.EC0.ECMX)
        }

        If (LGreater (Arg0, 0x02))
        {
            Store (One, \_SB.NFBS)
            If (LEqual (Arg0, 0x03))
            {
                Store (\_SB.LID._LID (), Local0)
                If (XOr (Local0, LSTA))
                {
                    \_SB.PCI0.IGPU.GLID (Local0)
                }

                If (LNotEqual (And (PNHM, 0x000F0FF0), 0x000106E0))
                {
                    Store (IDPM, APMC) /* \APMC */
                }
            }

            If (LEqual (Arg0, 0x04)) {}
        }

        If (LOr (LEqual (Arg0, 0x04), LEqual (WCOS (), One)))
        {
            Notify (\_SB.SLPB, 0x02) // Device Wake
        }

        Store (\_SB.PCI0.LPCB.EC0.GACS (), Local2)
        \_SB.PCI0.LPCB.EC0.PWUP (0x03, 0xFF)
        Store (\_SB.PCI0.LPCB.EC0.GBAP (), Local1)
        Store (\_SB.PCI0.LPCB.EC0.GACS (), Local3)
        Store (Local3, PWRS) /* \PWRS */
        XOr (Local2, Local3, Local3)
        If (LGreater (Arg0, 0x02))
        {
            Notify (\_SB.ADP1, 0x80) // Status Change
            PCNT ()
        }

        If (LEqual (Local3, Zero))
        {
            If (LEqual (Arg0, 0x04))
            {
                XOr (Local2, One, \_SB.ACST)
            }
        }

        PWAK (Arg0)
        \_SB.VWAK (Arg0)
        Store (\_SB.HST1.GHID (), Local0)
        \_SB.PCI0.ACEL.ITAL ()
    }

    Method (PCNT, 0, Serialized)
    {
    }

    Mutex (MUTX, 0x00)
    Method (P8XH, 2, Serialized)
    {
        If (LEqual (Arg0, Zero))
        {
            \_SB.ODBG (Arg1)
            Store (Or (And (P80D, 0xFFFFFF00), Arg1), P80D) /* \P80D */
        }

        If (LEqual (Arg0, One))
        {
            \_SB.ODG1 (Arg1)
            Store (Or (And (P80D, 0xFFFF00FF), ShiftLeft (Arg1, 0x08)
                ), P80D) /* \P80D */
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (Or (And (P80D, 0xFF00FFFF), ShiftLeft (Arg1, 0x10)
                ), P80D) /* \P80D */
        }

        If (LEqual (Arg0, 0x03))
        {
            Store (Or (And (P80D, 0x00FFFFFF), ShiftLeft (Arg1, 0x18)
                ), P80D) /* \P80D */
        }
    }

    OperationRegion (SPRT, SystemIO, 0xB2, 0x02)
    Field (SPRT, ByteAcc, Lock, Preserve)
    {
        SSMP,   8
    }

    Method (_PIC, 1, NotSerialized)  // _PIC: Interrupt Model
    {
        Store (Arg0, GPIC) /* \GPIC */
    }

    Method (_PTS, 1, NotSerialized)  // _PTS: Prepare To Sleep
    {
        If (LEqual (Arg0, 0x05)) {}
        Else
        {
            HPTS (Arg0)
            If (LEqual (Arg0, 0x03))
            {
                If (LAnd (DTSE, LGreater (TCNT, One)))
                {
                    TRAP (0x02, 0x1E)
                }
            }
        }
    }

    Method (_WAK, 1, NotSerialized)  // _WAK: Wake
    {
        If (LOr (LLess (Arg0, One), LGreater (Arg0, 0x05)))
        {
            Store (0x03, Arg0)
        }

        HWAK (Arg0)
        \_SB.PCI0.POSC (OSCC, Zero)
        If (LEqual (Arg0, 0x03)) {}
        If (LOr (LEqual (Arg0, 0x03), LEqual (Arg0, 0x04)))
        {
            If (LAnd (DTSE, LGreater (TCNT, One)))
            {
                TRAP (0x02, 0x14)
            }

            If (CondRefOf (CFGD))
            {
                If (And (CFGD, 0x01000000))
                {
                    If (LAnd (And (CFGD, 0xF0), LAnd (LEqual (OSYS, 0x07D1), 
                        LNot (And (PDC0, 0x10)))))
                    {
                        TRAP (One, 0x48)
                    }
                }
            }

            If (LEqual (OSYS, 0x07D2))
            {
                If (And (CFGD, One))
                {
                    If (LGreater (\_PR.CPU0._PPC, Zero))
                    {
                        Subtract (\_PR.CPU0._PPC, One, \_PR.CPU0._PPC) /* External reference */
                        PNOT ()
                        Add (\_PR.CPU0._PPC, One, \_PR.CPU0._PPC) /* External reference */
                        PNOT ()
                    }
                    Else
                    {
                        Add (\_PR.CPU0._PPC, One, \_PR.CPU0._PPC) /* External reference */
                        PNOT ()
                        Subtract (\_PR.CPU0._PPC, One, \_PR.CPU0._PPC) /* External reference */
                        PNOT ()
                    }
                }
            }
        }

        Return (Package (0x02)
        {
            Zero, 
            Zero
        })
    }

    Method (GETB, 3, Serialized)
    {
        Multiply (Arg0, 0x08, Local0)
        Multiply (Arg1, 0x08, Local1)
        CreateField (Arg2, Local0, Local1, TBF3)
        Return (TBF3) /* \GETB.TBF3 */
    }

    Method (PNOT, 0, Serialized)
    {
    }

    Method (TRAP, 2, Serialized)
    {
        Store (Arg1, SMIF) /* \SMIF */
        If (LEqual (Arg0, One))
        {
            Store (Zero, TRP0) /* \TRP0 */
        }

        If (LEqual (Arg0, 0x02))
        {
            Store (Arg1, DTSF) /* \DTSF */
            Store (Zero, TRPD) /* \TRPD */
            Return (DTSF) /* \DTSF */
        }

        Return (SMIF) /* \SMIF */
    }

    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            Store (0x07D6, OSYS) /* \OSYS */
            Store (One, PFLV) /* \PFLV */
        }
    }

    OperationRegion (GNVS, SystemMemory, 0xBCC25918, 0x019F)
    Field (GNVS, AnyAcc, Lock, Preserve)
    {
        OSYS,   16, 
        SMIF,   8, 
        PRM0,   8, 
        PRM1,   8, 
        SCIF,   8, 
        PRM2,   8, 
        PRM3,   8, 
        LCKF,   8, 
        PRM4,   8, 
        PRM5,   8, 
        P80D,   32, 
        LIDS,   8, 
        PWRS,   8, 
        DBGS,   8, 
        THOF,   8, 
        ACT1,   8, 
        ACTT,   8, 
        PSVT,   8, 
        TC1V,   8, 
        TC2V,   8, 
        TSPV,   8, 
        CRTT,   8, 
        DTSE,   8, 
        DTS1,   8, 
        DTS2,   8, 
        DTSF,   8, 
        Offset (0x28), 
        APIC,   8, 
        TCNT,   8, 
        PCP0,   8, 
        PCP1,   8, 
        PPCM,   8, 
        PPMF,   32, 
        C67L,   8, 
        NATP,   8, 
        CMAP,   8, 
        CMBP,   8, 
        LPTP,   8, 
        FDCP,   8, 
        CMCP,   8, 
        CIRP,   8, 
        SMSC,   8, 
        W381,   8, 
        SMC1,   8, 
        IGDS,   8, 
        TLST,   8, 
        CADL,   8, 
        PADL,   8, 
        CSTE,   16, 
        NSTE,   16, 
        SSTE,   16, 
        NDID,   8, 
        DID1,   32, 
        DID2,   32, 
        DID3,   32, 
        DID4,   32, 
        DID5,   32, 
        KSV0,   32, 
        KSV1,   8, 
        Offset (0x62), 
        DCLK,   16, 
        FSBF,   16, 
        Offset (0x67), 
        BLCS,   8, 
        BRTL,   8, 
        ALSE,   8, 
        ALAF,   8, 
        LLOW,   8, 
        LHIH,   8, 
        Offset (0x6E), 
        EMAE,   8, 
        EMAP,   16, 
        EMAL,   16, 
        Offset (0x74), 
        MEFE,   8, 
        DSTS,   8, 
        Offset (0x78), 
        TPMP,   8, 
        TPME,   8, 
        Offset (0x82), 
        GTF0,   56, 
        GTF2,   56, 
        IDEM,   8, 
        GTF1,   56, 
        BID,    8, 
        Offset (0xAA), 
        ASLB,   32, 
        IBTT,   8, 
        IPAT,   8, 
        ITVF,   8, 
        ITVM,   8, 
        IPSC,   8, 
        IBLC,   8, 
        IBIA,   8, 
        ISSC,   8, 
        I409,   8, 
        I509,   8, 
        I609,   8, 
        I709,   8, 
        IPCF,   8, 
        IDMS,   8, 
        IF1E,   8, 
        HVCO,   8, 
        NXD1,   32, 
        NXD2,   32, 
        NXD3,   32, 
        NXD4,   32, 
        NXD5,   32, 
        NXD6,   32, 
        NXD7,   32, 
        NXD8,   32, 
        GSMI,   8, 
        PAVP,   8, 
        Offset (0xE1), 
        OSCC,   8, 
        NEXP,   8, 
        SDGV,   8, 
        SDDV,   8, 
        Offset (0xEB), 
        DSEN,   8, 
        ECON,   8, 
        GPIC,   8, 
        CTYP,   8, 
        L01C,   8, 
        VFN0,   8, 
        VFN1,   8, 
        Offset (0x100), 
        NVGA,   32, 
        NVHA,   32, 
        AMDA,   32, 
        DID6,   32, 
        DID7,   32, 
        DID8,   32, 
        EBAS,   32, 
        CPSP,   32, 
        EECP,   32, 
        EVCP,   32, 
        XBAS,   32, 
        OBS1,   32, 
        OBS2,   32, 
        OBS3,   32, 
        OBS4,   32, 
        OBS5,   32, 
        OBS6,   32, 
        OBS7,   32, 
        OBS8,   32, 
        Offset (0x157), 
        ATMC,   8, 
        PTMC,   8, 
        ATRA,   8, 
        PTRA,   8, 
        PNHM,   32, 
        TBAB,   32, 
        TBAH,   32, 
        RTIP,   8, 
        TSOD,   8, 
        ATPC,   8, 
        PTPC,   8, 
        PFLV,   8, 
        BREV,   8, 
        SGMD,   8, 
        SGFL,   8, 
        PWOK,   8, 
        HLRS,   8, 
        DSEL,   8, 
        ESEL,   8, 
        PSEL,   8, 
        PWEN,   8, 
        PRST,   8, 
        MXD1,   32, 
        MXD2,   32, 
        MXD3,   32, 
        MXD4,   32, 
        MXD5,   32, 
        MXD6,   32, 
        MXD7,   32, 
        MXD8,   32, 
        GBAS,   16, 
        Offset (0x19D), 
        ALFP,   8, 
        IMON,   8
    }

    OperationRegion (ASMA, SystemMemory, 0xBCC27018, 0x1060)
    Field (ASMA, AnyAcc, NoLock, Preserve)
    {
        ASMB,   33536
    }

    OperationRegion (AF10, SystemMemory, 0xBCC29018, 0x0A16)
    Field (AF10, AnyAcc, Lock, Preserve)
    {
        STAT,   32, 
        EVAL,   8, 
        ASTL,   8, 
        ASTG,   256, 
        OWNT,   640, 
        PROD,   640, 
        MODL,   640, 
        PTYP,   640, 
        PFRQ,   640, 
        MEMS,   640, 
        DATE,   640, 
        FAMI,   640, 
        SERL,   640, 
        VREV,   640, 
        VRE2,   640, 
        KBCD,   640, 
        HDDS,   160, 
        HDDM,   320, 
        CDAT,   136, 
        CSTS,   8, 
        CYCL,   8, 
        PBSN,   144, 
        SBSN,   144, 
        BSTS,   8, 
        BORD,   72, 
        APST,   8, 
        OAPW,   3200, 
        NAPW,   3200, 
        SECO,   32, 
        SECS,   32, 
        SKUN,   128, 
        SVID,   80, 
        SSID,   32, 
        BTFC,   160, 
        WLFC,   160, 
        WWFC,   160, 
        GPFC,   160, 
        UUID,   256, 
        CFID,   208, 
        PWDL,   16, 
        USRN,   264, 
        ROLE,   32, 
        CMDV,   32, 
        KBDL,   32, 
        HASH,   160, 
        SPSF,   8, 
        FMOD,   8, 
        NBDL,   8, 
        MBDL,   8, 
        NBAD,   8, 
        MBAD,   8, 
        WUFI,   24, 
        LFND,   1296, 
        ATIM,   48, 
        PCID,   512, 
        PCVR,   40, 
        CURL,   1040, 
        RDSP,   8, 
        FCM,    32, 
        MPMC,   8, 
        SBCT,   120, 
        TXTC,   8, 
        AMTC,   8, 
        CPRV,   120, 
        BKPR,   8
    }

    OperationRegion (HPDF, SystemMemory, 0xBCC2AE18, 0x017C)
    Field (HPDF, AnyAcc, Lock, Preserve)
    {
        SLPT,   4, 
        WHOS,   4, 
        SDFG,   4, 
        LEGF,   1, 
        KCDB,   1, 
        KLDB,   1, 
        TPMX,   1, 
        FOAL,   1, 
        AEDA,   1, 
        ALSF,   1, 
        WOLD,   1, 
        HSED,   1, 
        HDEN,   1, 
        MDEN,   1, 
        ICPT,   1, 
        PMCS,   1, 
        UWKD,   1, 
        INQW,   1, 
        ILUX,   1, 
        ITPS,   1, 
        FCIN,   1, 
        ASFG,   2, 
        WDPE,   8, 
        WDSA,   16, 
        WDST,   16, 
        WDGN,   16, 
        WDSS,   16, 
        WLBN,   8, 
        PRDT,   8, 
        LPDP,   16, 
        EAX,    32, 
        EBX,    32, 
        ECX,    32, 
        EDX,    32, 
        REFS,   32, 
        SSCI,   8, 
        SBFC,   8, 
        TJMX,   8, 
        TRCN,   8, 
        DCAP,   8, 
        LOTR,   160, 
        HITR,   160, 
        WABN,   8, 
        WADN,   8, 
        WAFN,   8, 
        DTCD,   32, 
        BDCP,   8, 
        TBRB,   32, 
        OHCB,   32, 
        EDID,   2048, 
        ESTA,   8, 
        VRMS,   32, 
        VRMB,   32, 
        SGME,   8
    }

    OperationRegion (HPD2, SystemMemory, 0xBBC37F18, 0x6D)
    Field (HPD2, AnyAcc, Lock, Preserve)
    {
        CFPS,   8, 
        CMDS,   8, 
        BRID,   8, 
        F11,    1, 
        RSVD,   31, 
        WLDA,   768, 
        WLFL,   8, 
        WLIX,   8, 
        BTIX,   8, 
        WWIX,   8, 
        W2IX,   8, 
        GPSI,   8
    }

    OperationRegion (HPBR, SystemMemory, 0xBCC26F18, 0x7E)
    Field (HPBR, AnyAcc, Lock, Preserve)
    {
        PAID,   32, 
        PHSZ,   8, 
        PVSZ,   8, 
        BRCT,   8, 
        BCCT,   8, 
        BMAP,   88, 
        BCLV,   216, 
        BRLV,   200, 
        BRNT,   400, 
        BPWG,   16, 
        BPWO,   16, 
        PNLF,   8
    }

    Scope (_GPE)
    {
        Method (_L01, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Add (L01C, One, L01C) /* \L01C */
            \_SB.PCI0.RP01.HPLG ()
            \_SB.PCI0.RP02.HPLG ()
            \_SB.PCI0.RP03.HPLG ()
            \_SB.PCI0.RP04.HPLG ()
            \_SB.PCI0.RP05.HPLG ()
            \_SB.PCI0.RP06.HPLG ()
            \_SB.PCI0.RP07.HPLG ()
            \_SB.PCI0.RP08.HPLG ()
        }

        Method (_L02, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Store (Zero, GPEC) /* \GPEC */
            Store (SSCI, Local0)
            If (Local0)
            {
                Store (Zero, SSCI) /* \SSCI */
                If (LEqual (Local0, One))
                {
                    VFN4 ()
                }

                If (LEqual (Local0, 0x04)) {}
                If (LEqual (Local0, 0x05)) {}
                If (LEqual (Local0, 0x03))
                {
                    VBRE (0x87)
                }

                If (LEqual (Local0, 0x02))
                {
                    VBRE (0x86)
                }
            }
        }

        Method (_L09, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            \_SB.PCI0.RP01.PME ()
            \_SB.PCI0.RP02.PME ()
            \_SB.PCI0.RP03.PME ()
            \_SB.PCI0.RP04.PME ()
            \_SB.PCI0.RP05.PME ()
            \_SB.PCI0.RP06.PME ()
            \_SB.PCI0.RP07.PME ()
            \_SB.PCI0.RP08.PME ()
        }

        Method (_L0B, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            Notify (\_SB.PCI0.PCIB, 0x02) // Device Wake
        }

        Method (_L0D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            If (\_SB.PCI0.EH01.PMES)
            {
                Store (One, \_SB.PCI0.EH01.PMES)
                Notify (\_SB.PCI0.EH01, 0x02) // Device Wake
            }

            If (\_SB.PCI0.EH02.PMES)
            {
                Store (One, \_SB.PCI0.EH02.PMES)
                Notify (\_SB.PCI0.EH02, 0x02) // Device Wake
            }

            If (\_SB.PCI0.HDEF.PMES)
            {
                Store (One, \_SB.PCI0.HDEF.PMES)
                Notify (\_SB.PCI0.HDEF, 0x02) // Device Wake
            }

            Notify (\_SB.PCI0.LANC, 0x02) // Device Wake
        }

        Method (_L13, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            And (GPIE, 0xFFFFFFFFFFFFFFF7, Local0)
            Store (Local0, GPIE) /* \GPIE */
            Or (GPL3, 0x10, Local0)
            Store (Local0, GPL3) /* \GPL3 */
            Sleep (0x03E8)
            Notify (\_SB.PCI0.SATA, 0x81) // Information Change
        }

        Method (_L1D, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
        {
            XOr (GIV, 0x2000, Local0)
            Store (Local0, GIV) /* \GIV_ */
            VDET ()
            Sleep (0x03E8)
            Notify (\_SB.PCI0.EH02, Zero) // Bus Check
            Notify (\_SB.PCI0.SATA, Zero) // Bus Check
            DKET ()
        }

        Method (HWWP, 1, Serialized)
        {
            If (LOr (LEqual (INQW, Zero), LEqual (Arg0, One)))
            {
                Store (Zero, Local0)
                If (And (GPL0, 0x00400000))
                {
                    Store (One, Local0)
                }

                \_SB.PCI0.LPCB.EC0.HWWP (Local0)
            }
        }
    }

    Scope (_PR)
    {
        Processor (CPU0, 0x00, 0x00000410, 0x06) {}
        Processor (CPU1, 0x01, 0x00000410, 0x06) {}
        Processor (CPU2, 0x02, 0x00000410, 0x06) {}
        Processor (CPU3, 0x03, 0x00000410, 0x06) {}
        Processor (CPU4, 0x04, 0x00000410, 0x06) {}
        Processor (CPU5, 0x05, 0x00000410, 0x06) {}
        Processor (CPU6, 0x06, 0x00000410, 0x06) {}
        Processor (CPU7, 0x07, 0x00000410, 0x06) {}
    }

    Name (NIST, Package (0x10)
    {
        "0", 
        "1", 
        "2", 
        "3", 
        "4", 
        "5", 
        "6", 
        "7", 
        "8", 
        "9", 
        "A", 
        "B", 
        "C", 
        "D", 
        "E", 
        "F"
    })
    Method (ISTR, 2, NotSerialized)
    {
        Store (Arg0, Local0)
        Store ("", Local7)
        Store (Arg1, Local4)
        While (LGreater (Local4, Zero))
        {
            And (Local0, 0x0F, Local1)
            Store (DerefOf (Index (NIST, Local1)), Local2)
            Concatenate (Local2, Local7, Local3)
            Store (Local3, Local7)
            ShiftRight (Local0, 0x04, Local0)
            Decrement (Local4)
        }

        Return (Local7)
    }

    Method (SRCP, 2, NotSerialized)
    {
        Store (SizeOf (Arg0), Local7)
        If (LNotEqual (Local7, SizeOf (Arg1)))
        {
            Return (Zero)
        }

        Name (ST00, Buffer (Local7) {})
        Name (ST01, Buffer (Local7) {})
        Store (Arg0, ST00) /* \SRCP.ST00 */
        Store (Arg1, ST01) /* \SRCP.ST01 */
        Store (Zero, Local6)
        Store (One, Local0)
        While (LAnd (LNotEqual (Local6, Local7), Local0))
        {
            Store (DerefOf (Index (ST00, Local6)), Local2)
            Store (DerefOf (Index (ST01, Local6)), Local3)
            Increment (Local6)
            If (LNotEqual (Local2, Local3))
            {
                Store (Zero, Local0)
            }
        }

        Return (Local0)
    }

    Name (WOSI, 0xFF)
    Name (OSID, Package (0x03)
    {
        "Microsoft Windows", 
        "Microsoft WindowsME: Millennium Edition", 
        "Microsoft Windows NT"
    })
    Method (SRCM, 3, NotSerialized)
    {
        Name (ST00, Buffer (0x8C) {})
        Name (ST01, Buffer (0x8C) {})
        Store (Arg0, ST00) /* \SRCM.ST00 */
        Store (Arg1, ST01) /* \SRCM.ST01 */
        Store (Zero, Local6)
        Store (One, Local0)
        While (LAnd (LNotEqual (Local6, Arg2), Local0))
        {
            Store (DerefOf (Index (ST00, Local6)), Local2)
            Store (DerefOf (Index (ST01, Local6)), Local3)
            Increment (Local6)
            If (LNotEqual (Local2, Local3))
            {
                Store (Zero, Local0)
            }
        }

        Return (Local0)
    }

    Method (WCOS, 0, Serialized)
    {
        Store (0x06, WOSI) /* \WOSI */
        Store (WOSI, WHOS) /* \WHOS */
        Return (WOSI) /* \WOSI */
    }

    Method (UPRW, 2, Serialized)
    {
        Store (Package (0x02)
            {
                Zero, 
                Zero
            }, Local0)
        Store (Arg0, Index (Local0, Zero))
        If (LEqual (UWKD, Zero))
        {
            Store (Arg1, Index (Local0, One))
        }

        Return (Local0)
    }

    Name (EUPC, Package (0x04)
    {
        0xFF, 
        0xFF, 
        Zero, 
        Zero
    })
    Name (EPLD, Buffer (0x10)
    {
        /* 0000 */   0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        /* 0008 */   0x30, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
    })
    Method (CBRT, 2, Serialized)
    {
        Store (SizeOf (Arg0), Local6)
        Store (SizeOf (Arg1), Local7)
        If (LEqual (Local6, Zero))
        {
            Store (Arg1, Local0)
            Return (Local0)
        }

        If (LEqual (Local7, Zero))
        {
            Store (Arg0, Local0)
            Return (Local0)
        }

        Add (Local7, Local6, Local1)
        Subtract (Local1, 0x02, Local1)
        Store (Buffer (Local1) {}, Local0)
        Store (Zero, Local1)
        While (LLess (Local1, SizeOf (Arg0)))
        {
            Store (DerefOf (Index (Arg0, Local1)), Index (Local0, Local1))
            Increment (Local1)
        }

        Subtract (Local1, 0x02, Local1)
        Store (Zero, Local2)
        While (LLess (Local2, SizeOf (Arg1)))
        {
            Store (DerefOf (Index (Arg1, Local2)), Index (Local0, Local1))
            Increment (Local1)
            Increment (Local2)
        }

        Return (Local0)
    }

    Scope (_SB)
    {
        Mutex (MSMI, 0x00)
        Method (SSMI, 5, NotSerialized)
        {
            Acquire (MSMI, 0xFFFF)
            If (Arg4)
            {
                Acquire (_GL, 0xFFFF)
            }

            ShiftLeft (Arg0, 0x10, EAX) /* \EAX_ */
            Store (Arg1, EBX) /* \EBX_ */
            Store (Arg2, ECX) /* \ECX_ */
            Store (Arg3, EDX) /* \EDX_ */
            Store (Zero, REFS) /* \REFS */
            ^PCI0.GSWS (Arg0)
            Store (REFS, Local0)
            If (Arg4)
            {
                Release (_GL)
            }

            Release (MSMI)
            Return (Local0)
        }

        Name (BCLI, Zero)
        Name (BCLS, Package (0x03)
        {
            Package (0x0D) {}, 
            Package (0x17) {}, 
            Package (0x1B) {}
        })
        Name (NITS, Package (0x03)
        {
            Buffer (0x16) {}, 
            Buffer (0x2A) {}, 
            Buffer (0x32) {}
        })
        Name (BCLC, Zero)
        Method (BCL, 0, Serialized)
        {
            If (LEqual (BCLC, Zero))
            {
                If (LGreater (WCOS (), 0x06))
                {
                    Store (BCCT, BRCT) /* \BRCT */
                }

                Store (Zero, Local7)
                If (LGreaterEqual (BRCT, 0x15))
                {
                    Store (One, BCLI) /* \_SB_.BCLI */
                    Store (One, Local7)
                    If (LEqual (BRCT, 0x19))
                    {
                        Store (0x02, BCLI) /* \_SB_.BCLI */
                    }
                }

                Store (Zero, Local1)
                If (And (DCAP, 0x10))
                {
                    Store (BRLV, Local0)
                    Store (Zero, Local5)
                    Store (BMAP, Local4)
                    While (LLess (Local1, BRCT))
                    {
                        If (Local7)
                        {
                            Store (Local1, Local3)
                        }
                        Else
                        {
                            Store (DerefOf (Index (Local4, Local1)), Local3)
                        }

                        Store (DerefOf (Index (Local0, Local3)), Local2)
                        Multiply (Local2, 0x64, Local3)
                        Divide (Add (Local3, 0x7F), 0xFF, Local6, Local2)
                        Store (Local2, Index (DerefOf (Index (BCLS, BCLI)), Add (Local1, 
                            0x02)))
                        If (LGreater (Local2, Local5))
                        {
                            Store (Local2, Local5)
                        }

                        Increment (Local1)
                    }

                    ShiftRight (BRCT, One, Local3)
                    Store (DerefOf (Index (DerefOf (Index (BCLS, BCLI)), Local3)), 
                        Index (DerefOf (Index (BCLS, BCLI)), One))
                    Store (Local5, Index (DerefOf (Index (BCLS, BCLI)), Zero))
                }
                Else
                {
                    Store (BCLV, Local4)
                    Store (BMAP, Local0)
                    While (LLess (Local1, Add (BRCT, 0x02)))
                    {
                        If (LOr (Local7, LLess (Local1, 0x02)))
                        {
                            Store (Local1, Local3)
                        }
                        Else
                        {
                            Store (DerefOf (Index (Local0, Subtract (Local1, 0x02))), Local3)
                            Add (Local3, 0x02, Local3)
                        }

                        Store (DerefOf (Index (Local4, Local3)), Local2)
                        Store (Local2, Index (DerefOf (Index (BCLS, BCLI)), Local1))
                        Increment (Local1)
                    }
                }

                Store (BRNT, Local0)
                Store (BMAP, Local1)
                Store (Zero, Local2)
                While (LLess (Local2, BRCT))
                {
                    If (Local7)
                    {
                        Store (Local2, Local3)
                    }
                    Else
                    {
                        Store (DerefOf (Index (Local1, Local2)), Local3)
                    }

                    ShiftLeft (Local3, One, Local3)
                    ShiftLeft (Local2, One, Local5)
                    Store (DerefOf (Index (Local0, Local3)), Local4)
                    Store (Local4, Index (DerefOf (Index (NITS, BCLI)), Local5))
                    Store (DerefOf (Index (Local0, Add (Local3, One))), Local4)
                    Store (Local4, Index (DerefOf (Index (NITS, BCLI)), Add (Local5, 
                        One)))
                    Increment (Local2)
                }

                Store (One, BCLC) /* \_SB_.BCLC */
            }

            Return (DerefOf (Index (BCLS, BCLI)))
        }

        Name (BRIG, 0x64)
        Method (BCM, 1, Serialized)
        {
            Store (Zero, Local0)
            If (LGreater (WCOS (), 0x05))
            {
                Or (WDPE, 0x40, WDPE) /* \WDPE */
                Store (One, Local0)
            }

            Store (Arg0, BRIG) /* \_SB_.BRIG */
            Store (Match (DerefOf (Index (BCLS, BCLI)), MGE, Arg0, MTR, 
                Zero, 0x02), Local1)
            If (LEqual (Local1, Ones))
            {
                Subtract (SizeOf (DerefOf (Index (BCLS, BCLI))), One, Local1)
            }

            Subtract (Local1, 0x02, Local1)
            If (Local0)
            {
                Store (Local1, BRID) /* \BRID */
            }

            Return (Local0)
        }

        Method (BQC, 0, Serialized)
        {
            Store (BRIG, Local0)
            Return (Local0)
        }

        Method (HDDC, 1, Serialized)
        {
            If (LEqual (Arg0, 0x02))
            {
                Store (EDID, Local1)
            }
            Else
            {
                Store (EDID, Local3)
                Store (0x80, Local0)
                Store (Buffer (Local0) {}, Local1)
                Store (Zero, Local2)
                While (LLess (Local2, Local0))
                {
                    Store (DerefOf (Index (Local3, Local2)), Index (Local1, Local2))
                    Increment (Local2)
                }
            }

            Return (Local1)
        }

        Method (SBRC, 0, Serialized)
        {
            Store (BRID, Local0)
            Subtract (BRCT, One, Local4)
            If (LGreater (BRID, Local4))
            {
                Store (Local4, Local0)
            }

            If (LLess (BRID, Zero))
            {
                Store (Zero, Local0)
            }

            Store (BRLV, Local2)
            Store (BMAP, Local5)
            If (LEqual (BRCT, 0x0B))
            {
                Store (DerefOf (Index (Local5, Local0)), Local0)
            }

            Store (DerefOf (Index (Local2, Local0)), Local1)
            Store (Local1, Debug)
            Return (Local1)
        }
    }

    Scope (_SB)
    {
        Device (PCI0)
        {
            Name (_HPP, Package (0x04)  // _HPP: Hot Plug Parameters
            {
                0x10, 
                0x40, 
                Zero, 
                Zero
            })
            Method (_S3D, 0, NotSerialized)  // _S3D: S3 Device State
            {
                Return (0x02)
            }

            Method (_S4D, 0, NotSerialized)  // _S4D: S4 Device State
            {
                Return (0x02)
            }

            Name (_HID, EisaId ("PNP0A08"))  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0A03"))  // _CID: Compatible ID
            Name (_ADR, Zero)  // _ADR: Address
            OperationRegion (HBUS, PCI_Config, Zero, 0x0100)
            Field (HBUS, DWordAcc, NoLock, Preserve)
            {
                Offset (0x40), 
                EPEN,   1, 
                    ,   11, 
                EPBR,   20, 
                Offset (0x48), 
                MHEN,   1, 
                    ,   14, 
                MHBR,   17, 
                Offset (0x50), 
                GCLK,   1, 
                Offset (0x54), 
                D0EN,   1, 
                Offset (0x60), 
                PXEN,   1, 
                PXSZ,   2, 
                    ,   23, 
                PXBR,   6, 
                Offset (0x68), 
                DIEN,   1, 
                    ,   11, 
                DIBR,   20, 
                Offset (0x70), 
                    ,   20, 
                MEBR,   12, 
                Offset (0x80), 
                    ,   4, 
                PM0H,   2, 
                Offset (0x81), 
                PM1L,   2, 
                    ,   2, 
                PM1H,   2, 
                Offset (0x82), 
                PM2L,   2, 
                    ,   2, 
                PM2H,   2, 
                Offset (0x83), 
                PM3L,   2, 
                    ,   2, 
                PM3H,   2, 
                Offset (0x84), 
                PM4L,   2, 
                    ,   2, 
                PM4H,   2, 
                Offset (0x85), 
                PM5L,   2, 
                    ,   2, 
                PM5H,   2, 
                Offset (0x86), 
                PM6L,   2, 
                    ,   2, 
                PM6H,   2, 
                Offset (0x87), 
                Offset (0xA8), 
                    ,   20, 
                TUUD,   19, 
                Offset (0xBC), 
                    ,   20, 
                TLUD,   12, 
                Offset (0xC8), 
                    ,   7, 
                HTSE,   1
            }

            OperationRegion (MCHT, SystemMemory, 0xFED10000, 0x1100)
            Field (MCHT, ByteAcc, NoLock, Preserve)
            {
            }

            Name (BUF0, ResourceTemplate ()
            {
                WordBusNumber (ResourceProducer, MinFixed, MaxFixed, PosDecode,
                    0x0000,             // Granularity
                    0x0000,             // Range Minimum
                    0x00FF,             // Range Maximum
                    0x0000,             // Translation Offset
                    0x0100,             // Length
                    ,, _Y00)
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000CF7,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000CF8,         // Length
                    ,, , TypeStatic)
                IO (Decode16,
                    0x0CF8,             // Range Minimum
                    0x0CF8,             // Range Maximum
                    0x01,               // Alignment
                    0x08,               // Length
                    )
                DWordIO (ResourceProducer, MinFixed, MaxFixed, PosDecode, EntireRange,
                    0x00000000,         // Granularity
                    0x00000D00,         // Range Minimum
                    0x0000FFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x0000F300,         // Length
                    ,, , TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000A0000,         // Range Minimum
                    0x000BFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00020000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C0000,         // Range Minimum
                    0x000C3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y01, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C4000,         // Range Minimum
                    0x000C7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y02, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000C8000,         // Range Minimum
                    0x000CBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y03, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000CC000,         // Range Minimum
                    0x000CFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y04, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D0000,         // Range Minimum
                    0x000D3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y05, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D4000,         // Range Minimum
                    0x000D7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y06, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000D8000,         // Range Minimum
                    0x000DBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y07, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000DC000,         // Range Minimum
                    0x000DFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y08, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E0000,         // Range Minimum
                    0x000E3FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y09, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E4000,         // Range Minimum
                    0x000E7FFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0A, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000E8000,         // Range Minimum
                    0x000EBFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0B, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000EC000,         // Range Minimum
                    0x000EFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00004000,         // Length
                    ,, _Y0C, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x000F0000,         // Range Minimum
                    0x000FFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00010000,         // Length
                    ,, _Y0D, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0x00000000,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x00000001,         // Length
                    ,, _Y0E, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0x00000000,         // Range Minimum
                    0xFEDFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0xFEE00000,         // Length
                    ,, _Y0F, AddressRangeMemory, TypeStatic)
                DWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
                    0x00000000,         // Granularity
                    0xFEE01000,         // Range Minimum
                    0xFFFFFFFF,         // Range Maximum
                    0x00000000,         // Translation Offset
                    0x011FF000,         // Length
                    ,, , AddressRangeMemory, TypeStatic)
            })
            Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
            {
                CreateWordField (BUF0, \_SB.PCI0._Y00._MAX, PBMX)  // _MAX: Maximum Base Address
                Store (0x3E, PBMX) /* \_SB_.PCI0._CRS.PBMX */
                CreateWordField (BUF0, \_SB.PCI0._Y00._LEN, PBLN)  // _LEN: Length
                Store (0x3F, PBLN) /* \_SB_.PCI0._CRS.PBLN */
                If (PM1L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y01._LEN, C0LN)  // _LEN: Length
                    Store (Zero, C0LN) /* \_SB_.PCI0._CRS.C0LN */
                }

                If (LEqual (PM1L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y01._RW, C0RW)  // _RW_: Read-Write Status
                    Store (Zero, C0RW) /* \_SB_.PCI0._CRS.C0RW */
                }

                If (PM1H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y02._LEN, C4LN)  // _LEN: Length
                    Store (Zero, C4LN) /* \_SB_.PCI0._CRS.C4LN */
                }

                If (LEqual (PM1H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y02._RW, C4RW)  // _RW_: Read-Write Status
                    Store (Zero, C4RW) /* \_SB_.PCI0._CRS.C4RW */
                }

                If (PM2L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y03._LEN, C8LN)  // _LEN: Length
                    Store (Zero, C8LN) /* \_SB_.PCI0._CRS.C8LN */
                }

                If (LEqual (PM2L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y03._RW, C8RW)  // _RW_: Read-Write Status
                    Store (Zero, C8RW) /* \_SB_.PCI0._CRS.C8RW */
                }

                If (PM2H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y04._LEN, CCLN)  // _LEN: Length
                    Store (Zero, CCLN) /* \_SB_.PCI0._CRS.CCLN */
                }

                If (LEqual (PM2H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y04._RW, CCRW)  // _RW_: Read-Write Status
                    Store (Zero, CCRW) /* \_SB_.PCI0._CRS.CCRW */
                }

                If (PM3L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y05._LEN, D0LN)  // _LEN: Length
                    Store (Zero, D0LN) /* \_SB_.PCI0._CRS.D0LN */
                }

                If (LEqual (PM3L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y05._RW, D0RW)  // _RW_: Read-Write Status
                    Store (Zero, D0RW) /* \_SB_.PCI0._CRS.D0RW */
                }

                If (PM3H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y06._LEN, D4LN)  // _LEN: Length
                    Store (Zero, D4LN) /* \_SB_.PCI0._CRS.D4LN */
                }

                If (LEqual (PM3H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y06._RW, D4RW)  // _RW_: Read-Write Status
                    Store (Zero, D4RW) /* \_SB_.PCI0._CRS.D4RW */
                }

                If (PM4L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y07._LEN, D8LN)  // _LEN: Length
                    Store (Zero, D8LN) /* \_SB_.PCI0._CRS.D8LN */
                }

                If (LEqual (PM4L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y07._RW, D8RW)  // _RW_: Read-Write Status
                    Store (Zero, D8RW) /* \_SB_.PCI0._CRS.D8RW */
                }

                If (PM4H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y08._LEN, DCLN)  // _LEN: Length
                    Store (Zero, DCLN) /* \_SB_.PCI0._CRS.DCLN */
                }

                If (LEqual (PM4H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y08._RW, DCRW)  // _RW_: Read-Write Status
                    Store (Zero, DCRW) /* \_SB_.PCI0._CRS.DCRW */
                }

                If (PM5L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y09._LEN, E0LN)  // _LEN: Length
                    Store (Zero, E0LN) /* \_SB_.PCI0._CRS.E0LN */
                }

                If (LEqual (PM5L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y09._RW, E0RW)  // _RW_: Read-Write Status
                    Store (Zero, E0RW) /* \_SB_.PCI0._CRS.E0RW */
                }

                If (PM5H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0A._LEN, E4LN)  // _LEN: Length
                    Store (Zero, E4LN) /* \_SB_.PCI0._CRS.E4LN */
                }

                If (LEqual (PM5H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0A._RW, E4RW)  // _RW_: Read-Write Status
                    Store (Zero, E4RW) /* \_SB_.PCI0._CRS.E4RW */
                }

                If (PM6L)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0B._LEN, E8LN)  // _LEN: Length
                    Store (Zero, E8LN) /* \_SB_.PCI0._CRS.E8LN */
                }

                If (LEqual (PM6L, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0B._RW, E8RW)  // _RW_: Read-Write Status
                    Store (Zero, E8RW) /* \_SB_.PCI0._CRS.E8RW */
                }

                If (PM6H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0C._LEN, ECLN)  // _LEN: Length
                    Store (Zero, ECLN) /* \_SB_.PCI0._CRS.ECLN */
                }

                If (LEqual (PM6H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0C._RW, ECRW)  // _RW_: Read-Write Status
                    Store (Zero, ECRW) /* \_SB_.PCI0._CRS.ECRW */
                }

                If (PM0H)
                {
                    CreateDWordField (BUF0, \_SB.PCI0._Y0D._LEN, F0LN)  // _LEN: Length
                    Store (Zero, F0LN) /* \_SB_.PCI0._CRS.F0LN */
                }

                If (LEqual (PM0H, One))
                {
                    CreateBitField (BUF0, \_SB.PCI0._Y0D._RW, F0RW)  // _RW_: Read-Write Status
                    Store (Zero, F0RW) /* \_SB_.PCI0._CRS.F0RW */
                }

                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MIN, M1MN)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._MAX, M1MX)  // _MAX: Maximum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0E._LEN, M1LN)  // _LEN: Length
                ShiftLeft (TLUD, 0x14, M1MN) /* \_SB_.PCI0._CRS.M1MN */
                ShiftLeft (PXBR, 0x1A, Local0)
                Subtract (Local0, One, M1MX) /* \_SB_.PCI0._CRS.M1MX */
                Add (Subtract (M1MX, M1MN), One, M1LN) /* \_SB_.PCI0._CRS.M1LN */
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MIN, M2MN)  // _MIN: Minimum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._MAX, M2MX)  // _MAX: Maximum Base Address
                CreateDWordField (BUF0, \_SB.PCI0._Y0F._LEN, M2LN)  // _LEN: Length
                ShiftRight (0x10000000, PXSZ, Local1)
                Add (Local0, Local1, M2MN) /* \_SB_.PCI0._CRS.M2MN */
                Add (Subtract (M2MX, M2MN), One, M2LN) /* \_SB_.PCI0._CRS.M2LN */
                Return (BUF0) /* \_SB_.PCI0.BUF0 */
            }

            Device (PDRC)
            {
                Name (_HID, EisaId ("PNP0C02"))  // _HID: Hardware ID
                Name (_UID, One)  // _UID: Unique ID
                Name (BUF0, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00004000,         // Address Length
                        _Y10)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00008000,         // Address Length
                        _Y11)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y12)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00001000,         // Address Length
                        _Y14)
                    Memory32Fixed (ReadWrite,
                        0x00000000,         // Address Base
                        0x00000000,         // Address Length
                        _Y13)
                    Memory32Fixed (ReadWrite,
                        0xFED20000,         // Address Base
                        0x00020000,         // Address Length
                        )
                    Memory32Fixed (ReadOnly,
                        0xFED90000,         // Address Base
                        0x00004000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFED45000,         // Address Base
                        0x0004B000,         // Address Length
                        )
                    Memory32Fixed (ReadWrite,
                        0xFEC00000,         // Address Base
                        0x00001000,         // Address Length
                        )
                })
                Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                {
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y10._BAS, RBR0)  // _BAS: Base Address
                    ShiftLeft (^^LPCB.RCBA, 0x0E, RBR0) /* \_SB_.PCI0.PDRC._CRS.RBR0 */
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y11._BAS, MBR0)  // _BAS: Base Address
                    ShiftLeft (MHBR, 0x0F, MBR0) /* \_SB_.PCI0.PDRC._CRS.MBR0 */
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y12._BAS, DBR0)  // _BAS: Base Address
                    ShiftLeft (DIBR, 0x0C, DBR0) /* \_SB_.PCI0.PDRC._CRS.DBR0 */
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._BAS, XBR0)  // _BAS: Base Address
                    ShiftLeft (PXBR, 0x1A, XBR0) /* \_SB_.PCI0.PDRC._CRS.XBR0 */
                    CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y13._LEN, XSZ0)  // _LEN: Length
                    ShiftRight (0x10000000, PXSZ, XSZ0) /* \_SB_.PCI0.PDRC._CRS.XSZ0 */
                    If (TBRB)
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._BAS, TBR0)  // _BAS: Base Address
                        Store (TBRB, TBR0) /* \_SB_.PCI0.PDRC._CRS.TBR0 */
                    }
                    Else
                    {
                        CreateDWordField (BUF0, \_SB.PCI0.PDRC._Y14._LEN, TBLN)  // _LEN: Length
                        Store (Zero, TBLN) /* \_SB_.PCI0.PDRC._CRS.TBLN */
                    }

                    Return (BUF0) /* \_SB_.PCI0.PDRC.BUF0 */
                }
            }

            Device (PEGP)
            {
                Name (_ADR, 0x00010000)  // _ADR: Address
                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (IGPU)
            {
                Name (_ADR, 0x00020000)  // _ADR: Address
                Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                {
                    Store (And (Arg0, 0x07), DSEN) /* \DSEN */
                    HDOS (Arg0)
                }

                Method (_DOD, 0, NotSerialized)  // _DOD: Display Output Devices
                {
                    If (LEqual (DODC, Zero))
                    {
                        Store (One, DODC) /* \_SB_.PCI0.IGPU.DODC */
                        If (SCIP ())
                        {
                            HDOD ()
                            Store (Zero, NDID) /* \NDID */
                            If (CondRefOf (IDAB)) {}
                            Else
                            {
                                If (LNotEqual (DIDL, Zero))
                                {
                                    Store (SDDL (DIDL), DID1) /* \DID1 */
                                }

                                If (LNotEqual (DDL2, Zero))
                                {
                                    Store (SDDL (DDL2), DID2) /* \DID2 */
                                }

                                If (LNotEqual (DDL3, Zero))
                                {
                                    Store (SDDL (DDL3), DID3) /* \DID3 */
                                }

                                If (LNotEqual (DDL4, Zero))
                                {
                                    Store (SDDL (DDL4), DID4) /* \DID4 */
                                }

                                If (LNotEqual (DDL5, Zero))
                                {
                                    Store (SDDL (DDL5), DID5) /* \DID5 */
                                }

                                If (LNotEqual (DDL6, Zero))
                                {
                                    Store (SDDL (DDL6), DID6) /* \DID6 */
                                }

                                If (LNotEqual (DDL7, Zero))
                                {
                                    Store (SDDL (DDL7), DID7) /* \DID7 */
                                }

                                If (LNotEqual (DDL8, Zero))
                                {
                                    Store (SDDL (DDL8), DID8) /* \DID8 */
                                }
                            }
                        }

                        If (LEqual (NDID, Zero))
                        {
                            Store (0x0400, Index (DerefOf (Index (DODS, NDID)), Zero))
                        }

                        If (LEqual (NDID, One))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                        }

                        If (LEqual (NDID, 0x02))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                        }

                        If (LEqual (NDID, 0x03))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                        }

                        If (LEqual (NDID, 0x04))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                            Store (Or (0x00010000, DID4), Index (DerefOf (Index (DODS, NDID
                                )), 0x03))
                        }

                        If (LEqual (NDID, 0x05))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                            Store (Or (0x00010000, DID4), Index (DerefOf (Index (DODS, NDID
                                )), 0x03))
                            Store (Or (0x00010000, DID5), Index (DerefOf (Index (DODS, NDID
                                )), 0x04))
                        }

                        If (LEqual (NDID, 0x06))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                            Store (Or (0x00010000, DID4), Index (DerefOf (Index (DODS, NDID
                                )), 0x03))
                            Store (Or (0x00010000, DID5), Index (DerefOf (Index (DODS, NDID
                                )), 0x04))
                            Store (Or (0x00010000, DID6), Index (DerefOf (Index (DODS, NDID
                                )), 0x05))
                        }

                        If (LEqual (NDID, 0x07))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                            Store (Or (0x00010000, DID4), Index (DerefOf (Index (DODS, NDID
                                )), 0x03))
                            Store (Or (0x00010000, DID5), Index (DerefOf (Index (DODS, NDID
                                )), 0x04))
                            Store (Or (0x00010000, DID6), Index (DerefOf (Index (DODS, NDID
                                )), 0x05))
                            Store (Or (0x00010000, DID7), Index (DerefOf (Index (DODS, NDID
                                )), 0x06))
                        }

                        If (LEqual (NDID, 0x08))
                        {
                            Store (Or (0x00010000, DID1), Index (DerefOf (Index (DODS, NDID
                                )), Zero))
                            Store (Or (0x00010000, DID2), Index (DerefOf (Index (DODS, NDID
                                )), One))
                            Store (Or (0x00010000, DID3), Index (DerefOf (Index (DODS, NDID
                                )), 0x02))
                            Store (Or (0x00010000, DID4), Index (DerefOf (Index (DODS, NDID
                                )), 0x03))
                            Store (Or (0x00010000, DID5), Index (DerefOf (Index (DODS, NDID
                                )), 0x04))
                            Store (Or (0x00010000, DID6), Index (DerefOf (Index (DODS, NDID
                                )), 0x05))
                            Store (Or (0x00010000, DID7), Index (DerefOf (Index (DODS, NDID
                                )), 0x06))
                            Store (Or (0x00010000, DID8), Index (DerefOf (Index (DODS, NDID
                                )), 0x07))
                        }
                    }

                    Store (NDID, Local0)
                    If (LGreater (NDID, 0x08))
                    {
                        Store (Zero, Local0)
                    }

                    Return (DerefOf (Index (DODS, Local0)))
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (LEqual (INIM, One))
                    {
                        SSMI (0xEA81, Zero, Zero, Zero, Zero)
                        GLID (^^^LID._LID ())
                        Store (Zero, INIM) /* \_SB_.PCI0.IGPU.INIM */
                    }
                }

                Device (DD01)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID1, Zero))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID1))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        Return (CDDS (DID1))
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD1) /* \NXD1 */
                        }

                        Return (NDDS (DID1))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD02)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID2, Zero))
                        {
                            Return (0x02)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID2))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (LIDS, Zero))
                        {
                            Return (Zero)
                        }

                        Return (CDDS (DID2))
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD2) /* \NXD2 */
                        }

                        Return (NDDS (DID2))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD03)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID3, Zero))
                        {
                            Return (0x03)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID3))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID3, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID3))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD3) /* \NXD3 */
                        }

                        Return (NDDS (DID3))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD04)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID4, Zero))
                        {
                            Return (0x04)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID4))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID4, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID4))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD4) /* \NXD4 */
                        }

                        Return (NDDS (DID4))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD05)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID5, Zero))
                        {
                            Return (0x05)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID5))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID5, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID5))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD5) /* \NXD5 */
                        }

                        Return (NDDS (DID5))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD06)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID6, Zero))
                        {
                            Return (0x06)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID6))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID6, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID6))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD6) /* \NXD6 */
                        }

                        Return (NDDS (DID6))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD07)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID7, Zero))
                        {
                            Return (0x07)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID7))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID7, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID7))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD7) /* \NXD7 */
                        }

                        Return (NDDS (DID7))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Device (DD08)
                {
                    Method (_ADR, 0, Serialized)  // _ADR: Address
                    {
                        If (LEqual (DID8, Zero))
                        {
                            Return (0x08)
                        }
                        Else
                        {
                            Return (And (0xFFFF, DID8))
                        }
                    }

                    Method (_DCS, 0, NotSerialized)  // _DCS: Display Current Status
                    {
                        If (LEqual (DID8, Zero))
                        {
                            Return (0x0B)
                        }
                        Else
                        {
                            Return (CDDS (DID8))
                        }
                    }

                    Method (_DGS, 0, NotSerialized)  // _DGS: Display Graphics State
                    {
                        If (CondRefOf (SNXD))
                        {
                            Return (NXD8) /* \NXD8 */
                        }

                        Return (NDDS (DID8))
                    }

                    Method (_DSS, 1, NotSerialized)  // _DSS: Device Set State
                    {
                        If (LEqual (And (Arg0, 0xC0000000), 0xC0000000))
                        {
                            Store (NSTE, CSTE) /* \CSTE */
                        }
                    }
                }

                Method (SDDL, 1, NotSerialized)
                {
                    Increment (NDID)
                    Store (And (Arg0, 0x0F0F), Local0)
                    Or (0x80000000, Local0, Local1)
                    If (LEqual (DIDL, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL2, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL3, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL4, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL5, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL6, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL7, Local0))
                    {
                        Return (Local1)
                    }

                    If (LEqual (DDL8, Local0))
                    {
                        Return (Local1)
                    }

                    Return (Zero)
                }

                Method (CDDS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x0F0F), Local0)
                    If (LEqual (Zero, Local0))
                    {
                        Return (0x1D)
                    }

                    If (LEqual (CADL, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL2, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL3, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL4, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL5, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL6, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL7, Local0))
                    {
                        Return (0x1F)
                    }

                    If (LEqual (CAL8, Local0))
                    {
                        Return (0x1F)
                    }

                    Return (0x1D)
                }

                Method (NDDS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x0F0F), Local0)
                    If (LEqual (Zero, Local0))
                    {
                        Return (Zero)
                    }

                    If (LEqual (NADL, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL2, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL3, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL4, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL5, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL6, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL7, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (NDL8, Local0))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Scope (^^PCI0)
                {
                    OperationRegion (MCHP, PCI_Config, 0x40, 0xC0)
                    Field (MCHP, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x60), 
                        TASM,   10, 
                        Offset (0x62)
                    }
                }

                OperationRegion (IGDP, PCI_Config, 0x40, 0xC0)
                Field (IGDP, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x12), 
                        ,   1, 
                    GIVD,   1, 
                        ,   2, 
                    GUMA,   3, 
                    Offset (0x14), 
                        ,   4, 
                    GMFN,   1, 
                    Offset (0x18), 
                    Offset (0xA4), 
                    ASLE,   8, 
                    Offset (0xA8), 
                    GSSE,   1, 
                    GSSB,   14, 
                    GSES,   1, 
                    Offset (0xB0), 
                        ,   12, 
                    CDVL,   1, 
                    Offset (0xB2), 
                    Offset (0xB5), 
                    LBPC,   8, 
                    Offset (0xBC), 
                    ASLS,   32
                }

                OperationRegion (IGDM, SystemMemory, ASLB, 0x2000)
                Field (IGDM, AnyAcc, NoLock, Preserve)
                {
                    SIGN,   128, 
                    SIZE,   32, 
                    OVER,   32, 
                    SVER,   256, 
                    VVER,   128, 
                    GVER,   128, 
                    MBOX,   32, 
                    DMOD,   32, 
                    Offset (0x100), 
                    DRDY,   32, 
                    CSTS,   32, 
                    CEVT,   32, 
                    Offset (0x120), 
                    DIDL,   32, 
                    DDL2,   32, 
                    DDL3,   32, 
                    DDL4,   32, 
                    DDL5,   32, 
                    DDL6,   32, 
                    DDL7,   32, 
                    DDL8,   32, 
                    CPDL,   32, 
                    CPL2,   32, 
                    CPL3,   32, 
                    CPL4,   32, 
                    CPL5,   32, 
                    CPL6,   32, 
                    CPL7,   32, 
                    CPL8,   32, 
                    CADL,   32, 
                    CAL2,   32, 
                    CAL3,   32, 
                    CAL4,   32, 
                    CAL5,   32, 
                    CAL6,   32, 
                    CAL7,   32, 
                    CAL8,   32, 
                    NADL,   32, 
                    NDL2,   32, 
                    NDL3,   32, 
                    NDL4,   32, 
                    NDL5,   32, 
                    NDL6,   32, 
                    NDL7,   32, 
                    NDL8,   32, 
                    ASLP,   32, 
                    TIDX,   32, 
                    CHPD,   32, 
                    CLID,   32, 
                    CDCK,   32, 
                    SXSW,   32, 
                    EVTS,   32, 
                    CNOT,   32, 
                    NRDY,   32, 
                    Offset (0x200), 
                    SCIE,   1, 
                    GEFC,   4, 
                    GXFC,   3, 
                    GESF,   8, 
                    Offset (0x204), 
                    PARM,   32, 
                    DSLP,   32, 
                    Offset (0x300), 
                    ARDY,   32, 
                    ASLC,   32, 
                    TCHE,   32, 
                    ALSI,   32, 
                    BCLP,   32, 
                    PFIT,   32, 
                    CBLV,   32, 
                    BCLM,   320, 
                    CPFM,   32, 
                    EPFM,   32, 
                    PLUT,   592, 
                    PFMB,   32, 
                    CCDV,   32, 
                    PCFT,   32, 
                    Offset (0x400), 
                    GVD1,   49152, 
                    PHED,   32, 
                    BDDC,   2048
                }

                Name (DBTB, Package (0x15)
                {
                    Zero, 
                    0x07, 
                    0x38, 
                    0x01C0, 
                    0x0E00, 
                    0x3F, 
                    0x01C7, 
                    0x0E07, 
                    0x01F8, 
                    0x0E38, 
                    0x0FC0, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero, 
                    0x7000, 
                    0x7007, 
                    0x7038, 
                    0x71C0, 
                    0x7E00
                })
                Name (CDCT, Package (0x05)
                {
                    Package (0x02)
                    {
                        0xE4, 
                        0x0140
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }, 

                    Package (0x02)
                    {
                        Zero, 
                        Zero
                    }, 

                    Package (0x02)
                    {
                        0xDE, 
                        0x014D
                    }
                })
                Name (SUCC, One)
                Name (NVLD, 0x02)
                Name (CRIT, 0x04)
                Name (NCRT, 0x06)
                Method (GSCI, 0, Serialized)
                {
                    Method (GBDA, 0, Serialized)
                    {
                        If (LEqual (GESF, Zero))
                        {
                            Store (0x59, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, One))
                        {
                            Store (0x80, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, 0x04))
                        {
                            Store (0x30000000, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, 0x05))
                        {
                            Or (PARM, ShiftLeft (LIDS, 0x10), PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Add (PARM, 0x00010000, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, 0x06))
                        {
                            Store (Zero, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (Zero)
                        }

                        If (LEqual (GESF, 0x07))
                        {
                            Store (GIVD, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            XOr (PARM, One, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Or (PARM, ShiftLeft (GMFN, One), PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Or (PARM, 0x1800, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Or (PARM, ShiftLeft (IDMS, 0x11), PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Or (ShiftLeft (DerefOf (Index (DerefOf (Index (CDCT, HVCO)), CDVL
                                )), 0x15), PARM, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (One, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, 0x0A))
                        {
                            Store (Zero, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (Zero)
                        }

                        Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                        Return (CRIT) /* \_SB_.PCI0.IGPU.CRIT */
                    }

                    Method (SBCB, 0, Serialized)
                    {
                        If (LEqual (GESF, Zero))
                        {
                            Store (Zero, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (0x000F87FD, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (0x40, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        If (LEqual (GESF, 0x07))
                        {
                            If (LEqual (PARM, Zero))
                            {
                                Store (CLID, Local0)
                                If (And (0x80000000, Local0))
                                {
                                    And (CLID, 0x0F, CLID) /* \_SB_.PCI0.IGPU.CLID */
                                    GLID (CLID)
                                }
                            }

                            Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                            Store (Zero, PARM) /* \_SB_.PCI0.IGPU.PARM */
                            Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                        }

                        Store (Zero, GESF) /* \_SB_.PCI0.IGPU.GESF */
                        Return (SUCC) /* \_SB_.PCI0.IGPU.SUCC */
                    }

                    If (LEqual (GEFC, 0x04))
                    {
                        Store (GBDA (), GXFC) /* \_SB_.PCI0.IGPU.GXFC */
                    }

                    If (LEqual (GEFC, 0x06))
                    {
                        Store (SBCB (), GXFC) /* \_SB_.PCI0.IGPU.GXFC */
                    }

                    Store (Zero, GEFC) /* \_SB_.PCI0.IGPU.GEFC */
                    Store (One, SCIS) /* \SCIS */
                    Store (Zero, GSSE) /* \_SB_.PCI0.IGPU.GSSE */
                    Store (Zero, SCIE) /* \_SB_.PCI0.IGPU.SCIE */
                    Return (Zero)
                }

                Method (PDRD, 0, NotSerialized)
                {
                    If (LNot (DRDY))
                    {
                        Sleep (ASLP)
                    }

                    Return (LNot (DRDY))
                }

                Method (PSTS, 0, NotSerialized)
                {
                    If (LGreater (CSTS, 0x02))
                    {
                        Sleep (ASLP)
                    }

                    Return (LEqual (CSTS, 0x03))
                }

                Method (GNOT, 2, NotSerialized)
                {
                    If (PDRD ())
                    {
                        Return (One)
                    }

                    Store (Arg0, CEVT) /* \_SB_.PCI0.IGPU.CEVT */
                    Store (0x03, CSTS) /* \_SB_.PCI0.IGPU.CSTS */
                    If (LAnd (LEqual (CHPD, Zero), LEqual (Arg1, Zero)))
                    {
                        If (LAnd (LGreater (OSYS, 0x07D0), LLess (OSYS, 0x07D6)))
                        {
                            Notify (PCI0, Arg1)
                        }
                        Else
                        {
                            Notify (IGPU, Arg1)
                        }
                    }

                    If (CondRefOf (WMAB))
                    {
                        WMAB (Arg0)
                    }
                    Else
                    {
                        Notify (IGPU, 0x80) // Status Change
                    }

                    If (LNot (PSTS ()))
                    {
                        Store (Zero, CEVT) /* \_SB_.PCI0.IGPU.CEVT */
                    }

                    Return (Zero)
                }

                Method (GHDS, 1, NotSerialized)
                {
                    Store (Arg0, TIDX) /* \_SB_.PCI0.IGPU.TIDX */
                    Return (GNOT (One, Zero))
                }

                Method (GLID, 1, NotSerialized)
                {
                    Store (Arg0, CLID) /* \_SB_.PCI0.IGPU.CLID */
                    Return (GNOT (0x02, Zero))
                }

                Method (GDCK, 1, NotSerialized)
                {
                    Store (Arg0, CDCK) /* \_SB_.PCI0.IGPU.CDCK */
                    Return (GNOT (0x04, Zero))
                }

                Method (PARD, 0, NotSerialized)
                {
                    If (LNot (ARDY))
                    {
                        Sleep (ASLP)
                    }

                    Return (LNot (ARDY))
                }

                Method (AINT, 2, NotSerialized)
                {
                    If (LNot (And (TCHE, ShiftLeft (One, Arg0))))
                    {
                        Return (One)
                    }

                    If (PARD ())
                    {
                        Return (One)
                    }

                    If (LEqual (Arg0, 0x02))
                    {
                        If (CPFM)
                        {
                            And (CPFM, 0x0F, Local0)
                            And (EPFM, 0x0F, Local1)
                            If (LEqual (Local0, One))
                            {
                                If (And (Local1, 0x06))
                                {
                                    Store (0x06, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                }
                                Else
                                {
                                    If (And (Local1, 0x08))
                                    {
                                        Store (0x08, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                    Else
                                    {
                                        Store (One, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                }
                            }

                            If (LEqual (Local0, 0x06))
                            {
                                If (And (Local1, 0x08))
                                {
                                    Store (0x08, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                }
                                Else
                                {
                                    If (And (Local1, One))
                                    {
                                        Store (One, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                    Else
                                    {
                                        Store (0x06, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                }
                            }

                            If (LEqual (Local0, 0x08))
                            {
                                If (And (Local1, One))
                                {
                                    Store (One, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                }
                                Else
                                {
                                    If (And (Local1, 0x06))
                                    {
                                        Store (0x06, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                    Else
                                    {
                                        Store (0x08, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                                    }
                                }
                            }
                        }
                        Else
                        {
                            XOr (PFIT, 0x07, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                        }

                        Or (PFIT, 0x80000000, PFIT) /* \_SB_.PCI0.IGPU.PFIT */
                        Store (0x04, ASLC) /* \_SB_.PCI0.IGPU.ASLC */
                    }
                    Else
                    {
                        If (LEqual (Arg0, One))
                        {
                            Store (Arg1, BCLP) /* \_SB_.PCI0.IGPU.BCLP */
                            Or (BCLP, 0x80000000, BCLP) /* \_SB_.PCI0.IGPU.BCLP */
                            Store (0x02, ASLC) /* \_SB_.PCI0.IGPU.ASLC */
                        }
                        Else
                        {
                            If (LEqual (Arg0, Zero))
                            {
                                Store (Arg1, ALSI) /* \_SB_.PCI0.IGPU.ALSI */
                                Store (One, ASLC) /* \_SB_.PCI0.IGPU.ASLC */
                            }
                            Else
                            {
                                Return (One)
                            }
                        }
                    }

                    Store (One, ASLE) /* \_SB_.PCI0.IGPU.ASLE */
                    Return (Zero)
                }

                Method (SCIP, 0, NotSerialized)
                {
                    If (LNotEqual (OVER, Zero))
                    {
                        Return (LNot (GSMI))
                    }

                    Return (Zero)
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg2, Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03
                        })
                    }

                    Return (Package (0x06)
                    {
                        "AAPL,snb-platform-id", 
                        Buffer (0x04)
                        {
                             0x00, 0x00, 0x01, 0x00
                        }, 

                        "AAPL,ig-platform-id", 
                        Buffer (0x04)
                        {
                             0x03, 0x00, 0x66, 0x01
                        }, 

                        "hda-gfx", 
                        Buffer (0x0A)
                        {
                            "onboard-1"
                        }
                    })
                }

                OperationRegion (RMPC, PCI_Config, 0x10, 0x04)
                Field (RMPC, AnyAcc, NoLock, Preserve)
                {
                    BAR1,   32
                }

                Device (PNLF)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Name (_HID, EisaId ("APP0002"))  // _HID: Hardware ID
                    Name (_CID, "backlight")  // _CID: Compatible ID
                    Name (_UID, 0x0A)  // _UID: Unique ID
                    Name (_STA, 0x0B)  // _STA: Status
                    OperationRegion (BRIT, SystemMemory, And (BAR1, 0xFFFFFFFFFFFFFFF0), 0x000E1184)
                    Field (BRIT, AnyAcc, Lock, Preserve)
                    {
                        Offset (0x48250), 
                        LEV2,   32, 
                        LEVL,   32, 
                        Offset (0x70040), 
                        P0BL,   32, 
                        Offset (0xC8250), 
                        LEVW,   32, 
                        LEVX,   32, 
                        Offset (0xE1180), 
                        PCHL,   32
                    }

                    Name (LMAX, 0x0710)
                    Name (KMAX, 0x0710)
                    Name (KPCH, Zero)
                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        Store (PCHL, KPCH) /* \_SB_.PCI0.IGPU.PNLF.KPCH */
                        If (LNot (LMAX))
                        {
                            Store (ShiftRight (LEVX, 0x10), LMAX) /* \_SB_.PCI0.IGPU.PNLF.LMAX */
                        }

                        If (LNot (LMAX))
                        {
                            Store (KMAX, LMAX) /* \_SB_.PCI0.IGPU.PNLF.LMAX */
                        }

                        Store (ShiftLeft (LMAX, 0x10), KLVX) /* \_SB_.PCI0.IGPU.PNLF.KLVX */
                        If (LNotEqual (LMAX, KMAX))
                        {
                            Store (Zero, Local0)
                            While (LLess (Local0, SizeOf (_BCL)))
                            {
                                Store (DerefOf (Index (_BCL, Local0)), Local1)
                                Divide (Multiply (Local1, LMAX), KMAX, , Local1)
                                Store (Local1, Index (_BCL, Local0))
                                Increment (Local0)
                            }

                            Divide (Multiply (XRGL, LMAX), KMAX, , XRGL) /* \_SB_.PCI0.IGPU.PNLF.XRGL */
                            Divide (Multiply (XRGH, LMAX), KMAX, , XRGH) /* \_SB_.PCI0.IGPU.PNLF.XRGH */
                        }

                        Store (ShiftRight (LEVX, 0x10), Local1)
                        If (LNotEqual (Local1, LMAX))
                        {
                            Store (LEVL, Local0)
                            If (LOr (LNot (Local0), LNot (Local1)))
                            {
                                Store (LMAX, Local0)
                                Store (LMAX, Local1)
                            }

                            Divide (Multiply (Local0, LMAX), Local1, , Local0)
                            If (LGreater (LEVL, LMAX))
                            {
                                Store (KLVX, LEVX) /* \_SB_.PCI0.IGPU.PNLF.LEVX */
                                Store (Local0, LEVL) /* \_SB_.PCI0.IGPU.PNLF.LEVL */
                            }
                            Else
                            {
                                Store (Local0, LEVL) /* \_SB_.PCI0.IGPU.PNLF.LEVL */
                                Store (KLVX, LEVX) /* \_SB_.PCI0.IGPU.PNLF.LEVX */
                            }
                        }
                    }

                    Method (_BCM, 1, NotSerialized)  // _BCM: Brightness Control Method
                    {
                        If (LNotEqual (PCHL, KPCH))
                        {
                            Store (KPCH, PCHL) /* \_SB_.PCI0.IGPU.PNLF.PCHL */
                        }

                        If (LNotEqual (LEVW, 0x80000000))
                        {
                            Store (0x80000000, LEVW) /* \_SB_.PCI0.IGPU.PNLF.LEVW */
                        }

                        If (LNotEqual (LEVX, KLVX))
                        {
                            Store (KLVX, LEVX) /* \_SB_.PCI0.IGPU.PNLF.LEVX */
                        }

                        Store (Match (_BCL, MGE, Arg0, MTR, Zero, 0x02), Local0)
                        If (LEqual (Local0, Ones))
                        {
                            Subtract (SizeOf (_BCL), One, Local0)
                        }

                        If (LNotEqual (LEV2, 0x80000000))
                        {
                            Store (0x80000000, LEV2) /* \_SB_.PCI0.IGPU.PNLF.LEV2 */
                        }

                        Store (DerefOf (Index (_BCL, Local0)), LEVL) /* \_SB_.PCI0.IGPU.PNLF.LEVL */
                    }

                    Method (_BQC, 0, NotSerialized)  // _BQC: Brightness Query Current
                    {
                        Store (Match (_BCL, MGE, LEVL, MTR, Zero, 0x02), Local0)
                        If (LEqual (Local0, Ones))
                        {
                            Subtract (SizeOf (_BCL), One, Local0)
                        }

                        Return (DerefOf (Index (_BCL, Local0)))
                    }

                    Method (_DOS, 1, NotSerialized)  // _DOS: Disable Output Switching
                    {
                        ^^_DOS (Arg0)
                    }

                    Method (XBCM, 1, NotSerialized)
                    {
                        If (LNotEqual (PCHL, KPCH))
                        {
                            Store (KPCH, PCHL) /* \_SB_.PCI0.IGPU.PNLF.PCHL */
                        }

                        If (LNotEqual (LEVW, 0x80000000))
                        {
                            Store (0x80000000, LEVW) /* \_SB_.PCI0.IGPU.PNLF.LEVW */
                        }

                        If (LNotEqual (LEVX, KLVX))
                        {
                            Store (KLVX, LEVX) /* \_SB_.PCI0.IGPU.PNLF.LEVX */
                        }

                        If (LGreater (Arg0, XRGH))
                        {
                            Store (XRGH, Arg0)
                        }

                        If (LAnd (Arg0, LLess (Arg0, XRGL)))
                        {
                            Store (XRGL, Arg0)
                        }

                        If (LNotEqual (LEV2, 0x80000000))
                        {
                            Store (0x80000000, LEV2) /* \_SB_.PCI0.IGPU.PNLF.LEV2 */
                        }

                        Store (Arg0, LEVL) /* \_SB_.PCI0.IGPU.PNLF.LEVL */
                    }

                    Method (XBQC, 0, NotSerialized)
                    {
                        Store (LEVL, Local0)
                        If (LGreater (Local0, XRGH))
                        {
                            Store (XRGH, Local0)
                        }

                        If (LAnd (Local0, LLess (Local0, XRGL)))
                        {
                            Store (XRGL, Local0)
                        }

                        Return (Local0)
                    }

                    Name (XOPT, 0x06)
                    Name (XRGL, 0x28)
                    Name (XRGH, 0x0710)
                    Name (KLVX, 0x07100000)
                    Name (_BCL, Package (0x43)  // _BCL: Brightness Control Levels
                    {
                        0x0710, 
                        0x01DF, 
                        Zero, 
                        0x35, 
                        0x37, 
                        0x39, 
                        0x3B, 
                        0x3E, 
                        0x42, 
                        0x47, 
                        0x4D, 
                        0x53, 
                        0x5B, 
                        0x63, 
                        0x6C, 
                        0x77, 
                        0x82, 
                        0x8E, 
                        0x9A, 
                        0xA8, 
                        0xB7, 
                        0xC6, 
                        0xD6, 
                        0xE8, 
                        0xFA, 
                        0x010D, 
                        0x0121, 
                        0x0135, 
                        0x014B, 
                        0x0162, 
                        0x0179, 
                        0x0191, 
                        0x01AA, 
                        0x01C5, 
                        0x01DF, 
                        0x01FB, 
                        0x0218, 
                        0x0236, 
                        0x0254, 
                        0x0273, 
                        0x0294, 
                        0x02B5, 
                        0x02D7, 
                        0x02FA, 
                        0x031D, 
                        0x0342, 
                        0x0368, 
                        0x038E, 
                        0x03B5, 
                        0x03DE, 
                        0x0407, 
                        0x0431, 
                        0x045B, 
                        0x0487, 
                        0x04B4, 
                        0x04E1, 
                        0x0510, 
                        0x053F, 
                        0x056F, 
                        0x05A0, 
                        0x05D2, 
                        0x0605, 
                        0x0638, 
                        0x066D, 
                        0x06A2, 
                        0x06D9, 
                        0x0710
                    })
                }
            }

            Scope (IGPU)
            {
                Name (DODC, Zero)
                Name (INIM, Zero)
                Name (HPDD, Package (0x09)
                {
                    0x0400, 
                    0x0100, 
                    0x0200, 
                    0x0300, 
                    0x0301, 
                    0x0302, 
                    0x0303, 
                    0x0304, 
                    0x0305
                })
                Name (DSPR, Buffer (0x09)
                {
                    /* 0000 */   0x00, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x01,
                    /* 0008 */   0x02
                })
                Name (DODS, Package (0x09)
                {
                    Package (0x01)
                    {
                        0xFFFFFFFF
                    }, 

                    Package (0x01)
                    {
                        0xFFFFFFFF
                    }, 

                    Package (0x02)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x03)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x04)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x05)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x06)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x07)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }, 

                    Package (0x08)
                    {
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF, 
                        0xFFFFFFFF
                    }
                })
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    Store (One, INIM) /* \_SB_.PCI0.IGPU.INIM */
                    DKET ()
                    Store (SBRC (), Local0)
                    Or (Local0, 0x80000000, BCLP) /* \_SB_.PCI0.IGPU.BCLP */
                    Store (Zero, WDSA) /* \WDSA */
                    Store (Zero, WDST) /* \WDST */
                    Store (Zero, WDGN) /* \WDGN */
                }

                Method (HDOS, 1, NotSerialized)
                {
                    And (WDPE, 0xF8, Local0)
                    And (WDPE, 0x87, Local1)
                    Or (Local0, Arg0, WDPE) /* \WDPE */
                    If (CondRefOf (^PDOS, Local2))
                    {
                        PDOS (Arg0, Local1)
                    }
                }

                Method (HDOD, 0, NotSerialized)
                {
                    Store (One, Local1)
                    If (And (TCHE, 0x02))
                    {
                        Store (0x03, Local1)
                    }

                    Or (DCAP, Local1, DCAP) /* \DCAP */
                }

                Method (PDDS, 1, NotSerialized)
                {
                    Store (And (Arg0, 0x0F0F), Local0)
                    If (LEqual (Zero, Local0))
                    {
                        Return (Zero)
                    }

                    If (LEqual (CPDL, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL2, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL3, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL4, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL5, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL6, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL7, Local0))
                    {
                        Return (One)
                    }

                    If (LEqual (CPL8, Local0))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (UPNA, 2, Serialized)
                {
                    If (LEqual (Arg0, Zero))
                    {
                        Store (NADL, Local1)
                        Store (Arg1, NADL) /* \_SB_.PCI0.IGPU.NADL */
                    }

                    If (LEqual (Arg0, One))
                    {
                        Store (NDL2, Local1)
                        Store (Arg1, NDL2) /* \_SB_.PCI0.IGPU.NDL2 */
                    }

                    If (LEqual (Arg0, 0x02))
                    {
                        Store (NDL3, Local1)
                        Store (Arg1, NDL3) /* \_SB_.PCI0.IGPU.NDL3 */
                    }

                    If (LEqual (Arg0, 0x03))
                    {
                        Store (NDL4, Local1)
                        Store (Arg1, NDL4) /* \_SB_.PCI0.IGPU.NDL4 */
                    }

                    If (LEqual (Arg0, 0x04))
                    {
                        Store (NDL5, Local1)
                        Store (Arg1, NDL5) /* \_SB_.PCI0.IGPU.NDL5 */
                    }

                    If (LEqual (Arg0, 0x05))
                    {
                        Store (NDL6, Local1)
                        Store (Arg1, NDL6) /* \_SB_.PCI0.IGPU.NDL6 */
                    }

                    If (LEqual (Arg0, 0x06))
                    {
                        Store (NDL7, Local1)
                        Store (Arg1, NDL7) /* \_SB_.PCI0.IGPU.NDL7 */
                    }

                    If (LEqual (Arg0, 0x07))
                    {
                        Store (NDL8, Local1)
                        Store (Arg1, NDL8) /* \_SB_.PCI0.IGPU.NDL8 */
                    }

                    Return (Local1)
                }

                Method (UPAA, 0, Serialized)
                {
                    Store (Zero, Local1)
                    While (LLess (Local1, SizeOf (HPDD)))
                    {
                        ShiftLeft (One, Local1, Local0)
                        Store (DerefOf (Index (HPDD, Local1)), Local2)
                        If (PDDS (Local2))
                        {
                            Or (WDST, Local0, WDST) /* \WDST */
                        }
                        Else
                        {
                            And (WDST, Not (Local0), WDST) /* \WDST */
                        }

                        If (LEqual (CDDS (Local2), 0x1F))
                        {
                            Or (WDSA, Local0, WDSA) /* \WDSA */
                        }
                        Else
                        {
                            And (WDSA, Not (Local0), WDSA) /* \WDSA */
                        }

                        Increment (Local1)
                    }
                }

                Method (UPND, 0, Serialized)
                {
                    Store (WDGN, Local1)
                    Store (Zero, Local0)
                    Store (Zero, Local2)
                    While (LAnd (LLess (Local0, SizeOf (DSPR)), Local1))
                    {
                        Store (DerefOf (Index (DSPR, Local0)), Local3)
                        ShiftLeft (One, Local3, Local4)
                        If (And (Local1, Local4))
                        {
                            Store (DerefOf (Index (HPDD, Local3)), Local5)
                            UPNA (Local2, Local5)
                            Increment (Local2)
                            And (Local1, Not (Local4), Local1)
                        }

                        If (LGreaterEqual (Local2, 0x02))
                        {
                            Break
                        }

                        Increment (Local0)
                    }

                    XOr (WDGN, Local1, WDGN) /* \WDGN */
                    Store (One, Local1)
                    While (LAnd (LLess (Local2, 0x08), Local1))
                    {
                        Store (UPNA (Local2, Zero), Local1)
                        Increment (Local2)
                    }
                }

                Method (GF4E, 1, Serialized)
                {
                    UPAA ()
                    If (LEqual (WDSA, One))
                    {
                        Or (WDST, One, WDGN) /* \WDGN */
                    }
                    Else
                    {
                        If (And (WDSA, One))
                        {
                            And (WDST, 0xFFFFFFFFFFFFFFFE, WDGN) /* \WDGN */
                        }
                        Else
                        {
                            Store (One, WDGN) /* \WDGN */
                        }
                    }

                    UPND ()
                    Signal (F4EV)
                    GHDS (Zero)
                    Return (One)
                }

                Method (DKET, 0, NotSerialized)
                {
                    If (LEqual (GIVD, Zero))
                    {
                        Store ("GFX DockEvent Enter", Debug)
                        Store (DCKD (), Local0)
                        Store ("Dock Status", Debug)
                        Store (Local0, Debug)
                        GDCK (Local0)
                        Store ("GFX DockEvent Exit", Debug)
                    }

                    Return (Zero)
                }

                Method (RFHS, 1, Serialized)
                {
                    If (Arg0)
                    {
                        UPAA ()
                    }
                    Else
                    {
                        Wait (F4EV, 0x0500)
                    }
                }

                Method (SNXS, 0, Serialized)
                {
                    UPND ()
                    GHDS (Zero)
                }

                Method (SBRV, 0, Serialized)
                {
                    Store ("Set Brightness", Debug)
                    If (LEqual (And (DCAP, 0x02), Zero))
                    {
                        If (And (TCHE, 0x02))
                        {
                            Store ("TCHE set", Debug)
                            Or (DCAP, 0x02, DCAP) /* \DCAP */
                        }
                    }

                    And (DCAP, 0x02, Local3)
                    If (Local3)
                    {
                        Store ("OpRegion take control of Brightness", Debug)
                        Store (SBRC (), Local1)
                        Store (Local1, Debug)
                        AINT (One, Local1)
                    }

                    Return (Local3)
                }

                Scope (DD02)
                {
                    Method (_BCL, 0, Serialized)  // _BCL: Brightness Control Levels
                    {
                        Return (BCL ())
                    }

                    Method (_BCM, 1, Serialized)  // _BCM: Brightness Control Method
                    {
                        Store (BCM (Arg0), Local0)
                        If (Local0)
                        {
                            Store (BRID, Local1)
                            If (LEqual (SBRV (), Zero))
                            {
                                SSMI (0xEA74, 0x04, Local1, Zero, Zero)
                            }

                            Signal (BEVT)
                        }
                    }

                    Method (_BQC, 0, Serialized)  // _BQC: Brightness Query Current
                    {
                        Return (BQC ())
                    }
                }

                Scope (\_GPE)
                {
                    Method (_L06, 0, NotSerialized)  // _Lxx: Level-Triggered GPE
                    {
                        If (LEqual (\_SB.PCI0.IGPU.GIVD, Zero))
                        {
                            If (LAnd (\_SB.PCI0.IGPU.GSSE, LNot (GSMI)))
                            {
                                \_SB.PCI0.IGPU.GSCI ()
                            }
                            Else
                            {
                                Store (One, SCIS) /* \SCIS */
                            }
                        }
                    }

                    Name (WOAT, 0xFF)
                    Method (CNDD, 1, NotSerialized)
                    {
                        If (LEqual (\_SB.PCI0.IGPU.GIVD, Zero))
                        {
                            If (LOr (Arg0, LNotEqual (WDST, WOAT)))
                            {
                                Store (WDST, WOAT) /* \_GPE.WOAT */
                                If (LGreaterEqual (WCOS (), 0x04))
                                {
                                    Notify (\_SB.PCI0, Zero) // Bus Check
                                }
                                Else
                                {
                                    Notify (\_SB.PCI0.IGPU, Zero) // Bus Check
                                }

                                Sleep (0x02EE)
                            }
                        }
                    }

                    Method (VHIV, 3, Serialized)
                    {
                        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
                        If (\_SB.PCI0.IGPU.GIVD)
                        {
                            Return (One)
                        }

                        Store (Arg2, _T_0) /* \_GPE.VHIV._T_0 */
                        If (LEqual (_T_0, One))
                        {
                            If (And (Arg0, 0x80))
                            {
                                Notify (\_SB.PCI0.IGPU.DD02, Arg0)
                            }
                            Else
                            {
                                Store ("Verify no OS controlled brightness b/c VideoBrightnessEvent", Debug)
                                If (LEqual (And (WDPE, 0x44), Zero))
                                {
                                    Store ("VBRE method, use OpRegion method", Debug)
                                    \_SB.PCI0.IGPU.SBRV ()
                                }
                            }
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x02))
                            {
                                \_SB.PCI0.IGPU.GDCC (One)
                                If (LEqual (And (WDPE, 0x03), Zero))
                                {
                                    If (And (DCAP, One))
                                    {
                                        \_SB.PCI0.IGPU.DKET ()
                                    }
                                    Else
                                    {
                                        \_SB.SSMI (0xEA74, 0x06, Zero, Zero, Zero)
                                        CNDD (Zero)
                                        Notify (\_SB.PCI0.IGPU, 0x80) // Status Change
                                    }
                                }
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x03))
                                {
                                    Store (\_SB.LID._LID (), \_SB.PCI0.IGPU.CLID)
                                    If (LOr (LLess (WCOS (), 0x06), LEqual (And (WDPE, 0x03), 
                                        Zero)))
                                    {
                                        If (And (DCAP, One))
                                        {
                                            If (\_SB.PCI0.IGPU.GLID (\_SB.LID._LID ()))
                                            {
                                                Or (0x80000000, \_SB.PCI0.IGPU.CLID, \_SB.PCI0.IGPU.CLID)
                                            }
                                        }
                                        Else
                                        {
                                            \_SB.SSMI (0xEA74, 0x05, Zero, Zero, Zero)
                                            CNDD (One)
                                            Notify (\_SB.PCI0.IGPU, 0x80) // Status Change
                                            If (LLess (WCOS (), 0x06))
                                            {
                                                Store (Zero, LRSC) /* \_GPE.LRSC */
                                            }
                                        }
                                    }
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x04))
                                    {
                                        If (LEqual (And (WDPE, 0x03), Zero))
                                        {
                                            If (And (DCAP, One))
                                            {
                                                \_SB.PCI0.IGPU.GF4E (Zero)
                                            }
                                            Else
                                            {
                                                CNDD (Zero)
                                                Notify (\_SB.PCI0.IGPU, 0x80) // Status Change
                                            }
                                        }
                                    }
                                    Else
                                    {
                                        If (LEqual (_T_0, 0x06))
                                        {
                                            If (And (DCAP, One))
                                            {
                                                \_SB.PCI0.IGPU.SNXS ()
                                            }
                                            Else
                                            {
                                                CNDD (Zero)
                                                Notify (\_SB.PCI0.IGPU, 0x80) // Status Change
                                            }
                                        }
                                        Else
                                        {
                                            If (LEqual (_T_0, 0x07))
                                            {
                                                \_SB.PCI0.IGPU.RFHS (Arg0)
                                            }
                                            Else
                                            {
                                                If (LEqual (_T_0, 0x08))
                                                {
                                                    If (LEqual (Arg0, 0x04))
                                                    {
                                                        \_SB.PCI0.IGPU.GLID (\_SB.LID._LID ())
                                                        \_SB.PCI0.IGPU.DKET ()
                                                    }

                                                    If (LGreaterEqual (Arg0, 0x03))
                                                    {
                                                        If (LEqual (And (WDPE, 0x44), Zero))
                                                        {
                                                            Store (\_SB.SBRC (), Local0)
                                                            Or (Local0, 0x80000000, \_SB.PCI0.IGPU.BCLP)
                                                        }
                                                    }
                                                }
                                                Else
                                                {
                                                    If (LEqual (_T_0, 0x09))
                                                    {
                                                        If (LEqual (And (WDPE, 0x04), Zero))
                                                        {
                                                            \_SB.PCI0.IGPU.SBRV ()
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }

                        Return (Zero)
                    }
                }

                Event (^^BEVT)
                Event (^^F4EV)
                Scope (\_GPE)
                {
                    Method (VBRE, 1, Serialized)
                    {
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (VHIV (Arg0, Zero, One), Local1)
                        }

                        If (And (SGMD, 0x0F))
                        {
                            If (LNotEqual (\_SB.PCI0.PEGP.DGFX.SVID, 0xFFFF))
                            {
                                If (And (Arg0, 0x80))
                                {
                                    Notify (\_SB.PCI0.PEGP.DGFX.DD02, Arg0)
                                }
                            }
                        }
                    }

                    Method (VFN4, 0, Serialized)
                    {
                        Signal (\_SB.F4EV)
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (VHIV (Zero, Zero, 0x04), Local1)
                        }
                    }

                    Method (VDET, 0, Serialized)
                    {
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (VHIV (Zero, Zero, 0x02), Local1)
                        }
                    }

                    Name (LRSC, One)
                    Method (VLET, 0, Serialized)
                    {
                        Store (One, LRSC) /* \_GPE.LRSC */
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (VHIV (Zero, Zero, 0x03), Local1)
                        }

                        Return (LRSC) /* \_GPE.LRSC */
                    }

                    Method (VPUP, 2, Serialized)
                    {
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (VHIV (Arg0, Arg1, 0x05), Local1)
                        }
                    }
                }

                Scope (\_SB)
                {
                    Method (VSDD, 1, Serialized)
                    {
                        If (And (DCAP, 0x04))
                        {
                            Return (0xFFFF)
                        }
                        Else
                        {
                            If (LEqual (And (WDPE, 0x03), Zero))
                            {
                                Store (Arg0, WDGN) /* \WDGN */
                                Store (One, Local1)
                                If (Local1)
                                {
                                    Store (\_GPE.VHIV (Arg0, Zero, 0x06), Local1)
                                }
                            }

                            Return (Zero)
                        }

                        Return (Zero)
                    }

                    Method (VGDD, 1, Serialized)
                    {
                        If (LAnd (And (DCAP, 0x04), Arg0))
                        {
                            Return (0xFFFF)
                        }
                        Else
                        {
                            If (And (DCAP, One))
                            {
                                If (LEqual (Arg0, Zero))
                                {
                                    Wait (F4EV, 0x0500)
                                }

                                Store (One, Local1)
                                If (Local1)
                                {
                                    Store (\_GPE.VHIV (Arg0, Zero, 0x07), Local1)
                                }
                            }
                            Else
                            {
                                If (Arg0)
                                {
                                    SSMI (0xEA74, 0x02, Zero, Zero, Zero)
                                }
                            }

                            Return (WDST) /* \WDST */
                        }
                    }

                    Method (VWAK, 1, Serialized)
                    {
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (\_GPE.VHIV (Arg0, Zero, 0x08), Local1)
                        }
                    }

                    Method (WBRT, 0, NotSerialized)
                    {
                        Store (One, Local1)
                        If (Local1)
                        {
                            Store (\_GPE.VHIV (Zero, Zero, 0x09), Local1)
                        }
                    }
                }

                Name (DCSC, 0xFF)
                Method (GDCC, 1, Serialized)
                {
                    If (LAnd (Arg0, LEqual (DCSC, 0xFF)))
                    {
                        Store (0x07, Local0)
                        If (DCKD ())
                        {
                            Or (Local0, 0x08, Local0)
                        }

                        Store (Local0, DCSC) /* \_SB_.PCI0.IGPU.DCSC */
                    }

                    Return (DCSC) /* \_SB_.PCI0.IGPU.DCSC */
                }

                Method (PDOS, 2, NotSerialized)
                {
                }
            }

            Device (PEGP.DGFX)
            {
                Name (_ADR, Zero)  // _ADR: Address
            }

            Scope (\)
            {
                OperationRegion (IO_T, SystemIO, 0x1000, 0x10)
                Field (IO_T, ByteAcc, NoLock, Preserve)
                {
                    TRPI,   16, 
                    Offset (0x04), 
                    Offset (0x06), 
                    Offset (0x08), 
                    TRP0,   8, 
                    Offset (0x0A), 
                    Offset (0x0B), 
                    Offset (0x0C), 
                    Offset (0x0D), 
                    Offset (0x0E), 
                    Offset (0x0F), 
                    Offset (0x10)
                }

                OperationRegion (IO_D, SystemIO, 0x0810, 0x04)
                Field (IO_D, ByteAcc, NoLock, Preserve)
                {
                    TRPD,   8
                }

                OperationRegion (PMIO, SystemIO, 0x0400, 0x80)
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x20), 
                        ,   2, 
                    SPST,   1, 
                        ,   16, 
                    GPS3,   1, 
                    Offset (0x42), 
                        ,   1, 
                    GPEC,   1, 
                    Offset (0x64), 
                        ,   9, 
                    SCIS,   1, 
                    Offset (0x66)
                }

                OperationRegion (GPIO, SystemIO, 0x0500, 0x64)
                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    GU00,   8, 
                    GU01,   8, 
                    GU02,   8, 
                    GU03,   8, 
                    GIO0,   8, 
                    GIO1,   8, 
                    GIO2,   8, 
                    GIO3,   8, 
                    Offset (0x0C), 
                    GL00,   8, 
                    GL01,   8, 
                    GL02,   8, 
                        ,   3, 
                    GP27,   1, 
                    GP28,   1, 
                    Offset (0x10), 
                    Offset (0x18), 
                    GB00,   8, 
                    GB01,   8, 
                    GB02,   8, 
                    GB03,   8, 
                    Offset (0x2C), 
                    GIV0,   8, 
                    GIV1,   8, 
                    GIV2,   8, 
                    GIV3,   8, 
                    GU04,   8, 
                    GU05,   8, 
                    GU06,   8, 
                    GU07,   8, 
                    GIO4,   8, 
                    GIO5,   8, 
                    GIO6,   8, 
                    GIO7,   8, 
                        ,   5, 
                        ,   1, 
                    Offset (0x39), 
                    GL05,   8, 
                    GL06,   8, 
                    GL07,   8, 
                    Offset (0x40), 
                    GU08,   8, 
                    GU09,   8, 
                    GU0A,   8, 
                    GU0B,   8, 
                        ,   5, 
                    GI69,   1, 
                    Offset (0x45), 
                    GIO9,   8, 
                    GIOA,   8, 
                    GIOB,   8, 
                        ,   5, 
                    GL69,   1, 
                    Offset (0x49), 
                    GL09,   8, 
                    GL0A,   8, 
                    GL0B,   8
                }

                OperationRegion (RCRB, SystemMemory, 0xFED1C000, 0x4000)
                Field (RCRB, DWordAcc, Lock, Preserve)
                {
                    Offset (0x1A8), 
                    APMC,   2, 
                    Offset (0x1000), 
                    Offset (0x3000), 
                    Offset (0x3404), 
                    HPAS,   2, 
                        ,   5, 
                    HPAE,   1, 
                    Offset (0x3418), 
                        ,   1, 
                        ,   1, 
                    SATD,   1, 
                    SMBD,   1, 
                    HDAD,   1, 
                    Offset (0x341A), 
                    RP1D,   1, 
                    RP2D,   1, 
                    RP3D,   1, 
                    RP4D,   1, 
                    RP5D,   1, 
                    RP6D,   1, 
                    RP7D,   1, 
                    RP8D,   1
                }

                Method (GETP, 1, Serialized)
                {
                    If (LEqual (And (Arg0, 0x09), Zero))
                    {
                        Return (0xFFFFFFFF)
                    }

                    If (LEqual (And (Arg0, 0x09), 0x08))
                    {
                        Return (0x0384)
                    }

                    ShiftRight (And (Arg0, 0x0300), 0x08, Local0)
                    ShiftRight (And (Arg0, 0x3000), 0x0C, Local1)
                    Return (Multiply (0x1E, Subtract (0x09, Add (Local0, Local1))
                        ))
                }

                Method (GDMA, 5, Serialized)
                {
                    If (Arg0)
                    {
                        If (LAnd (Arg1, Arg4))
                        {
                            Return (0x14)
                        }

                        If (LAnd (Arg2, Arg4))
                        {
                            Return (Multiply (Subtract (0x04, Arg3), 0x0F))
                        }

                        Return (Multiply (Subtract (0x04, Arg3), 0x1E))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (GETT, 1, Serialized)
                {
                    Return (Multiply (0x1E, Subtract (0x09, Add (And (ShiftRight (Arg0, 0x02
                        ), 0x03), And (Arg0, 0x03)))))
                }

                Method (GETF, 3, Serialized)
                {
                    Name (TMPF, Zero)
                    If (Arg0)
                    {
                        Or (TMPF, One, TMPF) /* \GETF.TMPF */
                    }

                    If (And (Arg2, 0x02))
                    {
                        Or (TMPF, 0x02, TMPF) /* \GETF.TMPF */
                    }

                    If (Arg1)
                    {
                        Or (TMPF, 0x04, TMPF) /* \GETF.TMPF */
                    }

                    If (And (Arg2, 0x20))
                    {
                        Or (TMPF, 0x08, TMPF) /* \GETF.TMPF */
                    }

                    If (And (Arg2, 0x4000))
                    {
                        Or (TMPF, 0x10, TMPF) /* \GETF.TMPF */
                    }

                    Return (TMPF) /* \GETF.TMPF */
                }

                Method (SETP, 3, Serialized)
                {
                    If (LGreater (Arg0, 0xF0))
                    {
                        Return (0x08)
                    }
                    Else
                    {
                        If (And (Arg1, 0x02))
                        {
                            If (LAnd (LLessEqual (Arg0, 0x78), And (Arg2, 0x02)))
                            {
                                Return (0x2301)
                            }

                            If (LAnd (LLessEqual (Arg0, 0xB4), And (Arg2, One)))
                            {
                                Return (0x2101)
                            }
                        }

                        Return (0x1001)
                    }
                }

                Method (SDMA, 1, Serialized)
                {
                    If (LLessEqual (Arg0, 0x14))
                    {
                        Return (One)
                    }

                    If (LLessEqual (Arg0, 0x1E))
                    {
                        Return (0x02)
                    }

                    If (LLessEqual (Arg0, 0x2D))
                    {
                        Return (One)
                    }

                    If (LLessEqual (Arg0, 0x3C))
                    {
                        Return (0x02)
                    }

                    If (LLessEqual (Arg0, 0x5A))
                    {
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SETT, 3, Serialized)
                {
                    If (And (Arg1, 0x02))
                    {
                        If (LAnd (LLessEqual (Arg0, 0x78), And (Arg2, 0x02)))
                        {
                            Return (0x0B)
                        }

                        If (LAnd (LLessEqual (Arg0, 0xB4), And (Arg2, One)))
                        {
                            Return (0x09)
                        }
                    }

                    Return (0x04)
                }
            }

            Device (LANC)
            {
                Name (_ADR, 0x00190000)  // _ADR: Address
                Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                {
                    Store (Package (0x02)
                        {
                            0x0D, 
                            0x05
                        }, Local0)
                    If (WOLD)
                    {
                        Store (Zero, Index (Local0, One))
                    }

                    Return (Local0)
                }
            }

            Device (HDEF)
            {
                Name (_ADR, 0x001B0000)  // _ADR: Address
                OperationRegion (HDAR, PCI_Config, 0x4C, 0x10)
                Field (HDAR, WordAcc, NoLock, Preserve)
                {
                    DCKA,   1, 
                    Offset (0x01), 
                    DCKM,   1, 
                        ,   6, 
                    DCKS,   1, 
                    Offset (0x08), 
                        ,   15, 
                    PMES,   1
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg2, Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03
                        })
                    }

                    Return (Package (0x06)
                    {
                        "hda-gfx", 
                        Buffer (0x0A)
                        {
                            "onboard-1"
                        }, 

                        "layout-id", 
                        Buffer (0x04)
                        {
                             0x0C, 0x00, 0x00, 0x00
                        }, 

                        "PinConfigurations", 
                        Buffer (Zero) {}
                    })
                }
            }

            Device (EH01)
            {
                Name (_ADR, 0x001D0000)  // _ADR: Address
                OperationRegion (EHCX, PCI_Config, 0x54, 0x10)
                Field (EHCX, AnyAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1, 
                    Offset (0x0E), 
                    PIMP,   1, 
                    PMSK,   8
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (LAnd (LEqual (Arg0, 0x02), LEqual (Arg1, One)))
                    {
                        Store (One, PMSK) /* \_SB_.PCI0.EH01.PMSK */
                        Store (One, PIMP) /* \_SB_.PCI0.EH01.PIMP */
                    }
                }

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT0)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x0D, 0x03))
                }

                Name (_S3D, 0x02)  // _S3D: S3 Device State
                Name (_S4D, 0x03)  // _S4D: S4 Device State
                Scope (RHUB.PRT0)
                {
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Return (EUPC) /* \EUPC */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Device (HPT0)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (HPT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }

                    Device (HPT2)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (HPT3)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT4)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                        Method (_EJD, 0, NotSerialized)  // _EJD: Ejection Dependent Device
                        {
                            Return ("\\_SB.PCI0.RP02.ECF0")
                        }
                    }

                    Device (HPT5)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT6)
                    {
                        Name (_ADR, 0x07)  // _ADR: Address
                    }

                    Device (HPT7)
                    {
                        Name (_ADR, 0x08)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg2, Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03
                        })
                    }

                    Return (Package (0x10)
                    {
                        "built-in", 
                        Buffer (One)
                        {
                             0x00
                        }, 

                        "AAPL,clock-id", 
                        Buffer (One)
                        {
                             0x01
                        }, 

                        "device_type", 
                        Buffer (0x05)
                        {
                            "EHCI"
                        }, 

                        "AAPL,current-available", 
                        0x0834, 
                        "AAPL,current-extra", 
                        0x0898, 
                        "AAPL,current-extra-in-sleep", 
                        0x0640, 
                        "AAPL,device-internal", 
                        0x02, 
                        "AAPL,max-port-current-in-sleep", 
                        0x0834
                    })
                }
            }

            Device (EH02)
            {
                Name (_ADR, 0x001A0000)  // _ADR: Address
                OperationRegion (EHCX, PCI_Config, 0x54, 0x10)
                Field (EHCX, AnyAcc, NoLock, Preserve)
                {
                        ,   15, 
                    PMES,   1, 
                    Offset (0x0E), 
                    PIMP,   1, 
                    PMSK,   8
                }

                Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                {
                    If (LAnd (LEqual (Arg0, 0x02), LEqual (Arg1, One)))
                    {
                        Store (One, PMSK) /* \_SB_.PCI0.EH02.PMSK */
                        Store (One, PIMP) /* \_SB_.PCI0.EH02.PIMP */
                    }
                }

                Device (RHUB)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (PRT0)
                    {
                        Name (_ADR, One)  // _ADR: Address
                    }

                    Device (PRT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                    }
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x0D, 0x03))
                }

                Name (_S3D, 0x02)  // _S3D: S3 Device State
                Name (_S4D, 0x03)  // _S4D: S4 Device State
                Scope (RHUB.PRT0)
                {
                    Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                    {
                        Return (EUPC) /* \EUPC */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Device (HPT0)
                    {
                        Name (_ADR, One)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT1)
                    {
                        Name (_ADR, 0x02)  // _ADR: Address
                        Method (_UPC, 0, Serialized)  // _UPC: USB Port Capabilities
                        {
                            Return (EUPC) /* \EUPC */
                        }

                        Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                        {
                            Return (EPLD) /* \EPLD */
                        }
                    }

                    Device (HPT2)
                    {
                        Name (_ADR, 0x03)  // _ADR: Address
                    }

                    Device (HPT3)
                    {
                        Name (_ADR, 0x04)  // _ADR: Address
                    }

                    Device (HPT4)
                    {
                        Name (_ADR, 0x05)  // _ADR: Address
                    }

                    Device (HPT5)
                    {
                        Name (_ADR, 0x06)  // _ADR: Address
                    }
                }

                Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                {
                    If (LEqual (Arg2, Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x03
                        })
                    }

                    Return (Package (0x10)
                    {
                        "built-in", 
                        Buffer (One)
                        {
                             0x00
                        }, 

                        "AAPL,clock-id", 
                        Buffer (One)
                        {
                             0x01
                        }, 

                        "device_type", 
                        Buffer (0x05)
                        {
                            "EHCI"
                        }, 

                        "AAPL,current-available", 
                        0x0834, 
                        "AAPL,current-extra", 
                        0x0898, 
                        "AAPL,current-extra-in-sleep", 
                        0x0640, 
                        "AAPL,device-internal", 
                        0x02, 
                        "AAPL,max-port-current-in-sleep", 
                        0x0834
                    })
                }
            }

            Device (PCIB)
            {
                Name (_ADR, 0x001E0000)  // _ADR: Address
                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x0B, 
                    0x05
                })
            }

            Device (LPCB)
            {
                Name (_ADR, 0x001F0000)  // _ADR: Address
                Scope (\_SB)
                {
                    OperationRegion (PCI0.LPCB.LPC1, PCI_Config, 0x40, 0xC0)
                    Field (PCI0.LPCB.LPC1, AnyAcc, NoLock, Preserve)
                    {
                        Offset (0x20), 
                        PARC,   8, 
                        PBRC,   8, 
                        PCRC,   8, 
                        PDRC,   8, 
                        Offset (0x28), 
                        PERC,   8, 
                        PFRC,   8, 
                        PGRC,   8, 
                        PHRC,   8
                    }

                    Device (LNKA)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, One)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PARC, 0x80, PARC) /* \_SB_.PARC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLA, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLA, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKA._CRS.IRQ0 */
                            ShiftLeft (One, And (PARC, 0x0F), IRQ0) /* \_SB_.LNKA._CRS.IRQ0 */
                            Return (RTLA) /* \_SB_.LNKA._CRS.RTLA */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PARC) /* \_SB_.PARC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PARC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKB)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x02)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PBRC, 0x80, PBRC) /* \_SB_.PBRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLB, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLB, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKB._CRS.IRQ0 */
                            ShiftLeft (One, And (PBRC, 0x0F), IRQ0) /* \_SB_.LNKB._CRS.IRQ0 */
                            Return (RTLB) /* \_SB_.LNKB._CRS.RTLB */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PBRC) /* \_SB_.PBRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PBRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKC)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x03)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PCRC, 0x80, PCRC) /* \_SB_.PCRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLC, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLC, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKC._CRS.IRQ0 */
                            ShiftLeft (One, And (PCRC, 0x0F), IRQ0) /* \_SB_.LNKC._CRS.IRQ0 */
                            Return (RTLC) /* \_SB_.LNKC._CRS.RTLC */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PCRC) /* \_SB_.PCRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PCRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKD)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x04)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PDRC, 0x80, PDRC) /* \_SB_.PDRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLD, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLD, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKD._CRS.IRQ0 */
                            ShiftLeft (One, And (PDRC, 0x0F), IRQ0) /* \_SB_.LNKD._CRS.IRQ0 */
                            Return (RTLD) /* \_SB_.LNKD._CRS.RTLD */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PDRC) /* \_SB_.PDRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PDRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKE)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x05)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PERC, 0x80, PERC) /* \_SB_.PERC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLE, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLE, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKE._CRS.IRQ0 */
                            ShiftLeft (One, And (PERC, 0x0F), IRQ0) /* \_SB_.LNKE._CRS.IRQ0 */
                            Return (RTLE) /* \_SB_.LNKE._CRS.RTLE */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PERC) /* \_SB_.PERC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PERC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKF)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x06)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PFRC, 0x80, PFRC) /* \_SB_.PFRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLF, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLF, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKF._CRS.IRQ0 */
                            ShiftLeft (One, And (PFRC, 0x0F), IRQ0) /* \_SB_.LNKF._CRS.IRQ0 */
                            Return (RTLF) /* \_SB_.LNKF._CRS.RTLF */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PFRC) /* \_SB_.PFRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PFRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKG)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x07)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PGRC, 0x80, PGRC) /* \_SB_.PGRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,10,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLG, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLG, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKG._CRS.IRQ0 */
                            ShiftLeft (One, And (PGRC, 0x0F), IRQ0) /* \_SB_.LNKG._CRS.IRQ0 */
                            Return (RTLG) /* \_SB_.LNKG._CRS.RTLG */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PGRC) /* \_SB_.PGRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PGRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }

                    Device (LNKH)
                    {
                        Name (_HID, EisaId ("PNP0C0F"))  // _HID: Hardware ID
                        Name (_UID, 0x08)  // _UID: Unique ID
                        Method (_DIS, 0, Serialized)  // _DIS: Disable Device
                        {
                            Or (PHRC, 0x80, PHRC) /* \_SB_.PHRC */
                        }

                        Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                        {
                            IRQ (Level, ActiveLow, Shared, )
                                {1,3,4,5,6,7,11,12,14,15}
                        })
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (RTLH, ResourceTemplate ()
                            {
                                IRQ (Level, ActiveLow, Shared, )
                                    {}
                            })
                            CreateWordField (RTLH, One, IRQ0)
                            Store (Zero, IRQ0) /* \_SB_.LNKH._CRS.IRQ0 */
                            ShiftLeft (One, And (PHRC, 0x0F), IRQ0) /* \_SB_.LNKH._CRS.IRQ0 */
                            Return (RTLH) /* \_SB_.LNKH._CRS.RTLH */
                        }

                        Method (_SRS, 1, Serialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, One, IRQ0)
                            FindSetRightBit (IRQ0, Local0)
                            Decrement (Local0)
                            Store (Local0, PHRC) /* \_SB_.PHRC */
                        }

                        Method (_STA, 0, Serialized)  // _STA: Status
                        {
                            If (And (PHRC, 0x80))
                            {
                                Return (0x09)
                            }
                            Else
                            {
                                Return (0x0B)
                            }
                        }
                    }
                }

                OperationRegion (LPC0, PCI_Config, 0x40, 0xC0)
                Field (LPC0, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x40), 
                    IOD0,   8, 
                    IOD1,   8, 
                    Offset (0xB0), 
                    RAEN,   1, 
                        ,   13, 
                    RCBA,   18
                }

                Device (EC0)
                {
                    Name (_HID, EisaId ("PNP0C09"))  // _HID: Hardware ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_GPE, 0x16)  // _GPE: General Purpose Events
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0062,             // Range Minimum
                            0x0062,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0066,             // Range Minimum
                            0x0066,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                    })
                    Mutex (ECMX, 0x00)
                    Name (ECRG, Zero)
                    Name (HSWK, Zero)
                    Method (ECRI, 0, Serialized)
                    {
                        Store (WCOS (), OST) /* \_SB_.PCI0.LPCB.EC0_.OST_ */
                        PWUP (0x07, 0xFF)
                        Store (GBAP (), Local0)
                        ITLB ()
                        SBTN (Local0, 0x81)
                        UHSW ()
                        PRIT ()
                    }

                    Method (_REG, 2, NotSerialized)  // _REG: Region Availability
                    {
                        If (LEqual (Arg0, 0x03))
                        {
                            Store (Arg1, ECRG) /* \_SB_.PCI0.LPCB.EC0_.ECRG */
                            Store (LOr (LEqual (WCOS (), One), LEqual (WCOS (), 0x02)), Local1)
                            If (LAnd (Arg1, LNot (Local1)))
                            {
                                ECRI ()
                            }
                        }
                    }

                    OperationRegion (ECRM, EmbeddedControl, Zero, 0xFF)
                    Field (ECRM, ByteAcc, NoLock, Preserve)
                    {
                        PMCD,   32, 
                        S0FL,   8, 
                        SXF0,   8, 
                        SXF1,   8, 
                        CPWR,   16, 
                        CVLT,   16, 
                        CCUR,   16, 
                        DIDX,   8, 
                        CIDX,   8, 
                        PMCC,   8, 
                        PMEP,   8, 
                        Offset (0x22), 
                        CRZN,   8, 
                        THTA,   8, 
                        HYST,   8, 
                        CRIT,   8, 
                        TEMP,   8, 
                        TENA,   8, 
                        Offset (0x29), 
                        TOAD,   8, 
                        PHTP,   8, 
                        THEM,   8, 
                        TMPO,   8, 
                        Offset (0x2E), 
                        FRDC,   8, 
                        FTGC,   8, 
                        PLTP,   8, 
                        Offset (0x32), 
                        DTMP,   8, 
                        Offset (0x35), 
                        PL1,    8, 
                        PL2,    8, 
                        BCVD,   8, 
                        Offset (0x40), 
                        ABDI,   8, 
                        ABAD,   8, 
                        ABIX,   8, 
                        ABDA,   8, 
                        ABST,   8, 
                        PORI,   8, 
                        Offset (0x4C), 
                        PSSB,   8, 
                        Offset (0x80), 
                        Offset (0x81), 
                            ,   4, 
                        SLPT,   4, 
                        FNSW,   1, 
                        SFNC,   1, 
                        ACPI,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        DETF,   1, 
                        LIDS,   1, 
                        TBLT,   1, 
                            ,   1, 
                            ,   1, 
                            ,   1, 
                        COMM,   1, 
                        PME,    1, 
                        SBVD,   1, 
                        ADP,    1, 
                        ADID,   2, 
                        LCTV,   1, 
                        BATP,   4, 
                        BPU,    1, 
                        Offset (0x86), 
                        BSEL,   4, 
                        Offset (0x87), 
                        LB1,    8, 
                        LB2,    8, 
                        BDC0,   8, 
                        BDC1,   8, 
                        Offset (0x8D), 
                        BFC0,   8, 
                        BFC1,   8, 
                        RTE0,   8, 
                        RTE1,   8, 
                        BTC,    1, 
                        Offset (0x92), 
                        BME0,   8, 
                        BME1,   8, 
                        BDN,    8, 
                        BDV0,   8, 
                        BDV1,   8, 
                        BCX0,   8, 
                        BCX1,   8, 
                        BST,    4, 
                        Offset (0x9B), 
                        ATE0,   8, 
                        ATE1,   8, 
                        BPR0,   8, 
                        BPR1,   8, 
                        BCR0,   8, 
                        BCR1,   8, 
                        BRC0,   8, 
                        BRC1,   8, 
                        BCC0,   8, 
                        BCC1,   8, 
                        BPV0,   8, 
                        BPV1,   8, 
                        BCA0,   8, 
                        BCA1,   8, 
                        BCB0,   8, 
                        BCB1,   8, 
                        BCP0,   8, 
                        BCP1,   8, 
                        BCW,    16, 
                        ATF0,   8, 
                        ATF1,   8, 
                        BCL,    16, 
                        AXC0,   8, 
                        AXC1,   8, 
                        BCG1,   8, 
                        BT1I,   1, 
                        BT2I,   1, 
                            ,   2, 
                        BATN,   4, 
                        BST0,   8, 
                        BST1,   8, 
                        BCG2,   8, 
                        Offset (0xBD), 
                        BMO,    8, 
                        Offset (0xBF), 
                        BRCV,   8, 
                        Offset (0xC1), 
                        BIF,    8, 
                        BRCC,   8, 
                        Offset (0xC9), 
                        BSN0,   8, 
                        BSN1,   8, 
                        BDA0,   8, 
                        BDA1,   8, 
                        BMF,    8, 
                        Offset (0xCF), 
                        CTLB,   8, 
                        Offset (0xD1), 
                        BTY,    8, 
                        Offset (0xD5), 
                        MFAC,   8, 
                        CFAN,   8, 
                        PFAN,   8, 
                        OCPS,   8, 
                        OCPR,   8, 
                        OCPE,   8, 
                        TMP1,   8, 
                        TMP2,   8, 
                        NABT,   4, 
                        BCM,    4, 
                        CCBQ,   16, 
                        CBT0,   8, 
                        CBT1,   8, 
                        Offset (0xE3), 
                        OST,    4, 
                        Offset (0xE4), 
                        Offset (0xE5), 
                        TPTE,   1, 
                        TBBN,   1, 
                            ,   3, 
                        TP,     1, 
                        Offset (0xE6), 
                        SHK,    8, 
                        AUDS,   1, 
                        SPKR,   1, 
                        Offset (0xE8), 
                        HSEN,   4, 
                        HSST,   4, 
                        Offset (0xEA), 
                            ,   2, 
                        WWP,    1, 
                        WLP,    1, 
                        Offset (0xEF), 
                        INCH,   2, 
                        IDIS,   2, 
                        INAC,   1
                    }

                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        If (LOr (LEqual (WCOS (), One), LEqual (WCOS (), 0x02)))
                        {
                            ECRI ()
                        }
                    }

                    OperationRegion (MAIO, SystemIO, 0x0200, 0x02)
                    Field (MAIO, ByteAcc, NoLock, Preserve)
                    {
                        MAIN,   8, 
                        MADT,   8
                    }

                    IndexField (MAIN, MADT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x8C), 
                            ,   7, 
                        CLID,   1, 
                        Offset (0x95), 
                        PWM0,   8, 
                        Offset (0x9D), 
                        PWMC,   8
                    }

                    Method (KFCL, 2, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg1, MFAC) /* \_SB_.PCI0.LPCB.EC0_.MFAC */
                            If (LAnd (LGreaterEqual (Arg0, Zero), LLessEqual (Arg0, 0x64)))
                            {
                                Store (Arg0, CFAN) /* \_SB_.PCI0.LPCB.EC0_.CFAN */
                            }
                        }

                        Release (ECMX)
                    }

                    Method (KSFS, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg0, CFAN) /* \_SB_.PCI0.LPCB.EC0_.CFAN */
                        }

                        Release (ECMX)
                    }

                    Method (KGFS, 0, NotSerialized)
                    {
                        Store (0x14, Local0)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (CFAN, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (KRFS, 0, NotSerialized)
                    {
                        Store (0x1E, Local0)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (PFAN, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SFSD, 1, Serialized)
                    {
                        Multiply (Arg0, 0x40, Local1)
                        Divide (Local1, 0x64, Local2, Local0)
                        Subtract (0x40, Local0, Local0)
                        And (PWM0, 0x80, Local1)
                        If (LEqual (Local0, 0x40))
                        {
                            Or (Local1, One, Local1)
                        }
                        Else
                        {
                            ShiftLeft (Local0, One, Local0)
                            Or (Local0, Local1, Local1)
                        }

                        Store (Local1, PWM0) /* \_SB_.PCI0.LPCB.EC0_.PWM0 */
                    }

                    Method (GFSD, 0, Serialized)
                    {
                        And (PWM0, 0x7F, Local0)
                        If (And (Local0, One))
                        {
                            Store (Zero, Local1)
                        }
                        Else
                        {
                            ShiftRight (Local0, One, Local0)
                            Subtract (0x40, Local0, Local0)
                            Multiply (Local0, 0x64, Local0)
                            Divide (Add (Local0, 0x20), 0x40, Local2, Local1)
                            Increment (Local1)
                        }

                        Return (Local1)
                    }

                    Method (GSHK, 0, Serialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (SHK, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SSHK, 1, Serialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg0, Debug)
                            Store (Arg0, SHK) /* \_SB_.PCI0.LPCB.EC0_.SHK_ */
                        }

                        Release (ECMX)
                    }

                    Method (SAST, 1, Serialized)
                    {
                        Store (Zero, Local0)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg0, AUDS) /* \_SB_.PCI0.LPCB.EC0_.AUDS */
                            Store (One, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (HSPW, 2, Serialized)
                    {
                        If (HSED)
                        {
                            Store (HSWK, Local0)
                            If (Arg0)
                            {
                                Or (Local0, Arg1, HSWK) /* \_SB_.PCI0.LPCB.EC0_.HSWK */
                            }
                            Else
                            {
                                And (Local0, Not (Arg1), HSWK) /* \_SB_.PCI0.LPCB.EC0_.HSWK */
                            }
                        }
                        Else
                        {
                            Store (Zero, HSWK) /* \_SB_.PCI0.LPCB.EC0_.HSWK */
                        }
                    }

                    Method (UHSW, 0, Serialized)
                    {
                    }

                    Method (CHSW, 1, Serialized)
                    {
                        Store (Zero, Local1)
                        Return (Local1)
                    }

                    Method (HWLP, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            XOr (Arg0, Zero, WLP) /* \_SB_.PCI0.LPCB.EC0_.WLP_ */
                        }

                        Release (ECMX)
                    }

                    Method (HWWP, 1, NotSerialized)
                    {
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            If (LAnd (And (WWIX, 0x80), LEqual (Arg0, Zero)))
                            {
                                Sleep (0x1388)
                            }

                            XOr (Arg0, One, WWP) /* \_SB_.PCI0.LPCB.EC0_.WWP_ */
                        }

                        Release (ECMX)
                    }

                    Method (ECAB, 4, Serialized)
                    {
                        Store (0xECAB, Local0)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (0xFF00, Local0)
                            Store (Arg0, ABDI) /* \_SB_.PCI0.LPCB.EC0_.ABDI */
                            Store (Arg1, ABAD) /* \_SB_.PCI0.LPCB.EC0_.ABAD */
                            Store (Arg2, ABIX) /* \_SB_.PCI0.LPCB.EC0_.ABIX */
                            If (LEqual (And (Arg1, One), Zero))
                            {
                                Store (Arg3, ABDA) /* \_SB_.PCI0.LPCB.EC0_.ABDA */
                            }

                            Store (0xFF, ABST) /* \_SB_.PCI0.LPCB.EC0_.ABST */
                            Sleep (0x5A)
                            Store (0x80, Local0)
                            Store (0x0B, Local1)
                            While (LAnd (And (Local0, 0x80), LGreater (Local1, Zero)))
                            {
                                Sleep (0x0A)
                                Store (ABST, Local0)
                                Decrement (Local1)
                            }

                            ShiftLeft (Local0, 0x08, Local0)
                            If (LAnd (LEqual (Local0, Zero), And (Arg1, One)))
                            {
                                And (ABDA, 0xFF, Local1)
                                Or (Local0, Local1, Local0)
                            }
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Name (NGBF, 0xFF)
                    Name (NGBT, 0xFF)
                    Name (GACP, 0x07)
                    Name (ACST, One)
                    Name (SMAR, Zero)
                    Name (NBAP, Zero)
                    Name (NNBO, One)
                    Name (NDCB, Zero)
                    Name (NLB1, 0xC8)
                    Name (NLB2, 0x64)
                    Mutex (BTMX, 0x00)
                    Name (NBTT, Package (0x08)
                    {
                        "Unknown", 
                        "NiMH", 
                        "LiIon"
                    })
                    Method (UPAD, 0, Serialized)
                    {
                        Acquire (BTMX, 0xFFFF)
                        If (And (GACP, One))
                        {
                            And (GACP, 0x06, GACP) /* \_SB_.PCI0.LPCB.EC0_.GACP */
                            Release (BTMX)
                            Store (One, Local0)
                            Store (Zero, Local1)
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                Store (ADP, Local0)
                                Store (ADID, Local1)
                            }

                            Release (ECMX)
                            Store (Local0, ACST) /* \_SB_.PCI0.LPCB.EC0_.ACST */
                            If (And (DTCD, 0x0800))
                            {
                                If (And (DTCD, 0x1000))
                                {
                                    Store (Zero, ACST) /* \_SB_.PCI0.LPCB.EC0_.ACST */
                                }
                                Else
                                {
                                    Store (One, ACST) /* \_SB_.PCI0.LPCB.EC0_.ACST */
                                }
                            }

                            Store (Local1, SMAR) /* \_SB_.PCI0.LPCB.EC0_.SMAR */
                        }
                        Else
                        {
                            Release (BTMX)
                        }
                    }

                    Method (GACS, 0, Serialized)
                    {
                        UPAD ()
                        Return (ACST) /* \_SB_.PCI0.LPCB.EC0_.ACST */
                    }

                    Method (GPID, 0, Serialized)
                    {
                        UPAD ()
                        Return (SMAR) /* \_SB_.PCI0.LPCB.EC0_.SMAR */
                    }

                    Method (GBAP, 0, Serialized)
                    {
                        Acquire (BTMX, 0xFFFF)
                        If (And (GACP, 0x02))
                        {
                            And (GACP, 0x05, GACP) /* \_SB_.PCI0.LPCB.EC0_.GACP */
                            Release (BTMX)
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                Store (BATP, NBAP) /* \_SB_.PCI0.LPCB.EC0_.NBAP */
                            }

                            Release (ECMX)
                        }
                        Else
                        {
                            Release (BTMX)
                        }

                        Return (NBAP) /* \_SB_.PCI0.LPCB.EC0_.NBAP */
                    }

                    Method (PWUP, 2, Serialized)
                    {
                        Store (Zero, Local0)
                        Acquire (BTMX, 0xFFFF)
                        Or (Arg0, GACP, Local1)
                        And (Local1, 0x07, GACP) /* \_SB_.PCI0.LPCB.EC0_.GACP */
                        If (And (GACP, 0x02))
                        {
                            Or (NGBF, Arg1, NGBF) /* \_SB_.PCI0.LPCB.EC0_.NGBF */
                        }

                        If (And (GACP, 0x04))
                        {
                            If (LNotEqual (NGBT, 0xFF))
                            {
                                Store (One, Local0)
                            }

                            Or (NGBT, Arg1, NGBT) /* \_SB_.PCI0.LPCB.EC0_.NGBT */
                        }

                        Release (BTMX)
                        Return (Local0)
                    }

                    Method (BTDR, 1, Serialized)
                    {
                        If (LEqual (Arg0, One))
                        {
                            Store (One, NNBO) /* \_SB_.PCI0.LPCB.EC0_.NNBO */
                        }
                        Else
                        {
                            If (LEqual (Arg0, Zero))
                            {
                                Store (Zero, NNBO) /* \_SB_.PCI0.LPCB.EC0_.NNBO */
                            }
                        }

                        Return (NNBO) /* \_SB_.PCI0.LPCB.EC0_.NNBO */
                    }

                    Method (BSTA, 1, Serialized)
                    {
                        BTDR (One)
                        Store (GBAP (), Local0)
                        Store (0x0F, Local1)
                        If (And (Local0, Arg0))
                        {
                            Store (0x1F, Local1)
                        }

                        Return (Local1)
                    }

                    Method (GBSS, 2, Serialized)
                    {
                        ToBCD (Arg0, Local0)
                        Store (ISTR (Local0, 0x05), Local3)
                        Concatenate (Local3, " ", Local4)
                        ShiftRight (Arg1, 0x09, Local0)
                        Add (Local0, 0x07BC, Local1)
                        ToBCD (Local1, Local0)
                        Store (ISTR (Local0, 0x04), Local2)
                        Concatenate (Local4, Local2, Local3)
                        Concatenate (Local3, "/", Local4)
                        ShiftRight (Arg1, 0x05, Local0)
                        And (Local0, 0x0F, Local1)
                        ToBCD (Local1, Local0)
                        Store (ISTR (Local0, 0x02), Local2)
                        Concatenate (Local4, Local2, Local3)
                        Concatenate (Local3, "/", Local4)
                        And (Arg1, 0x1F, Local1)
                        ToBCD (Local1, Local0)
                        Store (ISTR (Local0, 0x02), Local2)
                        Concatenate (Local4, Local2, Local3)
                        Return (Local3)
                    }

                    Method (GBMF, 0, Serialized)
                    {
                        Store (Buffer (0x12) {}, Local0)
                        Store (Zero, Local3)
                        Store (BMF, Local1)
                        While (LAnd (LLess (Local3, 0x10), LNotEqual (Local1, Zero)))
                        {
                            Store (Local1, Index (Local0, Local3))
                            Increment (Local3)
                            Store (BMF, Local1)
                        }

                        Return (Local0)
                    }

                    Method (GCTL, 1, Serialized)
                    {
                        Name (CTBF, Buffer (0x10) {})
                        Store (Zero, Local3)
                        Store (Zero, Local2)
                        While (LNotEqual (Local3, 0x10))
                        {
                            Store (CTLB, Index (CTBF, Local2))
                            Increment (Local2)
                            Increment (Local3)
                        }

                        Return (CTBF) /* \_SB_.PCI0.LPCB.EC0_.GCTL.CTBF */
                    }

                    Method (GDNM, 1, Serialized)
                    {
                        Name (DNBF, Buffer (0x07) {})
                        Store (Zero, Local3)
                        Store (Zero, Local2)
                        While (LNotEqual (Local3, 0x07))
                        {
                            Store (BDN, Index (DNBF, Local2))
                            Increment (Local2)
                            Increment (Local3)
                        }

                        Return (DNBF) /* \_SB_.PCI0.LPCB.EC0_.GDNM.DNBF */
                    }

                    Method (GDCH, 1, Serialized)
                    {
                        Name (DCBF, Buffer (0x04) {})
                        Store (Zero, Local3)
                        Store (Zero, Local2)
                        While (LNotEqual (Local3, 0x04))
                        {
                            Store (BTY, Index (DCBF, Local2))
                            Increment (Local2)
                            Increment (Local3)
                        }

                        Return (DCBF) /* \_SB_.PCI0.LPCB.EC0_.GDCH.DCBF */
                    }

                    Method (BTIF, 1, Serialized)
                    {
                        ShiftLeft (One, Arg0, Local7)
                        BTDR (One)
                        If (LEqual (BSTA (Local7), 0x0F))
                        {
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        Store (NGBF, Local0)
                        Release (BTMX)
                        If (LEqual (And (Local0, Local7), Zero))
                        {
                            Return (Zero)
                        }

                        Store (NDBS, Index (NBST, Arg0))
                        Acquire (BTMX, 0xFFFF)
                        Or (NGBT, Local7, NGBT) /* \_SB_.PCI0.LPCB.EC0_.NGBT */
                        Release (BTMX)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg0, BSEL) /* \_SB_.PCI0.LPCB.EC0_.BSEL */
                            Store (B1B2 (BFC0, BFC1), Local0)
                            Store (Local0, Index (DerefOf (Index (NBTI, Arg0)), One))
                            Store (Local0, Index (DerefOf (Index (NBTI, Arg0)), 0x02))
                            Store (B1B2 (BDV0, BDV1), Index (DerefOf (Index (NBTI, Arg0)), 
                                0x04))
                            Store (NLB1, Index (DerefOf (Index (NBTI, Arg0)), 0x05))
                            Store (NLB2, Index (DerefOf (Index (NBTI, Arg0)), 0x06))
                            Store (B1B2 (BSN0, BSN1), Local0)
                            Store (B1B2 (BDA0, BDA1), Local1)
                            Store (B1B2 (BCC0, BCC1), Index (DerefOf (Index (NBTI, Arg0)), 
                                0x0D))
                            Acquire (ECMX, 0xFFFF)
                            Store (0x05, CRZN) /* \_SB_.PCI0.LPCB.EC0_.CRZN */
                            Store (TEMP, Local2)
                            Release (ECMX)
                            Add (Multiply (Local2, 0x0A), 0x0AAC, Local2)
                            Store (Local2, Index (DerefOf (Index (NBTI, Arg0)), 0x0E))
                        }

                        Release (ECMX)
                        Store (GBSS (Local0, Local1), Local2)
                        Store (Local2, Index (DerefOf (Index (NBTI, Arg0)), 0x0A))
                        Acquire (BTMX, 0xFFFF)
                        And (NGBF, Not (Local7), NGBF) /* \_SB_.PCI0.LPCB.EC0_.NGBF */
                        Release (BTMX)
                        Return (Zero)
                    }

                    Method (BTST, 2, Serialized)
                    {
                        ShiftLeft (One, Arg0, Local7)
                        BTDR (One)
                        If (LEqual (BSTA (Local7), 0x0F))
                        {
                            Store (Package (0x04)
                                {
                                    Zero, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF, 
                                    0xFFFFFFFF
                                }, Index (NBST, Arg0))
                            Return (0xFF)
                        }

                        Acquire (BTMX, 0xFFFF)
                        If (Arg1)
                        {
                            Store (0xFF, NGBT) /* \_SB_.PCI0.LPCB.EC0_.NGBT */
                        }

                        Store (NGBT, Local0)
                        Release (BTMX)
                        If (LEqual (And (Local0, Local7), Zero))
                        {
                            Return (Zero)
                        }

                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Arg0, BSEL) /* \_SB_.PCI0.LPCB.EC0_.BSEL */
                            Store (BST, Local0)
                            Store (B1B2 (BPR0, BPR1), Local3)
                            Store (B1B2 (BRC0, BRC1), Index (DerefOf (Index (NBST, Arg0)), 
                                0x02))
                            Store (B1B2 (BPV0, BPV1), Index (DerefOf (Index (NBST, Arg0)), 
                                0x03))
                        }

                        Release (ECMX)
                        If (LEqual (GACS (), One))
                        {
                            And (0xFFFFFFFFFFFFFFFE, Local0, Local0)
                        }
                        Else
                        {
                            And (0xFFFFFFFFFFFFFFFD, Local0, Local0)
                        }

                        If (And (Local0, One))
                        {
                            Acquire (BTMX, 0xFFFF)
                            Store (Local7, NDCB) /* \_SB_.PCI0.LPCB.EC0_.NDCB */
                            Release (BTMX)
                        }

                        Store (Local0, Index (DerefOf (Index (NBST, Arg0)), Zero))
                        If (And (Local0, One))
                        {
                            If (LOr (LLess (Local3, 0x0190), LGreater (Local3, 0x1964)))
                            {
                                Store (DerefOf (Index (DerefOf (Index (NBST, Arg0)), One)), 
                                    Local5)
                                If (LOr (LLess (Local5, 0x0190), LGreater (Local5, 0x1964)))
                                {
                                    Store (0x0D7A, Local3)
                                }
                                Else
                                {
                                    Store (Local5, Local3)
                                }
                            }
                        }
                        Else
                        {
                            If (LEqual (And (Local0, 0x02), Zero))
                            {
                                Store (Zero, Local3)
                            }
                        }

                        Store (Local3, Index (DerefOf (Index (NBST, Arg0)), One))
                        Acquire (BTMX, 0xFFFF)
                        And (NGBT, Not (Local7), NGBT) /* \_SB_.PCI0.LPCB.EC0_.NGBT */
                        Release (BTMX)
                        Return (Zero)
                    }

                    Method (ITLB, 0, NotSerialized)
                    {
                        Divide (Add (NLB1, 0x09), 0x0A, Local0, Local1)
                        Divide (0x9F, 0x0A, Local0, Local2)
                        If (ECRG)
                        {
                            Store (Local1, LB1) /* \_SB_.PCI0.LPCB.EC0_.LB1_ */
                            Store (Local2, LB2) /* \_SB_.PCI0.LPCB.EC0_.LB2_ */
                        }
                    }

                    Method (GBTI, 1, NotSerialized)
                    {
                        Store ("Enter getbattinfo", Debug)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            If (And (BATP, ShiftLeft (One, Arg0)))
                            {
                                Store (Arg0, BSEL) /* \_SB_.PCI0.LPCB.EC0_.BSEL */
                                Store (Package (0x03)
                                    {
                                        Zero, 
                                        0x6B, 
                                        Buffer (0x6B) {}
                                    }, Local0)
                                Store (B1B2 (BDC0, BDC1), Index (DerefOf (Index (Local0, 0x02)), 
                                    Zero))
                                Store (ShiftRight (B1B2 (BDC0, BDC1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), One))
                                Store (B1B2 (BFC0, BFC1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x02))
                                Store (ShiftRight (B1B2 (BFC0, BFC1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x03))
                                Store (B1B2 (BRC0, BRC1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x04))
                                Store (ShiftRight (B1B2 (BRC0, BRC1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x05))
                                Store (B1B2 (BME0, BME1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x06))
                                Store (ShiftRight (B1B2 (BME0, BME1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x07))
                                Store (B1B2 (BCC0, BCC1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x08))
                                Store (ShiftRight (B1B2 (BCC0, BCC1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x09))
                                Store (B1B2 (CBT0, CBT1), Local1)
                                Subtract (Local1, 0x0AAC, Local1)
                                Divide (Local1, 0x0A, Local2, Local3)
                                Store (Local3, Index (DerefOf (Index (Local0, 0x02)), 0x0A))
                                Store (ShiftRight (Local3, 0x08), Index (DerefOf (Index (Local0, 0x02
                                    )), 0x0B))
                                Store (B1B2 (BPV0, BPV1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x0C))
                                Store (ShiftRight (B1B2 (BPV0, BPV1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x0D))
                                Store (B1B2 (BPR0, BPR1), Local1)
                                If (Local1)
                                {
                                    If (And (B1B2 (BST0, BST1), 0x40))
                                    {
                                        Add (Not (Local1), One, Local1)
                                        And (Local1, 0xFFFF, Local1)
                                    }
                                }

                                Store (Local1, Index (DerefOf (Index (Local0, 0x02)), 0x0E))
                                Store (ShiftRight (Local1, 0x08), Index (DerefOf (Index (Local0, 0x02
                                    )), 0x0F))
                                Store (B1B2 (BDV0, BDV1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x10))
                                Store (ShiftRight (B1B2 (BDV0, BDV1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x11))
                                Store (B1B2 (BST0, BST1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x12))
                                Store (ShiftRight (B1B2 (BST0, BST1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x13))
                                Store (B1B2 (BCX0, BCX1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x14))
                                Store (ShiftRight (B1B2 (BCX0, BCX1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x15))
                                Store (B1B2 (BCA0, BCA1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x16))
                                Store (ShiftRight (B1B2 (BCA0, BCA1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x17))
                                Store (B1B2 (BCB0, BCB1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x18))
                                Store (ShiftRight (B1B2 (BCB0, BCB1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x19))
                                Store (B1B2 (BCP0, BCP1), Index (DerefOf (Index (Local0, 0x02)), 
                                    0x1A))
                                Store (ShiftRight (B1B2 (BCP0, BCP1), 0x08), Index (DerefOf (Index (
                                    Local0, 0x02)), 0x1B))
                                CreateField (DerefOf (Index (Local0, 0x02)), 0xE0, 0x80, BTSN)
                                Store (GBSS (B1B2 (BSN0, BSN1), B1B2 (BDA0, BDA1)), BTSN) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BTSN */
                                Store (GBMF (), Local1)
                                Store (SizeOf (Local1), Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), 0x0160, Multiply (Local2, 0x08
                                    ), BMAN)
                                Store (Local1, BMAN) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BMAN */
                                Add (Local2, 0x2C, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x80, CLBL)
                                Store (GCTL (Zero), CLBL) /* \_SB_.PCI0.LPCB.EC0_.GBTI.CLBL */
                                Add (Local2, 0x11, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x38, DNAM)
                                Store (GDNM (Zero), DNAM) /* \_SB_.PCI0.LPCB.EC0_.GBTI.DNAM */
                                Add (Local2, 0x07, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x20, DCHE)
                                Store (GDCH (Zero), DCHE) /* \_SB_.PCI0.LPCB.EC0_.GBTI.DCHE */
                                Add (Local2, 0x04, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, BMAC)
                                Store (Zero, BMAC) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BMAC */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, BMAD)
                                Store (B1B2 (BDA0, BDA1), BMAD) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BMAD */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, BCCU)
                                Store (BRCC, BCCU) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BCCU */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, BCVO)
                                Store (BRCV, BCVO) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BCVO */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, BAVC)
                                Store (B1B2 (BCR0, BCR1), Local1)
                                If (Local1)
                                {
                                    If (And (B1B2 (BST0, BST1), 0x40))
                                    {
                                        Add (Not (Local1), One, Local1)
                                        And (Local1, 0xFFFF, Local1)
                                    }
                                }

                                Store (Local1, BAVC) /* \_SB_.PCI0.LPCB.EC0_.GBTI.BAVC */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, RTTE)
                                Store (B1B2 (RTE0, RTE1), RTTE) /* \_SB_.PCI0.LPCB.EC0_.GBTI.RTTE */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, ATTE)
                                Store (B1B2 (ATE0, ATE1), RTTE) /* \_SB_.PCI0.LPCB.EC0_.GBTI.RTTE */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x10, ATTF)
                                Store (B1B2 (ATF0, ATF1), RTTE) /* \_SB_.PCI0.LPCB.EC0_.GBTI.RTTE */
                                Add (Local2, 0x02, Local2)
                                CreateField (DerefOf (Index (Local0, 0x02)), Multiply (Local2, 0x08), 
                                    0x08, NOBS)
                                Store (BATN, NOBS) /* \_SB_.PCI0.LPCB.EC0_.GBTI.NOBS */
                            }
                            Else
                            {
                                Store (Package (0x02)
                                    {
                                        0x34, 
                                        Zero
                                    }, Local0)
                            }
                        }
                        Else
                        {
                            Store (Package (0x02)
                                {
                                    0x0D, 
                                    Zero
                                }, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (GBTC, 0, NotSerialized)
                    {
                        Store ("Enter GetBatteryControl", Debug)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Package (0x03)
                                {
                                    Zero, 
                                    0x04, 
                                    Buffer (0x04) {}
                                }, Local0)
                            If (And (BATP, One))
                            {
                                Store (Zero, BSEL) /* \_SB_.PCI0.LPCB.EC0_.BSEL */
                                Store (Zero, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                If (And (BST, One))
                                {
                                    Store (0x02, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                }

                                If (And (BST, 0x02))
                                {
                                    Store (One, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                }

                                If (And (BST, 0x04))
                                {
                                    Store (0x0E, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                }

                                If (LGreaterEqual (B1B2 (AXC0, AXC1), 0xFA))
                                {
                                    Store (0x03, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                }
                                Else
                                {
                                    If (LAnd (LEqual (INAC, Zero), LEqual (INCH, 0x03)))
                                    {
                                        Store (0x04, Index (DerefOf (Index (Local0, 0x02)), Zero))
                                    }
                                }
                            }
                            Else
                            {
                                Store (0xFF, Index (DerefOf (Index (Local0, 0x02)), Zero))
                            }

                            If (And (BATP, 0x02))
                            {
                                Store (One, BSEL) /* \_SB_.PCI0.LPCB.EC0_.BSEL */
                                Store (Zero, Index (DerefOf (Index (Local0, 0x02)), One))
                                If (And (BST, One))
                                {
                                    Store (0x02, Index (DerefOf (Index (Local0, 0x02)), One))
                                }

                                If (And (BST, 0x02))
                                {
                                    Store (One, Index (DerefOf (Index (Local0, 0x02)), One))
                                }

                                If (And (BST, 0x04))
                                {
                                    Store (0x0E, Index (DerefOf (Index (Local0, 0x02)), One))
                                }

                                If (LGreaterEqual (B1B2 (AXC0, AXC1), 0xFA))
                                {
                                    Store (0x03, Index (DerefOf (Index (Local0, 0x02)), One))
                                }
                                Else
                                {
                                    If (LAnd (LEqual (INAC, Zero), LEqual (INCH, 0x03)))
                                    {
                                        Store (0x04, Index (DerefOf (Index (Local0, 0x02)), One))
                                    }
                                }
                            }
                            Else
                            {
                                Store (0xFF, Index (DerefOf (Index (Local0, 0x02)), One))
                            }
                        }
                        Else
                        {
                            Store (Package (0x02)
                                {
                                    0x35, 
                                    Zero
                                }, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (SBTC, 3, NotSerialized)
                    {
                        Store ("Enter SetBatteryControl", Debug)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (Zero, PSSB) /* \_SB_.PCI0.LPCB.EC0_.PSSB */
                            Store (Arg2, Local0)
                            Store (Local0, Debug)
                            Store (Package (0x02)
                                {
                                    0x06, 
                                    Zero
                                }, Local4)
                            Store (Zero, Local1)
                            Store (Zero, Local2)
                            Store (DerefOf (Index (Local0, 0x10)), Local1)
                            If (LEqual (Local1, Zero))
                            {
                                Store ("battery 0", Debug)
                                If (And (BATP, One))
                                {
                                    Store (DerefOf (Index (Local0, 0x11)), Local2)
                                    If (LEqual (Local2, Zero))
                                    {
                                        Store (Zero, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Zero, IDIS) /* \_SB_.PCI0.LPCB.EC0_.IDIS */
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (Zero, AXC0) /* \_SB_.PCI0.LPCB.EC0_.AXC0 */
                                        Store (Zero, AXC1) /* \_SB_.PCI0.LPCB.EC0_.AXC1 */
                                        Store (One, PSSB) /* \_SB_.PCI0.LPCB.EC0_.PSSB */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, One))
                                    {
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (0x02, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x02))
                                    {
                                        Store (One, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (0x02, IDIS) /* \_SB_.PCI0.LPCB.EC0_.IDIS */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x03))
                                    {
                                        Store (0xFA, AXC0) /* \_SB_.PCI0.LPCB.EC0_.AXC0 */
                                        Store (Zero, AXC1) /* \_SB_.PCI0.LPCB.EC0_.AXC1 */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x04))
                                    {
                                        Store (0xFA, AXC0) /* \_SB_.PCI0.LPCB.EC0_.AXC0 */
                                        Store (Zero, AXC1) /* \_SB_.PCI0.LPCB.EC0_.AXC1 */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x05))
                                    {
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (0x03, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }
                                }
                                Else
                                {
                                    Store (Package (0x02)
                                        {
                                            0x34, 
                                            Zero
                                        }, Local4)
                                }
                            }

                            If (LEqual (Local1, One))
                            {
                                If (And (BATP, 0x02))
                                {
                                    Store ("battery 1", Debug)
                                    Store (DerefOf (Index (Local0, 0x11)), Local2)
                                    If (LEqual (Local2, Zero))
                                    {
                                        Store (Zero, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Zero, IDIS) /* \_SB_.PCI0.LPCB.EC0_.IDIS */
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (Zero, AXC0) /* \_SB_.PCI0.LPCB.EC0_.AXC0 */
                                        Store (Zero, AXC1) /* \_SB_.PCI0.LPCB.EC0_.AXC1 */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, One))
                                    {
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (One, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x02))
                                    {
                                        Store (One, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (One, IDIS) /* \_SB_.PCI0.LPCB.EC0_.IDIS */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x03))
                                    {
                                        Store (0xFA, AXC0) /* \_SB_.PCI0.LPCB.EC0_.AXC0 */
                                        Store (Zero, AXC1) /* \_SB_.PCI0.LPCB.EC0_.AXC1 */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x04))
                                    {
                                        Store (Zero, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Zero, IDIS) /* \_SB_.PCI0.LPCB.EC0_.IDIS */
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }

                                    If (LEqual (Local2, 0x05))
                                    {
                                        Store (Zero, INAC) /* \_SB_.PCI0.LPCB.EC0_.INAC */
                                        Store (0x03, INCH) /* \_SB_.PCI0.LPCB.EC0_.INCH */
                                        Store (Package (0x02)
                                            {
                                                Zero, 
                                                Zero
                                            }, Local4)
                                    }
                                }
                                Else
                                {
                                    Store (Package (0x02)
                                        {
                                            0x34, 
                                            Zero
                                        }, Local4)
                                }
                            }
                        }

                        Release (ECMX)
                        Return (Local4)
                    }

                    Mutex (OTMT, 0x00)
                    Name (OTLL, Zero)
                    Name (OTSI, One)
                    Name (OTRT, Zero)
                    Name (OTEN, Zero)
                    Name (LRPC, Zero)
                    Name (MXCP, Zero)
                    Method (_Q03, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Acquire (BTMX, 0xFFFF)
                        Store (NDCB, Local0)
                        Release (BTMX)
                        PWUP (0x04, Local0)
                        SBTN (Local0, 0x80)
                    }

                    Method (_Q04, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Acquire (OTMT, 0xFFFF)
                        Store (GTST (), OTLL) /* \_SB_.PCI0.LPCB.EC0_.OTLL */
                        Store (One, OTSI) /* \_SB_.PCI0.LPCB.EC0_.OTSI */
                        Release (OTMT)
                        RPPC (Zero)
                        PPNT ()
                    }

                    Method (_Q05, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (THEM, Local0)
                    }

                    Method (_Q06, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        PWUP (0x05, 0x03)
                        If (BTDR (0x02))
                        {
                            Notify (ADP1, 0x80) // Status Change
                            PNOT ()
                        }

                        \_GPE.VBRE (Zero)
                        If (^^^RP03.PDSX)
                        {
                            If (LEqual (ADP, One))
                            {
                                Store (Zero, ^^^RP03.SMHC.D3EF) /* \_SB_.PCI0.RP03.SMHC.D3EF */
                            }
                            Else
                            {
                                Store (One, ^^^RP03.SMHC.D3EF) /* \_SB_.PCI0.RP03.SMHC.D3EF */
                            }
                        }
                        Else
                        {
                            If (LEqual (ADP, One))
                            {
                                Store (Zero, GI69) /* \GI69 */
                                Store (Zero, GL69) /* \GL69 */
                                Sleep (0x05)
                                Store (One, GL69) /* \GL69 */
                                Store (One, GI69) /* \GI69 */
                            }
                        }
                    }

                    Method (_Q08, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        PWUP (0x06, One)
                        Store (GBAP (), Local0)
                        If (LNotEqual (Local0, 0x02))
                        {
                            PWUP (0x04, 0x02)
                            If (BTDR (0x02))
                            {
                                Notify (BAT1, 0x80) // Status Change
                            }
                        }

                        If (BTDR (0x02))
                        {
                            Notify (BAT0, 0x81) // Information Change
                        }
                    }

                    Method (_Q0A, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (\_GPE.VLET (), Local4)
                        Notify (LID, 0x80) // Status Change
                        ^^^ACEL.AJAL ()
                    }

                    Method (_Q09, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        PWUP (0x04, One)
                        If (BTDR (0x02))
                        {
                            Notify (BAT0, 0x80) // Status Change
                        }
                    }

                    Method (_Q0B, 0, NotSerialized)  // _Qxx: EC Query
                    {
                    }

                    Method (_Q0C, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        Store (THEM, Local0)
                    }

                    Method (_Q18, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        PWUP (0x06, 0x02)
                        Store (GBAP (), Local0)
                        If (LNotEqual (Local0, One))
                        {
                            PWUP (0x04, One)
                            If (BTDR (0x02))
                            {
                                Notify (BAT0, 0x80) // Status Change
                            }
                        }

                        If (BTDR (0x02))
                        {
                            Notify (BAT1, 0x81) // Information Change
                        }
                    }

                    Method (_Q19, 0, NotSerialized)  // _Qxx: EC Query
                    {
                        PWUP (0x04, 0x02)
                        If (BTDR (0x02))
                        {
                            Notify (BAT1, 0x80) // Status Change
                        }
                    }

                    Method (SBTN, 2, Serialized)
                    {
                        If (And (Arg0, One))
                        {
                            Notify (BAT0, Arg1)
                        }

                        If (And (Arg0, 0x02))
                        {
                            Notify (BAT1, Arg1)
                        }
                    }

                    Method (PRIT, 0, NotSerialized)
                    {
                        RPPC (One)
                        Store (GACS (), PWRS) /* \PWRS */
                        PNOT ()
                        If (LEqual (^^^HDEF.ASTI, Zero))
                        {
                            SAST (^^^HDEF.ASTA)
                        }

                        Store (^^^^HST1.GHID (), Local0)
                        If (And (GBAP (), One))
                        {
                            Store (0x1F, BT0P) /* \_SB_.BT0P */
                        }
                    }

                    Method (GTST, 0, Serialized)
                    {
                        Store (0x02, Local0)
                        Acquire (ECMX, 0xFFFF)
                        If (ECRG)
                        {
                            Store (OCPS, Local0)
                        }

                        Release (ECMX)
                        Return (Local0)
                    }

                    Method (ETSI, 3, Serialized)
                    {
                        If (LNotEqual (Arg2, Zero))
                        {
                            Store (Zero, OTRT) /* \_SB_.PCI0.LPCB.EC0_.OTRT */
                        }

                        If (LOr (LNotEqual (Arg1, OTRT), LNotEqual (Arg0, OTEN)))
                        {
                            Acquire (ECMX, 0xFFFF)
                            If (ECRG)
                            {
                                If (LNotEqual (Arg1, OTRT))
                                {
                                    Store (Arg1, OCPR) /* \_SB_.PCI0.LPCB.EC0_.OCPR */
                                    Store (Arg1, OTRT) /* \_SB_.PCI0.LPCB.EC0_.OTRT */
                                }

                                Store (Arg0, OCPE) /* \_SB_.PCI0.LPCB.EC0_.OCPE */
                                Store (Arg0, OTEN) /* \_SB_.PCI0.LPCB.EC0_.OTEN */
                            }

                            Release (ECMX)
                        }
                    }

                    Method (SMCP, 1, Serialized)
                    {
                        Acquire (OTMT, 0xFFFF)
                        If (LEqual (Arg0, Zero))
                        {
                            Store (One, MXCP) /* \_SB_.PCI0.LPCB.EC0_.MXCP */
                            If (LEqual (LRPC, Zero))
                            {
                                Store (One, LRPC) /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                            }
                        }
                        Else
                        {
                            Store (Zero, MXCP) /* \_SB_.PCI0.LPCB.EC0_.MXCP */
                            If (LEqual (LRPC, One))
                            {
                                Store (Zero, LRPC) /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                            }
                        }

                        Release (OTMT)
                        RPPC (One)
                        PPNT ()
                    }

                    Method (RPPC, 1, Serialized)
                    {
                        Store (Zero, Local1)
                        If (CondRefOf (\_PR.CPU0._PSS, Local2))
                        {
                            Store (\_PR.CPU0._PSS, Local0)
                            Store (SizeOf (Local0), Local1)
                        }

                        Store (Zero, Local3)
                        If (LGreater (Local1, Zero))
                        {
                            Subtract (Local1, One, Local1)
                        }
                        Else
                        {
                            Store (0x03, Local3)
                        }

                        Acquire (OTMT, 0xFFFF)
                        If (OTSI)
                        {
                            Store (OTLL, Local0)
                            Store (Zero, OTSI) /* \_SB_.PCI0.LPCB.EC0_.OTSI */
                            If (LEqual (Local0, Zero))
                            {
                                If (LLess (LRPC, Local1))
                                {
                                    Add (LRPC, One, LRPC) /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                                }
                            }
                            Else
                            {
                                If (LEqual (Local0, 0x02))
                                {
                                    If (LGreater (LRPC, MXCP))
                                    {
                                        Subtract (LRPC, One, LRPC) /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                                    }
                                }
                                Else
                                {
                                    If (LEqual (Local0, 0x03))
                                    {
                                        Store (Local1, LRPC) /* \_SB_.PCI0.LPCB.EC0_.LRPC */
                                    }
                                }
                            }
                        }

                        If (LLess (LRPC, Local1))
                        {
                            Or (Local3, One, Local3)
                        }

                        If (LGreater (LRPC, MXCP))
                        {
                            Or (Local3, 0x02, Local3)
                        }

                        ETSI (Local3, 0x14, Arg0)
                        Release (OTMT)
                        If (CondRefOf (\_PR.CPU0._PPC, Local5))
                        {
                            Store (LRPC, \_PR.CPU0._PPC) /* External reference */
                        }
                    }

                    Method (PPNT, 0, Serialized)
                    {
                    }
                }

                Device (DMAC)
                {
                    Name (_HID, EisaId ("PNP0200"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0000,             // Range Minimum
                            0x0000,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        IO (Decode16,
                            0x0081,             // Range Minimum
                            0x0081,             // Range Maximum
                            0x01,               // Alignment
                            0x11,               // Length
                            )
                        IO (Decode16,
                            0x0093,             // Range Minimum
                            0x0093,             // Range Maximum
                            0x01,               // Alignment
                            0x0D,               // Length
                            )
                        IO (Decode16,
                            0x00C0,             // Range Minimum
                            0x00C0,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                        DMA (Compatibility, NotBusMaster, Transfer8_16, )
                            {4}
                    })
                }

                Device (FWHD)
                {
                    Name (_HID, EisaId ("INT0800"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        Memory32Fixed (ReadOnly,
                            0xFF000000,         // Address Base
                            0x01000000,         // Address Length
                            )
                    })
                }

                Device (HTAM)
                {
                    Name (_HID, EisaId ("PNP0C02"))  // _HID: Hardware ID
                    Name (_UID, 0x05)  // _UID: Unique ID
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (ResourceTemplate ()
                        {
                            IO (Decode16,
                                0xFE00,             // Range Minimum
                                0xFE00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0xFE80,             // Range Minimum
                                0xFE80,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            Memory32Fixed (ReadWrite,
                                0xFED40000,         // Address Base
                                0x00005000,         // Address Length
                                )
                        })
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (LEqual (TPMX, Zero))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            Return (0x0F)
                        }
                    }
                }

                Device (GTPM)
                {
                    Method (_HID, 0, Serialized)  // _HID: Hardware ID
                    {
                        If (LEqual (TVID, 0x15D1))
                        {
                            Return (0x0201D824)
                        }
                        Else
                        {
                            Return (0x310CD041)
                        }
                    }

                    Name (_CID, EisaId ("PNP0C31"))  // _CID: Compatible ID
                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Return (ResourceTemplate ()
                        {
                            IO (Decode16,
                                0xFE00,             // Range Minimum
                                0xFE00,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            IO (Decode16,
                                0xFE80,             // Range Minimum
                                0xFE80,             // Range Maximum
                                0x01,               // Alignment
                                0x10,               // Length
                                )
                            Memory32Fixed (ReadWrite,
                                0xFED40000,         // Address Base
                                0x00005000,         // Address Length
                                )
                        })
                    }

                    OperationRegion (TMMB, SystemMemory, 0xFED40000, 0x1000)
                    Field (TMMB, ByteAcc, Lock, Preserve)
                    {
                        ACCS,   8, 
                        Offset (0x18), 
                        TSTA,   8, 
                        TBCA,   8, 
                        Offset (0xF00), 
                        TVID,   16, 
                        TDID,   16
                    }

                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        If (LEqual (ACCS, 0xFF))
                        {
                            Return (Zero)
                        }
                        Else
                        {
                            If (LEqual (TPMX, One))
                            {
                                Return (Zero)
                            }
                            Else
                            {
                                Return (0x0F)
                            }
                        }
                    }

                    Name (PUID, Buffer (0x10)
                    {
                        /* 0000 */   0xA6, 0xFA, 0xDD, 0x3D, 0x1B, 0x36, 0xB4, 0x4E,
                        /* 0008 */   0xA4, 0x24, 0x8D, 0x10, 0x08, 0x9D, 0x16, 0x53
                    })
                    Name (REV1, "1.0")
                    Name (PPIB, Buffer (0x02)
                    {
                         0x00, 0x00
                    })
                    Name (MUID, Buffer (0x10)
                    {
                        /* 0000 */   0xED, 0x54, 0x60, 0x37, 0x13, 0xCC, 0x75, 0x46,
                        /* 0008 */   0x90, 0x1C, 0x47, 0x56, 0xD7, 0xF2, 0xD4, 0x5D
                    })
                    Method (HPPI, 4, NotSerialized)
                    {
                        If (LNotEqual (Arg1, One))
                        {
                            Return (Buffer (One)
                            {
                                 0x00
                            })
                        }

                        If (LLessEqual (Arg2, 0x06))
                        {
                            If (LEqual (Arg2, Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x7F
                                })
                            }

                            If (LEqual (Arg2, One))
                            {
                                Return (REV1) /* \_SB_.PCI0.LPCB.GTPM.REV1 */
                            }

                            If (LEqual (Arg2, 0x02))
                            {
                                Store (DerefOf (Index (Arg3, Zero)), Local0)
                                Store ("TPM Func 2", Debug)
                                Store (Local0, Debug)
                                If (LLessEqual (Local0, 0x0E))
                                {
                                    If (LOr (LEqual (Local0, 0x0C), LEqual (Local0, 0x0D)))
                                    {
                                        Return (One)
                                    }
                                    Else
                                    {
                                        Store (0x02, Local2)
                                        SSMI (0xEA7D, 0x05, Zero, Zero, Zero)
                                        Store (ECX, Local1)
                                        If (LEqual (And (Local1, One), One))
                                        {
                                            If (LEqual (And (Local1, 0x02), Zero))
                                            {
                                                If (LOr (LEqual (Local0, 0x05), LEqual (Local0, 0x0E)))
                                                {
                                                    Return (Local2)
                                                }
                                            }

                                            SSMI (0xEA7E, Zero, Local0, Zero, One)
                                            Store (EAX, Debug)
                                            Store (EBX, Debug)
                                            Store (ECX, Debug)
                                            If (LEqual (EBX, Zero))
                                            {
                                                Store (Zero, Local2)
                                            }
                                        }

                                        Return (Local2)
                                    }
                                }
                                Else
                                {
                                    Return (One)
                                }
                            }

                            If (LEqual (Arg2, 0x03))
                            {
                                Store ("TPM Func 3", Debug)
                                SSMI (0xEA7D, Zero, Zero, Zero, One)
                                Store (EAX, Debug)
                                Store (EBX, Debug)
                                Store (ECX, Debug)
                                Name (DSMB, Package (0x02)
                                {
                                    One, 
                                    Zero
                                })
                                If (LEqual (EBX, Zero))
                                {
                                    Store (Zero, Index (DSMB, Zero))
                                    Store (Zero, Index (DSMB, One))
                                    Store (ECX, Local0)
                                    If (LLessEqual (Local0, 0x0E))
                                    {
                                        Store (Zero, Index (DSMB, Zero))
                                        Store (Local0, Index (DSMB, One))
                                    }
                                }

                                Return (DSMB) /* \_SB_.PCI0.LPCB.GTPM.HPPI.DSMB */
                            }

                            If (LEqual (Arg2, 0x04))
                            {
                                Return (0x02)
                            }

                            If (LEqual (Arg2, 0x05))
                            {
                                Store ("TPM Func 5", Debug)
                                SSMI (0xEA7D, One, Zero, Zero, One)
                                Name (DSMC, Package (0x03)
                                {
                                    One, 
                                    Zero, 
                                    Zero
                                })
                                Store (EAX, Debug)
                                Store (EBX, Debug)
                                Store (ECX, Debug)
                                If (LEqual (EBX, Zero))
                                {
                                    Store (Zero, Index (DSMC, Zero))
                                    Store (ECX, Index (DSMC, One))
                                    SSMI (0xEA7D, 0x02, Zero, Zero, One)
                                    Store (ECX, Index (DSMC, 0x02))
                                }

                                Return (DSMC) /* \_SB_.PCI0.LPCB.GTPM.HPPI.DSMC */
                            }

                            If (LEqual (Arg2, 0x06))
                            {
                                Store (Arg3, PPIB) /* \_SB_.PCI0.LPCB.GTPM.PPIB */
                                If (LAnd (LOr (LEqual (DerefOf (Index (PPIB, Zero)), 0x45), 
                                    LEqual (DerefOf (Index (PPIB, Zero)), 0x65)), LOr (LEqual (DerefOf (Index (
                                    PPIB, One)), 0x4E), LEqual (DerefOf (Index (PPIB, One)), 0x6E))))
                                {
                                    Return (Zero)
                                }
                                Else
                                {
                                    Return (One)
                                }
                            }
                        }

                        Return (Buffer (One)
                        {
                             0x00
                        })
                    }

                    Method (HMOR, 4, NotSerialized)
                    {
                        If (LNotEqual (Arg1, One))
                        {
                            Return (One)
                        }

                        If (LNotEqual (Arg2, One))
                        {
                            Return (One)
                        }

                        Store (DerefOf (Index (Arg3, Zero)), Local0)
                        SSMI (0xEA7F, Local0, Zero, Zero, One)
                        Store (Zero, Local0)
                        If (LNotEqual (EBX, Zero))
                        {
                            Store (One, Local0)
                        }

                        Return (Local0)
                    }
                }

                Device (HPET)
                {
                    Name (_HID, EisaId ("PNP0103"))  // _HID: Hardware ID
                    Name (_UID, Zero)  // _UID: Unique ID
                    Name (BUF0, ResourceTemplate ()
                    {
                        IRQNoFlags ()
                            {0,8,11,15}
                        Memory32Fixed (ReadWrite,
                            0xFED00000,         // Address Base
                            0x00000400,         // Address Length
                            )
                    })
                    Name (_STA, 0x0F)  // _STA: Status
                    Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                    {
                        Return (BUF0) /* \_SB_.PCI0.LPCB.HPET.BUF0 */
                    }
                }

                Device (IPIC)
                {
                    Name (_HID, EisaId ("PNP0000"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0020,             // Range Minimum
                            0x0020,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0024,             // Range Minimum
                            0x0024,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0028,             // Range Minimum
                            0x0028,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x002C,             // Range Minimum
                            0x002C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0030,             // Range Minimum
                            0x0030,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0034,             // Range Minimum
                            0x0034,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0038,             // Range Minimum
                            0x0038,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x003C,             // Range Minimum
                            0x003C,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A0,             // Range Minimum
                            0x00A0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A4,             // Range Minimum
                            0x00A4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00A8,             // Range Minimum
                            0x00A8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00AC,             // Range Minimum
                            0x00AC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B0,             // Range Minimum
                            0x00B0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B4,             // Range Minimum
                            0x00B4,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00B8,             // Range Minimum
                            0x00B8,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x00BC,             // Range Minimum
                            0x00BC,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x04D0,             // Range Minimum
                            0x04D0,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                }

                Device (MATH)
                {
                    Name (_HID, EisaId ("PNP0C04"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x00F0,             // Range Minimum
                            0x00F0,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQNoFlags ()
                            {13}
                    })
                }

                Device (LDRC)
                {
                    Name (_HID, EisaId ("PNP0C02"))  // _HID: Hardware ID
                    Name (_UID, 0x02)  // _UID: Unique ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x002E,             // Range Minimum
                            0x002E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x004E,             // Range Minimum
                            0x004E,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0061,             // Range Minimum
                            0x0061,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0063,             // Range Minimum
                            0x0063,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0065,             // Range Minimum
                            0x0065,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0067,             // Range Minimum
                            0x0067,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0080,             // Range Minimum
                            0x0080,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0092,             // Range Minimum
                            0x0092,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x00B2,             // Range Minimum
                            0x00B2,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                        IO (Decode16,
                            0x0200,             // Range Minimum
                            0x0200,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x1000,             // Range Minimum
                            0x1000,             // Range Maximum
                            0x01,               // Alignment
                            0x10,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0xFFFF,             // Range Minimum
                            0xFFFF,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0400,             // Range Minimum
                            0x0400,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0x0500,             // Range Minimum
                            0x0500,             // Range Maximum
                            0x01,               // Alignment
                            0x80,               // Length
                            )
                        IO (Decode16,
                            0xEF80,             // Range Minimum
                            0xEF80,             // Range Maximum
                            0x01,               // Alignment
                            0x20,               // Length
                            )
                    })
                }

                Device (RTC)
                {
                    Name (_HID, EisaId ("PNP0B00"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0070,             // Range Minimum
                            0x0070,             // Range Maximum
                            0x01,               // Alignment
                            0x02,               // Length
                            )
                    })
                }

                Device (TIMR)
                {
                    Name (_HID, EisaId ("PNP0100"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0040,             // Range Minimum
                            0x0040,             // Range Maximum
                            0x01,               // Alignment
                            0x04,               // Length
                            )
                        IO (Decode16,
                            0x0050,             // Range Minimum
                            0x0050,             // Range Maximum
                            0x10,               // Alignment
                            0x04,               // Length
                            )
                    })
                }

                Device (SIO)
                {
                    Name (_HID, EisaId ("PNP0A06"))  // _HID: Hardware ID
                    OperationRegion (SOCG, SystemIO, 0x4E, 0x02)
                    Field (SOCG, ByteAcc, NoLock, Preserve)
                    {
                        SIOI,   8, 
                        SIOD,   8
                    }

                    IndexField (SIOI, SIOD, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x01), 
                            ,   2, 
                        PPPW,   1, 
                        PPM,    1, 
                        Offset (0x02), 
                            ,   3, 
                        S1PW,   1, 
                            ,   3, 
                        S2PW,   1, 
                        Offset (0x04), 
                        PPXM,   2, 
                        Offset (0x0D), 
                        CR0D,   8, 
                        Offset (0x23), 
                        PPBS,   8, 
                        S1BS,   8, 
                        S2BS,   8, 
                        PPDM,   4, 
                        Offset (0x27), 
                        PPIQ,   4, 
                        Offset (0x28), 
                        S2IQ,   4, 
                        S1IQ,   4, 
                        Offset (0x2B), 
                        FRBS,   8, 
                        FRDM,   4
                    }

                    OperationRegion (SORT, SystemIO, 0x0210, 0x10)
                    Field (SORT, ByteAcc, NoLock, Preserve)
                    {
                        Offset (0x0C), 
                        GP1,    8, 
                        GP2,    5, 
                        Offset (0x0E), 
                        GP3,    8, 
                        GP4,    8
                    }

                    Mutex (SIOM, 0x00)
                    Name (MSPS, Zero)
                    Name (MSPV, Zero)
                    Method (_INI, 0, NotSerialized)  // _INI: Initialize
                    {
                        ECM ()
                        If (LNotEqual (CR0D, 0x7A))
                        {
                            Store (Zero, SDFG) /* \SDFG */
                        }

                        DCM ()
                    }

                    Method (ECM, 0, NotSerialized)
                    {
                        Acquire (SIOM, 0xFFFF)
                        Store (0x55, SIOI) /* \_SB_.PCI0.LPCB.SIO_.SIOI */
                    }

                    Method (DCM, 0, NotSerialized)
                    {
                        Store (0xAA, SIOI) /* \_SB_.PCI0.LPCB.SIO_.SIOI */
                        Release (SIOM)
                    }

                    Method (GETS, 1, NotSerialized)
                    {
                        ECM ()
                        Store (Zero, Local0)
                        If (LEqual (Arg0, One))
                        {
                            Store (PPBS, Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (S1BS, Local0)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (S2BS, Local0)
                                }
                            }
                        }

                        Store (Zero, Local1)
                        If (And (Local0, 0xC0))
                        {
                            ShiftLeft (Local0, 0x02, Local1)
                        }

                        DCM ()
                        Return (Local1)
                    }

                    Method (GETR, 1, NotSerialized)
                    {
                        Name (GRES, Package (0x04)
                        {
                            Zero, 
                            Zero, 
                            Zero, 
                            Zero
                        })
                        ECM ()
                        Store (Zero, Local0)
                        Store (Zero, Local1)
                        Store (Zero, Local2)
                        Store (Zero, Local3)
                        If (LEqual (Arg0, One))
                        {
                            Store (PPBS, Local0)
                            Store (PPIQ, Local2)
                            Store (PPDM, Local3)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (S1BS, Local0)
                                Store (S1IQ, Local2)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (S2BS, Local0)
                                    Store (FRBS, Local1)
                                    Store (S2IQ, Local2)
                                    Store (FRDM, Local3)
                                }
                            }
                        }

                        ShiftLeft (Local0, 0x02, Index (GRES, Zero))
                        ShiftLeft (Local1, 0x03, Index (GRES, One))
                        Store (Zero, Local4)
                        If (LGreater (Local2, Zero))
                        {
                            ShiftLeft (One, Local2, Local4)
                        }

                        Store (Local4, Index (GRES, 0x02))
                        Store (Zero, Local4)
                        If (LAnd (LGreater (Local3, Zero), LLess (Local3, 0x04)))
                        {
                            ShiftLeft (One, Local3, Local4)
                        }

                        Store (Local4, Index (GRES, 0x03))
                        DCM ()
                        Return (GRES) /* \_SB_.PCI0.LPCB.SIO_.GETR.GRES */
                    }

                    Method (SETR, 5, NotSerialized)
                    {
                        ECM ()
                        ShiftRight (Arg1, 0x02, Local0)
                        FindSetRightBit (Arg3, Local1)
                        If (LAnd (LGreater (Local1, One), LLess (Local1, 0x11)))
                        {
                            Decrement (Local1)
                        }
                        Else
                        {
                            Store (Zero, Local1)
                        }

                        FindSetRightBit (Arg4, Local2)
                        If (LAnd (LGreater (Local2, One), LLess (Local2, 0x05)))
                        {
                            Decrement (Local2)
                        }
                        Else
                        {
                            Store (0x0F, Local2)
                        }

                        If (LEqual (Arg0, One))
                        {
                            Store (Local0, PPBS) /* \_SB_.PCI0.LPCB.SIO_.PPBS */
                            Store (Local1, PPIQ) /* \_SB_.PCI0.LPCB.SIO_.PPIQ */
                            Store (Local2, PPDM) /* \_SB_.PCI0.LPCB.SIO_.PPDM */
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                And (Local0, 0xFE, S1BS) /* \_SB_.PCI0.LPCB.SIO_.S1BS */
                                Store (Local1, S1IQ) /* \_SB_.PCI0.LPCB.SIO_.S1IQ */
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    And (Local0, 0xFE, S2BS) /* \_SB_.PCI0.LPCB.SIO_.S2BS */
                                    ShiftRight (Arg2, 0x03, FRBS) /* \_SB_.PCI0.LPCB.SIO_.FRBS */
                                    Store (Local1, S2IQ) /* \_SB_.PCI0.LPCB.SIO_.S2IQ */
                                    Store (Local2, FRDM) /* \_SB_.PCI0.LPCB.SIO_.FRDM */
                                }
                            }
                        }

                        DCM ()
                    }

                    Method (GLPM, 0, NotSerialized)
                    {
                        ECM ()
                        Store (PPM, Local0)
                        Store (PPXM, Local1)
                        DCM ()
                        If (Local0)
                        {
                            Store (Zero, Local2)
                        }
                        Else
                        {
                            Store (0x03, Local2)
                            If (LEqual (Local1, Zero))
                            {
                                Store (One, Local2)
                            }

                            If (LEqual (Local1, One))
                            {
                                Store (0x02, Local2)
                            }
                        }

                        Return (Local2)
                    }

                    Method (DPWS, 1, Serialized)
                    {
                        ECM ()
                        If (LEqual (Arg0, One))
                        {
                            Store (PPPW, Local0)
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (S1PW, Local0)
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (S2PW, Local0)
                                }
                            }
                        }

                        DCM ()
                        Return (Local0)
                    }

                    Method (DPW, 2, Serialized)
                    {
                        ECM ()
                        If (LEqual (Arg0, One))
                        {
                            Store (Arg1, PPPW) /* \_SB_.PCI0.LPCB.SIO_.PPPW */
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (Arg1, S1PW) /* \_SB_.PCI0.LPCB.SIO_.S1PW */
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (Arg1, S2PW) /* \_SB_.PCI0.LPCB.SIO_.S2PW */
                                }
                            }
                        }

                        DCM ()
                    }

                    Method (GDPA, 0, Serialized)
                    {
                        Store (GETS (0x02), Local0)
                        Return (Local0)
                    }

                    Alias (GDPA, ^^^GDPA)
                    Method (SODS, 2, Serialized)
                    {
                        And (Not (SDFG), Arg1, Local1)
                        If (LOr (LEGF, Local1))
                        {
                            Store (Zero, Local0)
                        }
                        Else
                        {
                            Store (GETS (Arg0), Local1)
                            Store (0x0D, Local0)
                            If (Local1)
                            {
                                Store (0x0F, Local0)
                            }
                        }

                        Return (Local0)
                    }

                    Method (DSOD, 1, Serialized)
                    {
                        If (GETS (Arg0))
                        {
                            Store (GETR (Arg0), Local0)
                            Store (DerefOf (Index (Local0, One)), Local1)
                            Store (DerefOf (Index (Local0, 0x02)), Local2)
                            Store (DerefOf (Index (Local0, 0x03)), Local3)
                            Store (DerefOf (Index (Local0, Zero)), Local4)
                            Or (ShiftLeft (Local4, 0x08), Local3, Local3)
                            CFG (Arg0, Zero, Local1, Local2, Local3)
                            SETR (Arg0, Zero, Zero, Zero, Zero)
                        }
                    }

                    Device (HCOM)
                    {
                        Name (_HID, EisaId ("PNP0C02"))  // _HID: Hardware ID
                        Name (_UID, 0x04)  // _UID: Unique ID
                        Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                        {
                            Name (CMRS, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y15)
                            })
                            CreateWordField (CMRS, \_SB.PCI0.LPCB.SIO.HCOM._CRS._Y15._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CMRS, \_SB.PCI0.LPCB.SIO.HCOM._CRS._Y15._MAX, MAX1)  // _MAX: Maximum Base Address
                            Store (GETR (0x02), Local1)
                            Store (DerefOf (Index (Local1, Zero)), MIN1) /* \_SB_.PCI0.LPCB.SIO_.HCOM._CRS.MIN1 */
                            Store (MIN1, MAX1) /* \_SB_.PCI0.LPCB.SIO_.HCOM._CRS.MAX1 */
                            Return (CMRS) /* \_SB_.PCI0.LPCB.SIO_.HCOM._CRS.CMRS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Store (Zero, Local0)
                            If (LEGF)
                            {
                                If (GETS (0x02))
                                {
                                    Store (0x0F, Local0)
                                }
                            }

                            Return (Local0)
                        }
                    }

                    Device (COM1)
                    {
                        Name (_HID, EisaId ("PNP0501"))  // _HID: Hardware ID
                        Name (_CID, EisaId ("PNP0500"))  // _CID: Compatible ID
                        Name (_DDN, "COM1")  // _DDN: DOS Device Name
                        Name (RCOD, Zero)
                        Name (POSS, ResourceTemplate ()
                        {
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x02F8,             // Range Minimum
                                    0x02F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03E8,             // Range Minimum
                                    0x03E8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {4}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x02E8,             // Range Minimum
                                    0x02E8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IRQNoFlags ()
                                    {3}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            Return (POSS) /* \_SB_.PCI0.LPCB.SIO_.COM1.POSS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            Store (Zero, Local0)
                            If (LOr (DCKD (), ICPT))
                            {
                                If (LNot (RCOD))
                                {
                                    Store (SODS (0x02, 0x02), Local0)
                                }
                                Else
                                {
                                    Store (0x0D, Local0)
                                }
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            DSOD (0x02)
                            Return (Zero)
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x09, IRQ0)
                            If (SODS (0x02, 0x02))
                            {
                                _DIS ()
                                CFG (0x02, MIN1, Zero, IRQ0, Zero)
                                SETR (0x02, MIN1, Zero, IRQ0, Zero)
                            }

                            Store (Zero, RCOD) /* \_SB_.PCI0.LPCB.SIO_.COM1.RCOD */
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x03F8,             // Range Minimum
                                    0x03F8,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y16)
                                IRQNoFlags (_Y17)
                                    {4}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y16._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y16._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.COM1._CRS._Y17._INT, IRQ0)  // _INT: Interrupts
                            If (RCOD)
                            {
                                Store (Zero, Local0)
                            }
                            Else
                            {
                                Store (SODS (0x02, 0x02), Local0)
                            }

                            If (LEqual (Local0, Zero))
                            {
                                Store (Zero, MIN1) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.MIN1 */
                                Store (Zero, MAX1) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.MAX1 */
                                Store (Zero, IRQ0) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.IRQ0 */
                                Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.CRES */
                            }

                            Store (GETR (0x02), Local1)
                            Store (DerefOf (Index (Local1, Zero)), MIN1) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.MIN1 */
                            Store (MIN1, MAX1) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.MAX1 */
                            Store (DerefOf (Index (Local1, 0x02)), IRQ0) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.IRQ0 */
                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.COM1._CRS.CRES */
                        }

                        PowerResource (COMP, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                Return (DPWS (0x02))
                            }

                            Method (_ON, 0, NotSerialized)  // _ON_: Power On
                            {
                                DPW (0x02, One)
                            }

                            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                            {
                            }
                        }

                        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                        {
                            COMP
                        })
                    }

                    Device (LPT0)
                    {
                        Method (_HID, 0, Serialized)  // _HID: Hardware ID
                        {
                            If (GTM ())
                            {
                                Store (0x0104D041, Local0)
                            }
                            Else
                            {
                                Store (0x0004D041, Local0)
                            }

                            Return (Local0)
                        }

                        Name (LPM, 0xFF)
                        Method (GTM, 0, Serialized)
                        {
                            If (LEqual (LPM, 0xFF))
                            {
                                Store (GLPM (), Local0)
                                Store (Zero, LPM) /* \_SB_.PCI0.LPCB.SIO_.LPT0.LPM_ */
                                If (LGreater (Local0, One))
                                {
                                    Store (One, LPM) /* \_SB_.PCI0.LPCB.SIO_.LPT0.LPM_ */
                                }
                            }

                            Return (LPM) /* \_SB_.PCI0.LPCB.SIO_.LPT0.LPM_ */
                        }

                        Name (RLPD, Zero)
                        Name (POSS, ResourceTemplate ()
                        {
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFn (0x00, 0x00)
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {1,3}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {5,7}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x0278,             // Range Minimum
                                    0x0278,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    )
                                IO (Decode16,
                                    0x0678,             // Range Minimum
                                    0x0678,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            StartDependentFnNoPri ()
                            {
                                IO (Decode16,
                                    0x03BC,             // Range Minimum
                                    0x03BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x04,               // Length
                                    )
                                IO (Decode16,
                                    0x07BC,             // Range Minimum
                                    0x07BC,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    )
                                IRQNoFlags ()
                                    {}
                                DMA (Compatibility, NotBusMaster, Transfer8, )
                                    {}
                            }
                            EndDependentFn ()
                        })
                        Method (_PRS, 0, NotSerialized)  // _PRS: Possible Resource Settings
                        {
                            Return (POSS) /* \_SB_.PCI0.LPCB.SIO_.LPT0.POSS */
                        }

                        Method (_STA, 0, NotSerialized)  // _STA: Status
                        {
                            If (RLPD)
                            {
                                Store (0x0D, Local0)
                            }
                            Else
                            {
                                Store (SODS (One, 0x04), Local0)
                            }

                            Return (Local0)
                        }

                        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
                        {
                            DSOD (One)
                            Return (Zero)
                        }

                        Method (_SRS, 1, NotSerialized)  // _SRS: Set Resource Settings
                        {
                            CreateWordField (Arg0, 0x02, MIN1)
                            CreateWordField (Arg0, 0x0A, MIN2)
                            CreateWordField (Arg0, 0x11, IRQ0)
                            CreateWordField (Arg0, 0x14, DMA0)
                            If (SODS (One, 0x04))
                            {
                                _DIS ()
                                CFG (One, MIN1, MIN2, IRQ0, DMA0)
                                SETR (One, MIN1, MIN2, IRQ0, DMA0)
                            }

                            Store (Zero, RLPD) /* \_SB_.PCI0.LPCB.SIO_.LPT0.RLPD */
                        }

                        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
                        {
                            Name (CRES, ResourceTemplate ()
                            {
                                IO (Decode16,
                                    0x0378,             // Range Minimum
                                    0x0378,             // Range Maximum
                                    0x01,               // Alignment
                                    0x08,               // Length
                                    _Y18)
                                IO (Decode16,
                                    0x0778,             // Range Minimum
                                    0x0778,             // Range Maximum
                                    0x01,               // Alignment
                                    0x03,               // Length
                                    _Y19)
                                IRQNoFlags (_Y1A)
                                    {7}
                                DMA (Compatibility, NotBusMaster, Transfer8, _Y1B)
                                    {3}
                            })
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y18._MIN, MIN1)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y18._MAX, MAX1)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y18._LEN, LEN1)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y19._MIN, MIN2)  // _MIN: Minimum Base Address
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y19._MAX, MAX2)  // _MAX: Maximum Base Address
                            CreateByteField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y19._LEN, LEN2)  // _LEN: Length
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y1A._INT, IRQ0)  // _INT: Interrupts
                            CreateWordField (CRES, \_SB.PCI0.LPCB.SIO.LPT0._CRS._Y1B._DMA, DMA0)  // _DMA: Direct Memory Access
                            If (RLPD)
                            {
                                Store (Zero, Local0)
                            }
                            Else
                            {
                                Store (SODS (One, 0x04), Local0)
                            }

                            If (LEqual (Local0, Zero))
                            {
                                Store (Zero, MIN1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN1 */
                                Store (Zero, MAX1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MAX1 */
                                Store (Zero, MIN2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN2 */
                                Store (Zero, MAX2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MAX2 */
                                Store (Zero, IRQ0) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.IRQ0 */
                                Store (Zero, DMA0) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.DMA0 */
                                Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.CRES */
                            }

                            Store (GETR (One), Local1)
                            Store (DerefOf (Index (Local1, Zero)), MIN1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN1 */
                            Store (MIN1, MAX1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MAX1 */
                            If (LEqual (MIN1, 0x0278))
                            {
                                Store (0x08, LEN1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.LEN1 */
                                Store (0x03, LEN2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.LEN2 */
                            }

                            If (LEqual (MIN1, 0x03BC))
                            {
                                Store (0x04, LEN1) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.LEN1 */
                                Store (0x03, LEN2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.LEN2 */
                            }

                            Add (MIN1, 0x0400, MIN2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MIN2 */
                            Store (MIN2, MAX2) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.MAX2 */
                            Store (DerefOf (Index (Local1, 0x02)), IRQ0) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.IRQ0 */
                            Store (DerefOf (Index (Local1, 0x03)), DMA0) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.DMA0 */
                            Return (CRES) /* \_SB_.PCI0.LPCB.SIO_.LPT0._CRS.CRES */
                        }

                        PowerResource (LPP, 0x00, 0x0000)
                        {
                            Method (_STA, 0, NotSerialized)  // _STA: Status
                            {
                                Return (DPWS (One))
                            }

                            Method (_ON, 0, NotSerialized)  // _ON_: Power On
                            {
                                DPW (One, One)
                            }

                            Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                            {
                            }
                        }

                        Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                        {
                            LPP
                        })
                    }
                }

                Device (PS2K)
                {
                    Name (_HID, EisaId ("PNP0303"))  // _HID: Hardware ID
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IO (Decode16,
                            0x0060,             // Range Minimum
                            0x0060,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IO (Decode16,
                            0x0064,             // Range Minimum
                            0x0064,             // Range Maximum
                            0x01,               // Alignment
                            0x01,               // Length
                            )
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {1}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            FixedIO (
                                0x0060,             // Address
                                0x01,               // Length
                                )
                            FixedIO (
                                0x0064,             // Address
                                0x01,               // Length
                                )
                            IRQNoFlags ()
                                {1}
                        }
                        EndDependentFn ()
                    })
                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If (LEqual (Arg2, Zero))
                        {
                            Return (Buffer (One)
                            {
                                 0x03
                            })
                        }

                        Return (Package (0x04)
                        {
                            "RM,oem-id", 
                            "HPQOEM", 
                            "RM,oem-table-id", 
                            "167C"
                        })
                    }
                }

                Device (PS2M)
                {
                    Name (_CID, Package (0x03)  // _CID: Compatible ID
                    {
                        EisaId ("SYN0100"), 
                        EisaId ("SYN0002"), 
                        EisaId ("PNP0F13")
                    })
                    Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                    {
                        IRQ (Edge, ActiveHigh, Exclusive, )
                            {12}
                    })
                    Name (_PRS, ResourceTemplate ()  // _PRS: Possible Resource Settings
                    {
                        StartDependentFn (0x00, 0x00)
                        {
                            IRQNoFlags ()
                                {12}
                        }
                        EndDependentFn ()
                    })
                }
            }

            Device (SATA)
            {
                Name (_ADR, 0x001F0002)  // _ADR: Address
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                    Offset (0x50), 
                    MAPV,   2
                }
            }

            Device (SAT1)
            {
                Name (_ADR, 0x001F0005)  // _ADR: Address
                OperationRegion (SACS, PCI_Config, 0x40, 0xC0)
                Field (SACS, DWordAcc, NoLock, Preserve)
                {
                    PRIT,   16, 
                    SECT,   16, 
                    PSIT,   4, 
                    SSIT,   4, 
                    Offset (0x08), 
                    SYNC,   4, 
                    Offset (0x0A), 
                    SDT0,   2, 
                        ,   2, 
                    SDT1,   2, 
                    Offset (0x0B), 
                    SDT2,   2, 
                        ,   2, 
                    SDT3,   2, 
                    Offset (0x14), 
                    ICR0,   4, 
                    ICR1,   4, 
                    ICR2,   4, 
                    ICR3,   4, 
                    ICR4,   4, 
                    ICR5,   4, 
                    Offset (0x50), 
                    MAPV,   2
                }
            }

            Device (SBUS)
            {
                Name (_ADR, 0x001F0003)  // _ADR: Address
                OperationRegion (SMBP, PCI_Config, 0x40, 0xC0)
                Field (SMBP, DWordAcc, NoLock, Preserve)
                {
                        ,   2, 
                    I2CE,   1
                }

                OperationRegion (SMBI, SystemIO, 0xEF80, 0x10)
                Field (SMBI, ByteAcc, NoLock, Preserve)
                {
                    HSTS,   8, 
                    Offset (0x02), 
                    HCON,   8, 
                    HCOM,   8, 
                    TXSA,   8, 
                    DAT0,   8, 
                    DAT1,   8, 
                    HBDR,   8, 
                    PECR,   8, 
                    RXSA,   8, 
                    SDAT,   16
                }

                Method (SSXB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Arg0, TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (0x48, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRXB, 1, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Or (Arg0, One), TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (0x44, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    }

                    Return (0xFFFF)
                }

                Method (SWRB, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Arg0, TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (Arg2, DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    Store (0x48, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRDB, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Or (Arg0, One), TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (0x48, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    }

                    Return (0xFFFF)
                }

                Method (SWRW, 3, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Arg0, TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    And (Arg2, 0xFF, DAT1) /* \_SB_.PCI0.SBUS.DAT1 */
                    And (ShiftRight (Arg2, 0x08), 0xFF, DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    Store (0x4C, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SRDW, 2, Serialized)
                {
                    If (STRT ())
                    {
                        Return (0xFFFF)
                    }

                    Store (Zero, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Or (Arg0, One), TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (0x4C, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (Or (ShiftLeft (DAT0, 0x08), DAT1))
                    }

                    Return (0xFFFFFFFF)
                }

                Method (SBLW, 4, Serialized)
                {
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg3, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Arg0, TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (SizeOf (Arg2), DAT0) /* \_SB_.PCI0.SBUS.DAT0 */
                    Store (Zero, Local1)
                    Store (DerefOf (Index (Arg2, Zero)), HBDR) /* \_SB_.PCI0.SBUS.HBDR */
                    Store (0x54, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    While (LGreater (SizeOf (Arg2), Local1))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (0x80, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Increment (Local1)
                        If (LGreater (SizeOf (Arg2), Local1))
                        {
                            Store (DerefOf (Index (Arg2, Local1)), HBDR) /* \_SB_.PCI0.SBUS.HBDR */
                        }
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (One)
                    }

                    Return (Zero)
                }

                Method (SBLR, 3, Serialized)
                {
                    Name (TBUF, Buffer (0x0100) {})
                    If (STRT ())
                    {
                        Return (Zero)
                    }

                    Store (Arg2, I2CE) /* \_SB_.PCI0.SBUS.I2CE */
                    Store (0xBF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (Or (Arg0, One), TXSA) /* \_SB_.PCI0.SBUS.TXSA */
                    Store (Arg1, HCOM) /* \_SB_.PCI0.SBUS.HCOM */
                    Store (0x54, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    Store (0x0FA0, Local0)
                    While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                    {
                        Decrement (Local0)
                        Stall (0x32)
                    }

                    If (LNot (Local0))
                    {
                        KILL ()
                        Return (Zero)
                    }

                    Store (DAT0, Index (TBUF, Zero))
                    Store (0x80, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                    Store (One, Local1)
                    While (LLess (Local1, DerefOf (Index (TBUF, Zero))))
                    {
                        Store (0x0FA0, Local0)
                        While (LAnd (LNot (And (HSTS, 0x80)), Local0))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                        }

                        If (LNot (Local0))
                        {
                            KILL ()
                            Return (Zero)
                        }

                        Store (HBDR, Index (TBUF, Local1))
                        Store (0x80, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Increment (Local1)
                    }

                    If (COMP ())
                    {
                        Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                        Return (TBUF) /* \_SB_.PCI0.SBUS.SBLR.TBUF */
                    }

                    Return (Zero)
                }

                Method (STRT, 0, Serialized)
                {
                    Store (0xC8, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x40))
                        {
                            Decrement (Local0)
                            Sleep (One)
                            If (LEqual (Local0, Zero))
                            {
                                Return (One)
                            }
                        }
                        Else
                        {
                            Store (Zero, Local0)
                        }
                    }

                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, One))
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                        Else
                        {
                            Return (Zero)
                        }
                    }

                    Return (One)
                }

                Method (COMP, 0, Serialized)
                {
                    Store (0x0FA0, Local0)
                    While (Local0)
                    {
                        If (And (HSTS, 0x02))
                        {
                            Return (One)
                        }
                        Else
                        {
                            Decrement (Local0)
                            Stall (0x32)
                            If (LEqual (Local0, Zero))
                            {
                                KILL ()
                            }
                        }
                    }

                    Return (Zero)
                }

                Method (KILL, 0, Serialized)
                {
                    Or (HCON, 0x02, HCON) /* \_SB_.PCI0.SBUS.HCON */
                    Or (HSTS, 0xFF, HSTS) /* \_SB_.PCI0.SBUS.HSTS */
                }

                Device (BUS0)
                {
                    Name (_CID, "smbus")  // _CID: Compatible ID
                    Name (_ADR, Zero)  // _ADR: Address
                    Device (DVL0)
                    {
                        Name (_ADR, 0x57)  // _ADR: Address
                        Name (_CID, "diagsvault")  // _CID: Compatible ID
                        Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                        {
                            If (LEqual (Arg2, Zero))
                            {
                                Return (Buffer (One)
                                {
                                     0x03
                                })
                            }

                            Return (Package (0x02)
                            {
                                "address", 
                                0x57
                            })
                        }
                    }
                }
            }

            Scope (\)
            {
                OperationRegion (THMR, SystemMemory, TBRB, 0xDC)
                Field (THMR, AnyAcc, Lock, Preserve)
                {
                    Offset (0x30), 
                    CTV1,   16, 
                    CTV2,   16, 
                    Offset (0x60), 
                    PTV,    8, 
                    Offset (0xD8), 
                    PCHT,   8, 
                    MCHT,   8
                }
            }

            Device (RP01)
            {
                Name (_ADR, 0x001C0000)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP01.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP01.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP01.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP01.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP01.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP01.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP01.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP01.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP01.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP01.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP01.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP01.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP01.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x13
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKD, 
                                Zero
                            }
                        })
                    }
                }
            }

            Device (RP02)
            {
                Name (_ADR, 0x001C0001)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP02.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP02.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP02.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP02.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP02.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP02.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP02.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP02.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP02.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP02.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP02.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP02.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP02.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x10
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKA, 
                                Zero
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
                Device (ECF0)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW) /* \_SB_.PCI0.RP02._PRW */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (One)
                    }
                }

                Device (ECF1)
                {
                    Name (_ADR, One)  // _ADR: Address
                }

                Device (ECF2)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                }

                Device (ECF3)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                }

                Device (ECF4)
                {
                    Name (_ADR, 0x04)  // _ADR: Address
                }

                Device (ECF5)
                {
                    Name (_ADR, 0x05)  // _ADR: Address
                }

                Device (ECF6)
                {
                    Name (_ADR, 0x06)  // _ADR: Address
                }

                Device (ECF7)
                {
                    Name (_ADR, 0x07)  // _ADR: Address
                }

                Scope (ECF0)
                {
                    Method (_EJD, 0, NotSerialized)  // _EJD: Ejection Dependent Device
                    {
                        Return ("\\_SB.PCI0.EH01.RHUB.PRT0.HPT4")
                    }
                }
            }

            Device (RP03)
            {
                Name (_ADR, 0x001C0002)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP03.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP03.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP03.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP03.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP03.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP03.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP03.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP03.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP03.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP03.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP03.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP03.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP03.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x12
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x11
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKC, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKB, 
                                Zero
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
                Device (SMHC)
                {
                    OperationRegion (JMDE, PCI_Config, 0xAC, 0x10)
                    Field (JMDE, AnyAcc, NoLock, Preserve)
                    {
                            ,   6, 
                        D3EF,   1, 
                        Offset (0x01)
                    }

                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }

                Device (MSHC)
                {
                    Name (_ADR, One)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }

                Device (XDCC)
                {
                    Name (_ADR, 0x02)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }

                Device (I1C)
                {
                    Name (_ADR, 0x03)  // _ADR: Address
                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    Method (_RMV, 0, NotSerialized)  // _RMV: Removal Status
                    {
                        Return (Zero)
                    }
                }
            }

            Device (RP04)
            {
                Name (_ADR, 0x001C0003)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP04.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP04.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP04.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP04.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP04.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP04.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP04.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP04.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP04.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP04.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP04.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP04.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP04.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    If (GPIC)
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                Zero, 
                                0x13
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                Zero, 
                                0x10
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                Zero, 
                                0x11
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                Zero, 
                                0x12
                            }
                        })
                    }
                    Else
                    {
                        Return (Package (0x04)
                        {
                            Package (0x04)
                            {
                                0xFFFF, 
                                Zero, 
                                LNKD, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                One, 
                                LNKA, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x02, 
                                LNKB, 
                                Zero
                            }, 

                            Package (0x04)
                            {
                                0xFFFF, 
                                0x03, 
                                LNKC, 
                                Zero
                            }
                        })
                    }
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x05
                })
                Device (WNIC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW) /* \_SB_.PCI0.RP04._PRW */
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }
                }
            }

            Device (RP05)
            {
                Name (_ADR, 0x001C0004)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP05.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP05.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP05.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP05.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP05.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP05.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP05.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP05.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP05.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP05.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP05.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP05.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP05.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP01._PRT ())
                }
            }

            Device (RP06)
            {
                Name (_ADR, 0x001C0005)  // _ADR: Address
                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP06.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP06.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP06.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP06.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP06.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP06.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP06.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP06.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP06.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP06.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP06.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP06.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP06.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP02._PRT ())
                }
            }

            Device (RP07)
            {
                Name (_ADR, 0x001C0006)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP7D))
                }

                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP07.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP07.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP07.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP07.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP07.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP07.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP07.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP07.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP07.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP07.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP07.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP07.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP07.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP03._PRT ())
                }

                Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
                {
                    0x09, 
                    0x04
                })
            }

            Device (RP08)
            {
                Name (_ADR, 0x001C0007)  // _ADR: Address
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP8D))
                }

                OperationRegion (PXCS, PCI_Config, 0x40, 0xC0)
                Field (PXCS, AnyAcc, NoLock, WriteAsZeros)
                {
                    Offset (0x12), 
                        ,   13, 
                    LASX,   1, 
                    Offset (0x1A), 
                    ABPX,   1, 
                        ,   2, 
                    PDCX,   1, 
                        ,   2, 
                    PDSX,   1, 
                    Offset (0x1B), 
                    LSCX,   1, 
                    Offset (0x20), 
                    Offset (0x22), 
                    PSPX,   1, 
                    Offset (0x98), 
                        ,   30, 
                    HPEX,   1, 
                    PMEX,   1, 
                        ,   30, 
                    HPSX,   1, 
                    PMSX,   1
                }

                Field (PXCS, AnyAcc, NoLock, Preserve)
                {
                    Offset (0x02), 
                    Offset (0x03), 
                    SI,     1, 
                    Offset (0x10), 
                        ,   4, 
                    LD,     1, 
                    Offset (0x18), 
                    SCTL,   16, 
                    SSTS,   16, 
                    Offset (0x98), 
                        ,   30, 
                    HPCE,   1, 
                    PMCE,   1
                }

                Method (HPLG, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (HPSX)
                        {
                            Sleep (0x64)
                            If (PDCX)
                            {
                                Store (One, PDCX) /* \_SB_.PCI0.RP08.PDCX */
                                Store (One, HPSX) /* \_SB_.PCI0.RP08.HPSX */
                                SSMI (0x5D, Zero, Zero, Zero, Zero)
                                Notify (^, Zero) // Bus Check
                            }
                            Else
                            {
                                Store (One, HPSX) /* \_SB_.PCI0.RP08.HPSX */
                            }
                        }
                    }
                }

                Method (PME, 0, Serialized)
                {
                    If (_STA ())
                    {
                        If (PSPX)
                        {
                            While (PSPX)
                            {
                                Store (One, PSPX) /* \_SB_.PCI0.RP08.PSPX */
                            }

                            Store (One, PMSX) /* \_SB_.PCI0.RP08.PMSX */
                            Notify (^, 0x02) // Device Wake
                        }
                    }
                }

                Method (OSC, 2, Serialized)
                {
                    If (_STA ())
                    {
                        Store (Arg0, HPCE) /* \_SB_.PCI0.RP08.HPCE */
                        If (Arg0)
                        {
                            And (SCTL, 0xFFC0, Local6)
                            If (SI)
                            {
                                Or (Local6, One, Local6)
                            }

                            Store (Local6, SCTL) /* \_SB_.PCI0.RP08.SCTL */
                            Store (0x3F, SSTS) /* \_SB_.PCI0.RP08.SSTS */
                        }
                        Else
                        {
                            Store (One, ABPX) /* \_SB_.PCI0.RP08.ABPX */
                            Store (One, PDCX) /* \_SB_.PCI0.RP08.PDCX */
                            Store (One, HPSX) /* \_SB_.PCI0.RP08.HPSX */
                        }

                        Store (Arg1, PMCE) /* \_SB_.PCI0.RP08.PMCE */
                        If (LEqual (Arg1, Zero))
                        {
                            Store (One, PMSX) /* \_SB_.PCI0.RP08.PMSX */
                        }
                    }
                }

                Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
                {
                    Return (^^RP04._PRT ())
                }

                Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                {
                    Return (UPRW (0x09, 0x04))
                }
            }

            Method (POSC, 2, Serialized)
            {
                If (LOr (Arg1, LOr (And (Arg0, One), And (Arg0, 
                    0x04))))
                {
                    XOr (And (Arg0, One), One, Local4)
                    XOr (And (ShiftRight (Arg0, 0x02), One), One, Local5)
                    ^RP01.OSC (Local4, Local5)
                    ^RP02.OSC (Local4, Local5)
                    If (LAnd (^RP03.HPCE, Zero))
                    {
                        ^RP03.OSC (Local4, Local5)
                    }
                    Else
                    {
                        ^RP03.OSC (One, Local5)
                    }

                    ^RP04.OSC (Local4, Local5)
                    ^RP05.OSC (Local4, Local5)
                    ^RP06.OSC (Local4, Local5)
                    ^RP07.OSC (Local4, Local5)
                    ^RP08.OSC (Local4, Local5)
                    Store (Local5, ^LPCB.BPEE) /* \_SB_.PCI0.LPCB.BPEE */
                }
            }

            Device (B0D4)
            {
                Name (_ADR, 0x00040000)  // _ADR: Address
            }

            Scope (\)
            {
                Field (PMIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x22), 
                    GPIS,   16, 
                    Offset (0x2A), 
                    GPIE,   16, 
                    Offset (0x30), 
                    GSIE,   1, 
                    EOS,    1, 
                        ,   2, 
                    SSME,   1, 
                    Offset (0x34), 
                        ,   5, 
                    APMS,   1, 
                    Offset (0x38), 
                    AGSE,   16, 
                    AGSS,   16
                }

                Field (GPIO, ByteAcc, NoLock, Preserve)
                {
                    Offset (0x04), 
                    GPSL,   32, 
                    Offset (0x0C), 
                    GPL0,   32, 
                    Offset (0x2C), 
                    GIV,    32, 
                    Offset (0x38), 
                    GPL2,   32, 
                    Offset (0x48), 
                    GPL3,   32
                }
            }

            Method (GUPT, 1, NotSerialized)
            {
                And (Arg0, 0x0F, Local2)
                Store (0x06, Local1)
                If (LEqual (Arg0, 0x001D0003))
                {
                    Store (0x0A, Local0)
                    Return (Local0)
                }

                ShiftLeft (Local2, One, Local0)
                If (LEqual (And (Arg0, 0x001A0000), 0x001A0000))
                {
                    Add (Local0, Local1, Local0)
                }

                Return (Local0)
            }

            Method (UPSW, 1, Serialized)
            {
                Store (One, Local0)
                ShiftRight (0x0407, Arg0, Local1)
                And (Local1, One, Local0)
                Return (Local0)
            }

            Method (GSWS, 1, NotSerialized)
            {
                While (APMS)
                {
                    Stall (One)
                }

                Store (0xF3, SSMP) /* \SSMP */
                Stall (0x32)
                While (APMS)
                {
                    Stall (One)
                }
            }

            Mutex (SMIM, 0x00)
            Name (SMIS, Zero)
            Name (SMID, Zero)
            Method (DSMI, 0, NotSerialized)
            {
                Acquire (SMIM, 0xFFFF)
                If (LEqual (SMID, Zero))
                {
                    Store (Zero, GSIE) /* \GSIE */
                    Store (Zero, EOS) /* \EOS_ */
                }

                Increment (SMID)
                Release (SMIM)
            }

            Method (ESMI, 0, NotSerialized)
            {
                Acquire (SMIM, 0xFFFF)
                Decrement (SMID)
                If (LEqual (SMID, Zero))
                {
                    Store (One, EOS) /* \EOS_ */
                    Store (One, GSIE) /* \GSIE */
                }

                Release (SMIM)
            }

            Alias (DSMI, \DSMI)
            Alias (ESMI, \ESMI)
            Name (PUID, Buffer (0x10)
            {
                /* 0000 */   0x5B, 0x4D, 0xDB, 0x33, 0xF7, 0x1F, 0x1C, 0x40,
                /* 0008 */   0x96, 0x57, 0x74, 0x41, 0xC0, 0x3D, 0xD7, 0x66
            })
            Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
            {
                CreateDWordField (Arg3, Zero, CDW1)
                CreateDWordField (Arg3, 0x04, CDW2)
                CreateDWordField (Arg3, 0x08, CDW3)
                Store (Arg0, Local1)
                If (LEqual (SRCP (Local1, PUID), One))
                {
                    Store (CDW2, Local2)
                    Store (CDW3, Local3)
                    If (LNotEqual (And (Local2, 0x16), 0x16))
                    {
                        And (Local3, 0x1E, Local3)
                    }

                    And (Local3, 0x1D, Local3)
                    If (LNot (And (CDW1, One)))
                    {
                        POSC (Local3, One)
                        If (And (Local3, 0x10)) {}
                    }

                    If (LNotEqual (Arg1, One))
                    {
                        Or (CDW1, 0x08, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    }

                    If (LNotEqual (CDW3, Local3))
                    {
                        Or (CDW1, 0x10, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    }

                    Store (Local3, CDW3) /* \_SB_.PCI0._OSC.CDW3 */
                    Store (Local3, OSCC) /* \OSCC */
                    Return (Arg3)
                }
                Else
                {
                    Or (CDW1, 0x04, CDW1) /* \_SB_.PCI0._OSC.CDW1 */
                    Return (Arg3)
                }
            }

            Method (ICST, 1, NotSerialized)
            {
                Store (0x0F, Local0)
                If (LEqual (Arg0, One))
                {
                    Store (Zero, Local0)
                }

                Return (Local0)
            }

            Scope (RP01)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP1D))
                }
            }

            Scope (RP02)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP2D))
                }
            }

            Scope (RP03)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP3D))
                }
            }

            Scope (RP04)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP4D))
                }
            }

            Scope (RP05)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP5D))
                }
            }

            Scope (RP06)
            {
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    Return (ICST (RP6D))
                }
            }

            Scope (HDEF)
            {
                Name (ASTA, Zero)
                Name (ASTI, Zero)
                PowerResource (APPR, 0x00, 0x0000)
                {
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (ASTA) /* \_SB_.PCI0.HDEF.ASTA */
                    }

                    Method (_ON, 0, NotSerialized)  // _ON_: Power On
                    {
                        Store (One, ASTA) /* \_SB_.PCI0.HDEF.ASTA */
                        Store (^^^LPCB.EC0.SAST (One), ASTI) /* \_SB_.PCI0.HDEF.ASTI */
                    }

                    Method (_OFF, 0, NotSerialized)  // _OFF: Power Off
                    {
                        Store (Zero, ASTA) /* \_SB_.PCI0.HDEF.ASTA */
                        Store (^^^LPCB.EC0.SAST (Zero), ASTI) /* \_SB_.PCI0.HDEF.ASTI */
                    }
                }

                Name (_PR0, Package (0x01)  // _PR0: Power Resources for D0
                {
                    APPR
                })
            }

            Scope (LPCB)
            {
                OperationRegion (LPC2, PCI_Config, 0x80, 0x3C)
                Field (LPC2, AnyAcc, NoLock, Preserve)
                {
                    CMAD,   3, 
                        ,   1, 
                    CMBD,   3, 
                    Offset (0x01), 
                    LPDC,   2, 
                        ,   2, 
                    FDDC,   1, 
                    Offset (0x02), 
                    CALE,   1, 
                    CBLE,   1, 
                    LLPE,   1, 
                    FDLE,   1, 
                    Offset (0x08), 
                    G2DC,   16, 
                    G2MK,   8, 
                    Offset (0x20), 
                        ,   10, 
                    BPEE,   1, 
                    Offset (0x38), 
                    GPRO,   32
                }

                Name (CDC, Package (0x08)
                {
                    0x03F8, 
                    0x02F8, 
                    0x0220, 
                    0x0228, 
                    0x0238, 
                    0x02E8, 
                    0x0338, 
                    0x03E8
                })
                Name (LPD, Package (0x03)
                {
                    0x0378, 
                    0x0278, 
                    0x03BC
                })
                Method (SMAB, 3, Serialized)
                {
                    If (LEqual (And (Arg0, One), Zero))
                    {
                        Store (One, Local0)
                        Store (^^SBUS.SWRB (Arg0, Arg1, Arg2), Local1)
                        If (Local1)
                        {
                            Store (Zero, Local0)
                        }
                    }
                    Else
                    {
                        Store (^^SBUS.SRDB (Arg0, Arg1), Local0)
                    }

                    Return (Local0)
                }

                Method (DCS, 3, NotSerialized)
                {
                    Store (Zero, Local1)
                    Store (Match (Arg0, MEQ, Arg1, MTR, Zero, Zero), Local0)
                    If (LNotEqual (Local0, Ones))
                    {
                        ShiftLeft (Local0, Arg2, Local1)
                    }

                    Return (Local1)
                }

                Method (DPD, 2, Serialized)
                {
                    If (LEqual (Arg0, Zero))
                    {
                        Store (Zero, FDLE) /* \_SB_.PCI0.LPCB.FDLE */
                    }
                    Else
                    {
                        If (LEqual (Arg0, One))
                        {
                            Store (Zero, LLPE) /* \_SB_.PCI0.LPCB.LLPE */
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (Zero, CALE) /* \_SB_.PCI0.LPCB.CALE */
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (Zero, CBLE) /* \_SB_.PCI0.LPCB.CBLE */
                                    And (G2DC, 0xFFFFFFFFFFFFFFFE, G2DC) /* \_SB_.PCI0.LPCB.G2DC */
                                }
                            }
                        }
                    }
                }

                Method (EPD, 3, Serialized)
                {
                    If (LEqual (Arg0, Zero))
                    {
                        Store (Zero, Local0)
                        If (LEqual (Arg1, 0x0370))
                        {
                            Store (One, Local0)
                        }

                        Store (Local0, FDDC) /* \_SB_.PCI0.LPCB.FDDC */
                        Store (One, FDLE) /* \_SB_.PCI0.LPCB.FDLE */
                    }
                    Else
                    {
                        If (LEqual (Arg0, One))
                        {
                            Store (DCS (LPD, Arg1, Zero), LPDC) /* \_SB_.PCI0.LPCB.LPDC */
                            Store (One, LLPE) /* \_SB_.PCI0.LPCB.LLPE */
                        }
                        Else
                        {
                            If (LEqual (Arg0, 0x02))
                            {
                                Store (DCS (CDC, Arg1, Zero), CMAD) /* \_SB_.PCI0.LPCB.CMAD */
                                Store (One, CALE) /* \_SB_.PCI0.LPCB.CALE */
                            }
                            Else
                            {
                                If (LEqual (Arg0, 0x03))
                                {
                                    Store (DCS (CDC, Arg1, Zero), CMBD) /* \_SB_.PCI0.LPCB.CMBD */
                                    Store (One, CBLE) /* \_SB_.PCI0.LPCB.CBLE */
                                    Store (0x0C, G2MK) /* \_SB_.PCI0.LPCB.G2MK */
                                    Or (Arg2, One, G2DC) /* \_SB_.PCI0.LPCB.G2DC */
                                }
                            }
                        }
                    }
                }

                Method (CFG, 5, Serialized)
                {
                    If (LEqual (Arg1, Zero))
                    {
                        DPD (Arg0, Arg2)
                    }
                    Else
                    {
                        EPD (Arg0, Arg1, Arg2)
                    }
                }
            }

            Device (ACEL)
            {
                Name (_HID, EisaId ("HPQ0004"))  // _HID: Hardware ID
                Name (DEPT, 0xFF)
                Name (CTST, 0xFF)
                Method (_INI, 0, NotSerialized)  // _INI: Initialize
                {
                    ITAL ()
                }

                Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
                {
                    Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
                    {
                        0x00000017,
                    }
                })
                Method (_STA, 0, NotSerialized)  // _STA: Status
                {
                    If (LEqual (DEPT, 0xFF))
                    {
                        Store (0x0F, Local0)
                        Store (ALRD (0x20), Local1)
                        If (And (Local1, 0xFF00))
                        {
                            Store (Zero, Local0)
                        }

                        Store (Local0, DEPT) /* \_SB_.PCI0.ACEL.DEPT */
                    }

                    Return (DEPT) /* \_SB_.PCI0.ACEL.DEPT */
                }

                Method (ITAL, 0, Serialized)
                {
                    If (_STA ())
                    {
                        ALWR (0x20, 0x5F)
                        ALWR (0x21, 0x22)
                        ALWR (0x32, 0x16)
                        ALWR (0x33, 0x02)
                        ALWR (0x30, 0x95)
                        ALWR (0x36, 0x13)
                        ALWR (0x37, One)
                        ALWR (0x34, 0x0A)
                        Store (0xFF, CTST) /* \_SB_.PCI0.ACEL.CTST */
                        AJAL ()
                    }
                }

                Method (AJAL, 0, Serialized)
                {
                    If (_STA ())
                    {
                        Store (^^LPCB.EC0.GACS (), Local0)
                        If (LAnd (LEqual (^^^LID._LID (), Zero), LEqual (Local0, Zero)))
                        {
                            If (LNotEqual (CTST, One))
                            {
                                Store (One, CTST) /* \_SB_.PCI0.ACEL.CTST */
                                ALWR (0x22, 0x60)
                            }
                        }
                        Else
                        {
                            If (LNotEqual (CTST, Zero))
                            {
                                Store (Zero, CTST) /* \_SB_.PCI0.ACEL.CTST */
                                ALWR (0x22, 0x40)
                            }
                        }
                    }
                }

                Method (CLRI, 0, Serialized)
                {
                    Store (Zero, Local2)
                    If (LEqual (^^LPCB.EC0.GACS (), Zero))
                    {
                        Store (0x04, Local0)
                        Store (0x04, Local1)
                        If (LEqual (^^^BAT0._STA (), 0x1F))
                        {
                            Store (DerefOf (Index (DerefOf (Index (NBST, Zero)), Zero)), 
                                Local0)
                        }

                        If (LEqual (^^^BAT1._STA (), 0x1F))
                        {
                            Store (DerefOf (Index (DerefOf (Index (NBST, One)), Zero)), 
                                Local1)
                        }

                        And (Local0, Local1, Local0)
                        If (And (Local0, 0x04))
                        {
                            Store (One, Local2)
                        }
                    }

                    Return (Local2)
                }

                Method (ALRD, 1, Serialized)
                {
                    Store (^^LPCB.SMAB (0x33, Arg0, Zero), Local0)
                    Return (Local0)
                }

                Method (ALWR, 2, Serialized)
                {
                    Store (^^LPCB.SMAB (0x32, Arg0, Arg1), Local0)
                    Return (Local0)
                }

                Method (ALID, 1, Serialized)
                {
                    Return (^^^LID._LID ())
                }

                Method (ADSN, 0, Serialized)
                {
                    Store (HDDS, Local0)
                    Store (Zero, Local0)
                    Return (Local0)
                }
            }

            Method (_PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (GPIC)
                {
                    Return (Package (0x1A)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            Zero, 
                            0x15
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            Zero, 
                            Zero, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            One, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x03, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            Zero, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            One, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x02, 
                            Zero, 
                            0x12
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x03, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            Zero, 
                            Zero, 
                            0x13
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            One, 
                            Zero, 
                            0x10
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            Zero, 
                            0x11
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            Zero, 
                            0x12
                        }
                    })
                }
                Else
                {
                    Return (Package (0x1A)
                    {
                        Package (0x04)
                        {
                            0x0001FFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0002FFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0019FFFF, 
                            Zero, 
                            LNKE, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001AFFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001BFFFF, 
                            Zero, 
                            LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            Zero, 
                            LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            One, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x02, 
                            LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001CFFFF, 
                            0x03, 
                            LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001DFFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            Zero, 
                            LNKF, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            One, 
                            LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x02, 
                            LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x001FFFFF, 
                            0x03, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            One, 
                            LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x02, 
                            LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0016FFFF, 
                            0x03, 
                            LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            Zero, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            One, 
                            LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x02, 
                            LNKC, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0004FFFF, 
                            0x03, 
                            LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            Zero, 
                            LNKD, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            One, 
                            LNKA, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            LNKB, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            LNKC, 
                            Zero
                        }
                    })
                }
            }

            Method (PCIB._PRT, 0, NotSerialized)  // _PRT: PCI Routing Table
            {
                If (GPIC)
                {
                    Return (Package (0x06)
                    {
                        Package (0x04)
                        {
                            0x0006FFFF, 
                            Zero, 
                            Zero, 
                            0x14
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            One, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x04, 
                            Zero, 
                            0x16
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x05, 
                            Zero, 
                            0x16
                        }
                    })
                }
                Else
                {
                    Return (Package (0x06)
                    {
                        Package (0x04)
                        {
                            0x0006FFFF, 
                            Zero, 
                            LNKE, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            One, 
                            LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x02, 
                            LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x03, 
                            LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x04, 
                            LNKG, 
                            Zero
                        }, 

                        Package (0x04)
                        {
                            0x0006FFFF, 
                            0x05, 
                            LNKG, 
                            Zero
                        }
                    })
                }
            }

            Field (GPIO, ByteAcc, NoLock, Preserve)
            {
                Offset (0x0C), 
                GLEP,   1
            }

            Scope (RP06)
            {
                Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                {
                    Store (Package (0x02)
                        {
                            0x09, 
                            0x05
                        }, Local0)
                    If (WOLD)
                    {
                        Store (Zero, Index (Local0, One))
                    }

                    Return (Local0)
                }

                OperationRegion (NPCI, PCI_Config, 0x19, One)
                Field (NPCI, ByteAcc, NoLock, Preserve)
                {
                    BUSN,   8
                }

                Method (GADD, 0, Serialized)
                {
                    Store (BUSN, Local0)
                    ShiftLeft (Local0, 0x14, Local0)
                    Add (0xE0000000, Local0, Local1)
                    Return (Local1)
                }

                Device (NIC)
                {
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_PRW, 0, Serialized)  // _PRW: Power Resources for Wake
                    {
                        Return (^^_PRW ())
                    }

                    Method (EJ0, 0, NotSerialized)
                    {
                        Sleep (0x0A)
                        Store (Zero, GLEP) /* \_SB_.PCI0.GLEP */
                    }

                    Method (LPON, 0, NotSerialized)
                    {
                        Store (CondRefOf (\_GPE._L1C, Local0), Local1)
                        Return (Local1)
                    }

                    Method (_PLD, 0, Serialized)  // _PLD: Physical Location of Device
                    {
                        Return (EPLD) /* \EPLD */
                    }

                    OperationRegion (PCIR, PCI_Config, 0x0C, One)
                    Field (PCIR, AnyAcc, NoLock, Preserve)
                    {
                        CLSZ,   8
                    }
                }
            }

            Scope (\_GPE)
            {
                Name (CBID, Zero)
                Method (L1C, 0, NotSerialized)
                {
                    Sleep (0x64)
                    If (LEqual (CBID, One))
                    {
                        HNLP (0x1000)
                        Store (GIV, Local0)
                        XOr (Local0, 0x1000, GIV) /* \GIV_ */
                        Store (Zero, CBID) /* \_GPE.CBID */
                    }
                    Else
                    {
                        Increment (CBID)
                    }
                }

                Method (HNLP, 1, Serialized)
                {
                    If (\_SB.PCI0.RP06.NIC.LPON ())
                    {
                        If (NNST ())
                        {
                            INIC ()
                        }
                        Else
                        {
                            If (\_SB.PCI0.GLEP)
                            {
                                If (ILUX)
                                {
                                    Notify (\_SB.PCI0.RP06.NIC, 0x03) // Eject Request
                                }
                                Else
                                {
                                    \_SB.PCI0.RP06.NIC.EJ0 ()
                                }
                            }
                        }

                        Sleep (0x64)
                        Notify (\_SB.PCI0.RP06, Zero) // Bus Check
                    }
                }

                Method (NNST, 0, Serialized)
                {
                    Store (GPL0, Local1)
                    Store (One, Local3)
                    If (And (Local1, 0x2000))
                    {
                        If (LEqual (\_SB.PCI0.LPCB.EC0.GACS (), Zero))
                        {
                            If (And (Local1, 0x1000))
                            {
                                Store (Zero, Local3)
                            }
                        }
                    }

                    Return (Local3)
                }

                Method (INIC, 0, Serialized)
                {
                    OperationRegion (NPC2, SystemMemory, \_SB.PCI0.RP06.GADD (), 0x02)
                    Field (NPC2, AnyAcc, NoLock, Preserve)
                    {
                        VEID,   16
                    }

                    Store (0x0B, Local1)
                    Store (One, Local3)
                    If (\_SB.PCI0.GLEP)
                    {
                        If (LEqual (VEID, 0x11AB))
                        {
                            Store (Zero, Local1)
                            Store (Zero, Local3)
                        }
                    }

                    Store (\_SB.PCI0.RP06.HPCE, Local2)
                    While (LAnd (LGreater (Local1, Zero), NNST ()))
                    {
                        Store (One, \_SB.PCI0.GLEP)
                        Sleep (0x012C)
                        Store (VEID, Local0)
                        If (LOr (LEqual (Local0, 0x11AB), LEqual (Local1, One)))
                        {
                            Store (Zero, Local1)
                        }
                        Else
                        {
                            Store (Zero, \_SB.PCI0.GLEP)
                            Sleep (0xC8)
                            Decrement (Local1)
                        }
                    }

                    Store (Local2, \_SB.PCI0.RP06.HPCE)
                    If (Local3)
                    {
                        \_SB.SSMI (0xEA3E, Zero, Zero, Zero, Zero)
                    }

                    If (LEqual (WCOS (), 0x03))
                    {
                        Store (0x10, \_SB.PCI0.RP06.NIC.CLSZ)
                    }
                }
            }

            Device (IMEI)
            {
                Name (_ADR, 0x00160000)  // _ADR: Address
            }
        }

        Name (NBTI, Package (0x02)
        {
            Package (0x0F)
            {
                One, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                One, 
                0xFFFFFFFF, 
                Zero, 
                Zero, 
                0x64, 
                0x64, 
                "Primary", 
                "100000", 
                "LIon", 
                "Hewlett-Packard", 
                Zero, 
                Zero
            }, 

            Package (0x0F)
            {
                One, 
                0xFFFFFFFF, 
                0xFFFFFFFF, 
                One, 
                0xFFFFFFFF, 
                Zero, 
                Zero, 
                0x64, 
                0x64, 
                "Travel", 
                "100000", 
                "LIon", 
                "Hewlett-Packard", 
                Zero, 
                Zero
            }
        })
        Name (NBST, Package (0x02)
        {
            Package (0x04)
            {
                Zero, 
                Zero, 
                0x0FA0, 
                0x04B0
            }, 

            Package (0x04)
            {
                Zero, 
                Zero, 
                0x0FA0, 
                0x04B0
            }
        })
        Name (NDBS, Package (0x04)
        {
            Zero, 
            Zero, 
            0x0FA0, 
            0x04B0
        })
        Name (ACST, One)
        Name (SMAR, Zero)
        Name (BT0P, 0x0F)
        Method (BTIF, 1, Serialized)
        {
            Store (^PCI0.LPCB.EC0.BTIF (Arg0), Local0)
            If (LEqual (Local0, 0xFF))
            {
                Return (Package (0x0D)
                {
                    Zero, 
                    0xFFFFFFFF, 
                    0xFFFFFFFF, 
                    One, 
                    0xFFFFFFFF, 
                    Zero, 
                    Zero, 
                    Zero, 
                    Zero, 
                    "", 
                    "", 
                    "", 
                    Zero
                })
            }
            Else
            {
                Return (DerefOf (Index (NBTI, Arg0)))
            }
        }

        Name (NFBS, One)
        Method (BTST, 1, Serialized)
        {
            Store (NFBS, Local1)
            If (NFBS)
            {
                Store (Zero, NFBS) /* \_SB_.NFBS */
            }

            Store (^PCI0.LPCB.EC0.BTST (Arg0, Local1), Local0)
            Return (DerefOf (Index (NBST, Arg0)))
        }

        Device (BAT0)
        {
            Name (_HID, EisaId ("PNP0C0A"))  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Store (^^PCI0.LPCB.EC0.BSTA (One), Local0)
                If (XOr (BT0P, Local0))
                {
                    Store (Local0, BT0P) /* \_SB_.BT0P */
                    Store (Local0, Local1)
                    If (LNotEqual (Local1, 0x1F))
                    {
                        Store (Zero, Local1)
                    }

                    SSMI (0xEA3A, Zero, Local1, Zero, Zero)
                    \_GPE.HWWP (One)
                    If (LEqual (FCIN, Zero))
                    {
                        ^^PCI0.LPCB.EC0.HWWP (Local1)
                    }
                }

                Return (Local0)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Return (BTIF (Zero))
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Return (BTST (Zero))
            }

            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
        }

        Device (BAT1)
        {
            Name (_HID, EisaId ("PNP0C0A"))  // _HID: Hardware ID
            Name (_UID, 0x02)  // _UID: Unique ID
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (Zero)
            }

            Method (_BIF, 0, NotSerialized)  // _BIF: Battery Information
            {
                Return (BTIF (One))
            }

            Method (_BST, 0, NotSerialized)  // _BST: Battery Status
            {
                Return (BTST (One))
            }

            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
        }

        Device (ADP1)
        {
            Name (_HID, "ACPI0003")  // _HID: Hardware ID
            Name (_PCL, Package (0x01)  // _PCL: Power Consumer List
            {
                _SB
            })
            Method (_PSR, 0, NotSerialized)  // _PSR: Power Source
            {
                Store (^^PCI0.LPCB.EC0.GACS (), Local0)
                Store (Local0, PWRS) /* \PWRS */
                Store (^^PCI0.LPCB.EC0.GPID (), Local1)
                If (XOr (Local0, ACST))
                {
                    \_GPE.HNLP (Zero)
                    ^^PCI0.ACEL.AJAL ()
                    \_GPE.VPUP (Local0, Local1)
                    ^^PCI0.LPCB.EC0.SMCP (Local0)
                }

                If (LOr (LAnd (Local0, LNot (ACST)), LAnd (Local1, LNot (SMAR)))) {}
                Store (Local0, ACST) /* \_SB_.ACST */
                Store (Local1, SMAR) /* \_SB_.SMAR */
                Return (Local0)
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x18, 
                0x03
            })
        }

        Device (SLPB)
        {
            Name (_HID, EisaId ("PNP0C0E"))  // _HID: Hardware ID
        }

        Device (LID)
        {
            Name (_HID, EisaId ("PNP0C0D"))  // _HID: Hardware ID
            Method (_LID, 0, NotSerialized)  // _LID: Lid Status
            {
                Store (^^PCI0.LPCB.EC0.CLID, Local0)
                Return (Local0)
            }
        }

        Device (HST1)
        {
            Name (_HID, EisaId ("PNP0C32"))  // _HID: Hardware ID
            Name (_UID, One)  // _UID: Unique ID
            Name (HS1S, 0xFF)
            Method (_STA, 0, Serialized)  // _STA: Status
            {
                If (LEqual (HS1S, 0xFF))
                {
                    Store (Zero, Local0)
                    If (LGreaterEqual (WCOS (), 0x06))
                    {
                        If (ISUD ())
                        {
                            Store (0x0F, Local0)
                        }
                    }

                    Store (Local0, HS1S) /* \_SB_.HST1.HS1S */
                }

                Return (HS1S) /* \_SB_.HST1.HS1S */
            }

            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x0A, 
                0x05
            })
            Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
            {
                ^^PCI0.LPCB.EC0.HSPW (Arg0, One)
            }

            Method (GHID, 0, Serialized)
            {
                If (_STA ())
                {
                    If (^^PCI0.LPCB.EC0.CHSW (One))
                    {
                        Notify (HST1, 0x02) // Device Wake
                    }
                }

                Return (Buffer (One)
                {
                     0x01
                })
            }
        }

        OperationRegion (LDPT, SystemIO, 0x80, One)
        Field (LDPT, ByteAcc, NoLock, Preserve)
        {
            LPDG,   8
        }

        OperationRegion (LDBP, SystemIO, 0x024C, 0x04)
        Field (LDBP, ByteAcc, NoLock, Preserve)
        {
            SLD1,   8, 
            SLD2,   8, 
            LLPD,   8, 
            LUPD,   8
        }

        Mutex (LDPS, 0x00)
        Mutex (LEXD, 0x00)
        Name (EDDA, Zero)
        Method (ODBG, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            Store (Arg0, LLPD) /* \_SB_.LLPD */
            Store (Arg0, LPDG) /* \_SB_.LPDG */
            Release (LDPS)
            Return (Zero)
        }

        Method (ODG1, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            Store (Arg0, LUPD) /* \_SB_.LUPD */
            Release (LDPS)
            Return (Zero)
        }

        Method (ODGW, 1, NotSerialized)
        {
            Acquire (LDPS, 0xFFFF)
            Store (And (Arg0, 0xFF), LLPD) /* \_SB_.LLPD */
            Store (And (ShiftRight (Arg0, 0x08), 0xFF), LUPD) /* \_SB_.LUPD */
            Store (And (Arg0, 0xFF), LPDG) /* \_SB_.LPDG */
            Release (LDPS)
            Return (Zero)
        }

        Method (ODGD, 1, NotSerialized)
        {
            Return (Zero)
        }

        Method (OTBY, 1, NotSerialized)
        {
            Return (Zero)
        }

        Method (OTWD, 1, NotSerialized)
        {
            Return (Zero)
        }

        Method (OTDD, 1, NotSerialized)
        {
            Return (Zero)
        }

        Method (ISDR, 0, NotSerialized)
        {
            Return (Zero)
        }

        Method (EODB, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODBG (EDDA)
            Release (LEXD)
        }

        Method (EODW, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODGW (EDDA)
            Release (LEXD)
        }

        Method (EODD, 0, Serialized)
        {
            Acquire (LEXD, 0xFFFF)
            ODGD (EDDA)
            Release (LEXD)
        }
    }

    Method (_SB.DCKD, 0, Serialized)
    {
        Store (One, Local0)
        If (And (GPL0, 0x2000))
        {
            Store (Zero, Local0)
        }

        Return (Local0)
    }

    Method (_SB.HST1.ISUD, 0, Serialized)
    {
        Return (One)
    }

    Method (_GPE.DKET, 0, Serialized)
    {
        If (LEqual (ICPT, Zero))
        {
            If (\_SB.DCKD ())
            {
                Notify (\_SB.PCI0.LPCB.SIO.COM1, Zero) // Bus Check
            }
            Else
            {
                Notify (\_SB.PCI0.LPCB.SIO.COM1, One) // Device Check
            }
        }
    }

    Method (_SB.PCI0.ACEL.ALED, 1, Serialized)
    {
        If (Arg0)
        {
            Or (GPL2, 0x02, GPL2) /* \GPL2 */
        }
        Else
        {
            And (GPL2, 0xFFFFFFFFFFFFFFFD, GPL2) /* \GPL2 */
        }
    }

    Method (_SB.GRFS, 0, Serialized)
    {
        Store (^PCI0.LPCB.EC0.KRFS (), Local0)
        Return (Local0)
    }

    Method (_SB.HODM, 3, NotSerialized)
    {
        Return (Package (0x02)
        {
            0x03, 
            Zero
        })
    }

    Method (PPTS, 1, Serialized)
    {
        \_SB.SSMI (0x5D, 0x03, Zero, Zero, Zero)
        Store (Zero, Local0)
    }

    Method (PWAK, 1, Serialized)
    {
        Notify (\_SB.PCI0.LPCB.SIO.COM1, Zero) // Bus Check
        Notify (\_SB.PCI0.RP02, Zero) // Bus Check
        Notify (\_SB.PCI0.EH01, Zero) // Bus Check
        Notify (\_SB.PCI0.EH02, Zero) // Bus Check
        If (LOr (LEqual (Arg0, 0x04), LEqual (Arg0, 0x03)))
        {
            \_SB.SSMI (0x5D, One, Zero, Zero, Zero)
            Notify (\_SB.PCI0.RP03, Zero) // Bus Check
        }

        If (LOr (LEqual (Arg0, 0x04), LEqual (Arg0, 0x03)))
        {
            If (LEqual (WCOS (), 0x06))
            {
                If (\_SB.PCI0.RP06.NIC.LPON ())
                {
                    If (\_SB.DCKD ())
                    {
                        Notify (\_SB.PCI0.RP06.NIC, Zero) // Bus Check
                    }
                }
            }
        }
    }

    Method (_SB.PCI0.LPCB.PS2M._HID, 0, Serialized)  // _HID: Hardware ID
    {
        Name (_T_0, Zero)  // _T_x: Emitted by ASL Compiler
        Store (PRDT, _T_0) /* \_SB_.PCI0.LPCB.PS2M._HID._T_0 */
        If (LEqual (_T_0, One))
        {
            Store (0x7C012E4F, Local1)
        }
        Else
        {
            If (LEqual (_T_0, 0x02))
            {
                Store (0x7B012E4F, Local1)
            }
            Else
            {
                If (LEqual (_T_0, 0x03))
                {
                    Store (0x7D012E4F, Local1)
                }
                Else
                {
                    If (LEqual (_T_0, 0x05))
                    {
                        Store (0x83012E4F, Local1)
                    }
                    Else
                    {
                        If (LEqual (_T_0, 0x07))
                        {
                            Store (0x80012E4F, Local1)
                        }
                        Else
                        {
                            If (LEqual (_T_0, 0x08))
                            {
                                Store (0x87012E4F, Local1)
                            }
                            Else
                            {
                                If (LEqual (_T_0, 0x09))
                                {
                                    Store (0x86012E4F, Local1)
                                }
                                Else
                                {
                                    If (LEqual (_T_0, 0x0A))
                                    {
                                        Store (0x85012E4F, Local1)
                                    }
                                    Else
                                    {
                                        Store (0x65012E4F, Local1)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Return (Local1)
    }

    Name (_S0, Package (0x03)  // _S0_: S0 System State
    {
        Zero, 
        Zero, 
        Zero
    })
    Name (_S3, Package (0x03)  // _S3_: S3 System State
    {
        0x05, 
        0x05, 
        Zero
    })
    Name (_S4, Package (0x03)  // _S4_: S4 System State
    {
        0x06, 
        0x06, 
        Zero
    })
    Name (_S5, Package (0x03)  // _S5_: S5 System State
    {
        0x07, 
        0x07, 
        Zero
    })
    Method (B1B2, 2, NotSerialized)
    {
        ShiftLeft (Arg1, 0x08, Local0)
        Or (Arg0, Local0, Local0)
        Return (Local0)
    }

    Device (SMCD)
    {
        Name (_HID, "FAN00000")  // _HID: Hardware ID
        Name (TACH, Package (0x02)
        {
            "System Fan", 
            "FAN0"
        })
        Name (TEMP, Package (0x04)
        {
            "CPU Heatsink", 
            "TCPU", 
            "Ambient", 
            "TAMB"
        })
        Method (FAN0, 0, Serialized)
        {
            Store (\_SB.PCI0.LPCB.EC0.FRDC, Local0)
            If (Local0)
            {
                Divide (Add (0x0003C000, ShiftRight (Local0, One)), Local0, , 
                    Local0)
            }

            If (LEqual (0x03C4, Local0))
            {
                Return (Zero)
            }

            Return (Local0)
        }

        Method (TCPU, 0, Serialized)
        {
            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
            Store (One, \_SB.PCI0.LPCB.EC0.CRZN)
            Store (\_SB.PCI0.LPCB.EC0.DTMP, Local0)
            Release (\_SB.PCI0.LPCB.EC0.ECMX)
            Return (Local0)
        }

        Method (TAMB, 0, Serialized)
        {
            Acquire (\_SB.PCI0.LPCB.EC0.ECMX, 0xFFFF)
            Store (0x04, \_SB.PCI0.LPCB.EC0.CRZN)
            Store (\_SB.PCI0.LPCB.EC0.TEMP, Local0)
            Release (\_SB.PCI0.LPCB.EC0.ECMX)
            Return (Local0)
        }
    }
}

