Return-Path: <SRS0=3Bcx=HF=broadcom.com=srinath.mannam@kernel.org>
Return-Path: <SRS0=3Bcx=HF=broadcom.com=srinath.mannam@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180414160918.GA158153@bhelgaas-glaptop.roam.corp.google.com>
References: <CABe79T47vUjq20HuMrJZxhZWMr0q3uXMF6xL1TgkqhqA8qi1wg@mail.gmail.com>
 <20180413135659.GC46420@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4nO7dC9uHwX-woAvkdw0+b2ssUyxgs0cnGo90OH_YD+Q@mail.gmail.com>
 <20180413211651.GA80087@bhelgaas-glaptop.roam.corp.google.com>
 <CABe79T4XC07tExSTOEoj9d5hkYWsm5QHUMD8rWorzz8S=V0yUA@mail.gmail.com> <20180414160918.GA158153@bhelgaas-glaptop.roam.corp.google.com>
From: Srinath Mannam <srinath.mannam@broadcom.com>
Date: Mon, 16 Apr 2018 21:03:33 +0530
Message-ID: <CABe79T5Qzm1uSSZJH38pgYrSuhxo1W-EJK-LU+NpWBgvoehm2w@mail.gmail.com>
Subject: Re: Issue with Enable LTR while pcie_aspm off
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Ray Jui <ray.jui@broadcom.com>, linux-pci@vger.kernel.org,
	Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Hi Bjorn,

Please find my comments inline.

On Sat, Apr 14, 2018 at 9:39 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Sat, Apr 14, 2018 at 09:04:05AM +0530, Srinath Mannam wrote:
>> I am sorry, in previous mail by mistake I have written L1.s support is
>> not there, Actually I wanted to write L0s support is not there.
>> L1 and L1ss support is there.
>
> If your endpoint (and everything in the path) advertise both LTR and
> L1ss support, that patch probably won't make a difference.
>
> It *might* make a difference if only part of the path supports both,
> because my reading of the spec is that L1ss requires LTR and LTR
> requires the entire path to support LTR, and we currently don't
> enforce that "entire path" part before enabling L1ss.
>
Yes, this patch did not work.
>> But In our platform we required to disable ASPM.
>
> We're trying to figure out exactly *why* you must disable ASPM.  If
> it's because of a hardware defect, e.g., the device advertises ASPM
> support but it's actually broken, we probably need to add a quirk.
> Given the complexity of ASPM, it's surprising we don't have similar
> quirks already.
>
We see issues with ASPM enabled. Some link issues observed so for time being
we are using with aspm disabled until we fix that issue.
with LTR enabled also we observed some problem, that after LTR messages received
from EP, we see completion timeout with config write.
So I thought If LTR configuration function also part of aspm file, as
it was under CONFIG_ASPM.
using pcie_aspm boot arg I can disable both ASPM and LTR.
If this is not possible, then I will go for alternative solution of
quirk implementation as you suggest.
>> RC in our platform supports upto Gen3 only.
>
> I don't think there's a connection between ASPM or LTR and the link
> speed (Gen2, Gen3, etc), is there?
>
Here is the lspci output of RC and EP. EP is directly connected to our
RC, nothing in between.
RC:
0000:00:00.0 PCI bridge: Broadcom Limited Device d714 (prog-if 00
[Normal decode])
        Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Interrupt: pin A routed to IRQ 116
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00000000-00000fff [size=4K]
        Memory behind bridge: 80000000-800fffff [size=1M]
        Prefetchable memory behind bridge:
00000000fff00000-00000000000fffff [empty]
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [48] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=1 PME-
        Capabilities: [ac] Express (v2) Root Port (Slot-), MSI 00
                DevCap: MaxPayload 512 bytes, PhantFunc 0
                        ExtTag+ RBE+
                DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
Unsupported+
                        RlxdOrd+ ExtTag+ PhantFunc- AuxPwr+ NoSnoop+
                        MaxPayload 512 bytes, MaxReadReq 512 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L0s L1,
