Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750850AbdHBVgm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 2 Aug 2017 17:36:42 -0400
Date: Wed, 2 Aug 2017 16:36:39 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] pci: ftpci100: fix of_irq_get() error check
Message-ID: <20170802213639.GI20308@bhelgaas-glaptop.roam.corp.google.com>
References: <20170715214406.657273405@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170715214406.657273405@cogentembedded.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sun, Jul 16, 2017 at 12:43:10AM +0300, Sergei Shtylyov wrote:
> of_irq_get() may return a negative error number as well as 0 on failure,
> while the driver only checks for 0, blithely continuing with the call to
> irq_set_chained_handler_and_data() -- that function expects *unsigned int*
> so should probably do nothing when a large IRQ number resulting from a
> conversion of a negative error number is passed to it. The driver then
> probes successfully while being only partly functional...
> 
> Check for 'irq <= 0' instead and propagate the negative error number to
> the probe method --  that will allow the deferred probing as well...
> 
> Fixes: d3c68e0a7e34 ("PCI: faraday: Add Faraday Technology FTPCI100 PCI Host Bridge driver")
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Applied with Linus' reviewed-by to pci/host-faraday for v4.14, thanks!

> ---
>  drivers/pci/host/pci-ftpci100.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: pci/drivers/pci/host/pci-ftpci100.c
> ===================================================================
> --- pci.orig/drivers/pci/host/pci-ftpci100.c
> +++ pci/drivers/pci/host/pci-ftpci100.c
> @@ -350,9 +350,9 @@ static int faraday_pci_setup_cascaded_ir
>  
>  	/* All PCI IRQs cascade off this one */
>  	irq = of_irq_get(intc, 0);
> -	if (!irq) {
> +	if (irq <= 0) {
>  		dev_err(p->dev, "failed to get parent IRQ\n");
> -		return -EINVAL;
> +		return irq ?: -EINVAL;
>  	}
>  
>  	p->irqdomain = irq_domain_add_linear(intc, 4,
> 
