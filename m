Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:28336 "EHLO
	ausc60ps301.us.dell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759810AbcAUPr5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jan 2016 10:47:57 -0500
From: <Jordan_Hargrave@Dell.com>
To: <babu.moger@oracle.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<alexander.duyck@gmail.com>, <hare@suse.de>, <mkubecek@suse.com>,
	<shane.seymour@hpe.com>, <myron.stowe@gmail.com>
Date: Thu, 21 Jan 2016 09:47:50 -0600
Subject: RE: [PATCH RFC] pci: Blacklist vpd access for buggy devices
Message-ID: <8B8F62BE6EB1824D91A8BF961FDC40B9179D157776@AUSX7MCPS305.AMER.DELL.COM>
References: <20160109010545.GA31085@localhost>
 <1452546789-62938-1-git-send-email-babu.moger@oracle.com>
 <56943184.3060303@oracle.com>
 <8B8F62BE6EB1824D91A8BF961FDC40B9179D157772@AUSX7MCPS305.AMER.DELL.COM>,<569E9EE6.2010900@oracle.com>
In-Reply-To: <569E9EE6.2010900@oracle.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

>From: Babu Moger [babu.moger@oracle.com]
>Sent: Tuesday, January 19, 2016 2:39 PM
>To: Hargrave, Jordan; bhelgaas@google.com
>Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; alexander.duyck@gmail.com; hare@suse.de; mkubecek@suse.com; shane.seymour@hpe.com; myron.stowe@gmail.com
>Subject: Re: [PATCH RFC] pci: Blacklist vpd access for buggy devices
>
>Hi Jordan,
>
>On 1/19/2016 9:22 AM, Jordan_Hargrave@dell.com wrote:
>> From: Babu Moger [babu.moger@oracle.com]
>> Sent: Monday, January 11, 2016 4:49 PM
>> To: bhelgaas@google.com
>> Cc: linux-pci@vger.kernel.org; linux-kernel@vger.kernel.org; alexander.duyck@gmail.com; hare@suse.de; mkubecek@suse.com; shane.seymour@hpe.com; myron.stowe@gmail.com; VenkatKumar.Duvvuru@avago.com; Hargrave, Jordan
>> Subject: Re: [PATCH RFC] pci: Blacklist vpd access for buggy devices
>>
>> Sorry. Missed Jordan.
>>
>> On 1/11/2016 3:13 PM, Babu Moger wrote:
>>> Reading or Writing of PCI VPD data causes system panic.
>>> We saw this problem by running "lspci -vvv" in the beginning.
>>> However this can be easily reproduced by running
>>>  cat /sys/bus/devices/XX../vpd
>>>
>>> VPD length has been set as 32768 by default. Accessing vpd
>>> will trigger read/write of 32k. This causes problem as we
>>> could read data beyond the VPD end tag. Behaviour is un-
>>> predictable when this happens. I see some other adapter doing
>>> similar quirks(commit bffadffd43d4 ("PCI: fix VPD limit quirk
>>> for Broadcom 5708S"))
>>>
>>> I see there is an attempt to fix this right way.
>>> https://patchwork.ozlabs.org/patch/534843/ or
>>> https://lkml.org/lkml/2015/10/23/97
>>>
>>> Tried to fix it this way, but problem is I dont see the proper
>>> start/end TAGs(at least for this adapter) at all. The data is
>>> mostly junk or zeros. This patch fixes the issue by setting the
>>> vpd length to 0x80.
>>>
>>> Also look at the threds
>>>
>>> https://lkml.org/lkml/2015/11/10/557
>>> https://lkml.org/lkml/2015/12/29/315
>>>
>>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>>> ---
>>>
>>> NOTE:
>>> Jordan, Are you sure all the devices in PCI_VENDOR_ID_ATHEROS and
>>> PCI_VENDOR_ID_ATTANSIC have this problem. You have used PCI_ANY_ID.
>>> I felt it is too broad. Can you please check.
>>>
>>
>> I don't actually have that hardware, it was a bugfix for biosdevname for RedHat.  We were getting
>> 'BUG: soft lockup - CPU#0 stuck for 23s!'  when attempting to read the vpd area.
>>
>> Certainly 0x1969:0x1026 experienced this.
>
>Ok. Thanks. I will update the patch 4/4.
>

Thanks! I also found 1969:2062. Maybe best to just block everything in drivers/net/ethernet/atheros/xxxx

atl1c:
 static const struct pci_device_id atl1c_pci_tbl[] = {
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATTANSIC_L1C)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATTANSIC_L2C)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATHEROS_L2C_B)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATHEROS_L2C_B2)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATHEROS_L1D)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATHEROS_L1D_2_0)},
         /* required last entry */
         { 0 }
};

atl1e
 static const struct pci_device_id atl1e_pci_tbl[] = {
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, PCI_DEVICE_ID_ATTANSIC_L1E)},
         {PCI_DEVICE(PCI_VENDOR_ID_ATTANSIC, 0x1066)},
         /* required last entry */
         { 0 }
 };

