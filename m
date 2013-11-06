Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f43.google.com ([209.85.212.43]:37908 "EHLO
	mail-vb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab3KFCiy (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 5 Nov 2013 21:38:54 -0500
MIME-Version: 1.0
In-Reply-To: <20131106002505.GC3359@google.com>
References: <52797238.8070304@gmail.com>
	<20131106002505.GC3359@google.com>
Date: Tue, 5 Nov 2013 18:38:51 -0800
Message-ID: <CADTPrLRmCjcKDeapFNk5vT3SfwSqSgVvd=u2p7BjgihXzsyfmg@mail.gmail.com>
Subject: Re: [PATCH] pciehp: Acknowledge the spurious "cmd completed" event.
From: Rajat Jain <rajatjain.linux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-hotplug@vger.kernel.org,
	Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>,
	Yijing Wang <wangyijing@huawei.com>,
	Guenter Roeck <groeck@juniper.net>,
	Rajat Jain <rajatjain@juniper.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Tom Nguyen <tom.l.nguyen@intel.com>,
	Kristen Accardi <kristen.c.accardi@intel.com>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

On Tue, Nov 5, 2013 at 4:25 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Nov 05, 2013 at 02:33:28PM -0800, Rajat Jain wrote:
>> In case of a spurious "cmd completed", pcie_write_cmd() does not
>> clear it, but yet expects more "cmd completed" events to be generated.
>> This does not happen because the previous (spurious) event has not
>> been acknowledged. Fix that.
>>
>> Signed-off-by: Rajat Jain <rajatjain@juniper.net>
>> Signed-off-by: Guenter Roeck <groeck@juniper.net>
>> ---
>> This is how I saw it in action: my controller does not implement any
>> hot-plug elements (LED, power ctrl, EMI etc) but still supports Command
>> completed bit.
>>  - During initialization,
>>       pcie_disable_notification()
>>       -> pcie_write_cmd()
>>          -> writes to Slot control register
>>             -> which causes PCI_EXP_SLTSTA_CC to get set, which is not
>>                cleared, because IRQ is not generated (we just disabled
>>                notifications).
>>  - After some time,
>>       pcie_enable_notification()
>>       -> pcie_write_cmd()
>>           -> finds PCI_EXP_SLTSTA_CC is set, assumes it is spurious.
>>           -> Does not clear it, yet expects more command completed
>>              events to be generated (never happens).
>
> I'm not sure this "cmd completed" is actually spurious.  Spec section
> 7.8.10 is very clear that any write to Slot Control must cause a
> hot-plug command to be generated (if the port is hot-plug capable).

I agree, and I think I am witnessing a "genuine" command completion
(caused by disabling of notifications).

>
> Can you collect "lspci -vv" output for your controller?
 >

Sure:

PCI bridge: Integrated Device Technology, Inc. Device 807a (rev 02)
(prog-if 00 [Normal decode])
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0
Bus: primary=02, secondary=50, subordinate=5f, sec-latency=0
I/O behind bridge: 00003000-00003fff
Memory behind bridge: 8c000000-8fffffff
Prefetchable memory behind bridge: 00000000b0600000-00000000b07fffff
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
        DevSta: CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- TransPend-
        LnkCap: Port #3, Speed 5GT/s, Width x4, ASPM L0s L1, Latency
L0 <4us, L1 <4us
                ClockPM- Surprise+ LLActRep+ BwNot+
        LnkCtl: ASPM Disabled; Disabled- Retrain- CommClk-
                ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
        LnkSta: Speed 2.5GT/s, Width x0, TrErr- Train- SlotClk-
DLActive- BWMgmt- ABWMgmt-
        SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise-
                Slot #3, PowerLimit 0.000W; Interlock- NoCompl-
        SltCtl: Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ HPIrq+ LinkChg+
                Control: AttnInd Unknown, PwrInd Unknown, Power- Interlock-
        SltSta: Status: AttnBtn- PowerFlt- MRL- CmdCplt+ PresDet- Interlock-
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
        Address: 00000000ff041740  Data: 0003
Capabilities: [100 v1] Advanced Error Reporting
        UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt-
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
        UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt-
RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
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
        ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ UpstreamFwd+
EgressCtrl+ DirectTrans+
        ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir- UpstreamFwd-
EgressCtrl- DirectTrans-
Capabilities: [330 v1] #12
Kernel driver in use: pcieport

In addition, here is what the pciehp driver spews out:

Hotplug Controller:
  Seg/Bus/Dev/Func/IRQ : 0000:02:03.0 IRQ 21
  Vendor ID            : 0x111d
  Device ID            : 0x807a
  Subsystem ID         : 0x0000
  Subsystem Vendor ID  : 0x0000
  PCIe Cap offset      : 0x40
  PCI resource [7]     : [io  0x13000-0x13fff]
  PCI resource [8]     : [mem 0xc0c000000-0xc0fffffff]
  PCI resource [9]     : [mem 0xc30600000-0xc307fffff 64bit pref]
Slot Capabilities      : 0x00180040
  Physical Slot Number : 3
  Attention Button     :  no
  Power Controller     :  no
  MRL Sensor           :  no
  Attention Indicator  :  no
  Power Indicator      :  no
  Hot-Plug Surprise    :  no
  EMI Present          :  no
  Command Completed    : yes
Slot Status            : 0x0010
Slot Control           : 0x0000
Link Active Reporting supported
HPC vendor_id 111d device_id 807a ss_vid 0 ss_did 0
Registering domain:bus:dev=0000:50:00 sun=3
Unexpected CMD_COMPLETED. Need to wait for command completed event.
Command not completed in 1000 msec

The last two output lines are part of the problem. Each controller
takes 1 second to initialized as the message shows.

>  I assume
> you're hitting this case in pcie_init() (added by 5808639bfa98
> ("pciehp: fix slow probing")):
>
>         /*
>          * Controller doesn't notify of command completion if the "No
>          * Command Completed Support" bit is set in Slot Capability
>          * register or the controller supports none of power
>          * controller, attention led, power led and EMI.
>          */
>         if (NO_CMD_CMPL(ctrl) ||
>             !(POWER_CTRL(ctrl) | ATTN_LED(ctrl) | PWR_LED(ctrl) | EMI(ctrl)))
>             ctrl->no_cmd_complete = 1;
>
> and we're setting "no_cmd_complete = 1" for your controller, which
> keeps us from waiting for completion in pcie_write_cmd().
>
> I'm dubious about the assertion that a controller without power
> control, attention LED, power LED, or EMI can't support command
> completion.  I don't see anything in the spec to that effect.

I agree, specially since I am seeing this contrary behavior (to that
assertion) in action :-)

