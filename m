Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46869 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754702AbaFQDZv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 16 Jun 2014 23:25:51 -0400
Received: by mail-pa0-f42.google.com with SMTP id lj1so5252672pab.29
        for <linux-pci@vger.kernel.org>; Mon, 16 Jun 2014 20:25:50 -0700 (PDT)
MIME-Version: 1.0
Reply-To: rajatxjain@gmail.com
In-Reply-To: <20140614212139.15202.93232.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <20140614210740.15202.84719.stgit@bhelgaas-glaptop.roam.corp.google.com>
	<20140614212139.15202.93232.stgit@bhelgaas-glaptop.roam.corp.google.com>
Date: Mon, 16 Jun 2014 20:25:50 -0700
Message-ID: <CAA93t1pi8ppv6Pbp7yzsU0EE7arXQVgUj2o1x-7-+Wy9yXD4DQ@mail.gmail.com>
Subject: Re: [PATCH RFC 4/4] PCI: pciehp: Remove assumptions about which
 commands cause completion events
From: Rajat Jain <rajatxjain@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Yinghai Lu <yinghai@kernel.org>, "Jan C. Nordholz" <jckn@gmx.net>,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello,

I tested all the 4 patches and they works great on my system (one that
sets the completion on all writes to "slot control" register).

Tested-by: Rajat Jain <rajatxjain@gmail.com>

02:01.0 PCI bridge: Integrated Device Technology, Inc. Device 807a
(rev 02) (prog-if 00 [Normal decode])
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0
        Bus: primary=02, secondary=90, subordinate=9f, sec-latency=0
        I/O behind bridge: 00002000-00002fff
        Memory behind bridge: 88000000-8bffffff
        Prefetchable memory behind bridge: 00000000b0200000-00000000b03fffff
        Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- <SERR- <PERR-
        BridgeCtl: Parity- SERR- NoISA- VGA- MAbort- >Reset- FastB2B-
                PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
        Capabilities: [40] Express (v2) Downstream Port (Slot+), MSI 00
                DevCap: MaxPayload 2048 bytes, PhantFunc 0, Latency
L0s <64ns, L1 <1us
                        ExtTag+ RBE+ FLReset-
                DevCtl: Report errors: Correctable- Non-Fatal- Fatal-
Unsupported-
                        RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
                        MaxPayload 128 bytes, MaxReadReq 128 bytes
                DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+
AuxPwr- TransPend-
                LnkCap: Port #1, Speed 5GT/s, Width x4, ASPM L0s L1,
Latency L0 <4us, L1 <4us
                        ClockPM- Surprise+ LLActRep+ BwNot+
                LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                        ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
                LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train-
SlotClk- DLActive- BWMgmt- ABWMgmt-
                SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd-
HotPlug+ Surprise-
                        Slot #1, PowerLimit 0.000W; Interlock- NoCompl-
                SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+
CmdCplt+ HPIrq+ LinkChg+
                        Control: AttnInd Unknown, PwrInd Unknown,
Power- Interlock-
                SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt-
PresDet- Interlock-
                        Changed: MRL- PresDet- LinkState-
                DevCap2: Completion Timeout: Not Supported,
TimeoutDis-, LTR-, OBFF Not Supported ARIFwd+
                DevCtl2: Completion Timeout: 50us to 50ms,
TimeoutDis-, LTR-, OBFF Disabled ARIFwd-
                LnkCtl2: Target Link Speed: 5GT/s, EnterCompliance-
SpeedDis-, Selectable De-emphasis: -6dB
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
                Address: 00000000fff41740  Data: 0001
        Capabilities: [100 v1] Advanced Error Reporting
                UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt-
UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
                UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt-
UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
                CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr+
                AERCap: First Error Pointer: 00, GenCap+ CGenEn- ChkCap+ ChkEn-
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
                ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
UpstreamFwd+ EgressCtrl+ DirectTrans+
                ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
UpstreamFwd- EgressCtrl- DirectTrans-
        Capabilities: [330 v1] #12
        Kernel driver in use: pcieport


Before these 4 patches, there was no timeout on my system but there
was a spurious error message saying

[   26.324838] pciehp 0000:02:00.0:pcie24: Unexpected CMD_COMPLETED.
Need to wait for command completed event

which was gone with these patches.


Thanks!

Rajat

