Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37879 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934328AbcCPSIp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 16 Mar 2016 14:08:45 -0400
Subject: Re: PCI IO resource question.
To: Bjorn Helgaas <helgaas@kernel.org>
References: <56E987B8.1090904@ti.com> <20160316164531.GA28797@localhost>
CC: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56E9A12F.50008@ti.com>
Date: Wed, 16 Mar 2016 14:08:47 -0400
MIME-Version: 1.0
In-Reply-To: <20160316164531.GA28797@localhost>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

Thanks for your quick response! Please see below some clarification
and follow up question.

On 03/16/2016 12:45 PM, Bjorn Helgaas wrote:
0x1000]
> 
> Obviously if the host bridge doesn't support I/O port space, we will
> be unable to assign space for I/O BARs, so you will see errors like
> this.  
> 
> We may be able to improve the message and/or make this less noisy.
> Guenter Roeck looked at a similar issue a while ago, but it's not
> completely trivial:
> 
>   http://lkml.kernel.org/r/20150515172836.GA27797@svl-evodev-groeck.juniper.net
> 
> The PCI core should check in pci_enable_device() whether all the
> device BARs have been assigned.  If not, it should fail.  But if a
> driver doesn't need I/O space, it can use pci_enable_device_mem() to
> indicate that it only needs the MEM BARs.  That should succeed even if
> the I/O BARs aren't assigned.
> 
> Bottom line, if you omit I/O space on your host bridge:
> 
>   - You will see annoying "no space for" and "failed to assign" messages
>   - Drivers that don't need I/O ports should still work
>   - It's far better to have the messages than it was to pretend that
>     the host bridge supported I/O space when it really didn't.
> 
>> [    0.448813] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
>> [    0.448822] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
>> [    0.448834] pci 0000:01:00.0: BAR 4: no space for [io  size 0x0010]
>> [    0.448841] pci 0000:01:00.0: BAR 4: failed to assign [io  size 0x0010]
>> [    0.448848] pci 0000:01:00.0: BAR 0: no space for [io  size 0x0008]
>> [    0.448855] pci 0000:01:00.0: BAR 0: failed to assign [io  size 0x0008]
>> [    0.448863] pci 0000:01:00.0: BAR 2: no space for [io  size 0x0008]
>> [    0.448870] pci 0000:01:00.0: BAR 2: failed to assign [io  size 0x0008]
>> [    0.448877] pci 0000:01:00.0: BAR 1: no space for [io  size 0x0004]
>> [    0.448884] pci 0000:01:00.0: BAR 1: failed to assign [io  size 0x0004]
>> [    0.448891] pci 0000:01:00.0: BAR 3: no space for [io  size 0x0004]
>> [    0.448898] pci 0000:01:00.0: BAR 3: failed to assign [io  size 0x0004]
>> [    0.448907] pci 0000:00:00.0: PCI bridge to [bus 01]
>>
>>
>> The original log is below and even with the error, I am able to have SATA
>> drive function as expected over this PCIe interface.
>>
>>
>> [    0.420648] PCI host bridge /soc/pcie@21020000 ranges:
>> [    0.420659]   No bus range found for /soc/pcie@21020000, using [bus 00-ff]
>> [    0.420679]    IO 0x23260000..0x400023263fff -> 0x00000000
>> [    0.420685] Requested IO range too big, new size set to 64K
>> [    0.420702]   MEM 0x60000000..0x6fffffff -> 0x60000000
>> [    0.420713] keystone-pcie 21021000.pcie: error -22: failed to map resource [io  0x0000-0x400000003fff]
>> [    0.431849] keystone-pcie 21021000.pcie: PCI host bridge to bus 0000:00
>> [    0.431861] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    0.431870] pci_bus 0000:00: root bus resource [io  0x0000-0x400000003fff]
> 
> This range is obviously bogus, since it's way too big and not a nice
> round size.  I guess this is what you're fixing.

Yes. But from your response, I gather it is better to remove the bogus range.
I removed the range, and did a read/write test to the hard drive connected 
to the Marvel SATA that is hooked to the PCIe interface and it still work
without issues. 
 
Another thing to worry about is the customers who are using custom
fpga pci devices connected to the pcie bus and presently using 
pci_enable_device() in their driver. So I guess if they fix their driver
to use pci_enable_device_mem() instead, it should continue to work
without issues, right? 

Regards,

Murali
> 
>> [    0.431879] pci_bus 0000:00: root bus resource [mem 0x60000000-0x6fffffff]
>> [    0.431906] pci 0000:00:00.0: [104c:b009] type 01 class 0x060400
>> [    0.432173] PCI: bus0: Fast back to back transfers disabled
>> [    0.432334] pci 0000:01:00.0: [1b4b:9182] type 00 class 0x010601
>> [    0.432382] pci 0000:01:00.0: reg 0x10: [io  0x8000-0x8007]
>> [    0.432402] pci 0000:01:00.0: reg 0x14: [io  0x8040-0x8043]
>> [    0.432420] pci 0000:01:00.0: reg 0x18: [io  0x8100-0x8107]
>> [    0.432439] pci 0000:01:00.0: reg 0x1c: [io  0x8140-0x8143]
>> [    0.432457] pci 0000:01:00.0: reg 0x20: [io  0x800000-0x80000f]
>> [    0.432476] pci 0000:01:00.0: reg 0x24: [mem 0x00900000-0x009001ff]
>> [    0.432495] pci 0000:01:00.0: reg 0x30: [mem 0xd0000000-0xd000ffff pref]
>> [    0.432561] pci 0000:01:00.0: PME# supported from D3hot
>> [    0.448635] PCI: bus1: Fast back to back transfers disabled
>> [    0.448717] pci 0000:00:00.0: BAR 8: assigned [mem 0x60000000-0x600fffff]
>> [    0.448729] pci 0000:00:00.0: BAR 9: assigned [mem 0x60100000-0x601fffff pref]
>> [    0.448738] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>> [    0.448751] pci 0000:01:00.0: BAR 6: assigned [mem 0x60100000-0x6010ffff pref]
>> [    0.448760] pci 0000:01:00.0: BAR 5: assigned [mem 0x60000000-0x600001ff]
>> [    0.448772] pci 0000:01:00.0: BAR 4: assigned [io  0x1000-0x100f]
>> [    0.448784] pci 0000:01:00.0: BAR 0: assigned [io  0x1010-0x1017]
>> [    0.448796] pci 0000:01:00.0: BAR 2: assigned [io  0x1018-0x101f]
>> [    0.448808] pci 0000:01:00.0: BAR 1: assigned [io  0x1020-0x1023]
>> [    0.448820] pci 0000:01:00.0: BAR 3: assigned [io  0x1024-0x1027]
>> [    0.448833] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    0.448842] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>> [    0.448851] pci 0000:00:00.0:   bridge window [mem 0x60000000-0x600fffff]
>> [    0.448860] pci 0000:00:00.0:   bridge window [mem 0x60100000-0x601fffff pref]
>> [    0.449077] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>> [    0.449086] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>> [    0.449095] pcie_pme 0000:00:00.0:pcie01: service driver pcie_pme loaded
>> [    0.449240] aer 0000:00:00.0:pcie02: service driver aer loaded
>>
>>
>> Thanks and regards,
>>
>> -- 
>> Murali Karicheri
>> Linux Kernel, Keystone
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Murali Karicheri
Linux Kernel, Keystone