>
> Since you're seeing PCI_EXP_SLTSTA_CC=1, your controller *should*
> support Command Completion notification and PCI_EXP_SLTCAP_NCCS should
> be 0 (per Table 7-20), so I wonder what happens on your system if you
> change pcie_init() so it leaves "ctrl->no_cmd_complete = 0" instead?
> Does it work correctly then?

Yes, it work well after that (Both the error output lines go away as
well). And the 1 second delay per controller is also gone.

>
> I know we can't just drop the "!(POWER_CTRL(ctrl) | ...)" tests
> because we don't want to reintroduce the problem fixed by
> 5808639bfa98, but I wonder if we can find a better fix that addresses
> both problems.

Please let me know if any one has any suggestions? IMHO, this patch
should yet not cause the original problem to reappear because we are
clearing the bit *only* when we know that it is already set (and no
way to clear it because at least in my controller no subsequent
interrupts can be generated). But I do not have enough understanding,
and will be glad to get any pointers.

Thanks,

- Rajat

>
> Bjorn
>
>>
>>  drivers/pci/hotplug/pciehp_hpc.c |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
>> index 5b8d749..ba8e06f 100644
>> --- a/drivers/pci/hotplug/pciehp_hpc.c
>> +++ b/drivers/pci/hotplug/pciehp_hpc.c
>> @@ -185,6 +185,7 @@ static int pcie_write_cmd(struct controller *ctrl, u16 cmd, u16 mask)
>>       }
>>
>>       if (slot_status & PCI_EXP_SLTSTA_CC) {
>> +             pciehp_writew(ctrl, PCI_EXP_SLTSTA, PCI_EXP_SLTSTA_CC);
>>               if (!ctrl->no_cmd_complete) {
>>                       /*
>>                        * After 1 sec and CMD_COMPLETED still not set, just
>> --
>> 1.7.9.5
>>
