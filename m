Return-Path: <keith.busch@intel.com>
Return-Path: <keith.busch@intel.com>
Date: Mon, 29 Aug 2016 13:55:58 -0400
From: Keith Busch <keith.busch@intel.com>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: helgaas@kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] vmd: convert to use pci_alloc_irq_vectors api
Message-ID: <20160829175558.GG19986@localhost.localdomain>
References: <1472491142-13783-1-git-send-email-jonathan.derrick@intel.com>
 <1472491142-13783-2-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1472491142-13783-2-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Aug 29, 2016 at 11:19:02AM -0600, Jon Derrick wrote:
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>

Nice simplification, looks good.

Reviewed-by: Keith Busch <keith.busch@intel.com>



> diff --git a/arch/x86/pci/vmd.c b/arch/x86/pci/vmd.c
> index 514b446..4c0eac7 100644
> --- a/arch/x86/pci/vmd.c
> +++ b/arch/x86/pci/vmd.c
> @@ -78,7 +78,6 @@ struct vmd_dev {
>  	char __iomem		*cfgbar;
>  
>  	int msix_count;
> -	struct msix_entry	*msix_entries;
>  	struct vmd_irq_list	*irqs;
>  
>  	struct pci_sysdata	sysdata;
> @@ -679,16 +678,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_entries = devm_kcalloc(&dev->dev, vmd->msix_count,
> -					 sizeof(*vmd->msix_entries),
> -					 GFP_KERNEL);
> -	if (!vmd->msix_entries)
> -		return -ENOMEM;
> -	for (i = 0; i < vmd->msix_count; i++)
> -		vmd->msix_entries[i].entry = i;
> -
> -	vmd->msix_count = pci_enable_msix_range(vmd->dev, vmd->msix_entries, 1,
> -						vmd->msix_count);
> +	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> +					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> @@ -699,7 +690,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  
>  	for (i = 0; i < vmd->msix_count; i++) {
>  		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
> -		vmd->irqs[i].vmd_vector = vmd->msix_entries[i].vector;
> +		vmd->irqs[i].vmd_vector = pci_irq_vector(dev, i);
>  		vmd->irqs[i].index = i;
>  
>  		err = devm_request_irq(&dev->dev, vmd->irqs[i].vmd_vector,
> -- 
