Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:39456 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934429AbcATSPH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2016 13:15:07 -0500
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <20160120160427.GD13437@red-moon>
 <569FB210.9090605@codeaurora.org> <20160120181003.GF13437@red-moon>
Cc: linux-pci@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <569FCEA8.4020001@codeaurora.org>
Date: Wed, 20 Jan 2016 13:15:04 -0500
MIME-Version: 1.0
In-Reply-To: <20160120181003.GF13437@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/20/2016 1:10 PM, Lorenzo Pieralisi wrote:
> On Wed, Jan 20, 2016 at 11:13:04AM -0500, Sinan Kaya wrote:
>> On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
>>> Hi,
>>>
>>> I noticed that:
>>>
>>> 79953dd22c1d ("PCI: rcar: Remove dependency on ARM-specific struct hw_pci")
>>> cbce7900598c ("PCI: designware: Make driver arch-agnostic")
>>>
>>> added code in the respective host controller drivers to size bridges
>>> and assign resources only if the PCI_PROBE_ONLY flag is clear, which makes
>>> me wonder if there exists PCI_PROBE_ONLY set-ups for the respective
>>> host controllers:
>>>
>>> - On ARM PCI_PROBE_ONLY can be set-up only via the command line or
>>>   by DT (but the host controllers drivers have to check the DT and
>>>   set it - see of_pci_check_probe_only()
>>>
>>>   in drivers/pci/host/pci-host-generic.c
>>>
>>>   neither designware nor rcar calls that function and I do not see
>>>   any dts file with that property). Given that I can't see a way
>>>   to set up PCI_PROBE_ONLY other than the command line on designware
>>>   or rcar I assume the PCI_PROBE_ONLY set-ups have been tested by
>>>   forcing it through command line parameter
>>>
>>> - On ARM64 PCI_PROBE_ONLY can *only* be set via DT, so see above
>>>
>>> We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:
>>
>> For platforms that does not have UEFI BIOS, it makes sense to remove
>> the probe only option as the firmware is not doing anything.
>>
>> For server like arm64 platforms, the behavior should be identical to
>> x86 world. The UEFI BIOS sets up the resources, kernel uses the
>> resources.
>>
>> Can we set this flag all the time for ACPI builds instead?
>>
>> What's so special about arm64 that we can't do probe only builds and
>> x86 can do?
> 
> Ok, let me give you a bit of background otherwise we talk at cross
> purposes here.
> 
> ARM and ARM64 arch code is currently forced to prevent calling:
> 
> pci_enable_resources() (eg arch/arm/kernel/bios32.c)
> 
> because, on platforms that are "PCI_PROBE_ONLY" (whatever that means),
> resources are neither assigned nor claimed. This works in practice
> but it is basically a workaround (ie the resources hierarchy is not
> validated at all in the kernel on PCI_PROBE_ONLY systems) and we want
> to get rid of that, that's what I mean by "get rid of PCI_PROBE_ONLY".
> 
> Now, how we can get rid of that plaster in pcibios_enable_device().
> 
> To do that, we must claim resources on PCI_PROBE_ONLY systems, but
> I know for certain Bjorn does not like the idea (I let you trawl
> the archives - at least he does not accept the idea of claiming
> resources ONLY on PCI_PROBE_ONLY systems, he thinks we should
> always claim resources regardless of that flag and fall-back to
> reassigning them in case claiming fails. That's perfectly reasonable,
> at least on systems with FW initializing PCI). The problem is dealing
> with legacy, so switching to resources claiming by default is a tad
> complicated, at least for testing (code is easy to implement).
> 
> So yes, on arm64 ACPI systems, regardless of PCI_PROBE_ONLY, resources
> must be claimed and reassigned if claiming fails (as x86), we start from
> fresh and we *must* do it from the beginning.
> 
> We can do that on arm64 (for ACPI - where PCI FW set-up is _supposed_ to
> be correct).

Yes, please. ACPI is not CPU centric and the behavior should be identical across
all systems.

Footnote: I remember reading somewhere that some BIOS want to keep track
of where the endpoints are mapped. Reassigning the resources break such systems.

> 
> On other arm64 (and arm) platforms, the question is whether it is safe
> to claim resources or not. Remember that there are already PCI host
> controller drivers in the kernel (with equivalent FW set-up) so there
> is legacy.
> 
> Resources claiming and assignment should be managed in arch code,
> not in host controllers specific code, and that's the reason I
> complained in this RFC about the scattering of PCI_PROBE_ONLY flag
> checks in host drivers, it is becoming unmanageable (if useful
> at all on designware and rcar, I would like to know if there are
> PCI_PROBE_ONLY set-ups probing those host drivers).
> 
> Does it make the point clearer ?

Yes, I feel better now. I understand now that this is a plumbing work for 
non-ACPI ARM/ARM64 systems.

> 
>>> https://patchwork.ozlabs.org/patch/545671/
>>>
>>> so unless you really have *existing* set-ups that require it, please
>>> remove the respective checks from the host controller drivers, this is
>>> becoming a serious issue, because either:
>>>
>>> - we claim resources if and only if PCI_PROBE_ONLY is set
>>>
>>> Either like this (to be done for every host controllers and ARM
>>> bios32):
>>>
>>> https://patchwork.ozlabs.org/patch/545670/
>>>
>>> or in core ARM/ARM64 code - eg pcibios_fixup_bus() - (to avoid adding a
>>> resource claiming call in ALL PCI host controllers)
>>>
>>> - or we *always* carry out resource claiming regardless of PCI_PROBE_ONLY
>>>   (but on ARM we can't really do that since PCI FW set-up on most of the
>>>   platforms is not present)
>>>
>>> On PCI_PROBE_ONLY systems resources claiming is mandatory if we want
>>> to get rid of arches workarounds:
>>
>> I'm hoping to see x86 like behavior on ARM64 without any gotchas as
>> there is nothing special about CPU type when it comes to PCI.
> 
> As I said, we must enforce it with ACPI, for DT platforms I am all
> ears to decide how we can implement it sanely (I think the only way
> to do it is by claiming the PCI resources on PCI_PROBE_ONLY systems,
> that's not ideal but it simplifies things a lot).
> 

OK.

> Thanks,
> Lorenzo
> 
>>
>>>
>>> https://patchwork.ozlabs.org/patch/545671/
>>>
>>> Comments very appreciated.
>>>
>>> Thanks,
>>> Lorenzo
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>>
>> -- 
>> Sinan Kaya
>> Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
>> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
>>


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
