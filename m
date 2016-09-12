Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756226AbcILWAy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Sep 2016 18:00:54 -0400
Date: Mon, 12 Sep 2016 17:00:50 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: keith.busch@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] vmd: allocate irq lists with correct msix count
Message-ID: <20160912220049.GF23532@localhost>
References: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 11:19:01AM -0600, Jon Derrick wrote:
> To reduce the amount of memory required for irq lists, only allocate
> their space after calling pci_msix_enable_range which may reduce the
> number of msix vectors allocated.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Applied both patches to pci/host-vmd for v4.9, with Keith's Reviewed-by,
thanks!

> ---
>  arch/x86/pci/vmd.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index 8d6bb8a..514b446 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -679,11 +679,6 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
> -				 GFP_KERNEL);
> -	if (!vmd->irqs)
> -		return -ENOMEM;
> -
>  	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
>  					 sizeof(*vmd->msix_entries),
>  					 GFP_KERNEL);
> @@ -697,6 +692,11 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> +	vmd->irqs = devm_kcalloc(&dev->dev, vmd->msix_count, sizeof(*vmd->irqs),
> +				 GFP_KERNEL);
> +	if (!vmd->irqs)
> +		return -ENOMEM;
> +
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
>  		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
> -- 
> 1.8.3.1
> 
