Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f171.google.com ([209.85.223.171]:37455 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932908AbaDIRUw (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 9 Apr 2014 13:20:52 -0400
Received: by mail-ie0-f171.google.com with SMTP id ar20so2754193iec.16
        for <linux-pci@vger.kernel.org>; Wed, 09 Apr 2014 10:20:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAA93t1rN_av-KBUxLtaYX00T1FyQhEaLGme_P7DaR=pd4eELPA@mail.gmail.com>
References: <CAA93t1rN_av-KBUxLtaYX00T1FyQhEaLGme_P7DaR=pd4eELPA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Wed, 9 Apr 2014 11:20:31 -0600
Message-ID: <CAErSpo6fvbC35NGHOAvmMC8NP705JoNCqqLhXz+6U-Zj0DNU9Q@mail.gmail.com>
Subject: Re: Debugging "Completion Timeout" errors as reported by AER
To: Rajat Jain <rajatxjain@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatjain@juniper.net>,
	Guenter Roeck <groeck@juniper.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 8, 2014 at 9:48 PM, Rajat Jain <rajatxjain@gmail.com> wrote:
> Hello,
>
> I am debugging a problem where the AER driver reports Completion
> Timeouts" for any PCI memory read access to a certain endpoint device:
>
> pcieport 0000:00:03.0: AER: Uncorrected (Non-Fatal) error received: id=0018
> pcieport 0000:00:03.0: PCIe Bus Error: severity=Uncorrected
> (Non-Fatal), type=Transaction Layer, id=0018(Requester ID)
> pcieport 0000:00:03.0:   device [8086:1f12] error status/mask=00004000/00400000
> pcieport 0000:00:03.0:    [14] Completion Timeout     (First)
> pcieport 0000:00:03.0: AER: Device recovery failed
> pcieport 0000:00:03.0: AER: Uncorrected (Non-Fatal) error received: id=0018
> pcieport 0000:00:03.0: PCIe Bus Error: severity=Uncorrected
> (Non-Fatal), type=Transaction Layer, id=0018(Requester ID)
> pcieport 0000:00:03.0:   device [8086:1f12] error status/mask=00004000/00400000
> pcieport 0000:00:03.0:    [14] Completion Timeout     (First)
> pcieport 0000:00:03.0: AER: Device recovery failed
>
> The configuration access to the said device is going on fine. The same
> end point and the same hardware is working fine on a different OS.
>
> This is what my PCIe hierarchy looks like:
>
> root@localhost:~# lspci -t
> -[0000:00]-+-00.0
>            +-01.0-[01-06]--
>            +-02.0-[07-0c]--
>            +-03.0-[0d-12]----00.0 <--- The device I am trying to access
>            +-04.0-[13-18]--
>            +-0e.0
>            +-0f.0
>            +-13.0
>            +-14.0
>            +-14.1
>            +-14.2
>            +-16.0
>            +-17.0
>            +-18.0
>            +-1f.0
>            \-1f.3
> root@localhost:~#
>
> The device i am trying to access is 0d:00.0 which is a FPGA device
> connected directly to an Intel root port:
>
> root@localhost:~# lspci -vvvv -s d:0
> 0d:00.0 System peripheral: Juniper Networks Device 006c (rev 02)
>         Subsystem: Juniper Networks Device 006c
>         Physical Slot: 2
>         Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx-
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Interrupt: pin A routed to IRQ 22
>         Region 0: Memory at 8c000000 (32-bit, non-prefetchable) [size=64M]
>         Capabilities: [50] MSI: Enable- Count=1/4 Maskable- 64bit+
>                 Address: 0000000000000000  Data: 0000
>         Capabilities: [78] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0-,D1-,D2-,D3hot-,D3cold-)
>                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [80] Express (v1) Endpoint, MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                         ExtTag- AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
> Unsupported-
>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>                         MaxPayload 256 bytes, MaxReadReq 512 bytes
>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq-
> AuxPwr- TransPend-
>                 LnkCap: Port #1, Speed 2.5GT/s, Width x4, ASPM L0s,
> Latency L0 unlimited, L1 unlimited
>                         ClockPM- Surprise- LLActRep- BwNot-
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive- BWMgmt- ABWMgmt-
>         Capabilities: [100 v1] Virtual Channel
>                 Caps:   LPEVC=0 RefClk=100ns PATEntryBits=1
>                 Arb:    Fixed- WRR32- WRR64- WRR128-
>                 Ctrl:   ArbSelect=Fixed
>                 Status: InProgress-
>                 VC0:    Caps:   PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
>                         Arb:    Fixed- WRR32- WRR64- WRR128- TWRR128- WRR256-
>                         Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
>                         Status: NegoPending- InProgress-
>         Kernel driver in use: sam-mfd-core
>
> This is how the parent root port is setup:
>
> root@localhost:~#
> root@localhost:~# lspci -vvvv -s 0:3.0
> 00:03.0 PCI bridge: Intel Corporation Device 1f12 (rev 02) (prog-if 00
> [Normal decode])
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>         Latency: 0, Cache Line Size: 64 bytes
>         Region 0: Memory at a4040000 (64-bit, non-prefetchable) [size=128K]
>         Bus: primary=00, secondary=0d, subordinate=12, sec-latency=0
>         I/O behind bridge: 00002000-00002fff
>         Memory behind bridge: 8c000000-93ffffff
>         Prefetchable memory behind bridge: 0000000082000000-0000000082ffffff
>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort+ <SERR- <PERR-
>         BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>         Capabilities: [40] Express (v2) Root Port (Slot+), MSI 00
>                 DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s
> <64ns, L1 <1us
>                         ExtTag+ RBE+ FLReset-
>                 DevCtl: Report errors: Correctable+ Non-Fatal+ Fatal+
> Unsupported+
>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>                         MaxPayload 256 bytes, MaxReadReq 256 bytes
>                 DevSta: CorrErr+ UncorrErr+ FatalErr- UnsuppReq-
> AuxPwr- TransPend-
>                 LnkCap: Port #3, Speed 5GT/s, Width x4, ASPM L1,
> Latency L0 <1us, L1 <4us
>                         ClockPM- Surprise+ LLActRep+ BwNot+
>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train-
> SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
> HotPlug+ Surprise+
>                         Slot #2, PowerLimit 25.000W; Interlock- NoCompl-
>                 SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
> CmdCplt+ HPIrq+ LinkChg+
>                         Control: AttnInd Off, PwrInd Off, Power- Interlock-
>                 SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
> PresDet+ Interlock-
>                         Changed: MRL- PresDet- LinkState-
>                 RootCtl: ErrCorrectable- ErrNon-Fatal- ErrFatal-
> PMEIntEna- CRSVisible-
>                 RootCap: CRSVisible-
>                 RootSta: PME ReqID 0000, PMEStatus- PMEPending-
>                 DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
> LTR-, OBFF Not Supported ARIFwd+
>                 DevCtl2: Completion Timeout: 50us to 50ms,
> TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
>                 LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-
>                          Transmit Margin: Normal Operating Range,
> EnterModifiedCompliance- ComplianceSOS-
>                          Compliance De-emphasis: -6dB
>                 LnkSta2: Current De-emphasis Level: -6dB,
> EqualizationComplete-, EqualizationPhase1-
>                          EqualizationPhase2-, EqualizationPhase3-,
> LinkEqualizationRequest-
>         Capabilities: [80] Power Management version 3
>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
> PME(D0+,D1-,D2-,D3hot+,D3cold+)
>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>         Capabilities: [88] Subsystem: Intel Corporation Device 7270
>         Capabilities: [90] MSI: Enable+ Count=1/1 Maskable+ 64bit-
>                 Address: fee0300c  Data: 4191
>                 Masking: 00000000  Pending: 00000000
>         Capabilities: [100 v1] Advanced Error Reporting
>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO+ CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>                 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
> UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
>                 AERCap: First Error Pointer: 0e, GenCap- CGenEn- ChkCap- ChkEn-
>         Kernel driver in use: pcieport
>
> root@localhost:~#
> root@localhost:~#
>
> The driver for the end point does little other than the following at
> this point, which is when the AER is received:
>
>        err = pci_enable_device(pdev);
>         if (err < 0) {
>                 dev_err(dev, "pci_enable_device() failed: %d\n", err);
>                 return err;
>         }
>
>         err = pci_request_regions(pdev, "sam-mfd-code");
>         if (err < 0) {
>                 dev_err(dev, "pci_request_regions() failed: %d\n",
>                         err);
>                 goto err_disable;
>         }
>
>         sam->membase = pci_ioremap_bar(pdev, 0);
>         if (!sam->membase) {
>                 dev_err(dev, "pci_ioremap_bar() failed\n");
>                 err = -ENOMEM;
>                 goto err_release;
>         }
>
>         cpld = (u8 *)sam->membase;
>         for (i = 0; i < 0x40; i++) {
>                         pr_emerg(" %02X", cpld[i]);
>         }
>
>
> My questions:
>
> 1) What can be the possible reasons for such a "completion timeout"?
> I'd have suspected the end device to not respond, but apparently it is
> working fine on a different OS. This looks like a configuration issue
> somewhere.

