Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:34945 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757204Ab3A2PMT (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 10:12:19 -0500
Date: Tue, 29 Jan 2013 16:12:11 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>,
	Jason Cooper <jason@lakedaemon.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Thierry Reding <thierry.reding@avionic-design.de>,
	Eran Ben-Avi <benavi@marvell.com>,
	Nadav Haklai <nadavh@marvell.com>,
	Maen Suleiman <maen@marvell.com>,
	Shadi Ammouri <shadi@marvell.com>,
	Gregory Clement <gregory.clement@free-electrons.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Subject: Re: [PATCH v2 05/27] arm: pci: add a align_resource hook
Message-ID: <20130129161211.7bb8cada@skate>
In-Reply-To: <1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
	<1359399397-29729-6-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Russell,

As the arch/arm/kernel/ maintainer, what is your position regarding the
below patch?

Thanks for your review,

Thomas

On Mon, 28 Jan 2013 19:56:14 +0100, Thomas Petazzoni wrote:
> The PCI specifications says that an I/O region must be aligned on a 4
> KB boundary, and a memory region aligned on a 1 MB boundary.
> 
> However, the Marvell PCIe interfaces rely on address decoding windows
> (which allow to associate a range of physical addresses with a given
> device). For PCIe memory windows, those windows are defined with a 1
> MB granularity (which matches the PCI specs), but PCIe I/O windows can
> only be defined with a 64 KB granularity, so they have to be 64 KB
> aligned. We therefore need to tell the PCI core about this special
> alignement requirement.
> 
> The PCI core already calls pcibios_align_resource() in the ARM PCI
> core, specifically for such purposes. So this patch extends the ARM
> PCI core so that it calls a ->align_resource() hook registered by the
> PCI driver, exactly like the existing ->map_irq() and ->swizzle()
> hooks.
> 
> A particular PCI driver can register a align_resource() hook, and do
> its own specific alignement, depending on the specific constraints of
> the underlying hardware.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> ---
>  arch/arm/include/asm/mach/pci.h |   11 +++++++++++
>  arch/arm/kernel/bios32.c        |    6 ++++++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> index 5cf2e97..7d2c3c8 100644
> --- a/arch/arm/include/asm/mach/pci.h
> +++ b/arch/arm/include/asm/mach/pci.h
> @@ -30,6 +30,11 @@ struct hw_pci {
>  	void		(*postinit)(void);
>  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
>  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> +	resource_size_t (*align_resource)(struct pci_dev *dev,
> +					  const struct resource *res,
> +					  resource_size_t start,
> +					  resource_size_t size,
> +					  resource_size_t align);
>  };
>  
>  /*
> @@ -51,6 +56,12 @@ struct pci_sys_data {
>  	u8		(*swizzle)(struct pci_dev *, u8 *);
>  					/* IRQ mapping				*/
>  	int		(*map_irq)(const struct pci_dev *, u8, u8);
> +					/* Resource alignement requirements	*/
> +	resource_size_t (*align_resource)(struct pci_dev *dev,
> +					  const struct resource *res,
> +					  resource_size_t start,
> +					  resource_size_t size,
> +					  resource_size_t align);
>  	void		*private_data;	/* platform controller private data	*/
>  };
>  
> diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
> index 5401645..be2e6c9 100644
> --- a/arch/arm/kernel/bios32.c
> +++ b/arch/arm/kernel/bios32.c
> @@ -462,6 +462,7 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
>  		sys->busnr   = busnr;
>  		sys->swizzle = hw->swizzle;
>  		sys->map_irq = hw->map_irq;
> +		sys->align_resource = hw->align_resource;
>  		INIT_LIST_HEAD(&sys->resources);
>  
>  		if (hw->private_data)
> @@ -574,6 +575,8 @@ char * __init pcibios_setup(char *str)
>  resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  				resource_size_t size, resource_size_t align)
>  {
> +	struct pci_dev *dev = data;
> +	struct pci_sys_data *sys = dev->sysdata;
>  	resource_size_t start = res->start;
>  
>  	if (res->flags & IORESOURCE_IO && start & 0x300)
> @@ -581,6 +584,9 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  
>  	start = (start + align - 1) & ~(align - 1);
>  
> +	if (sys->align_resource)
> +		return sys->align_resource(dev, res, start, size, align);
> +
>  	return start;
>  }
>  



-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
