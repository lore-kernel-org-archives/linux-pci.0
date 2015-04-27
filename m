Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:52899 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752184AbbD0QMN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2015 12:12:13 -0400
Message-ID: <553E5FE1.3030101@ti.com>
Date: Mon, 27 Apr 2015 12:12:17 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: keystone: Don't dereference possible NULL pointer
References: <20150409194540.18977.25638.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150409194540.18977.25638.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 04/09/2015 03:45 PM, Bjorn Helgaas wrote:
> Check for failure from platform_get_resource() (this check actually happens
> inside devm_ioremap_resource()) before dereferencing the pointer returned
> from platform_get_resource().
>
> Signed-off-by: Bjorn Helgaas<bhelgaas@google.com>
> ---
>   drivers/pci/host/pci-keystone-dw.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/host/pci-keystone-dw.c b/drivers/pci/host/pci-keystone-dw.c
> index 66d8ea41b972..f34892e0edb4 100644
> --- a/drivers/pci/host/pci-keystone-dw.c
> +++ b/drivers/pci/host/pci-keystone-dw.c
> @@ -496,11 +496,12 @@ int __init ks_dw_pcie_host_init(struct keystone_pcie *ks_pcie,
>
>   	/* Index 1 is the application reg. space address */
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> -	ks_pcie->app = *res;
>   	ks_pcie->va_app_base = devm_ioremap_resource(pp->dev, res);
>   	if (IS_ERR(ks_pcie->va_app_base))
>   		return PTR_ERR(ks_pcie->va_app_base);
>
> +	ks_pcie->app = *res;
> +
>   	/* Create legacy IRQ domain */
>   	ks_pcie->legacy_irq_domain =
>   			irq_domain_add_linear(ks_pcie->legacy_intc_np,
>
Bjorn,

Thanks for fixing this.

Acked-By: Murali Karicheri <m-karicheri2@ti.com>
