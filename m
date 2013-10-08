Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-db9lp0250.outbound.messaging.microsoft.com ([213.199.154.250]:20451
	"EHLO db9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756129Ab3JHW51 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 8 Oct 2013 18:57:27 -0400
Message-ID: <1381273037.7979.298.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/7] powerpc: Add interface to get msi region information
From: Scott Wood <scottwood@freescale.com>
To: Bharat Bhushan <r65777@freescale.com>
CC: <alex.williamson@redhat.com>, <joro@8bytes.org>,
	<benh@kernel.crashing.org>, <galak@kernel.crashing.org>,
	<linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-pci@vger.kernel.org>, <agraf@suse.de>,
	<iommu@lists.linux-foundation.org>,
	Bharat Bhushan <Bharat.Bhushan@freescale.com>
Date: Tue, 8 Oct 2013 17:57:17 -0500
In-Reply-To: <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
References: <1379575763-2091-1-git-send-email-Bharat.Bhushan@freescale.com>
	 <1379575763-2091-2-git-send-email-Bharat.Bhushan@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 2013-09-19 at 12:59 +0530, Bharat Bhushan wrote:
> @@ -376,6 +405,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
>  	int len;
>  	u32 offset;
>  	static const u32 all_avail[] = { 0, NR_MSI_IRQS };
> +	static int bank_index;
>  
>  	match = of_match_device(fsl_of_msi_ids, &dev->dev);
>  	if (!match)
> @@ -419,8 +449,8 @@ static int fsl_of_msi_probe(struct platform_device *dev)
>  				dev->dev.of_node->full_name);
>  			goto error_out;
>  		}
> -		msi->msiir_offset =
> -			features->msiir_offset + (res.start & 0xfffff);
> +		msi->msiir = res.start + features->msiir_offset;
> +		printk("msi->msiir = %llx\n", msi->msiir);

dev_dbg or remove

>  	}
>  
>  	msi->feature = features->fsl_pic_ip;
> @@ -470,6 +500,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
>  		}
>  	}
>  
> +	msi->bank_index = bank_index++;

What if multiple MSIs are boing probed in parallel?  bank_index is not
atomic.

> diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
> index 8225f86..6bd5cfc 100644
> --- a/arch/powerpc/sysdev/fsl_msi.h
> +++ b/arch/powerpc/sysdev/fsl_msi.h
> @@ -29,12 +29,19 @@ struct fsl_msi {
>  	struct irq_domain *irqhost;
>  
>  	unsigned long cascade_irq;
> -
> -	u32 msiir_offset; /* Offset of MSIIR, relative to start of CCSR */
> +	dma_addr_t msiir; /* MSIIR Address in CCSR */

Are you sure dma_addr_t is right here, versus phys_addr_t?  It implies
that it's the output of the DMA API, but I don't think the DMA API is
used in the MSI driver.  Perhaps it should be, but we still want the raw
physical address to pass on to VFIO.

>  	void __iomem *msi_regs;
>  	u32 feature;
>  	int msi_virqs[NR_MSI_REG];
>  
> +	/*
> +	 * During probe each bank is assigned a index number.
> +	 * index number ranges from 0 to 2^32.
> +	 * Example  MSI bank 1 = 0
> +	 * MSI bank 2 = 1, and so on.
> +	 */
> +	int bank_index;

2^32 doesn't fit in "int" (nor does 2^32 - 1).

Just say that indices start at 0.

-Scott



