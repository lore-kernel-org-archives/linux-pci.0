Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-vb0-f44.google.com ([209.85.212.44]:65454 "EHLO
	mail-vb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926Ab3DVRVx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 22 Apr 2013 13:21:53 -0400
Received: by mail-vb0-f44.google.com with SMTP id e12so6095016vbg.17
        for <linux-pci@vger.kernel.org>; Mon, 22 Apr 2013 10:21:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <51734D36.4000802@gmail.com>
References: <SNT136-W425B9A4DBEA719E570080DB2C80@phx.gbl> <5170B9BD.6040408@huawei.com>
 <CAErSpo43xWdYE8MT9Y4Hdi0bkNh3D4Su6zThAVs72+nYiUD5qg@mail.gmail.com>
 <BLU0-SMTP305A7D1308063E03F4C5CE9B2C90@phx.gbl> <5171F610.80001@huawei.com>
 <BLU0-SMTP185893DF37F0C811FA0BCB7B2C90@phx.gbl> <517204AE.9030907@huawei.com>
 <BLU0-SMTP106EAAAE910BEDD2F047B19B2C90@phx.gbl> <5172BF84.9090307@gmail.com>
 <BLU0-SMTP461505AE1FB450731CCD2B2B2C90@phx.gbl> <51734D36.4000802@gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 22 Apr 2013 11:21:32 -0600
Message-ID: <CAErSpo4XQDHz1SwOVYrBkUvHdKvByS2hCmpPrHv1QxjreUT-DQ@mail.gmail.com>
Subject: Re: Rescan PCIE bus to find recently powered on device.
To: Jiang Liu <liuj97@gmail.com>
Cc: Frank Rizzo <thefrankrizzo@hotmail.com>,
	Yijing Wang <wangyijing@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Apr 20, 2013 at 8:21 PM, Jiang Liu <liuj97@gmail.com> wrote:
> On 04/21/2013 04:52 AM, Frank Rizzo wrote:
>> 00:02.0 PCI bridge: Advanced Micro Devices [AMD] RS780 PCI to PCI bridge (ext gfx port 0) (prog-if 00 [Normal decode])
>>         Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx+
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0, Cache Line Size: 64 bytes
>>         Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
>>         I/O behind bridge: 0000f000-00000fff
>>         Memory behind bridge: fbb00000-fbdfffff
>>         Prefetchable memory behind bridge: 00000000fff00000-00000000000fffff
>>         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort+ <SERR- <PERR-
>>         BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
>>                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
>>         Capabilities: [50] Power Management version 3
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [58] Express (v2) Root Port (Slot+), MSI 00
>>                 DevCap: MaxPayload 128 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
>>                         ExtTag+ RBE+ FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
>>                         MaxPayload 128 bytes, MaxReadReq 128 bytes
>>                 DevSta: CorrErr- UncorrErr- FatalErr- UnsuppReq- AuxPwr- TransPend-
>>                 LnkCap: Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0 <64ns, L1 <1us
>>                         ClockPM- Surprise- LLActRep+ BwNot+
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 2.5GT/s, Width x4, TrErr- Train- SlotClk+ DLActive+ BWMgmt+ ABWMgmt-
>>                 SltCap: AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug- Surprise-
>>                         Slot #2, PowerLimit 75.000W; Interlock- NoCompl+
> Hi Frank,
>         According to "Hotplug-" flag above, the slot for 00:02.0 doesn't support hotplug.
> Actually no slot in this system supports PCI devic hotplug at all. So simply powering on
> the device connected to the adapter after booting won't work.

Hotplug support in the bridge just means we can *automatically* detect
hotplug events.  Powering on a connected device and manually
rescanning may still work.

But the first problem is that the 00:02.0 root port is left disabled
if there's nothing connected at boot-time.  This is a BIOS issue; it
must be using a chipset-specific way to disable the port completely,
and Linux has no way to enable it.

If the BIOS had left 00:02.0 enabled, it should work to power-on the
device below it, and even though 00:02.0 does not support hotplug, we
should be able to find the device below it with a manual rescan, e.g.,
"echo 1 > /sys/bus/pci/rescan".  (There might still be resource issues
with actually *using* the device, but we should at least find it.)

If 00:02.0 supported hotplug as well, then we would be able to to the
rescan automatically when the device below it powers up.

It's possible that the BIOS treats 00:02.0 specially because it's
intended as a graphics slot.  So if it's physically possible, you
might try swapping your external device connection with another device
that is always present at boot, e.g., the JMicron 1394 firewire device
at 03:00.0 or the Realtek NIC at 04:00.0.  Then the graphics slot
would be populated, so the BIOS should configure the 00:02.0 root
port, and it might leave the 00:05.0 or 00:06.0 root port configured
even if the external device is unpowered.  If that's the case, you
should be able to power-up the external device later, and a manual
rescan should find it.

Bjorn