>>
>> 09:00.0 Ethernet controller: Atheros Communications AR8121/AR8113/AR8114 Gigabit or Fast Ethernet (rev b0)
>>         Subsystem: Atheros Communications AR8121/AR8113/AR8114 Gigabit or Fast Ethernet
>>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
>>         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>>         Latency: 0, Cache Line Size: 64 bytes
>>         Interrupt: pin A routed to IRQ 46
>>         Region 0: Memory at c0300000 (64-bit, non-prefetchable) [size=256K]
>>         Region 2: I/O ports at 3000 [size=128]
>>         Capabilities: [40] Power Management version 2
>>                 Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot+,D3cold+)
>>                 Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
>>         Capabilities: [48] MSI: Enable+ Count=1/1 Maskable- 64bit+
>>                 Address: 00000000fee0300c  Data: 41a1
>>         Capabilities: [58] Express (v1) Endpoint, MSI 00
>>                 DevCap: MaxPayload 4096 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
>>                         ExtTag- AttnBtn+ AttnInd+ PwrInd+ RBE- FLReset-
>>                 DevCtl: Report errors: Correctable- Non-Fatal- Fatal- Unsupported-
>>                         RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop-
>>                         MaxPayload 128 bytes, MaxReadReq 512 bytes
>>                 DevSta: CorrErr- UncorrErr+ FatalErr- UnsuppReq+ AuxPwr+ TransPend-
>>                 LnkCap: Port #0, Speed 2.5GT/s, Width x1, ASPM L0s, Latency L0 unlimited, L1 unlimited
>>                         ClockPM- Surprise- LLActRep- BwNot-
>>                 LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>>                         ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>                 LnkSta: Speed 2.5GT/s, Width x1, TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
>>         Capabilities: [6c] Vital Product Data
>>                 Unknown small resource type 0b, will not decode more.
>>         Capabilities: [100 v1] Advanced Error Reporting
>>                 UESta:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-
>>                 UEMsk:  DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
>>                 UESvrt: DLP+ SDES- TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-
>>                 CESta:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>                 CEMsk:  RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
>>                 AERCap: First Error Pointer: 14, GenCap+ CGenEn- ChkCap+ ChkEn-
>>         Capabilities: [180 v1] Device Serial Number ff-2e-05-c3-00-23-8b-ff
>>         Kernel driver in use: ATL1E
>> 00: 69 19 26 10 07 04 10 00 b0 00 00 02 10 00 00 00
>> 10: 04 00 30 c0 00 00 00 00 01 30 00 00 00 00 00 00
>> 20: 00 00 00 00 00 00 00 00 00 00 00 00 69 19 26 10
>> 30: 00 00 00 00 40 00 00 00 00 00 00 00 0a 01 00 00
>> 40: 01 48 02 c0 00 00 00 00 05 58 81 00 0c 30 e0 fe
>> 50: 00 00 00 00 a1 41 00 00 10 6c 01 00 85 7f 04 05
>> 60: 00 20 1a 00 11 f4 03 00 40 00 11 10 03 00 00 80
>> 70: 5a ff 88 14 00 00 00 00 00 00 00 00 00 00 00 00
>> 80: 00 00 00 00 69 19 26 10 00 00 00 00 00 00 00 00
>> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>>
>>>  drivers/pci/quirks.c |   41 +++++++++++++++++++++++++++++++++++++++++
>>>  1 files changed, 41 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>> index b03373f..8abcee5 100644
>>> --- a/drivers/pci/quirks.c
>>> +++ b/drivers/pci/quirks.c
>>> @@ -2123,6 +2123,47 @@ static void quirk_via_cx700_pci_parking_caching(struct pci_dev *dev)
>>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_VIA, 0x324e, quirk_via_cx700_pci_parking_caching);
>>>
>>>  /*
>>> + * A read/write to sysfs entry ('/sys/bus/pci/devices/<id>/vpd')
>>> + * will dump 32k of data. The default length is set as 32768.
>>> + * Reading a full 32k will cause an access beyond the VPD end tag.
>>> + * The system behaviour at that point is mostly unpredictable.
>>> + * Apparently, some vendors have not implemented this VPD headers properly.
>>> + * Adding a generic function disable vpd data for these buggy adapters
>>> + * Add the DECLARE_PCI_FIXUP_FINAL line below with the specific with
>>> + * vendor and device of interest to use this quirk.
>>> + */
>>> +static void quirk_blacklist_vpd(struct pci_dev *dev)
>>> +{
>>> +     if (dev->vpd) {
>>> +             dev->vpd->len = 0;
>>> +             dev_warn(&dev->dev, "PCI vpd access has been disabled due to firmware bug\n");
>>> +     }
>>> +}
>>> +
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0060,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x007c,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0413,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0078,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0079,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0073,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x0071,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005b,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x002f,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d,
>>> +             quirk_blacklist_vpd);
>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f,
>>> +             quirk_blacklist_vpd);
>>> +
>>> +/*
>>>   * For Broadcom 5706, 5708, 5709 rev. A nics, any read beyond the
>>>   * VPD end tag will hang the device.  This problem was initially
>>>   * observed when a vpd entry was created in sysfs
>>>
>