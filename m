Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Gabriele Paoloni <gabriele.paoloni@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "bhelgaas@google.com" <bhelgaas@google.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Subject: RE: [PATCH 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Date: Tue, 16 May 2017 15:02:57 +0000
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E40A2E3DD@FRAEML521-MBX.china.huawei.com>
References: <1494930342-7132-1-git-send-email-gabriele.paoloni@huawei.com>
 <1494930342-7132-2-git-send-email-gabriele.paoloni@huawei.com>
 <20170516120642.GA2991@infradead.org>
In-Reply-To: <20170516120642.GA2991@infradead.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Christoph

Many thanks for your comments

> -----Original Message-----
> From: Christoph Hellwig [mailto:hch@infradead.org]
> Sent: 16 May 2017 13:07
> To: Gabriele Paoloni
> Cc: bhelgaas@google.com; helgaas@kernel.org; Linuxarm; linux-
> pci@vger.kernel.org; lukas@wunner.de; linux-kernel@vger.kernel.org;
> mika.westerberg@linux.intel.com
> Subject: Re: [PATCH 1/2] PCI/portdrv: add support for different MSI
> interrupts for PCIe port services
> 
> > --- a/drivers/pci/pcie/portdrv.h
> > +++ b/drivers/pci/pcie/portdrv.h
> > @@ -18,6 +18,11 @@
> >   */
> >  #define PCIE_PORT_MAX_MSIX_ENTRIES	32
> >
> > +/* According to the PCI Local Bus Specification REV. 3.0 the max
> number
> > + * of MSI vectors per function is 32
> > + */
> > +#define PCIE_PORT_MAX_MSI_ENTRIES	32
> 
> Just rename the above define to PCIE_PORT_MAX_MSI_ENTRIES and update
> the comment.

Ok agreed

> 
> >  /**
> > - * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for
> given port
> > + * pcie_port_enable_msix_or_msi - try to set up MSI-X or MSI as
> interrupt mode
> 
> .. and just call this pcie_port_enable_multi_vec or maybe even just
> pcie_port_enable_msi.

Maybe pcie_port_enable_irq_vec ?
 
> 
> > +static
> > +int pcie_port_enable_msix_or_msi(struct pci_dev *dev, int *irqs, int
> mask)
> 
> This style of indentation is entirely wrong.

Sorry about this; I'll fix it in V2

> 
> >  {
> >  	int nr_entries, entry, nvec = 0;
> >
> > @@ -63,6 +65,10 @@ static int pcie_port_enable_msix(struct pci_dev
> *dev, int *irqs, int mask)
> >  	 */
> >  	nr_entries = pci_alloc_irq_vectors(dev, 1,
> PCIE_PORT_MAX_MSIX_ENTRIES,
> >  			PCI_IRQ_MSIX);
> > +	if (nr_entries < 0) /* MSI-x failed let's try with MSI */
> > +		nr_entries = pci_alloc_irq_vectors(dev, 1,
> > +				PCIE_PORT_MAX_MSI_ENTRIES,
> > +				PCI_IRQ_MSI);
> 
> Just pass PCI_IRQ_MSI | PCI_IRQ_MSIX in the above call.

Yes you're right, thanks for spotting this

> 
> 
> >  		pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> >  		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS,
> &reg32);
> > @@ -125,6 +143,9 @@ static int pcie_port_enable_msix(struct pci_dev
> *dev, int *irqs, int mask)
> >  		/* Now allocate the MSI-X vectors for real */
> >  		nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> >  				PCI_IRQ_MSIX);
> > +		if (nr_entries < 0) /* MSI-x failed, let's try MSI*/
> > +			nr_entries = pci_alloc_irq_vectors(dev, nvec, nvec,
> > +					PCI_IRQ_MSI);
> 
> Same here.

Yep, thanks

> 
> >  		if (nr_entries < 0)
> >  			return nr_entries;
> >  	}
> > @@ -160,8 +181,8 @@ static int pcie_init_service_irqs(struct pci_dev
> *dev, int *irqs, int mask)
> >  	    ((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi())) {
> >  		flags &= ~PCI_IRQ_MSI;
> >  	} else {
> > -		/* Try to use MSI-X if supported */
> > -		if (!pcie_port_enable_msix(dev, irqs, mask))
> > +		/* Try to use MSI-X or MSI if supported */
> > +		if (!pcie_port_enable_msix_or_msi(dev, irqs, mask))
> >  			return 0;
> >  	}
> 
> We have another pci_alloc_irq_vectors call just below this which
> also passes PCI_IRQ_MSI, but we won't reach it anymore with your
> changes I think, so pcie_init_service_irqs will need some updates.
> (after checking that your code still works fine for single-MSI setups,
> of course)

I think we can reach that call if both MSI and MSIx fails and then it
will fall back to legacy IRQ. However you are right in saying that the
code should be reworked. Now it would be:

static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
{
	int ret, i;

	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
		irqs[i] = -1;

	/*
	 * Make sure MSI can be used for PCIe PME or hotplug. otherwise we have to
	 * use INTx or other interrupts, e.g. system shared interrupt.
	 */
	if (!((mask & PCIE_PORT_SERVICE_PME) && pcie_pme_no_msi()) &&
	    !((mask & PCIE_PORT_SERVICE_HP) && pciehp_no_msi()))
		/* Try to use MSI-X or MSI if supported */
		if (!pcie_port_enable_msix_or_msi(dev, irqs, mask))
			return 0;

	/* fall back to legacy IRQ */
	ret = pci_alloc_irq_vectors(dev, 1, 1, PCI_IRQ_LEGACY);
	if (ret < 0)
		return -ENODEV;

	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++) {
		if (i != PCIE_PORT_SERVICE_VC_SHIFT)
			irqs[i] = pci_irq_vector(dev, 0);
	}

	return 0;
}

What do you think?

Again many thanks
Gab    
