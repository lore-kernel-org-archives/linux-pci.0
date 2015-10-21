Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39668 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755170AbbJUQXd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 21 Oct 2015 12:23:33 -0400
Date: Wed, 21 Oct 2015 11:23:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Joerg Roedel <jroedel@suse.de>,
	Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] x86/PCI: Don't alloc pcibios-irq when MSI is enabled
Message-ID: <20151021162329.GB1583@localhost>
References: <1444386214-26319-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444386214-26319-1-git-send-email-joro@8bytes.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Oct 09, 2015 at 12:23:34PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The pcibios-irq and MSI both use dev->irq to store the IRQ
> number. While the MSI code checks for that and frees the
> pcibios-irq before overwriting dev->irq, the
> pcibios_alloc_irq function does not.
> 
> Usually this is not a problem, as the pcibios-irq is
> allocated before probe time of the device and the MSI irq is
> allocted from the drivers probe path.
> 
> But there are PCI devices handled by the core kernel and not
> by a standard pci driver, like the AMD IOMMU for example.
> For the AMD IOMMU a normal pci device driver does not make
> sense, because a driver can be forcibly unbound from its
> device, which is not a good idea for an IOMMU.
> 
> Nevertheless the PCI core code tries to match the PCI device
> implementing the AMD IOMMU against drivers, and
> allocates/frees a pcibios IRQ every time it tries out a new
> driver. This overwrites the dev->irq field set by
> pci_enable_msi() and sets it to 0 in the end (because the
> probe fails and the pcibios-irq is freed again).
> 
> On suspend/resume this breaks the kernel, because the irq
> descriptor for irq 0 is NULL.
> 
> Fix this by not allocating a pcibios-irq when MSI is
> already active. This also has the benefit, that a device
> claimed by the core kernel can not be probed by a pci driver
> later.
> 
> Cc: Jiang Liu <jiang.liu@linux.intel.com>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Applied with Thomas' reviewed-by to pci/msi for v4.4, thanks, Joerg!

> ---
>  arch/x86/pci/common.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/pci/common.c b/arch/x86/pci/common.c
> index dc78a4a..6254c06 100644
> --- a/arch/x86/pci/common.c
> +++ b/arch/x86/pci/common.c
> @@ -675,6 +675,14 @@ int pcibios_add_device(struct pci_dev *dev)
>  
>  int pcibios_alloc_irq(struct pci_dev *dev)
>  {
> +	/*
> +	 * If the PCI device was already claimed by core code and has
> +	 * MSI enabled, probing of the pcibios irq will overwrite
> +	 * dev->irq.  So bail out if MSI is already enabled.
> +	 */
> +	if (pci_dev_msi_enabled(dev))
> +		return -EBUSY;
> +
>  	return pcibios_enable_irq(dev);
>  }
>  
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
