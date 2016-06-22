Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35172 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751524AbcFVWoF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 22 Jun 2016 18:44:05 -0400
Date: Wed, 22 Jun 2016 17:43:58 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Russell King <linux@arm.linux.org.uk>,
	Arnd Bergmann <arnd@arndb.de>,
	David Daney <david.daney@cavium.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH v3 4/4] ARM/PCI: remove arch specific
 pcibios_enable_device()
Message-ID: <20160622224358.GG25485@localhost>
References: <1465383890-13538-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1465383890-13538-5-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465383890-13538-5-git-send-email-lorenzo.pieralisi@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jun 08, 2016 at 12:04:50PM +0100, Lorenzo Pieralisi wrote:
> The arm pcibios_enable_device() implementation exists solely
> to prevent enabling PCI resources on PCI_PROBE_ONLY systems, since
> on those systems the PCI resources are currently not claimed (ie
> inserted in the PCI resource tree - which means their parent
> pointer is not correctly set-up) therefore they can not be enabled
> since this would trigger PCI set-ups failures.
> 
> After removing the pci=firmware command line option in:
> 
> commit 903589ca7165 ("ARM: 8554/1: kernel: pci: remove pci=firmware
> command line parameter handling")
> 
> (that was used to set the PCI_PROBE_ONLY flag through the command line)
> and by introducing resources claiming in the PCI host controllers
> set-ups that have PCI_PROBE_ONLY as a probe option, there is no need for
> arch specific pcibios_enable_device() implementations anymore in that
> the kernel can rely on the generic pcibios_enable_device()
> implementation without resorting to arch specific code to work around
> the missing resources claiming enumeration step.
> 
> On !PCI_PROBE_ONLY PCI bus set-ups, resources are always assigned
> either in pcibios initialization code or PCI host controllers drivers;
> since the PCI resource assignment API takes care of inserting the
> assigned resources in the resource tree, the resources parent pointers
> are correctly set-up, which means that this patch leaves behaviour
> unchanged for all arm PCI set-ups that do not set the PCI_PROBE_ONLY
> flag.
> 
> Remove the pcibios_enable_device() function from the arm arch back-end
> so that the kernel now uses its generic implementation.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/kernel/bios32.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 05e61a2..488545f 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -590,18 +590,6 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	return start;
>  }
>  
> -/**
> - * pcibios_enable_device - Enable I/O and memory.
> - * @dev: PCI device to be enabled
> - */
> -int pcibios_enable_device(struct pci_dev *dev, int mask)
> -{
> -	if (pci_has_flag(PCI_PROBE_ONLY))
> -		return 0;
> -
> -	return pci_enable_resources(dev, mask);
> -}

This looks great.

What about the PCI_PROBE_ONLY test in pci_common_init_dev()?  Don't we
need to either remove that test (if it's impossible to get there with
PCI_PROBE_ONLY set), or add a pci_bus_claim_resources() call as we did
in pci_host_common_probe()?

I think it's unlikely that we'd get to pci_common_init_dev() with
PCI_PROBE_ONLY set:

  - the only way to set PCI_PROBE_ONLY on ARM is to call
    of_pci_check_probe_only(),

  - the only ARM caller of of_pci_check_probe_only() is
    pci_host_common_probe(),

  - pci_host_common_probe() doesn't call pci_common_init_dev().

But I guess it's possible to imagine a platform with both a generic
PCI bridge and a MVEBU, R-Car, or Tegra bridge.  Then
pci_host_common_probe() could set PCI_PROBE_ONLY, and we'd claim
resources under the generic bridge via the previous patch, but still
not claim those under the MVEBU bridge.  Then enabling the MVEBU
devices would fail.

I know this is a ridiculous scenario, but the code looks inconsistent
as it is.

>  int pci_mmap_page_range(struct pci_dev *dev, struct vm_area_struct *vma,
>  			enum pci_mmap_state mmap_state, int write_combine)
>  {
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
