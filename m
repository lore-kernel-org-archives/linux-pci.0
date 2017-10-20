Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Return-Path: <SRS0=Rdd+=BT=lst.de=hch@kernel.org>
Date: Fri, 20 Oct 2017 09:15:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dongdong Liu <liudongdong3@huawei.com>,
	Charles Chenxin <charles.chenxin@huawei.com>, linuxarm@huawei.com,
	Christoph Hellwig <hch@lst.de>,
	Gabriele Paoloni <gabriele.paoloni@huawei.com>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v5 3/3] PCI/portdrv: Compute MSI/MSI-X IRQ vectors
	after final allocation
Message-ID: <20171020071550.GE11101@lst.de>
References: <20171019225726.17806.62380.stgit@bhelgaas-glaptop.roam.corp.google.com> <20171019230121.17806.11826.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171019230121.17806.11826.stgit@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

> +/*
> + * Fill in *pme, *aer, *dpc with the relevant Interrupt Message Numbers if
> + * services are enabled in "mask".  Return the number of MSI/MSI-X vectors
> + * required to accommodate the largest Message Number.
> + */
> +static int pcie_message_numbers(struct pci_dev *dev, int mask,
> +				u32 *pme, u32 *aer, u32 *dpc)
> +{

Can you split factoring out this helper into a separate clean up patch
that goes before the actual change?

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

Note that we should probably replace the irqs array with one storing
the relative vector number and use pci_request_irq().  In fact in that
case we could probably just pass said array to pcie_message_numbers()
to further simplify it.
