Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57769 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756004AbcCUPY0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 21 Mar 2016 11:24:26 -0400
Subject: Re: PCI IO resource question.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <56E987B8.1090904@ti.com> <20160316164531.GA28797@localhost>
 <56E9A12F.50008@ti.com> <20160316192904.GA2703@localhost>
 <56E9BE6A.6090107@ti.com> <20160316214733.GA11542@localhost>
 <56EB217F.8070603@ti.com> <20160318112802.GA1810@red-moon>
 <56EC1A27.7000206@ti.com> <20160318230536.GA3264@red-moon>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56F0122A.6000701@ti.com>
Date: Mon, 21 Mar 2016 11:24:26 -0400
MIME-Version: 1.0
In-Reply-To: <20160318230536.GA3264@red-moon>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/18/2016 07:05 PM, Lorenzo Pieralisi wrote:
> On Fri, Mar 18, 2016 at 11:09:27AM -0400, Murali Karicheri wrote:
>> On 03/18/2016 07:28 AM, Lorenzo Pieralisi wrote:
>>> On Thu, Mar 17, 2016 at 05:28:31PM -0400, Murali Karicheri wrote:
>>>
>>> [...]
>>>
>>>>> The only ways I see that PCI_PROBE_ONLY can be set on ARM are if you have
>>>>> "linux,pci-probe-only" in your DT or you boot with "pci=firmware".
>>>>>
>>>>> I expect you're in this path:
>>>>>
>>>>>   ahci_init_one
>>>>>     pcim_enable_device
>>>>>       pci_enable_device
>>>>>         pci_enable_device_flags(dev, IORESOURCE_MEM | IORESOURCE_IO)
>>>>>           # build "bars" mask
>>>>>           do_pci_enable_device(dev, bars)
>>>>>             pcibios_enable_device
>>>>>               if (pci_has_flag(PCI_PROBE_ONLY))
>>>>>                 return 0;
>>>>>               pci_enable_resources
>>>>>
>>>>> Can you add a little debug code like this to verify that we're in this
>>>>> path?
>>>>
>>>> Yes we are in the path.
>>>>
>>>>
>>>> [    1.557561] ahci_init_one
>>>> [    1.560214] ahci 0000:01:00.0: version 3.0
>>>> [    1.564302] pcim_enable_device
>>>> [    1.567349] pci_enable_device
>>>> [    1.570340] pci_enable_device_flags
>>>> [    1.573824] do_pci_enable_device
>>>> [    1.577042] pcibios_enable_device
>>>> [    1.580380] pci_enable_resources
>>>
>>> So resources are actually enabled (ie PCI_PROBE_ONLY is not set)
>>> and that makes sense otherwise you would not be able to use the
>>> MEM resources anyway (ie they would not be enabled).
>>>
>>> I suspect the PCI dev IO resources were reset in reset_resource() in
>>> assign_requested_resource_sorted(), hence the bar mask that is built
>>> in pci_enable_device_flags() does not contain the IO resources,
>>> it would be helpful if you can print the bar mask passed to
>>> pcibios_enable_device() (ie the mask parameter).
>>
>> Here it is
>>
>> [    1.556507] ahci_init_one
>> [    1.559124] ahci 0000:01:00.0: version 3.0
>> [    1.563246] pcim_enable_device
>> [    1.566294] pci_enable_device
>> [    1.569252] pci_enable_device_flags
>> [    1.572766] do_pci_enable_device
>> [    1.575985] pcibios_enable_device 60
>> [    1.579551] pci_enable_resources
>>
>> I know that some of our customers use PCIe SATA from u-boot and would
>> like to honor the assignment in Linux space.. I believe they use
>> PCI_PROBE_ONLY by setting the bootarg. So Keystone PCI should work in
>> both cases.
> 
> Please, tell us more about it, what does "would like to honour" mean ?
> 
> Do they (ab)use pci=firmware bootarg just to keep FW PCIe SATA settings ?
> 
> There are two ways of setting PCI_PROBE_ONLY on ARM/ARM64 (unfortunately):
> 
> - DT chosen node
> - pci=firmware (on arm 32-bit platforms only)
> 
second one. pci=firmware.

> PCIe designware does not check the DT chosen node property, so you are
> telling me that some customers are abusing pci=firmware command line, that
> was never meant to be used on platforms other than ARM IXP2000 systems
> (see Documentation/kernel-parameters.txt).
> 
> Usage of PCI_PROBE_ONLY on ARM has been controversial and is completely
> ill-defined, so we are trying to get rid of its usage.
> 
> Now, commit ed00c83cd490 ("PCI: designware: Remove PCI_PROBE_ONLY handling")
> removed, after mailing list initial investigation and patch review
> 
> http://www.spinics.net/lists/linux-pci/msg48248.html
> 
> PCI_PROBE_ONLY handling from PCIe designware, which means that even if
> you pass pci=firmware parameter on the command line (wrongly, see above)
> the kernel reassigns resources and set-up PCIe settings.
> 
> Does this trigger issues on Keystone ? Or the systems that set that
> bootarg work even if the flag is ignored ? I want to understand and
> I really would like to avoid asking Bjorn to revert that commit for
> what looks like an abuse, I prefer finding a workaround if this is
> really an issue.

Unfortunately the customer uses an older version of kernel v3.13. The
Ubuntu Linux distro runs on Keystone based board using this version of
kernel. We have internal version of the PCI-keystone driver that runs on
this kernel. The requirement was like this at a high level. The U-Boot
requires the SATA hard drive to be initialized to load and run images from
hard disk. When Linux boots up, the hard drive file system is used as
rootfs.

So few changes added in Kernel PCI driver to support this. 
1. Linux PCI driver assumes, the PCI Link is initialized in u-boot. So
it just don't do re-initialization of the SerDes link. It checks the
link status and continue initialize the PCI-Keystone RC driver.
2. Uses pci=firmware to make sure the memory BARs are not re-assigned.

Without that, the Linux kernel PCI driver got some issues and I don't
have the details now as this happened almost 2 years ago.

I believe at least on K2E, this is a use case that we need to support.
K2E board has a Marvel SATA controller with a SATA port that we can hook
up a hard drive. I have a TODO item to bring up PCI and SATA on u-boot
and boot up Linux the same way as described above. So how this use case
is expected to work on ARM? I assume arch/arm/kernel/bios32.c is a
pseudo bios driver to emulate BIOS specific handling PCI initialization.

I am sure this is a use case that needs to be supported. Aren't there
other ARM based boards that uses SATA hard disks in u-boot to boot to
Linux? 

Murali

> 
> For the records, I am about to send a patch to remove pci=firmware
> to Russell patch system, so I really have to know what to expect
> on Keystone:
> 
> http://www.spinics.net/lists/linux-pci/msg49328.html
> 
> Please let me know, I ultimately want to implement code that on ARM
> carries out proper PCI resources allocation (claiming firmware and
> assign resources that fails to be claimed - ie they are not configured
> by FW properly), removing PCI_PROBE_ONLY handling is a stepping stone
> to get there.
> 

How the above use case is handled if you remove the PCI_PROBE_ONLY support?

Murali
> Thank you for your patience,
> Lorenzo
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
