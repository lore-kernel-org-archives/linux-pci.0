Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60326 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933838AbcATQNI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jan 2016 11:13:08 -0500
Subject: Re: [RFC] ARM/ARM64 PCI_PROBE_ONLY platforms
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	linux-pci@vger.kernel.org
References: <20160120160427.GD13437@red-moon>
Cc: Zhou Wang <wangzhou1@hisilicon.com>,
	Phil Edworthy <phil.edworthy@renesas.com>,
	Bjorn Helgaas <bhelgaas@google.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <569FB210.9090605@codeaurora.org>
Date: Wed, 20 Jan 2016 11:13:04 -0500
MIME-Version: 1.0
In-Reply-To: <20160120160427.GD13437@red-moon>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 1/20/2016 11:04 AM, Lorenzo Pieralisi wrote:
> Hi,
> 
> I noticed that:
> 
> 79953dd22c1d ("PCI: rcar: Remove dependency on ARM-specific struct hw_pci")
> cbce7900598c ("PCI: designware: Make driver arch-agnostic")
> 
> added code in the respective host controller drivers to size bridges
> and assign resources only if the PCI_PROBE_ONLY flag is clear, which makes
> me wonder if there exists PCI_PROBE_ONLY set-ups for the respective
> host controllers:
> 
> - On ARM PCI_PROBE_ONLY can be set-up only via the command line or
>   by DT (but the host controllers drivers have to check the DT and
>   set it - see of_pci_check_probe_only()
> 
>   in drivers/pci/host/pci-host-generic.c
> 
>   neither designware nor rcar calls that function and I do not see
>   any dts file with that property). Given that I can't see a way
>   to set up PCI_PROBE_ONLY other than the command line on designware
>   or rcar I assume the PCI_PROBE_ONLY set-ups have been tested by
>   forcing it through command line parameter
> 
> - On ARM64 PCI_PROBE_ONLY can *only* be set via DT, so see above
> 
> We want to get rid of PCI_PROBE_ONLY on ARM/ARM64:

For platforms that does not have UEFI BIOS, it makes sense to remove the probe only
option as the firmware is not doing anything.

For server like arm64 platforms, the behavior should be identical to x86 world. The UEFI
BIOS sets up the resources, kernel uses the resources.

Can we set this flag all the time for ACPI builds instead?

What's so special about arm64 that we can't do probe only builds and x86 can do?

> 
> https://patchwork.ozlabs.org/patch/545671/
> 
> so unless you really have *existing* set-ups that require it, please
> remove the respective checks from the host controller drivers, this is
> becoming a serious issue, because either:
> 
> - we claim resources if and only if PCI_PROBE_ONLY is set
> 
> Either like this (to be done for every host controllers and ARM
> bios32):
> 
> https://patchwork.ozlabs.org/patch/545670/
> 
> or in core ARM/ARM64 code - eg pcibios_fixup_bus() - (to avoid adding a
> resource claiming call in ALL PCI host controllers)
> 
> - or we *always* carry out resource claiming regardless of PCI_PROBE_ONLY
>   (but on ARM we can't really do that since PCI FW set-up on most of the
>   platforms is not present)
> 
> On PCI_PROBE_ONLY systems resources claiming is mandatory if we want
> to get rid of arches workarounds:

I'm hoping to see x86 like behavior on ARM64 without any gotchas as there is nothing
special about CPU type when it comes to PCI.

> 
> https://patchwork.ozlabs.org/patch/545671/
> 
> Comments very appreciated.
> 
> Thanks,
> Lorenzo
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
