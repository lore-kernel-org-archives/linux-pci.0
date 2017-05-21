Return-Path: <SRS0=Gqlj=43=bombadil.srs.infradead.org=BATV+207f86e375be5294e3b5+5019+infradead.org+hch@kernel.org>
Return-Path: <SRS0=Gqlj=43=bombadil.srs.infradead.org=BATV+207f86e375be5294e3b5+5019+infradead.org+hch@kernel.org>
Date: Sun, 21 May 2017 01:32:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: bhelgaas@google.com, helgaas@kernel.org, linuxarm@huawei.com,
	linux-pci@vger.kernel.org, lukas@wunner.de,
	linux-kernel@vger.kernel.org, mika.westerberg@linux.intel.com,
	hch@infradead.org, liudongdong3@huawei.com
Subject: Re: [PATCH v3 1/2] PCI/portdrv: add support for different MSI
 interrupts for PCIe port services
Message-ID: <20170521083234.GA20658@infradead.org>
References: <1495103748-7876-1-git-send-email-gabriele.paoloni@huawei.com>
 <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1495103748-7876-2-git-send-email-gabriele.paoloni@huawei.com>
List-ID: <linux-pci.vger.kernel.org>

> +		 *
> +		 * pci_irq_vector() below is able to handle entry differently
> +		 * depending on MSI vs MSI-x case
> +		 *
>  		 */

One more instance of this comment left :)

>  		pcie_capability_read_word(dev, PCI_EXP_FLAGS, &reg16);
>  		entry = (reg16 & PCI_EXP_FLAGS_IRQ) >> 9;
> @@ -100,7 +107,10 @@ static int pcie_port_enable_msix(struct pci_dev *dev, int *irqs, int mask)
>  		 * MSI/MSI-X vectors assigned to the port is going to be used
>  		 * for AER, where "For MSI-X, the value in this register
>  		 * indicates which MSI-X Table entry is used to generate the
> -		 * interrupt message."
> +		 * interrupt message."  and "For MSI, the value
> +		 * in this field indicates the offset between the base Message
> +		 * Data and the interrupt message that is generated."
> +		 *
>  		 */

And while this is getting a little too deep into nitpicking:  we usually
don't add empty lines to the end of comments.
