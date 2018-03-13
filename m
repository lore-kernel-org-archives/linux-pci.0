Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41754 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751621AbeCMRKq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Mar 2018 13:10:46 -0400
Date: Tue, 13 Mar 2018 17:10:39 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Keith Busch <keith.busch@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Scott Bauer <scott.bauer@intel.com>
Subject: Re: [PATCHv2] PCI: vmd: Use affinity to chain child device interrupts
Message-ID: <20180313171039.GB20373@e107981-ln.cambridge.arm.com>
References: <20180206202225.1124-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180206202225.1124-1-keith.busch@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Keith,

On Tue, Feb 06, 2018 at 01:22:25PM -0700, Keith Busch wrote:
> Performance for devices in VMD domains suffer in NUMA environments if
> we're not respecting the desired IRQ CPU affinity. This patch fixes
> that by creating managed affinity irq vectors for the VMD device, and
> then drivers registering their chained interrupts will be assigned the
> h/w irq that most closely matches its desired IRQ affinity. A tie is
> awarded to the lesser used vector.
> 
> Note, this only works for drivers that allocate their vectors with
> PCI_IRQ_AFFINITY. All other drivers will be assigned the least used
> vector without consideration for affinity.
> 
> Signed-off-by: Keith Busch <keith.busch@intel.com>
> Acked-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
> v1->v2:
> 
>   Added Jon's 'ack'.
> 
>   Update changelog subject.
> 
>  drivers/pci/host/vmd.c | 80 ++++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 65 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index 930a8fa08bd6..ac84676e79a4 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c

[...]

> @@ -233,9 +266,11 @@ static int vmd_msi_prepare(struct irq_domain *domain, struct device *dev,
>  	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct vmd_dev *vmd = vmd_from_bus(pdev->bus);
>  
> -	if (nvec > vmd->msix_count)
> +	if (nvec > vmd->msix_count) {
> +		if (vmd->msix_count > 1)
> +			return vmd->msix_count - 1;
>  		return vmd->msix_count;

I am about to apply this patch but I do not understand what's this hunk
is there for, to me vmd_msi_prepare() should just return an error in
this code path unless I am getting this wrong.

Thanks,
Lorenzo

> -
> +	}
>  	memset(arg, 0, sizeof(*arg));
>  	return 0;
>  }
> @@ -663,6 +698,14 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	struct vmd_dev *vmd;
>  	int i, err;
>  
> +	/*
> +	 * The first vector is reserved for special use, so start affinity at
> +	 * the second vector.
> +	 */
> +	struct irq_affinity affd = {
> +		.pre_vectors = 1,
> +	};
> +
>  	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
>  		return -ENOMEM;
>  
> @@ -688,8 +731,15 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
>  	if (vmd->msix_count < 0)
>  		return -ENODEV;
>  
> -	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
> -					PCI_IRQ_MSIX);
> +	/*
> +	 * Reserve remaining vectors that IRQ affinity won't be able to assign.
> +	 */
> +	if ((vmd->msix_count - 1) > cpumask_weight(cpu_present_mask))
> +		affd.post_vectors = vmd->msix_count -
> +					cpumask_weight(cpu_present_mask) - 1;
> +
> +	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
> +					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
>  	if (vmd->msix_count < 0)
>  		return vmd->msix_count;
>  
> -- 
> 2.14.3
> 
