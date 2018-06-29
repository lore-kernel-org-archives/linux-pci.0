Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 29 Jun 2018 14:44:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: faraday: add missing of_node_put()
Message-ID: <20180629134423.GF9643@red-moon>
References: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1529766899-1994-1-git-send-email-hofrat@osadl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Jun 23, 2018 at 05:14:59PM +0200, Nicholas Mc Guire wrote:
>  The call to of_get_next_child() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here in the error
> path and after the last usage.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
> Fixes: commit d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> ---
> 
> Patch found my experimental coccinelle script
> 
> Patch was compile tested with: gemini_defconfig (implies CONFIG_PCI_FTPCI100=y)
> 
> Patch is against 4.18-rc1 (localversion-next is next-20180621)
> 
>  drivers/pci/controller/pci-ftpci100.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied to pci/controller-fixes to be tentatively merged for -rc4,
thanks.

Lorenzo

> diff --git a/drivers/pci/controller/pci-ftpci100.c b/drivers/pci/controller/pci-ftpci100.c
> index a1ebe9e..20bb256 100644
> --- a/drivers/pci/controller/pci-ftpci100.c
> +++ b/drivers/pci/controller/pci-ftpci100.c
> @@ -355,11 +355,13 @@ static int faraday_pci_setup_cascaded_irq(struct faraday_pci *p)
>  	irq = of_irq_get(intc, 0);
>  	if (irq <= 0) {
>  		dev_err(p->dev, "failed to get parent IRQ\n");
> +		of_node_put(intc);
>  		return irq ?: -EINVAL;
>  	}
>  
>  	p->irqdomain = irq_domain_add_linear(intc, PCI_NUM_INTX,
>  					     &faraday_pci_irqdomain_ops, p);
> +	of_node_put(intc);
>  	if (!p->irqdomain) {
>  		dev_err(p->dev, "failed to create Gemini PCI IRQ domain\n");
>  		return -EINVAL;
> -- 
> 2.1.4
> 
