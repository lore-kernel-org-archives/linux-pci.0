Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 16 Jul 2015 10:04:26 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: David Daney <ddaney.cavm@gmail.com>
Cc: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Will Deacon <Will.Deacon@arm.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jason Cooper <jason@lakedaemon.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Robert Richter <rrichter@cavium.com>,
	David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 3/5] arm64, pci: Allow RC drivers to supply
 pcibios_add_device() implementation.
Message-ID: <20150716090426.GA17097@red-moon>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1436979285-8177-4-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi David,

On Wed, Jul 15, 2015 at 05:54:43PM +0100, David Daney wrote:
> From: David Daney <david.daney@cavium.com>
> 
> The default is to continue doing the what we have done before, but add
> a hook so that this can be overridden.

This commit log is inappropriate. On top of that, it is already
complicated enough to keep ARM and ARM64 in sync, I can't even
imagine what would happen if we added a hook to pcibios_add_device
so that RCs can implement their quirks beyond ARM64 core control.

> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/arm64/include/asm/pci.h |  3 +++
>  arch/arm64/kernel/pci.c      | 10 ++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pci.h b/arch/arm64/include/asm/pci.h
> index b008a72..ad3fb18 100644
> --- a/arch/arm64/include/asm/pci.h
> +++ b/arch/arm64/include/asm/pci.h
> @@ -37,6 +37,9 @@ static inline int pci_proc_domain(struct pci_bus *bus)
>  {
>  	return 1;
>  }
> +
> +void set_pcibios_add_device(int (*arg)(struct pci_dev *));
> +
>  #endif  /* CONFIG_PCI */
>  
>  #endif  /* __KERNEL__ */
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4095379..3356023 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -38,11 +38,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
>  	return res->start;
>  }
>  
> +static int (*pcibios_add_device_impl)(struct pci_dev *);
> +
> +void set_pcibios_add_device(int (*arg)(struct pci_dev *))
> +{
> +	pcibios_add_device_impl = arg;
> +}
> +
>  /*
>   * Try to assign the IRQ number from DT when adding a new device
>   */
>  int pcibios_add_device(struct pci_dev *dev)
>  {
> +	if (pcibios_add_device_impl)
> +		return pcibios_add_device_impl(dev);

I am totally against this (and to be honest by reading the other
patches I failed to understand why you even need it), see above.

Thanks,
Lorenzo

> +
>  	dev->irq = of_irq_parse_and_map_pci(dev, 0, 0);
>  
>  	return 0;
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
