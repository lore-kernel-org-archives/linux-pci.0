Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34734 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933288AbcCQV2e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Thu, 17 Mar 2016 17:28:34 -0400
Subject: Re: PCI IO resource question.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56E987B8.1090904@ti.com> <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com> <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com> <20160316214733.GA11542@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56EB217F.8070603@ti.com>
Date: Thu, 17 Mar 2016 17:28:31 -0400
MIME-Version: 1.0
In-Reply-To: <20160316214733.GA11542@localhost>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/16/2016 05:47 PM, Bjorn Helgaas wrote:
> On Wed, Mar 16, 2016 at 04:13:30PM -0400, Murali Karicheri wrote:
>> On 03/16/2016 03:29 PM, Bjorn Helgaas wrote:
>>> On Wed, Mar 16, 2016 at 02:08:47PM -0400, Murali Karicheri wrote:
>>>> Bjorn,
>>>>
>>>> Thanks for your quick response! Please see below some clarification
>>>> and follow up question.
>>>>
>>>> On 03/16/2016 12:45 PM, Bjorn Helgaas wrote:
>>>> 0x1000]
>>>>>
>>>>> Obviously if the host bridge doesn't support I/O port space, we will
>>>>> be unable to assign space for I/O BARs, so you will see errors like
>>>>> this.  
>>>>>
>>>>> We may be able to improve the message and/or make this less noisy.
>>>>> Guenter Roeck looked at a similar issue a while ago, but it's not
>>>>> completely trivial:
>>>>>
>>>>>   http://lkml.kernel.org/r/20150515172836.GA27797@svl-evodev-groeck.juniper.net
>>>>>
>>>>> The PCI core should check in pci_enable_device() whether all the
>>>>> device BARs have been assigned.  If not, it should fail.  But if a
>>>>> driver doesn't need I/O space, it can use pci_enable_device_mem() to
>>>>> indicate that it only needs the MEM BARs.  That should succeed even if
>>>>> the I/O BARs aren't assigned.
>>>>>
>>>>> Bottom line, if you omit I/O space on your host bridge:
>>>>>
>>>>>   - You will see annoying "no space for" and "failed to assign" messages
>>>>>   - Drivers that don't need I/O ports should still work
>>>>>   - It's far better to have the messages than it was to pretend that
>>>>>     the host bridge supported I/O space when it really didn't.
>>>>>
>>>>>> [    0.448813] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
>>>>>> [    0.448822] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
>>>>>> [    0.448834] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
>>>>>> [    0.448841] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
>>>>>> [    0.448848] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
>>>>>> [    0.448855] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
>>>>>> [    0.448863] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
>>>>>> [    0.448870] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
>>>>>> [    0.448877] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
>>>>>> [    0.448884] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
>>>>>> [    0.448891] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
>>>>>> [    0.448898] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
>>>>>> [    0.448907] pci 0000:00:00.0: PCI bridge to [bus 01]
>>>>>>
>>>>>>
>>>>>> The original log is below and even with the error, I am able to have SATA
>>>>>> drive function as expected over this PCIe interface.
>>>>>>
>>>>>>
>>>>>> [    0.420648] PCI host bridge /soc/pcie@21020000 ranges:
>>>>>> [    0.420659]   No bus range found for /soc/pcie@21020000, using [bus 00-ff]
>>>>>> [    0.420679]    IO 0x23260000..0x400023263fff -> 0x00000000
>>>>>> [    0.420685] Requested IO range too big, new size set to 64K
>>>>>> [    0.420702]   MEM 0x60000000..0x6fffffff -> 0x60000000
>>>>>> [    0.420713] keystone-pcie 21021000.pcie: error -22: failed to map resource [io  0x0000-0x400000003fff]
>>>>>> [    0.431849] keystone-pcie 21021000.pcie: PCI host bridge to bus 0000:00
>>>>>> [    0.431861] pci_bus 0000:00: root bus resource [bus 00-ff]
>>>>>> [    0.431870] pci_bus 0000:00: root bus resource [io  0x0000-0x400000003fff]
>>>>>
>>>>> This range is obviously bogus, since it's way too big and not a nice
>>>>> round size.  I guess this is what you're fixing.
>>>>
>>>> Yes. But from your response, I gather it is better to remove the bogus range.
>>>> I removed the range, and did a read/write test to the hard drive connected 
>>>> to the Marvel SATA that is hooked to the PCIe interface and it still work
>>>> without issues. 
>>>
>>> If your bridge doesn't support I/O space, you should definitely remove
>>> the range.
>>>
>> Ok. Will do.
>>
>>> I'm curious about this Marvell SATA device, though.  It is this
>>> device?
>>>
>>
>> Yes.
>>
>>>   pci 0000:01:00.0: [1b4b:9182] type 00 class 0x010601
>>>   pci 0000:01:00.0: reg 0x10: [io  0x8000-0x8007] 
>>>   pci 0000:01:00.0: reg 0x14: [io  0x8040-0x8043] 
>>>   pci 0000:01:00.0: reg 0x18: [io  0x8100-0x8107] 
>>>   pci 0000:01:00.0: reg 0x1c: [io  0x8140-0x8143] 
>>>   pci 0000:01:00.0: reg 0x20: [io  0x800000-0x80000f]
>>>   pci 0000:01:00.0: reg 0x24: [mem 0x00900000-0x009001ff]
>>>   pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
>>>
>>> If so, it looks like it uses the drivers/ata/ahci.c driver, which uses
>>> pcim_enable_device(), which should require all BARs to be assigned.
>>> (It doesn't look like there is a pcim_enable_device_mem() variant.)
>>>
>> What does it mean in the context of removing the IO resource DT binding?
>> My AHCI SATA driver works fine with the IO DT bindings removed except
>> that I see the the error log for assigning IO BAR
>>
>> If it expects all resources to be assigned, then it should have 
>> failed, right? But not.
> 
> Right, I'm expecting the SATA driver to fail when you remove the DT I/O
> resource binding.  I want to figure out why it doesn't fail.
> 
>> I see following
>>
>> [    1.547690] ahci 0000:01:00.0: version 3.0
>> [    1.551833] ahci 0000:01:00.0: limiting MRRS to 256
>> [    1.556822] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
>> [    1.564943] ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
>>
>>
>> And Then
>>
>> [    1.940284] ata1: SATA link down (SStatus 0 SControl 300)
>> [    2.140278] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>> [    2.147029] ata2.00: ATA-9: WDC WD10EZEX-08M2NA0, 01.01A01, max UDMA/100
>> [    2.153752] ata2.00: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32), AA
>> [    2.161524] ata2.00: configured for UDMA/100
>> [    2.165957] bounce: isa pool size: 16 pages
>> [    2.170289] scsi 1:0:0:0: Direct-Access     ATA      WDC WD10EZEX-08M 1A01 PQ: 0 ANSI: 5
>> [    2.178967] sd 1:0:0:0: [sda] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
>> [    2.186632] sd 1:0:0:0: [sda] 4096-byte physical blocks
>> [    2.192047] sd 1:0:0:0: [sda] Write Protect is off
>> [    2.196835] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
>> [    2.201968] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>> [    2.226610]  sda: sda1 sda2
>> [    2.230300] sd 1:0:0:0: [sda] Attached SCSI removable disk
>>
>>
>>> But if you're on an arm or arm64 platform and you have PCI_PROBE_ONLY
>>> set, pcibios_enable_device() doesn't check whether resources are
>>> assigned, so the problem would be masked.  We're trying to remove
>>> PCI_PROBE_ONLY, or at least remove it from paths like this, so this
>>> might become a problem soon.
>>>
>>
>> Keystone is ARM v7 A15 based. The driver doesn't set PCI_PROBE_ONLY.
>> So am expect face problem when you remove PCI_PROBE_ONLY? I guess not.
> 
> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
> 
> I expect you're in this path:
> 
>   ahci_init_one
>     pcim_enable_device
>       pci_enable_device
>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
>           # build "bars" mask
>           do_pci_enable_device(dev, bars)
>             pcibios_enable_device
>               if (pci_has_flag(PCI_PROBE_ONLY))
>                 return 0;
>               pci_enable_resources
> 
> Can you add a little debug code like this to verify that we're in this
> path?

