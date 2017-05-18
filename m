Return-Path: <SRS0=PvvZ=4Y=bombadil.srs.infradead.org=BATV+2e090b1720e02457929d+5016+infradead.org+hch@kernel.org>
Return-Path: <SRS0=PvvZ=4Y=bombadil.srs.infradead.org=BATV+2e090b1720e02457929d+5016+infradead.org+hch@kernel.org>
Date: Thu, 18 May 2017 02:26:30 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linuxarm@huawei.com,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	hch@infradead.org, liudongdong3@huawei.com
Subject: Re: [PATCH v2 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Message-ID: <20170518092630.GA28006@infradead.org>
References: <1495098098-1984-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495098098-1984-2-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495098098-1984-2-git-send-email-gabriele.paoloni@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

> - * pcie_port_enable_msix - try to set up MSI-X as interrupt mode for given port
> + * pcie_port_enable_msix_or_msi - try to set up MSI-X or MSI as interrupt mode
> + * for given port

just rename it to pcie_port_enable_vecs to avoid the overly long line..

> +		 * pci_irq_vector() below is able to handle entry differently
> +		 * depending on MSI vs MSI-x case

As mentioned in the review for the other patch:  no need to repeat
this for every user of pci_irq_vector.

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
