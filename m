Return-Path: <SRS0=1op+=4W=bombadil.srs.infradead.org=BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@kernel.org>
Return-Path: <SRS0=1op+=4W=bombadil.srs.infradead.org=BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@kernel.org>
Date: Tue, 16 May 2017 05:06:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linuxarm@huawei.com,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com
Subject: Re: [PATCH 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Message-ID: <20170516120642.GA2991@infradead.org>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
 <1494930342-7132-2-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1494930342-7132-2-git-send-email-gabriele.paoloni@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -18,6 +18,11 @@
>   */
>  #define PCIE_PORT_MAX_MSIX_ENTRIES	32
>  
> +/* According to the PCI Local Bus Specification REV. 3.0 the max number
> + * of MSI vectors per function is 32
> + */
> +#define PCIE_PORT_MAX_MSI_ENTRIES	32

Just rename the above define to PCIE_PORT_MAX_MSI_ENTRIES and update
the comment.

>  /**
> - * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for given port
> + * pcie_port_enable_msix_or_msi - try to set up MSI-X or MSI as interrupt mode

.. and just call this pcie_port_enable_multi_vec or maybe even just
pcie_port_enable_msi.

> +static
> +int pcie_port_enable_msix_or_msi(struct pci_dev *dev, int *irqs, int mask)

This style of indentation is entirely wrong.

>  {
>  	int nr_entries, entry, nvec = 0;
>  
> @@ -63,6 +65,10 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
>  	 */
>  	nr_entries = pci_alloc_irq_vectors(dev, 1, PCIE_PORT_MAX_MSIX_ENTRIES,
>  			PCI_IRQ_MSIX);
> +	if (nr_entries < 0) /* MSI-x failed let's try with MSI */
> +		nr_entries = pci_alloc_irq_vectors(dev, 1,
> +				PCIE_PORT_MAX_MSI_ENTRIES,
> +				PCI_IRQ_MSI);

Just pass PCI_IRQ_MSI | PCI_IRQ_MSIX in the above call.


>  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
>  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &reg32);
> @@ -125,6 +143,9 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
>  		/* Now allocate the MSI-X vectors for real */
>  		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
>  				PCI_IRQ_MSIX);
> +		if (nr_entries < 0) /* MSI-x failed, let's try MSI*/
> +			nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> +					PCI_IRQ_MSI);

Same here.

>  		if (nr_entries < 0)
>  			return nr_entries;
>  	}
> @@ -160,8 +181,8 @@ static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
>  	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
>  		flags &= ~PCI_IRQ_MSI;
>  	} else {
> -		/* Try to use MSI-X if supported */
> -		if (!pcie_port_enable_msix(dev, irqs, mask))
> +		/* Try to use MSI-X or MSI if supported */
> +		if (!pcie_port_enable_msix_or_msi(dev, irqs, mask))
>  			return 0;
>  	}

We have another pci_alloc_irq_vectors call just below this which
also passes PCI_IRQ_MSI, but we won't reach it anymore with your
changes I think, so pcie_init_service_irqs will need some updates.
(after checking that your code still works fine for single-MSI setups,
of course)
