Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f169.google.com ([209.85.223.169]:34626 "EHLO
	mail-ie0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbbGWNM1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jul 2015 09:12:27 -0400
Received: by iebmu5 with SMTP id mu5so191375540ieb.1
        for <linux-pci@vger.kernel.org>; Thu, 23 Jul 2015 06:12:26 -0700 (PDT)
Date: Thu, 23 Jul 2015 08:12:21 -0500
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
Subject: Re: [PATCH v5 05/19] PCI/MSI: of: Add support for OF-provided
 msi_domain
Message-ID: <20150723131221.GS21967@google.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-6-git-send-email-marc.zyngier@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1437643598-19795-6-git-send-email-marc.zyngier@arm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jul 23, 2015 at 10:26:24AM +0100, Marc Zyngier wrote:
> In order to populate the PCI host bridge msi_domain, use the
> "msi-parent" attribute to lookup a corresponding irq domain.
> If found, this is our MSI domain.
> 
> This gets plugged into the core PCI code.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +struct irq_domain *pci_host_bridge_of_msi_domain(struct pci_bus *bus)
> +{
> +#ifdef CONFIG_IRQ_DOMAIN
> +	struct device_node *np;
> +	struct irq_domain *d;
> +
> +	if (!bus->dev.of_node)
> +		return NULL;
> +	np = of_parse_phandle(bus->dev.of_node, "msi-parent", 0);
> +	if (!np)
> +		return NULL;
> +	d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
> +	if (!d)
> +		d = irq_find_host(np);
> +	return d;

    d = irq_find_matching_host(np, DOMAIN_BUS_PCI_MSI);
    if (d)
	    return d;

    return irq_find_host(np);

> +#else
> +	return NULL;
> +#endif

>  static struct irq_domain *pci_host_bridge_msi_domain(struct pci_bus *bus)
>  {
> +	struct irq_domain *d;
> +
>  	/*
>  	 * Any firmware interface that can resolve the msi_domain
>  	 * should be called from here.
>  	 */
> +	d = pci_host_bridge_of_msi_domain(bus);
>  
> -	return NULL;
> +	return d;

No temporary needed (until there's another firmware interface):

    return pci_host_bridge_of_msi_domain(bus);
