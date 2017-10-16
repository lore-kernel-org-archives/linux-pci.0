Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from us-smtp-delivery-107.mimecast.com ([216.205.24.107]:38406 "EHLO
        us-smtp-delivery-107.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751501AbdJPJLB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2017 05:11:01 -0400
Subject: Re: [PATCH 4/5] PCI: tango: Fix platform_get_irq() error handling
To: Fabio Estevam <festevam@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: linux-pci <linux-pci@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mason <slash.tmp@free.fr>
References: <1508018851-9272-1-git-send-email-festevam@gmail.com>
 <1508018851-9272-4-git-send-email-festevam@gmail.com>
From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Message-ID: <169eac7a-4dd1-f164-6342-9bac8b7dbf3a@sigmadesigns.com>
Date: Mon, 16 Oct 2017 11:09:15 +0200
MIME-Version: 1.0
In-Reply-To: <1508018851-9272-4-git-send-email-festevam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ gkh, maz, tglx, linus w

On 15/10/2017 00:07, Fabio Estevam wrote:

> When platform_get_irq() fails we should propagate the real error value
> instead of always returning -ENXIO.
> 
> Cc: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/pci/host/pcie-tango.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-tango.c b/drivers/pci/host/pcie-tango.c
> index e23f738..5196583 100644
> --- a/drivers/pci/host/pcie-tango.c
> +++ b/drivers/pci/host/pcie-tango.c
> @@ -272,9 +272,9 @@ static int tango_pcie_probe(struct platform_device *pdev)
>  		writel_relaxed(0, pcie->base + SMP8759_ENABLE + offset);
>  
>  	virq = platform_get_irq(pdev, 1);
> -	if (virq <= 0) {
> +	if (virq < 0) {
>  		dev_err(dev, "Failed to map IRQ\n");
> -		return -ENXIO;
> +		return virq;
>  	}
>  
>  	irq_dom = irq_domain_create_linear(fwnode, MSI_MAX, &dom_ops, pcie);

Hello Fabio,

I don't think this patch is correct.

AFAIU, on all but legacy platforms, when platform_get_irq() returns 0,
it is to signal an error condition.

Marc Z pointed out this discussion:
http://yarchive.net/comp/linux/zero.html

Looking more closely at the platform_get_irq implementation, and ignoring
the CONFIG_SPARC special-case, the return value is either:

* a valid virq > 0, or
* -EPROBE_DEFER, or
* some error code < 0, in the ACPI case, or
* -ENXIO, or
* res->start (an unsigned type, so >= 0)


I suppose it would be slightly nicer to write:

	virq = platform_get_irq(pdev, 1);
	if (virq <= 0)
		return virq ? virq : -ENODEV;

Regards.