Can you compare the config space settings of the Root Port and your
device under the other OS with those under Linux?  If the other OS is
Windows, AIDA64 (http://www.aida64.com) or RWEverything
(http://rweverything.com) might be useful, along with "lspci -xxx".

The root port (00:03.0) claims to support programmable completion
timeouts (ranges ABC), but it is currently set to the default of 50us
to 50ms:

               DevCap2: Completion Timeout: Range ABC, TimeoutDis+,
LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-

Linux currently never does anything with these timeouts, except for an
individual driver or two.

You could set the timeout higher with setpci (set the low nibble of
DevCtl2 to 0xa) and see if that makes any difference.  See sec 7.8.16
of the PCIe r3.0 spec for details.

> 3) The only anomaly I had found was this message while booting up:
> pci 0000:0d:00.0: Max Payload Size 128, but upstream 0000:00:03.0 set
> to 256; if necessary, use "pci=pcie_bus_safe" and report a bug
> But after using "pci=pcie_bus_safe", that also went away.

I assume using pcie_bus_safe didn't make any difference as far as the
completion timeouts?

> However, I'm not sure why currently the Maximum read size is still set
> to 512 in the device. Do you think that could be the issue?

I doubt it.  The device (0d:00.0) MPS is smaller than the Root Port
(00:03.0) MPS, so if the Root Port sent a TLP larger than 128 bytes,
that would be an issue, but (1) that would happen if the device did a
DMA read, but you're doing a read *from* the device and (2) I would
expect the device to report a Malformed TLP error, but you're seeing a
Completion Timeout from the Root Port (see spec sec 2.2.2).

Bjorn