Exit Latency L0s <1us, L1 <2us
                        ClockPM+ Surprise- LLActRep- BwNot+ ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt+ ABWMgmt-
                RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
PMEIntEna+ CRSVisible+
                RootCap: CRSVisible-
                RootSta: PME ReqID 0000, PMEStatus- PMEPending-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR+, OBFF Via WAKE# ARIFwd+
                         AtomicOpsCap: Routing- 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR+, OBFF Disabled ARIFwd-
                         AtomicOpsCtl: ReqEn- EgressBlck-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -3.5dB,
EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+,
LinkEqualizationRequest-
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
                RootCmd: CERptEn+ NFERptEn+ FERptEn+
                RootSta: CERcvd- MultCERcvd- UERcvd- MultUERcvd-
                         FirstFatal- NonFatalMsg- FatalMsg- IntMsg 0
                ErrorSrc: ERR_COR: 0000 ERR_FATAL/NONFATAL: 0000
        Capabilities: [180 v1] Vendor Specific Information: ID=0000
Rev=0 Len=028 <?>
        Capabilities: [240 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=8us PortTPowerOnTime=10us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=1us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us
        Capabilities: [300 v1] #19
        Kernel driver in use: pcieport

EP:
0000:01:00.0 Non-Volatile memory controller: Samsung Electronics Co
Ltd NVMe SSD Controller SM961/PM961 (prog-if 02 [NVM Express])
        Subsystem: Samsung Electronics Co Ltd NVMe SSD Controller SM961/PM961
        Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 255
        Region 0: Memory at 400000000 (64-bit, non-prefetchable)
[disabled] [size=16K]
        Capabilities: [40] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0-,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
        Capabilities: [50] MSI: Enable- Count=1/32 Maskable- 64bit+
                Address: 0000000000000000  Data: 0000
        Capabilities: [70] Express (v2) Endpoint, MSI 00
                DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
unlimited, L1 unlimited
                        ExtTag- AttnBtn- AttnInd- PwrInd- RBE+
FLReset+ SlotPowerLimit 0.000W
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+ FLReset-
                        MaxPayload 256 bytes, MaxReadReq 256 bytes
                DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
AuxPwr+ TransPend-
                LnkCap: Port #0, Speed 8GT/s, Width x4, ASPM L1, Exit
Latency L1 <64us
                        ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
                LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 8GT/s, Width x4, TrErr- Train- SlotClk+
DLActive- BWMgmt- ABWMgmt-
                DevCap2: Completion Timeout: Range ABCD, TimeoutDis+,
LTR+, OBFF Not Supported
                         AtomicOpsCap: 32bit- 64bit- 128bitCAS-
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled
                         AtomicOpsCtl: ReqEn-
                LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
                         Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                         Compliance De-emphasis: -6dB
                LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete+, EqualizationPhase1+
                         EqualizationPhase2+, EqualizationPhase3+,
LinkEqualizationRequest-
        Capabilities: [b0] MSI-X: Enable- Count=8 Masked-
                Vector table: BAR=0 offset=00003000
                PBA: BAR=0 offset=00002000
        Capabilities: [100 v2] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, ECRCGenCap+
ECRCGenEn- ECRCChkCap+ ECRCChkEn-
                        MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
                HeaderLog: 00000000 00000000 00000000 00000000
        Capabilities: [148 v1] Device Serial Number 00-00-00-00-00-00-00-00
        Capabilities: [158 v1] Power Budgeting <?>
        Capabilities: [168 v1] #19
        Capabilities: [188 v1] Latency Tolerance Reporting
                Max snoop latency: 0ns
                Max no snoop latency: 0ns
        Capabilities: [190 v1] L1 PM Substates
                L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+
ASPM_L1.1+ L1_PM_Substates+
                          PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
                L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
                           T_CommonMode=0us LTR1.2_Threshold=0ns
                L1SubCtl2: T_PwrOn=10us



> Bjorn
