Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:43021 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbbA3XIH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 18:08:07 -0500
Received: by mail-oi0-f44.google.com with SMTP id a3so36920390oib.3
        for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2015 15:08:06 -0800 (PST)
Date: Fri, 30 Jan 2015 17:08:03 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: benh@au1.ibm.com, gwshan@linux.vnet.ibm.com,
	linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V11 14/17] powerpc/powernv: Shift VF resource with an
 offset
Message-ID: <20150130230803.GA6795@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-15-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-15-git-send-email-weiyang@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 15, 2015 at 10:28:04AM +0800, Wei Yang wrote:
> On PowrNV platform, resource position in M64 implies the PE# the resource
> belongs to. In some particular case, adjustment of a resource is necessary
> to locate it to a correct position in M64.
> 
> This patch introduces a function to shift the 'real' PF IOV BAR address
> according to an offset.
> 
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/pci-ioda.c |   31 +++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 8bad2b0..62bb2eb 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -14,6 +14,7 @@
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/crash_dump.h>
> +#include <linux/pci_regs.h>
>  #include <linux/debugfs.h>
>  #include <linux/delay.h>
>  #include <linux/string.h>
> @@ -749,6 +750,36 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
>  	return 10;
>  }
>  
> +#ifdef CONFIG_PCI_IOV
> +static void pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
> +{
> +	struct pci_dn *pdn = pci_get_pdn(dev);
> +	int i;
> +	struct resource *res;
> +	resource_size_t size;
> +
> +	if (!dev->is_physfn)
> +		return;
> +
> +	for (i = PCI_IOV_RESOURCES; i <= PCI_IOV_RESOURCE_END; i++) {
> +		res = &dev->resource[i];
> +		if (!res->flags || !res->parent)
> +			continue;
> +
> +		if (!pnv_pci_is_mem_pref_64(res->flags))
> +			continue;
> +
> +		dev_info(&dev->dev, " Shifting VF BAR %pR to\n", res);
> +		size = pci_iov_resource_size(dev, i);
> +		res->start += size*offset;

It seems like you should adjust res->end, too.  Am I missing something?

And I'm not sure it's safe to move the resource here, because if we move it
outside the bounds of the parent, we'll corrupt the resource tree.  Maybe
we're safe for some reason here, but it requires more analysis than I've
done to prove it.

> +
> +		dev_info(&dev->dev, "                 %pR\n", res);
> +		pci_update_resource(dev, i);
> +	}
> +	pdn->max_vfs -= offset;
> +}
> +#endif /* CONFIG_PCI_IOV */
> +
>  #if 0
>  static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
>  {
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
