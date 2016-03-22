Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39558 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750728AbcCVTmA (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 22 Mar 2016 15:42:00 -0400
Subject: Re: PCI IO resource question.
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20160316164531.GA28797@localhost> <56E9A12F.50008@ti.com>
 <20160316192904.GA2703@localhost> <56E9BE6A.6090107@ti.com>
 <20160316214733.GA11542@localhost> <56EB217F.8070603@ti.com>
 <20160318112802.GA1810@red-moon> <56EC1A27.7000206@ti.com>
 <20160318230536.GA3264@red-moon> <56F0122A.6000701@ti.com>
 <20160321180245.GA13331@red-moon>
CC: Bjorn Helgaas <helgaas@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
From: Murali Karicheri <m-karicheri2@ti.com>
Message-ID: <56F1A007.70908@ti.com>
Date: Tue, 22 Mar 2016 15:41:59 -0400
MIME-Version: 1.0
In-Reply-To: <20160321180245.GA13331@red-moon>
Content-Type: text/plain; charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 03/21/2016 02:02 PM, Lorenzo Pieralisi wrote:
> On Mon, Mar 21, 2016 at 11:24:26AM -0400, Murali Karicheri wrote:
> 
> [...]
> 
>>>> I know that some of our customers use PCIe SATA from u-boot and would
>>>> like to honor the assignment in Linux space.. I believe they use
>>>> PCI_PROBE_ONLY by setting the bootarg. So Keystone PCI should work in
>>>> both cases.
>>>
>>> Please, tell us more about it, what does "would like to honour" mean ?
>>>
>>> Do they (ab)use pci=firmware bootarg just to keep FW PCIe SATA settings ?
>>>
>>> There are two ways of setting PCI_PROBE_ONLY on ARM/ARM64 (unfortunately):
>>>
>>> - DT chosen node
>>> - pci=firmware (on arm 32-bit platforms only)
>>>
>> second one. pci=firmware.
> 
> And that's an abuse that has to be stopped, I am removing that flag
> straight away for this precise reason.
> 
Let me speak up again. Keystone usage of pci=firmware was used by our
customer to address a specific problem. I am assuming they used it 
work around the BAR re-assignment problem in Linux space in v3.13 kernel
they were working with. 

The kernel-parameters.txt states

                firmware        [ARM] Do not re-enumerate the bus but instead
                                just use the configuration from the
                                bootloader. This is currently used on
                                IXP2000 systems where the bus has to be

Probably they used it to avoid re-enumerate similar to IXP2000. But as I
said before, I can't confirm the reason as this happened almost 2 years ago.

>>> PCIe designware does not check the DT chosen node property, so you are
>>> telling me that some customers are abusing pci=firmware command line, that
>>> was never meant to be used on platforms other than ARM IXP2000 systems
>>> (see Documentation/kernel-parameters.txt).

If the problem is same why you blame using this approach on non IXP2000 system?

>>>
>>> Usage of PCI_PROBE_ONLY on ARM has been controversial and is completely
>>> ill-defined, so we are trying to get rid of its usage.

No issues. At this point, I don't have the use case I described working in
our internal TI kernel based on v4.1.x or v4.4.x or upstream. However it will
be interesting to find the ARM platforms out there that uses firmware option,
irrespective of whether they abused its usage or not. Someone hopefully respond
to your patches if it breaks these platforms.

>>>
>>> Now, commit ed00c83cd490 ("PCI: designware: Remove PCI_PROBE_ONLY handling")
>>> removed, after mailing list initial investigation and patch review
>>>
>>> http://www.spinics.net/lists/linux-pci/msg48248.html
>>>
>>> PCI_PROBE_ONLY handling from PCIe designware, which means that even if
>>> you pass pci=firmware parameter on the command line (wrongly, see above)
>>> the kernel reassigns resources and set-up PCIe settings.
>>>
>>> Does this trigger issues on Keystone ? Or the systems that set that
>>> bootarg work even if the flag is ignored ? I want to understand and
>>> I really would like to avoid asking Bjorn to revert that commit for
>>> what looks like an abuse, I prefer finding a workaround if this is
>>> really an issue.

As I have said, I don't have the use case with pci=firmware working to
help you in this.

>>
>> Unfortunately the customer uses an older version of kernel v3.13. The
>> Ubuntu Linux distro runs on Keystone based board using this version of
>> kernel. We have internal version of the PCI-keystone driver that runs on
>> this kernel. The requirement was like this at a high level. The U-Boot
>> requires the SATA hard drive to be initialized to load and run images from
>> hard disk. When Linux boots up, the hard drive file system is used as
>> rootfs.
>>
>> So few changes added in Kernel PCI driver to support this. 
>> 1. Linux PCI driver assumes, the PCI Link is initialized in u-boot. So
>> it just don't do re-initialization of the SerDes link. It checks the
>> link status and continue initialize the PCI-Keystone RC driver.
>> 2. Uses pci=firmware to make sure the memory BARs are not re-assigned.
>>
>> Without that, the Linux kernel PCI driver got some issues and I don't
>> have the details now as this happened almost 2 years ago.
> 
> Ok, it is not a mainline problem then and it is not something we have
> to fix, other than removing that bootarg flag as soon as possible
> since as you describe here it can be (ab/mis)used.
> 
>> I believe at least on K2E, this is a use case that we need to support.
>> K2E board has a Marvel SATA controller with a SATA port that we can hook
>> up a hard drive. I have a TODO item to bring up PCI and SATA on u-boot
>> and boot up Linux the same way as described above. So how this use case
>> is expected to work on ARM? I assume arch/arm/kernel/bios32.c is a
>> pseudo bios driver to emulate BIOS specific handling PCI initialization.
> 
> PCI bios is a set of helper functions that are there as PCI arm arch
> back-end and to be honest I am not entirely sure I understand what you
> expect it to do, it certainly does not emulate any BIOS to the best
> of my knowledge.
> 
>> I am sure this is a use case that needs to be supported. Aren't there
>> other ARM based boards that uses SATA hard disks in u-boot to boot to
>> Linux? 
> 
> First off, PCI_PROBE_ONLY prevents reassigning resources and
> reprogramming PCIe settings for the whole PCI(e) hierarchy managed
> by all host controllers, it is not about one single device (and I
> do not even understand what's the problem you are facing), this
> for the records so that we are on the same page (maybe that's
> the only device in that system, but I thought I should mention
> that).
> 
>> How the above use case is handled if you remove the PCI_PROBE_ONLY support?
> 
> U-boot loads and boots the kernel in memory, quiesces the PCIe SATA device
> before kernel handover and the kernel carries out PCI enumeration, loads and
> probes the required device drivers.
> 

I am with you on this. Will re-visit if I ever has to support PCI in u-boot
to work with SATA.

> Can you define precisely what the problem is please ? In particular
> I want to understand why, by setting the PCI_PROBE_ONLY flag you want
> to make sure your PCIe SATA device BARs are not reassigned.
> 

No idea. As I have said, the customer did this in their custom board.

> Now, the question related to FW/OS handover of PCI resources is a
> complicated one and on ARM it was never solved/defined properly.
> 
> The question here, and I am not sure it can be answered with a simple
> answer, is how we make sure the OS does not touch PCI resources that
> have been initialized in FW and are not meant to be changed (whatever
> that means).
> 
> To at least have some hope to sort this out, the kernel must try to
> claim PCI resources as set-up by FW, if they are in a "reasonable" state
> they are claimed and not touched. For resources for which claiming
> fails, a reassignment policy must be implemented, that might require
> re-sizing bridges and release resources so that they can be effectively
> reallocated.
> 
> At present, on ALL ARM platforms out there (except for some oddballs
> and possibly some arm platforms that abused the pci=firmware parameter that
> I am hunting down and I am not aware of) the whole PCI resource space is
> always reassigned by the kernel (which does not mean that's always the
> right thing to do BTW, as it is it just works).
> 
> We must not try to "fix" this by misusing boot arguments and PCI_PROBE_ONLY,
> we must come up with a PCI resources allocation policy that implements what
> I mention above, my point is, PCI_PROBE_ONLY must mean the same thing
> for all ARM/ARM64 platforms otherwise it becomes complicated to handle in
> a sane way.
> 

Sounds good. Personally, I have never understood the usage of pci=firmware
or PCI_PROBE_ONLY. As you have said, ideally SATA over PCI should work fine
in u-boot and then again in the linux space like any other device drivers
do. Will re-visit when I have to support this use case again on our board
with latest kernel.

Murali

> Does this help ? Please let us know.
> 
> Thanks,
> Lorenzo
> 


-- 
Murali Karicheri
Linux Kernel, Keystone
