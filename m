Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:40584 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091Ab3JDTBh (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 4 Oct 2013 15:01:37 -0400
Message-ID: <524F111A.8080404@oracle.com>
Date: Fri, 04 Oct 2013 15:03:54 -0400
From: Boris Ostrovsky <boris.ostrovsky@oracle.com>
MIME-Version: 1.0
To: Aaron Opfer <me@aaronopfer.com>
CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	Clemens Ladisch <clemens@ladisch.de>,
	xen-devel@lists.xenproject.org
Subject: Re: ASMedia ASM1083/1085 rev3 and Xen DMA Failure
References: <CAOsGJpcuNuaEsBHk9mV2Lh_qiygzgfLYigSsbDoBke1GJ_XG-Q@mail.gmail.com> <20131004172958.GA18743@google.com> <20131004183409.GA21802@phenom.dumpdata.com>
In-Reply-To: <20131004183409.GA21802@phenom.dumpdata.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 10/04/2013 02:34 PM, Konrad Rzeszutek Wilk wrote:
> On Fri, Oct 04, 2013 at 11:29:58AM -0600, Bjorn Helgaas wrote:
>> [+cc Konrad, xen-devel]
> Hey Bjorn, Thanks!
>> On Wed, Oct 02, 2013 at 04:43:46PM -0400, Aaron Opfer wrote:
>>> First time submitting the kernel dev list, so if I have demonstrated
>>> gross incompetence in some way, please cut me some slack. :)
>>>
>>> I discussed with Clemens Ladisch an issue I was having that I thought
>>> was related to the driver he authored for my soundcard, but on his
>>> suggestion I experimented with other PCI devices and we have narrowed
>>> the issue to the PCI Bridge.
>>>
>>> What hints me toward DMA handling being the fault is the following
>>> message I receive during kernel initialization after rebooting from an
>>> Xen hypervisor into a baremetal-kernel, without a power-cycle:
>>>
>>> [0.012815] dmar: DRHD: handling fault status reg 3
>>> [0.012868] dmar: DMAR:[DMA Read] Request device [07:00.0] fault addr 7e00000
>>> [0.012868] DMAR:[fault reason 02] Present bit in context entry is clear

But if you powercycle the system you don't see this error?

Have you tried booting your kernel with "intel_iommu=off"?

-boris

>> Presumably 07:00.0 is your soundcard, and apparently it did a DMA
>> read to 0x7e00000, which wasn't mapped by the IOMMU.
>>
>>> In addition to other hints, such as simple IO like changing the active
>>> port on the soundcard worked (I could hear the relays clicking) but
>>> not the functions that DMA would be used (streaming audio).
>>>
>>> The PCI devices in my system are connected via this device, as listed by lspci:
>>>
>>> 06:00.0 PCI bridge: ASMedia Technology Inc. ASM1083/1085 PCIe to PCI
>>> Bridge (rev 03)
>>>
>>> This PCI bridge works under bare-metal Linux normally (w/ various
>>> debian kernels stable/unstable/testing/backports), but under Xen
>>> Hypervisor the PCI devices connected exhibit bad behavior.
>> So it fails with Xen but works otherwise?  I assume there are other
>> PCI devices, too?  Do they work?
>>
>> If you want to open a report at http://bugzilla.kernel.org, that would
>> be a handy place to attach a complete dmesg log and "lspci -vv" output
>> for more details.
>>
>>> For
>>> instance, aformentioned sound card outputs no sound and gets no
>>> microphone input at all, and an ethernet card causes a system lockup
>>> as soon as gnome's network manager attempts DHCP over it (presumably;
>>> I did not test this as thoroughly as the sound card).
>>>
>>> I've used Xen Hypervisors 4.1 and 4.2 and had the issues I described
>>> above with both of them. I was briefly running 4.3 but I did not test
>>> the device.
> So lets seperate some of these issues. The sound-card issue might be
> related to the Linux kernel Xen-SWIOTLB (fixed at some point)- so could
> you tell me what the kernel version you have?
>
> Xen 4.3 also has numerous fixes in the IOMMU path.
>
>>> Rev1 of the ASM1083 was apparently buggy to the point of being
>>> unusable, as Clemens pointed out. I would be disappointed if this
>>> device is similarly unsalvageable,but would be happier if this buggy
>>> hardware at the very least outputted warnings to users who attempt to
>>> use it (in Xen).
>>>
>>> All The Best,
>>>
>>> Aaron Opfer
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

