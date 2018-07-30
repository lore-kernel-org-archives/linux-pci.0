Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbeGaAnL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Jul 2018 20:43:11 -0400
Date: Mon, 30 Jul 2018 18:05:55 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: let pci_request_irq properly deal with threaded
 interrupts
Message-ID: <20180730230554.GF45322@bhelgaas-glaptop.roam.corp.google.com>
References: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d004975f-03a8-59f5-56ef-f4e1f8e12dfb@gmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Jul 30, 2018 at 12:03:42AM +0200, Heiner Kallweit wrote:
> If we have a threaded interrupt with the handler being NULL, then
> request_threaded_irq() -> __setup_irq() will complain and bail out
> if the IRQF_ONESHOT flag isn't set. Therefore check for the handler
> being NULL and set IRQF_ONESHOT in this case.
> 
> This change is needed to migrate the mei_me driver to
> pci_alloc_irq_vectors() and pci_request_irq().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied with Thomas' reviewed-by to pci/misc for v4.19, thanks!

> ---
>  drivers/pci/irq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/irq.c b/drivers/pci/irq.c
> index 2a808e10..a1de501a 100644
> --- a/drivers/pci/irq.c
> +++ b/drivers/pci/irq.c
> @@ -86,13 +86,17 @@ int pci_request_irq(struct pci_dev *dev, unsigned int nr, irq_handler_t handler,
>  	va_list ap;
>  	int ret;
>  	char *devname;
> +	unsigned long irqflags = IRQF_SHARED;
> +
> +	if (!handler)
> +		irqflags |= IRQF_ONESHOT;
>  
>  	va_start(ap, fmt);
>  	devname = kvasprintf(GFP_KERNEL, fmt, ap);
>  	va_end(ap);
>  
>  	ret = request_threaded_irq(pci_irq_vector(dev, nr), handler, thread_fn,
> -			IRQF_SHARED, devname, dev_id);
> +				   irqflags, devname, dev_id);
>  	if (ret)
>  		kfree(devname);
>  	return ret;
> -- 
> 2.18.0
> 
