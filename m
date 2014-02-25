Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:48885 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaBYT1d (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2014 14:27:33 -0500
Received: by mail-pb0-f48.google.com with SMTP id md12so4365074pbc.35
        for <linux-pci@vger.kernel.org>; Tue, 25 Feb 2014 11:27:33 -0800 (PST)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
Date: Tue, 25 Feb 2014 11:27:32 -0800
Message-ID: <CAA93t1osfYie-CWSTsqdeyzFOwCfsBPaGJ2rtyEkiY0e4kHUMw@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 24, 2014 at 4:46 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> [+cc Rajat]
>
> On Mon, Feb 24, 2014 at 4:59 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> On system with 16 PCI express hotplug slots, customer complain every slot
>> will report "Command not completed in 1000 msec" during initialization.
>>
>> Intel says that we should only wait command complete only for
>>            Electromechanical Interlock Control
>>            Power Controller Control
>>            Power Indicator Control
>>            Attention Indicator Control


Hello,

I have a HW that generates Command Completion notifications, even
though it does not implement any of the EMI, Power Controller, Power
Indicator, Attention indicator. Although I'm not sure whether or not
this behavior is compliant to PCIe spec, just wanted to pitch in to
convey that there are HW which have this behavior:

PCI bridge: Integrated Device Technology, Inc. Device 807a (rev 02)
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=02, secondary=30, subordinate=3f, sec-latency=0
I/O behind bridge: 00009000-00009fff
Memory behind bridge: 88000000-8bffffff
Prefetchable memory behind bridge: 00000000b1000000-00000000b11fffff
Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
        PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
        DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
                ExtTag+ RBE+ FLReset-
        DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
                RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                MaxPayload 128 bytes, MaxReadReq 128 bytes
        DevSta: CorrErr+ UncorrErr- FatalErr+ UnsuppReq+ AuxPwr- TransPend-
        LnkCap: Port #13, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
L0 <4us, L1 <4us
                ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk-
DLActive+ BWMgmt- ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
                Slot #13, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
                Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ Interlock-
                Changed: MRL- PresDet- LinkState-
        DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR-,
OBFF Not Supported ARIFwd+
        DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-,
OBFF Disabled ARIFwd-
        LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance- SpeedDis-,
Selectable De-emphasis: -6dB
                 Transmit Margin: Normal Operating Range,
EnterModifiedCompliance- ComplianceSOS-
                 Compliance De-emphasis: -6dB
        LnkSta2: Current De-emphasis Level: -6dB,
EqualizationComplete-, EqualizationPhase1-
                 EqualizationPhase2-, EqualizationPhase3-,
LinkEqualizationRequest-
Capabilities: [c0] Power Management version 3
        Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA
PME(D0+,D1-,D2-,D3hot+,D3cold+)
        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
        Address: 00000000fff41740  Data: 0008
Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES+ TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
        CESta:  RxErr+ BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
        AERCap: First Error Pointer: 05, GenCap+ CGenEn- ChkCap+ ChkEn-
Capabilities: [200 v1] Virtual Channel
        Caps:   LPEVC=0 RefClk=100ns PATEntryBits=4
        Arb:    Fixed- WRR32- WRR64- WRR128-
        Ctrl:   ArbSelect=Fixed
        Status: InProgress-
        VC0:    Caps:   PATOffset=04 MaxTimeSlots=1 RejSnoopTrans-
                Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
                Ctrl:   Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
                Status: NegoPending- InProgress-
                Port Arbitration Table <?>
Capabilities: [320 v1] Access Control Services
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl+ DirectTrans+
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
Capabilities: [330 v1] #12
Kernel driver in use: pcieport


>
> Is there something in the spec that says this?  I'm looking at section
> 6.7.3.2.  It says "If command completed events are supported, then
> software must wait for a command to complete before issuing the next
> command."  It's obvious that this is conditional on the "No Command
> Completed Support" bit, but I don't see anything about a connection
> with the other bits you mentioned.
>
> Is this related to an erratum in the Intel/AMD/Nvidia chipsets?  If
> so, we need at least a comment about that in the source, and
> preferably, some sort of quirk for these chipsets.
>
> Otherwise, we're likely to break this in the future when somebody
> reading the code says "this doesn't correspond with what the spec
> says."  In case we *do* break this in the future, I'd like to have a
> bugzilla that contains the dmesg showing the problem and "lspci -vv"
> so we have a hope of figuring out what systems this affects.
>
> This is similar to the issue Rajat is working on with
> http://patchwork.ozlabs.org/patch/322387/ .  I haven't merged that
> yet, but I probably will.  Is there any connection between that patch
> and this issue?  Does this issue still happen even with Rajat's patch
> applied?

Also, wanted to my mention that my patch applies equally to the
systems that exhibit this behavior and the other systems (Intel etc)
that do not exhibit this behavior. That is because if for any reason
(e.g. spurious interrupt) the condition "if (slot_status &
PCI_EXP_SLTSTA_CC)" becomes trues in pcie_write_cmd(), we do not clear
this bit but expect "cmd completed" events to be generated in future.
In other words my patch is independent of Yinghai's patch, and the
fact it helps my systems is a (desired) side effect.

