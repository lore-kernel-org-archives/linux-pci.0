Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:43495 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932082AbaGWQur (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jul 2014 12:50:47 -0400
Date: Wed, 23 Jul 2014 18:50:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/3] ACPI / PM: Make ACPI-based PCI wakeup work for the
 "freeze" sleep state
Message-ID: <20140723165044.GY3935@laptop>
References: <1907495.agrCMfRsQN@vostro.rjw.lan>
 <6491652.ycQtdn67HU@vostro.rjw.lan>
 <20140723120432.GU3935@laptop>
 <9451719.LAKB4xNqkA@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9451719.LAKB4xNqkA@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jul 23, 2014 at 06:55:53PM +0200, Rafael J. Wysocki wrote:
> OK, so I think that before going any deeper it's better to check if we don't
> leave anything obvious behind, so please see if this makes any difference (on
> top of the previous one):
> 
> ---
>  drivers/pci/pcie/pme.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/pci/pcie/pme.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pcie/pme.c
> +++ linux-pm/drivers/pci/pcie/pme.c
> @@ -364,7 +364,8 @@ static int pcie_pme_probe(struct pcie_de
>  	pcie_pme_interrupt_enable(port, false);
>  	pcie_clear_root_pme_status(port);
>  
> -	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED, "PCIe PME", srv);
> +	ret = request_irq(srv->irq, pcie_pme_irq, IRQF_SHARED | IRQF_NO_SUSPEND,
> +			  "PCIe PME", srv);
>  	if (ret) {
>  		kfree(data);
>  	} else {
> 

No joy :-(
