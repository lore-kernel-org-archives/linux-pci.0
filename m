Return-Path: <SRS0=Jbu+=RI=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56781C43381
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5DE20842
	for <linux-pci@archiver.kernel.org>; Tue,  5 Mar 2019 21:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551822340;
	bh=x83onjYOaHlTdiP86ngwtIGtV5PKGwUwz2YOHyIqxIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QbZjnG1PjT7HGjgOp7XP6qceujEO3vJJ5sCXEWQ/bs6lugREfG4K3vO1VTv1davIT
	 gZvjjWompVAM4gEXOn4rNPzd0TunhBx6Ux+liJ0V8df1GcSCwDeEv1REYUTpz+PEoN
	 2lMB5pls1LQd2aUh3fpEvNWNSY3p9TYq5lY6wbvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfCEVpk (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Tue, 5 Mar 2019 16:45:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:57840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbfCEVpj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Mar 2019 16:45:39 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96D9C20652;
        Tue,  5 Mar 2019 21:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551822338;
        bh=x83onjYOaHlTdiP86ngwtIGtV5PKGwUwz2YOHyIqxIU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EO/X5aUFebQmM8vowWIJzCpkyc2wdvihmvC7Q9zCut1Pfy6HznvUrQtD73XTooT0o
         GSctaM8x40TSremv8KzO3FCsLYWdckUWUCPiLAHnQG/b8Y2jG/f6krW5Z4WIKdDV/m
         g6YZFwXAC0mk1oWWOpGHqz0OARbGp2qFXiZ66OPE=
Date:   Tue, 5 Mar 2019 15:45:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     austin_bolen@dell.com, alex_gagniuc@dellteam.com,
        keith.busch@intel.com, Shyam_Iyer@Dell.com, lukas@wunner.de,
        okaya@kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Young <youngcdev@gmail.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: portdrv: Report degraded links via link
 bandwidth notification
Message-ID: <20190305214537.GB215617@google.com>
References: <20190227205840.26898-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227205840.26898-1-mr.nuke.me@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 27, 2019 at 02:58:17PM -0600, Alexandru Gagniuc wrote:
> A warning is generated when a PCIe device is probed with a degraded
> link, but there was no similar mechanism to warn when the link becomes
> degraded after probing. The Link Bandwidth Notification provides this
> mechanism.
> 
> Use the link bandwidth notification interrupt to detect bandwidth
> changes, and rescan the bandwidth, looking for the weakest point. This
> is the same logic used in probe().
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>

Nice work!  Applied with Lukas' reviewed-by to pci/portdrv for v5.1,
thanks!

> ---
>  drivers/pci/pcie/Makefile          |   1 +
>  drivers/pci/pcie/bw_notification.c | 109 +++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.h         |   6 +-
>  drivers/pci/pcie/portdrv_core.c    |  17 +++--
>  drivers/pci/pcie/portdrv_pci.c     |   1 +
>  5 files changed, 128 insertions(+), 6 deletions(-)
>  create mode 100644 drivers/pci/pcie/bw_notification.c
> 
> diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
> index ab514083d5d4..f1d7bc1e5efa 100644
> --- a/drivers/pci/pcie/Makefile
> +++ b/drivers/pci/pcie/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for PCI Express features and port driver
>  
>  pcieportdrv-y			:= portdrv_core.o portdrv_pci.o err.o
> +pcieportdrv-y			+= bw_notification.o
>  
>  obj-$(CONFIG_PCIEPORTBUS)	+= pcieportdrv.o
>  
> diff --git a/drivers/pci/pcie/bw_notification.c b/drivers/pci/pcie/bw_notification.c
> new file mode 100644
> index 000000000000..05bbef38dbbd
> --- /dev/null
> +++ b/drivers/pci/pcie/bw_notification.c
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCI Express Bandwidth notification services driver
> + * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> + *
> + * Copyright (C) 2019, Dell Inc
> + *
> + * The PCIe bandwidth notification provides a way to notify the operating system
> + * when the link width or data rate changes. This capability is required for all
> + * root ports and downstream ports supporting links wider than x1 and/or
> + * multiple link speeds.
> + *
> + * This service port driver hooks into the bandwidth notification interrupt and
> + * warns when links become degraded in operation.
> + */
> +
> +#include <linux/module.h>
> +
> +#include "../pci.h"
> +#include "portdrv.h"
> +
> +static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
> +{
> +	int ret;
> +	u32 lnk_cap;
> +
> +	ret = pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &lnk_cap);
> +	return (ret == PCIBIOS_SUCCESSFUL) && (lnk_cap & PCI_EXP_LNKCAP_LBNC);
> +}
> +
> +static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
> +{
> +	u16 lnk_ctl;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
> +	lnk_ctl |= PCI_EXP_LNKCTL_LBMIE;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
> +}
> +
> +static void pcie_disable_link_bandwidth_notification(struct pci_dev *dev)
> +{
> +	u16 lnk_ctl;
> +
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnk_ctl);
> +	lnk_ctl &= ~PCI_EXP_LNKCTL_LBMIE;
> +	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, lnk_ctl);
> +}
> +
> +static irqreturn_t pcie_bw_notification_handler(int irq, void *context)
> +{
> +	struct pcie_device *srv = context;
> +	struct pci_dev *port = srv->port;
> +	struct pci_dev *dev;
> +	u16 link_status, events;
> +	int ret;
> +
> +	ret = pcie_capability_read_word(port, PCI_EXP_LNKSTA, &link_status);
> +	events = link_status & PCI_EXP_LNKSTA_LBMS;
> +
> +	if (!events || ret != PCIBIOS_SUCCESSFUL)
> +		return IRQ_NONE;
> +
> +	down_read(&pci_bus_sem);
> +	/* Print status from upstream link partner, not this downstream port. */
> +	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
> +		__pcie_print_link_status(dev, false);
> +	up_read(&pci_bus_sem);
> +
> +	pcie_update_link_speed(port->subordinate, link_status);
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> +	return IRQ_HANDLED;
> +}
> +
> +static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> +{
> +	int ret;
> +
> +	/* Single-width or single-speed ports do not have to support this. */
> +	if (!pcie_link_bandwidth_notification_supported(srv->port))
> +		return -ENODEV;
> +
> +	ret = request_threaded_irq(srv->irq, NULL, pcie_bw_notification_handler,
> +				   IRQF_SHARED, "PCIe BW notif", srv);
> +	if (ret)
> +		return ret;
> +
> +	pcie_enable_link_bandwidth_notification(srv->port);
> +
> +	return 0;
> +}
> +
> +static void pcie_bandwidth_notification_remove(struct pcie_device *srv)
> +{
> +	pcie_disable_link_bandwidth_notification(srv->port);
> +	free_irq(srv->irq, srv);
> +}
> +
> +static struct pcie_port_service_driver pcie_bandwidth_notification_driver = {
> +	.name		= "pcie_bw_notification",
> +	.port_type	= PCIE_ANY_PORT,
> +	.service	= PCIE_PORT_SERVICE_BWNOTIF,
> +	.probe		= pcie_bandwidth_notification_probe,
> +	.remove		= pcie_bandwidth_notification_remove,
> +};
> +
> +int __init pcie_bandwidth_notification_init(void)
> +{
> +	return pcie_port_service_register(&pcie_bandwidth_notification_driver);
> +}
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index fbbf00b0992e..1d50dc58ac40 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -20,8 +20,10 @@
>  #define PCIE_PORT_SERVICE_HP		(1 << PCIE_PORT_SERVICE_HP_SHIFT)
>  #define PCIE_PORT_SERVICE_DPC_SHIFT	3	/* Downstream Port Containment */
>  #define PCIE_PORT_SERVICE_DPC		(1 << PCIE_PORT_SERVICE_DPC_SHIFT)
> +#define PCIE_PORT_SERVICE_BWNOTIF_SHIFT	4	/* Bandwidth notification */
> +#define PCIE_PORT_SERVICE_BWNOTIF	(1 << PCIE_PORT_SERVICE_BWNOTIF_SHIFT)
>  
> -#define PCIE_PORT_DEVICE_MAXSERVICES   4
> +#define PCIE_PORT_DEVICE_MAXSERVICES   5
>  
>  #ifdef CONFIG_PCIEAER
>  int pcie_aer_init(void);
> @@ -47,6 +49,8 @@ int pcie_dpc_init(void);
>  static inline int pcie_dpc_init(void) { return 0; }
>  #endif
>  
> +int pcie_bandwidth_notification_init(void);
> +
>  /* Port Type */
>  #define PCIE_ANY_PORT			(~0)
>  
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index f458ac9cb70c..7d04f9d087a6 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -99,7 +99,7 @@ static int pcie_message_numbers(struct pci_dev *dev, int mask,
>   */
>  static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  {
> -	int nr_entries, nvec;
> +	int nr_entries, nvec, pcie_irq;
>  	u32 pme = 0, aer = 0, dpc = 0;
>  
>  	/* Allocate the maximum possible number of MSI/MSI-X vectors */
> @@ -135,10 +135,13 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  			return nr_entries;
>  	}
>  
> -	/* PME and hotplug share an MSI/MSI-X vector */
> -	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> -		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
> -		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
> +	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */
> +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> +		    PCIE_PORT_SERVICE_BWNOTIF)) {
> +		pcie_irq = pci_irq_vector(dev, pme);
> +		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
> +		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
> +		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;
>  	}
>  
>  	if (mask & PCIE_PORT_SERVICE_AER)
> @@ -250,6 +253,10 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> +	    pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
> +		services |= PCIE_PORT_SERVICE_BWNOTIF;
> +
>  	return services;
>  }
>  
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 0acca3596807..a9dac4a8b017 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -238,6 +238,7 @@ static void __init pcie_init_services(void)
>  	pcie_pme_init();
>  	pcie_dpc_init();
>  	pcie_hp_init();
> +	pcie_bandwidth_notification_init();
>  }
>  
>  static int __init pcie_portdrv_init(void)
> -- 
> 2.19.2
> 
