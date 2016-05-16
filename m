Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:36735 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753854AbcEPSCh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2016 14:02:37 -0400
Received: by mail-qk0-f175.google.com with SMTP id x7so101074349qkd.3
        for <linux-pci@vger.kernel.org>; Mon, 16 May 2016 11:02:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1463331375.6071.39.camel@users.sourceforge.net>
References: <1463331375.6071.39.camel@users.sourceforge.net>
Date: Mon, 16 May 2016 12:02:35 -0600
Message-ID: <CAL-B5D19esStG0=nbUa-mJggtRDX94t542Vzz1=u_avq9qRgYQ@mail.gmail.com>
Subject: Re: `pcilib: sysfs_read_vpd: read failed: Input/output error` on
 ASRock E350M1
From: Myron Stowe <myron.stowe@gmail.com>
To: Paul Menzel <paulepanter@users.sourceforge.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, May 15, 2016 at 10:56 AM, Paul Menzel
<paulepanter@users.sourceforge.net> wrote:
> Dear Bjorn,
>
>
> running Linux 4.6.0-rc5-686-pae from Debian experimental, running
> `lspci -vv` on the ASRock E350M1 gives the error below. This wasn’t
> there with Linux 4.6-rc3.
>
> ```
> $ sudo lspci -s 3:0 -vv
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
>         Subsystem: ASRock Incorporation Motherboard (one of many)
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Interrupt: pin A routed to IRQ 26
>         Region 0: I/O ports at 1000 [size=256]
>         Region 2: Memory at f0004000 (64-bit, prefetchable) [size=4K]
>         Region 4: Memory at f0000000 (64-bit, prefetchable) [size=16K]
>         Capabilities: [40] Power Management version 3
>                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [50] MSI: Enable+ Count=1/1 Maskable- 64bit+
>                 Address: 00000000fee0300c  Data: 41d1
>         Capabilities: [70] Express (v2) Endpoint, MSI 01
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <512ns, L1 <64us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 128 bytes, MaxReadReq 4096 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr+ TransPend-
>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s L1, Exit Latency L0s <512ns, L1 <64us
>                         ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>                 DevCap2: Completion Timeout: Not Supported, TimeoutDis+, LTR-, OBFF Not Supported
>                 DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
>                 LnkCtl2: Target Link Speed: 2.5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
>         Capabilities: [b0] MSI-X: Enable- Count=4 Masked-
>                 Vector table: BAR=4 offset=00000000
>                 PBA: BAR=4 offset=00000800
>         Capabilities: [d0] Vital Product Data
> pcilib: sysfs_read_vpd: read failed: Input/output error
>                 Not readable

It looks as if reading the first byte(s) of VPD to decode the
"resource data types/tags" and "keywords" returned '0'.  Since that is
invalid (i.e. does not conform to a properly formatted "tag") 'lspci'
aborted any further accessing and returned "Not readable" (this sounds
very similar to what happens on a Serial Attached SCSI controller: LSI
Logic / Symbios Logic SAS2308 PCI-Express Fusion-MPT SAS-2 device
which, while denoting it has VPD via the Express capability, doe not -
the data area is all 0's.

>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
>         Capabilities: [140 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
>         Capabilities: [160 v1] Device Serial Number 01-00-00-00-68-4c-e0-00
>         Kernel driver in use: r8169
>         Kernel modules: r8169
> ```
>
> Is that related to [1]?
>

There have been a number of recent kernel commits to work-around know
buggy devices -
  v4.6-rc5
    67e6587  cxgb4: Set VPD size so we can read both VPD structures
    cb92148  PCI: Add pci_set_vpd_size() to set VPD size
  v4.6 -
    7c20078  PCI: Prevent VPD access for buggy devices
    c521b01  PCI: Sleep rather than busy-wait for VPD access completion
    408641e  PCI: Fold struct pci_vpd_pci22 into struct pci_vpd
    f1cd93f  PCI: Rename VPD symbols to remove unnecessary "pci22"
    da00684  PCI: Remove struct pci_vpd_ops.release function pointer
    6437907  PCI: Move pci_vpd_release() from header file to pci/access.c
    fc0a407  PCI: Move pci_read_vpd() and pci_write_vpd() close to other code
    104daa7  PCI: Determine actual VPD size on first access
    c556388  PCI: Use bitfield instead of bool for struct pci_vpd_pci22.busy
    f52e562  PCI: Allow access to VPD attributes with size 0
    9eb45d5  PCI: Update VPD definitions
  v4.3 -
    da2d03e  PCI: Use function 0 VPD only for identical functions
    9d92407  PCI: Fix devfn for VPD access through function 0
    7aa6ca4  PCI: Add VPD function 0 quirk for Intel Ethernet devices
    932c435  PCI: Add dev_flags bit to access VPD through function 0

What were you getting/seeing before?

Myron

>
> Thanks,
>
> Paul
>
>
> [1] https://lkml.org/lkml/2016/4/15/649
