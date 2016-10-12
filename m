Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Oct 2016 05:38:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [RFC PATCH 01/11] pci: endpoint: add EP core layer to enable EP
 controller and EP functions
Message-ID: <20161012123843.GA942@infradead.org>
References: <1473829927-20466-1-git-send-email-kishon@ti.com>
 <1473829927-20466-2-git-send-email-kishon@ti.com>
MIME-Version: 1.0
In-Reply-To: <1473829927-20466-2-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Joao.Pinto@synopsys.com,
 Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
 Joao Pinto <jpinto@synopsys.com>, Jingoo Han <jingoohan1@gmail.com>,
 Pratyush Anand <pratyush.anand@gmail.com>, nsekhar@ti.com,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 hch@infradead.org, m-karicheri2@ti.com, linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-omap@vger.kernel.org, mingkai.hu@nxp.com
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

> +/**
> + * pci_epc_stop() - stop the PCI link
> + * @epc: the link of the EPC device that has to be stopped
> + *
> + * Invoke to stop the PCI link
> + */
> +void pci_epc_stop(struct pci_epc *epc)
> +{
> +	if (IS_ERR(epc) || !epc->ops->stop)
> +		return;
> +
> +	spin_lock_irq(&epc->irq_lock);
> +	epc->ops->stop(epc);
> +	spin_unlock_irq(&epc->irq_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_stop);

Can you elaborate on the synchronization strategy here?  It seems
like irq_lock is generally taken irq save and just around method
calls.  Wou;dn't it be better to leave locking to the methods
themselves?

> +/**
> + * struct pci_epc - represents the PCI EPC device
> + * @dev: PCI EPC device
> + * @ops: function pointers for performing endpoint operations
> + * @mutex: mutex to protect pci_epc ops
> + */
> +struct pci_epc {
> +	struct device			dev;
> +	/* support only single function PCI device for now */
> +	struct pci_epf			*epf;
> +	const struct pci_epc_ops	*ops;
> +	spinlock_t			irq_lock;
> +};

And this still documentes a mutex instead of the irq save spinlock,
while we're at it..

> +/**
> + * struct pci_epf_bar - represents the BAR of EPF device
> + * @phys_addr: physical address that should be mapped to the BAR
> + * @size: the size of the address space present in BAR
> + */
> +struct pci_epf_bar {
> +	dma_addr_t	phys_addr;
> +	size_t		size;
> +};

Just curious: shouldn't this be a phys_addr_t instead of a dma_addr_t?


Otherwise this looks like a nice little framework to get started!

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