Yes we are in the path.


[    1.557561] ahci_init_one
[    1.560214] ahci 0000:01:00.0: version 3.0
[    1.564302] pcim_enable_device
[    1.567349] pci_enable_device
[    1.570340] pci_enable_device_flags
[    1.573824] do_pci_enable_device
[    1.577042] pcibios_enable_device
[    1.580380] pci_enable_resources
[    1.583608] ahci 0000:01:00.0: limiting MRRS to 256
[    1.588595] ahci 0000:01:00.0: AHCI 0001.0000 32 slots 2 ports 6 Gbps 0x3 impl SATA mode
[    1.596716] ahci 0000:01:00.0: flags: 64bit ncq sntf led only pmp fbs pio slum part sxs 
[    1.606183] scsi host0: ahci
[    1.609448] scsi host1: ahci
[    1.612636] ata1: SATA max UDMA/133 abar m512@0x60000000 port 0x60000100 irq 82
[    1.619974] ata2: SATA max UDMA/133 abar m512@0x60000000 port 0x60000180 irq 82

> 
>> I looked at pci_enable_resources()
>>
>> 	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
>> 		if (!(mask & (1 << i)))
>> 			continue;
>>
>> 		r = &dev->resource[i];
> 
>                 dev_info(&dev->dev, "BAR %d %pR mask %#04x parent %p\n", i, r, mask, r->parent);
> 
>>
>> 		if (!(r->flags & (IORESOURCE_IO | IORESOURCE_MEM)))
>> 			continue;
>> 		if ((i == PCI_ROM_RESOURCE) &&
>> 				(!(r->flags & IORESOURCE_ROM_ENABLE)))
>> 			continue;
>>
>> 		if (r->flags & IORESOURCE_UNSET) {
>> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not assigned\n",
>> 				i, r);
>> 			return -EINVAL;
>> 		}
>>
>> 		if (!r->parent) {
>> 			dev_err(&dev->dev, "can't enable device: BAR %d %pR not claimed\n",
>> 				i, r);
>> 			return -EINVAL;
>> 		}
>>
>> I don't see the error "can't enable device: BAR %d %pR not assigned" , so it doesn't
>> depend on IO bar as you mention below or is it in a different function?
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