Lastly, it seems to me that if a platform does not support the 4 HP
elements mentioned above, the only other reason to write to Slot_Ctrl
register will be to enable and disable notifications (during init /
suspend / resume / reset_slot etc). So I was wondering if it would
help if we explicitly cleared the CC bit after we enable disable
hotplug notifications? If such a change was there, then probably we'd
be able to cater both kind of systems, and making sure that none sees
a delay at boot up. But yes, I do agree that this is going to create
more haphazardness in the system (the code flow is already difficult
to follow, specially for "cmd completed")

Thanks,

Rajat

>
> Bjorn
>
>> System with AMD/Nvidia chipset have same problem.
>>
>> So change to only wait when following bits get changed.
>>         PCI_EXP_SLTCTL_EIC
>>         PCI_EXP_SLTCTL_PCC
>>         PCI_EXP_SLTCTL_PIC
>>         PCI_EXP_SLTCTL_AIC
>>
>> With that we could set 16 seconds during booting, later with 32 sockets system
>> with 64 pcie hotplug slots we could save 64 seconds.
>>
>> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
>>
>> ---
>>  drivers/pci/hotplug/pciehp_hpc.c |   11 ++++++-----
>>  include/uapi/linux/pci_regs.h    |    5 +++++
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
>> Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> ===================================================================
>> --- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
>> +++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -152,8 +152,8 @@ static void pcie_wait_cmd(struct control
>>  static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>>  {
>>         struct pci_dev *pdev = ctrl_dev(ctrl);
>> +       u16 slot_ctrl, old_slot_ctrl;
>>         u16 slot_status;
>> -       u16 slot_ctrl;
>>
>>         mutex_lock(&ctrl->ctrl_lock);
>>
>> @@ -181,9 +181,8 @@ static void pcie_write_cmd(struct contro
>>                 }
>>         }
>>
>> -       pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
>> -       slot_ctrl &= ~mask;
>> -       slot_ctrl |= (cmd & mask);
>> +       pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &old_slot_ctrl);
>> +       slot_ctrl = (old_slot_ctrl & ~mask) | (cmd & mask);
>>         ctrl->cmd_busy = 1;
>>         smp_mb();
>>         pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
>> @@ -191,7 +190,9 @@ static void pcie_write_cmd(struct contro
>>         /*
>>          * Wait for command completion.
>>          */
>> -       if (!ctrl->no_cmd_complete) {
>> +       if (!ctrl->no_cmd_complete &&
>> +           ((PCI_EXP_SLTCTL_WAIT_MASK & old_slot_ctrl) !=
>> +            (PCI_EXP_SLTCTL_WAIT_MASK & slot_ctrl))) {
>>                 int poll = 0;
>>                 /*
>>                  * if hotplug interrupt is not enabled or command
>> Index: linux-2.6/include/uapi/linux/pci_regs.h
>> ===================================================================
>> --- linux-2.6.orig/include/uapi/linux/pci_regs.h
>> +++ linux-2.6/include/uapi/linux/pci_regs.h
>> @@ -535,6 +535,11 @@
>>  #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
>>  #define  PCI_EXP_SLTCTL_EIC    0x0800  /* Electromechanical Interlock Control */
>>  #define  PCI_EXP_SLTCTL_DLLSCE 0x1000  /* Data Link Layer State Changed Enable */
>> +/* only need to wait command complete for hpc related */
>> +#define  PCI_EXP_SLTCTL_WAIT_MASK (PCI_EXP_SLTCTL_EIC | \
>> +                                  PCI_EXP_SLTCTL_PCC | \
>> +                                  PCI_EXP_SLTCTL_PIC | \
>> +                                  PCI_EXP_SLTCTL_AIC)
>>  #define PCI_EXP_SLTSTA         26      /* Slot Status */
>>  #define  PCI_EXP_SLTSTA_ABP    0x0001  /* Attention Button Pressed */
>>  #define  PCI_EXP_SLTSTA_PFD    0x0002  /* Power Fault Detected */