On Sat, Jun 14, 2014 at 2:21 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> We use incorrect logic to decide whether a PCIe hotplug controller
> generates command completion events.
>
> 5808639bfa98 ("pciehp: fix slow probing") assumed that the Slot Status
> "Command Completed" bit was set only for commands affecting slot power,
> indicators, or electromechanical interlock.  That assumption is false: per
> sec. 6.7.3.2 of PCIe spec r3.0, a write targeting any portion of the Slot
> Control register is a command, and (if command completed events are
> supported) software must wait for a command to complete before issuing the
> next command.
>
> 5808639bfa98 was to fix boot-time timeouts (see bugzilla below) on a Lenovo
> Thinkpad R61 with an Intel hotplug controller.  The controller probably has
> the Intel CF118 erratum, which means it doesn't report Command Completed
> unless the Slot Control power, indicator, or interlock bits are changed.
> This causes a timeout because pciehp always waits for Command Complete (if
> supported), regardless of which bits are changed.
>
> Remove the incorrect logic because the timeouts have been addressed
> differently by these changes:
>
>   PCI: pciehp: Wait for hotplug command completion lazily
>   PCI: pciehp: Compute timeout from hotplug command start time
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=10751
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c |   39 ++++++++------------------------------
>  1 file changed, 8 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 18ac24d84f9b..1f70de5359fb 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -161,8 +161,10 @@ static void pcie_wait_cmd(struct controller *ctrl)
>                 rc = wait_event_timeout(ctrl->queue, !ctrl->cmd_busy, timeout);
>         else
>                 rc = pcie_poll_cmd(ctrl, timeout);
> +
>         if (!rc)
> -               ctrl_dbg(ctrl, "Command not completed in 1000 msec\n");
> +               ctrl_info(ctrl, "Timeout on hotplug command %#010x\n",
> +                         ctrl->slot_ctrl);
>  }
>
>  /**
> @@ -174,7 +176,6 @@ static void pcie_wait_cmd(struct controller *ctrl)
>  static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>  {
>         struct pci_dev *pdev = ctrl_dev(ctrl);
> -       u16 slot_status;
>         u16 slot_ctrl;
>
>         mutex_lock(&ctrl->ctrl_lock);
> @@ -182,30 +183,6 @@ static void pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>         /* Wait for any previous command that might still be in progress */
>         pcie_wait_cmd(ctrl);
>
> -       pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
> -       if (slot_status & PCI_EXP_SLTSTA_CC) {
> -               pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> -                                          PCI_EXP_SLTSTA_CC);
> -               if (!ctrl->no_cmd_complete) {
> -                       /*
> -                        * After 1 sec and CMD_COMPLETED still not set, just
> -                        * proceed forward to issue the next command according
> -                        * to spec. Just print out the error message.
> -                        */
> -                       ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
> -               } else if (!NO_CMD_CMPL(ctrl)) {
> -                       /*
> -                        * This controller seems to notify of command completed
> -                        * event even though it supports none of power
> -                        * controller, attention led, power led and EMI.
> -                        */
> -                       ctrl_dbg(ctrl, "Unexpected CMD_COMPLETED. Need to wait for command completed event\n");
> -                       ctrl->no_cmd_complete = 0;
> -               } else {
> -                       ctrl_dbg(ctrl, "Unexpected CMD_COMPLETED. Maybe the controller is broken\n");
> -               }
> -       }
> -
>         pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
>         slot_ctrl &= ~mask;
>         slot_ctrl |= (cmd & mask);
> @@ -785,14 +762,14 @@ struct controller *pcie_init(struct pcie_device *dev)
>         mutex_init(&ctrl->ctrl_lock);
>         init_waitqueue_head(&ctrl->queue);
>         dbg_ctrl(ctrl);
> +
>         /*
>          * Controller doesn't notify of command completion if the "No
> -        * Command Completed Support" bit is set in Slot Capability
> -        * register or the controller supports none of power
> -        * controller, attention led, power led and EMI.
> +        * Command Completed Support" bit is set in Slot Capabilities.
> +        * If set, it means the controller can accept hotplug commands
> +        * with no delay between them.
>          */
> -       if (NO_CMD_CMPL(ctrl) ||
> -           !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
> +       if (NO_CMD_CMPL(ctrl))
>                 ctrl->no_cmd_complete = 1;
>
>         /* Check if Data Link Layer Link Active Reporting is implemented */
>
