Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38356 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbcGLMwI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 12 Jul 2016 08:52:08 -0400
Date: Tue, 12 Jul 2016 14:57:06 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
Message-ID: <20160712125705.GC26969@agordeev.lab.eng.brq.redhat.com>
References: <1468315218-20490-1-git-send-email-hch@lst.de>
 <1468315218-20490-6-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1468315218-20490-6-git-send-email-hch@lst.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jul 12, 2016 at 06:20:18PM +0900, Christoph Hellwig wrote:
> Set the affinity_mask in the PCI device before allocating vectors so that
> the affinity can be propagated through the MSI descriptor structures to
> the core IRQ code.  To facilitate this new __pci_enable_msi_range and
> __pci_enable_msix_range helpers are factored out of their not prefixed
> variants which assigning the new irq affinity mask in the PCI device
> so that the low-level interrupt code can perform the interrupt affinity
> assignment and do node-local allocations.
> 
> A new PCI_IRQ_NOAFFINITY flag is added to pci_alloc_irq_vectors so that
> this function can also be used by drivers that don't wish to use the
> automatic affinity assignment.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  Documentation/PCI/MSI-HOWTO.txt |   3 +
>  drivers/pci/msi.c               | 127 ++++++++++++++++++++++++++--------------
>  include/linux/pci.h             |   2 +
>  3 files changed, 89 insertions(+), 43 deletions(-)
> 
> diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
> index 0af91e8..16e9187 100644
> --- a/Documentation/PCI/MSI-HOWTO.txt
> +++ b/Documentation/PCI/MSI-HOWTO.txt
> @@ -97,6 +97,9 @@ The flags argument should normally be set to 0, but can be used to pass the
>  PCI_IRQ_NOMSI and PCI_IRQ_NOMSIX flag in case a device claims to support
>  MSI or MSI-X, but the support is broken, or to pass PCI_IRQ_NOLEGACY in
>  case the device does not support legacy interrupt lines.
> +By default this function will spread the interrupts around the available
> +CPUs, but this feature can be disabled by passing the PCI_IRQ_NOAFFINITY
> +flag.
>  
>  To get the Linux IRQ numbers passed to request_irq and free_irq
>  and the vectors use the following function:
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 00657bf..692deff 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -569,6 +569,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
>  	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
>  	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
>  	entry->nvec_used		= nvec;
> +	entry->affinity			= dev->irq_affinity;
>  
>  	if (control & PCI_MSI_FLAGS_64BIT)
>  		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
> @@ -680,10 +681,18 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
>  static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  			      struct msix_entry *entries, int nvec)
>  {
> +	const struct cpumask *mask = NULL;
>  	struct msi_desc *entry;
> -	int i;
> +	int cpu = -1, i;
>  
>  	for (i = 0; i < nvec; i++) {
> +		if (dev->irq_affinity) {
> +			cpu = cpumask_next(cpu, dev->irq_affinity);
> +			if (cpu >= nr_cpu_ids)
> +				cpu = cpumask_first(dev->irq_affinity);
> +			mask = cpumask_of(cpu);
> +		}
> +
>  		entry = alloc_msi_entry(&dev->dev);
>  		if (!entry) {
>  			if (!i)
> @@ -703,6 +712,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
>  		entry->msi_attrib.default_irq	= dev->irq;
>  		entry->mask_base		= base;
>  		entry->nvec_used		= 1;
> +		entry->affinity			= mask;
>  
>  		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
>  	}
> @@ -1028,19 +1038,8 @@ int pci_msi_enabled(void)
>  }
>  EXPORT_SYMBOL(pci_msi_enabled);
>  
> -/**
> - * pci_enable_msi_range - configure device's MSI capability structure
> - * @dev: device to configure
> - * @minvec: minimal number of interrupts to configure
> - * @maxvec: maximum number of interrupts to configure
> - *
> - * This function tries to allocate a maximum possible number of interrupts in a
> - * range between @minvec and @maxvec. It returns a negative errno if an error
> - * occurs. If it succeeds, it returns the actual number of interrupts allocated
> - * and updates the @dev's irq member to the lowest new interrupt number;
> - * the other interrupt numbers allocated to this device are consecutive.
> - **/
> -int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
> +static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
> +		unsigned int flags)
>  {
>  	int nvec;
>  	int rc;
> @@ -1068,20 +1067,77 @@ int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
>  	else if (nvec > maxvec)
>  		nvec = maxvec;
>  
> -	do {
> +	for (;;) {
> +		if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> +			if (nvec < minvec)
> +				return -ENOSPC;
> +		}
> +
>  		rc = msi_capability_init(dev, nvec);
> -		if (rc < 0) {
> +		if (rc == 0)
> +			return nvec;
> +
> +		kfree(dev->irq_affinity);
> +		dev->irq_affinity = NULL;
> +
> +		if (rc < 0)
>  			return rc;
> -		} else if (rc > 0) {
> -			if (rc < minvec)
> +		if (rc < minvec)
> +			return -ENOSPC;
> +		nvec = rc;
> +	}
> +}
> +
> +/**
> + * pci_enable_msi_range - configure device's MSI capability structure
> + * @dev: device to configure
> + * @minvec: minimal number of interrupts to configure
> + * @maxvec: maximum number of interrupts to configure
> + *
> + * This function tries to allocate a maximum possible number of interrupts in a
> + * range between @minvec and @maxvec. It returns a negative errno if an error
> + * occurs. If it succeeds, it returns the actual number of interrupts allocated
> + * and updates the @dev's irq member to the lowest new interrupt number;
> + * the other interrupt numbers allocated to this device are consecutive.
> + **/
> +int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
> +{
> +	return __pci_enable_msi_range(dev, minvec, maxvec, PCI_IRQ_NOAFFINITY);
> +}
> +EXPORT_SYMBOL(pci_enable_msi_range);
> +
> +static int __pci_enable_msix_range(struct pci_dev *dev,
> +		struct msix_entry *entries, int minvec, int maxvec,
> +		unsigned int flags)
> +{
> +	int nvec = maxvec;
> +	int rc;
> +
> +	if (maxvec < minvec)
> +		return -ERANGE;
> +
> +	for (;;) {
> +		if (!(flags & PCI_IRQ_NOAFFINITY)) {
> +			dev->irq_affinity = irq_create_affinity_mask(&nvec);
> +			if (nvec < minvec)
>  				return -ENOSPC;
> -			nvec = rc;
>  		}
> -	} while (rc);
>  
> -	return nvec;
> +		rc = pci_enable_msix(dev, entries, nvec);
> +		if (rc == 0)
> +			return nvec;
> +
> +		kfree(dev->irq_affinity);
> +		dev->irq_affinity = NULL;
> +
> +		if (rc < 0)
> +			return rc;
> +		if (rc < minvec)
> +			return -ENOSPC;
> +		nvec = rc;
> +	}
>  }
> -EXPORT_SYMBOL(pci_enable_msi_range);
>  
>  /**
>   * pci_enable_msix_range - configure device's MSI-X capability structure
> @@ -1099,26 +1155,10 @@ EXPORT_SYMBOL(pci_enable_msi_range);
>   * with new allocated MSI-X interrupts.
>   **/
>  int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
> -			       int minvec, int maxvec)
> +		int minvec, int maxvec)
>  {
> -	int nvec = maxvec;
> -	int rc;
> -
> -	if (maxvec < minvec)
> -		return -ERANGE;
> -
> -	do {
> -		rc = pci_enable_msix(dev, entries, nvec);
> -		if (rc < 0) {
> -			return rc;
> -		} else if (rc > 0) {
> -			if (rc < minvec)
> -				return -ENOSPC;
> -			nvec = rc;
> -		}
> -	} while (rc);
> -
> -	return nvec;
> +	return __pci_enable_msix_range(dev, entries, minvec, maxvec,
> +			PCI_IRQ_NOAFFINITY);
>  }
>  EXPORT_SYMBOL(pci_enable_msix_range);
>  
> @@ -1145,13 +1185,14 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  	int vecs = -ENOSPC;
>  
>  	if (!(flags & PCI_IRQ_NOMSIX)) {
> -		vecs = pci_enable_msix_range(dev, NULL, min_vecs, max_vecs);
> +		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
> +				flags);
>  		if (vecs > 0)
>  			return vecs;
>  	}
>  
>  	if (!(flags & PCI_IRQ_NOMSI)) {
> -		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
> +		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
>  		if (vecs > 0)
>  			return vecs;
>  	}
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 52ecd49..f140661 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -320,6 +320,7 @@ struct pci_dev {
>  	 * directly, use the values stored here. They might be different!
>  	 */
>  	unsigned int	irq;
> +	struct cpumask	*irq_affinity;
>  	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
>  
>  	bool match_driver;		/* Skip attaching driver */
> @@ -1240,6 +1241,7 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
>  #define PCI_IRQ_NOLEGACY	(1 << 0) /* don't use legacy interrupts */
>  #define PCI_IRQ_NOMSI		(1 << 1) /* don't use MSI interrupts */
>  #define PCI_IRQ_NOMSIX		(1 << 2) /* don't use MSI-X interrupts */
> +#define PCI_IRQ_NOAFFINITY	(1 << 3) /* don't auto-assign affinity */
>  
>  /* kmem_cache style wrapper around pci_alloc_consistent() */
>  
> -- 
> 2.1.4
> 

With, or without my -else nit:
Reviewed-by: Alexander Gordeev <agordeev@redhat.com>
