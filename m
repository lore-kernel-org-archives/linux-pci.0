Return-Path: <m-karicheri2@ti.com>
Return-Path: <m-karicheri2@ti.com>
Subject: Re: PCIe issue with NIC card that has 64bit BARs
To: Bjorn Helgaas <helgaas@kernel.org>
References: <5730E5DA.4020906@ti.com> <20160509203436.GC18166@localhost>
 <5730FADF.7000009@ti.com> <20160509152351.17389748@t450s.home>
 <57310353.5020802@ti.com> <20160509171246.3c33478b@t450s.home>
 <5733A849.7020508@ti.com> <20160511225515.GE28812@localhost>
CC: Alex Williamson <alex.williamson@redhat.com>,
        "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <57348C97.5000002@ti.com>
Date: Thu, 12 May 2016 10:00:55 -0400
MIME-Version: 1.0
In-Reply-To: <20160511225515.GE28812@localhost>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>

Bjorn,

On 05/11/2016 06:55 PM, Bjorn Helgaas wrote:
> On Wed, May 11, 2016 at 05:46:49PM -0400, Murali Karicheri wrote:
>> Bjorn, Alex,

>> 500200D0:00000000 00000000 00000000 00000000
>> 500200E0:00000000 00000000 00000000 00000000
>> 500200F0:00000000 00000000 00000000 00000000
>>
>> Corresponding PCI boot log
>>
>> [    2.310465] PCI host bridge /soc/pcie@21800000 ranges:
>> [    2.316146]   No bus range found for /soc/pcie@21800000, using [bus 00-ff]
>> [    2.323302]    IO 0x23250000..0x23253fff -> 0x00000000
>> [    2.328455]   MEM 0x50000000..0x5fffffff -> 0x50000000
>> [    2.335406] keystone-pcie 21801000.pcie: PCI host bridge to bus 0000:00
>> [    2.342206] pci_bus 0000:00: root bus resource [bus 00-ff]
>> [    2.347691] pci_bus 0000:00: root bus resource [io  0x0000-0x3fff]
>> [    2.353937] pci_bus 0000:00: root bus resource [mem 0x50000000-0x5fffffff]
>> [    2.361483] PCI: bus0: Fast back to back transfers disabled
>> [    2.368357] pci 0000:01:00.0: disabling ASPM on pre-1.1 PCIe device.  You can enable it with 'pcie_aspm=force'
>> [    2.378560] PCI: bus1: Fast back to back transfers disabled
>> [    2.384366] pci 0000:00:00.0: BAR 8: assigned [mem 0x50000000-0x500fffff]
>> [    2.391314] pci 0000:00:00.0: BAR 9: assigned [mem 0x50100000-0x501fffff pref]
>> [    2.398534] pci 0000:00:00.0: BAR 7: assigned [io  0x1000-0x1fff]
>> [    2.404699] pci 0000:01:00.0: BAR 0: assigned [mem 0x50000000-0x5001ffff]
>> [    2.411555] pci 0000:01:00.0: BAR 1: assigned [mem 0x50020000-0x5003ffff]
>> [    2.418348] pci 0000:01:00.0: BAR 6: assigned [mem 0x50100000-0x5011ffff pref]
>> [    2.425591] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
>> [    2.431712] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [    2.436675] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
>> [    2.442788] pci 0000:00:00.0:   bridge window [mem 0x50000000-0x500fffff]
>> [    2.449572] pci 0000:00:00.0:   bridge window [mem 0x50100000-0x501fffff pref]
>> [    2.457313] pcieport 0000:00:00.0: Signaling PME through PCIe PME interrupt
>> [    2.464412] pci 0000:01:00.0: Signaling PME through PCIe PME interrupt
>>
>>
>> Any idea where to start to debug this issue? Suggestion?
> 
> If I understand correctly, K2G is the platform where these NICs don't
> work. 

Yes.

> Do *any* PCI devices work correctly on that platform? 

No. I am trying to test a SATA controller and see if that works.
Marvel SATA controller works fine using Keystone PCIe controller, but this
is on K2E EVM and this shares the same PCIe controller hardware (designware).

> Maybe
> there's some host controller configuration problem related to the MMIO
> aperture?
> 
> If you have an analyzer, I guess you could look for your Read Requests
> and Completions, but I doubt you'd learn anything.  I assume the NICs
> are sending data over the link correctly, and something is happening
> to the data between the device and the CPU.
> 
> I would suspect something in the host controller.  Most controllers
> would give you 0xffffffff back instead of zeros if there's a problem,
> but maybe yours is special.
I will work with our hardware folks to see if they can suggest something
to debug.

Thanks for you response.

Murali
> 
> Bjorn
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
