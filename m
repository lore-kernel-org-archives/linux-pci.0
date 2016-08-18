Return-Path: <agordeev@redhat.com>
Return-Path: <agordeev@redhat.com>
Date: Thu, 18 Aug 2016 11:20:07 +0200
From: Alexander Gordeev <agordeev@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-pci@vger.kernel.org, helgaas@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] pci: call pci_intx when using legacy interrupts in
 pci_alloc_irq_vectors
Message-ID: <20160818092007.GD27949@agordeev.lab.eng.brq.redhat.com>
References: <1470924665-25860-1-git-send-email-hch@lst.de>
 <1470924665-25860-3-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470924665-25860-3-git-send-email-hch@lst.de>
List-ID: <linux-pci.vger.kernel.org>

On Thu, Aug 11, 2016 at 07:11:05AM -0700, Christoph Hellwig wrote:
> ahci currently insists on an explicit call to pci_intx before falling back
> from MSI or MSI-X to legacy irqs.  As pci_intx is a no-op if the command
> register already contains the right value is seems safe and useful to add
> this call to pci_alloc_irq_vectors so that ahci can just use
> pci_alloc_irq_vectors.

Looking at ahci_init_interrupts() (and probably at commit d684a90d
("ahci: per-port msix support")) it looks like pci_alloc_irq_vectors()
is able to preserve the current AHCI logic?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/pci/msi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 9233e7f..593698e 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -1200,8 +1200,11 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
>  	}
>  
>  	/* use legacy irq if allowed */
> -	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1)
> +	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1) {
> +		pci_intx(dev, 1);

It would rather called pci_intx_for_msi() here. But because it is
a generic code I am not sure what implications it has for all
drivers out there.

>  		return 1;
> +	}
> +
>  	return vecs;
>  }
>  EXPORT_SYMBOL(pci_alloc_irq_vectors);
> -- 
> 2.1.4
> 
