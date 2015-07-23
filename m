Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:33787 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752928AbbGWNNn (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 09:13:43 -0400
Received: by ietj16 with SMTP id j16so191904708iet.0
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 06:13:41 -0700 (PDT)
Date: Thu, 23 Jul 2015 08:13:36 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Jiang Liu <jiang.liu@linux.intel.com>,
	Jason Cooper <jason@lakedaemon.net>,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Yijing Wang <wangyijing@huawei.com>,
	Ma Jun <majun258@huawei.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Duc Dang <dhdang@apm.com>
Subject: Re: [PATCH v5 06/19] PCI/MSI: of: Allow msi_domain lookup using the
 host bridge node
Message-ID: <20150723131336.GT21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-7-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-7-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 10:26:25AM +0100, Marc Zyngier wrote:
> A number of platforms do not need to use the msi-parent property,
> as the host bridge itself provides the MSI controller.
> 
> Allow this configuration by performing an irq domain lookup based
> on the host bridge node if it doesn't have a valid msi-parent property.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/of.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index e2ebb7d..fcfdadf 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -69,12 +69,21 @@ struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
>  
>  	if (!bus->dev.of_node)
>  		return NULL;
> +
> +	/* Start looking for a phandle to an MSI controller. */
>  	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
> +
> +	/*
> +	 * If we don't have an msi-parent property, look for a domain
> +	 * directly attached to the host bridge.
> +	 */
>  	if (!np)
> -		return NULL;
> +		np = bus->dev.of_node;
> +
>  	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
>  	if (!d)
>  		d = irq_find_host(np);
> +
>  	return d;
>  #else
>  	return NULL;
> -- 
> 2.1.4
> 
