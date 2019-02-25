Return-Path: <SRS0=2sVk=RA=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D2C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 02:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4297220645
	for <linux-pci@archiver.kernel.org>; Mon, 25 Feb 2019 02:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfBYC3B (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Sun, 24 Feb 2019 21:29:01 -0500
Received: from bmailout2.hostsharing.net ([83.223.90.240]:48073 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727197AbfBYC3B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 24 Feb 2019 21:29:01 -0500
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8CE9A2800B3D1;
        Mon, 25 Feb 2019 03:28:57 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 2D9DF63B55; Mon, 25 Feb 2019 03:28:57 +0100 (CET)
Date:   Mon, 25 Feb 2019 03:28:57 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc:     helgaas@kernel.org, alex_gagniuc@dellteam.com,
        Austin.Bolen@dell.com, Shyam.Iyer@dell.com,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] PCI: pciehp: Report degraded links via link bandwidth
 notification
Message-ID: <20190225022857.awuspuxb4bedirjp@wunner.de>
References: <20181129230454.GF178809@google.com>
 <20181207182021.16344-1-mr.nuke.me@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207182021.16344-1-mr.nuke.me@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 07, 2018 at 12:20:00PM -0600, Alexandru Gagniuc wrote:
> A warning is generated when a PCIe device is probed with a degraded
> link, but there was no similar mechanism to warn when the link becomes
> degraded after probing. The Link Bandwidth Notification provides this
> mechanism.
> 
> Use the link bandwidth notification interrupt to detect bandwidth
> changes, and rescan the bandwidth, looking for the weakest point. This
> is the same logic used in probe().

This is unrelated to pciehp, so the subject prefix should be changed
to "PCI/portdrv".


> Q: Why is this unconditionally compiled in?
> A: The symmetrical check in pci probe() is also always compiled in.

Hm, it looks like the convention is to provide a separate Kconfig entry
for each port service.


> Q: Why call module_init() instead of adding a call in pcie_init_services() ?
> A: A call in pcie_init_services() also requires a prototype in portdrv.h, a
> non-static implementation in bw_notification.c. Using module_init() is
> functionally equivalent, and takes less code.

Commit c29de84149ab ("PCI: portdrv: Initialize service drivers directly")
moved away from module_init() on purpose, apparently to fix a race
condition.


> Q: Why print only on degraded links and not when a link is back to full speed?
> For symmetry with PCI probe(). Although I see a benefit in conveying that a
> link is back to full speed, I expect this to be extremely rare. Secondary bus
> reset is usually needed to retrain at full bandwidth.

What if the link is retrained at the same speed/width?  Intuitively
I'd compare the speed in the Link Status Register to what is cached
in the cur_bus_speed member of struct pci_bus and print a message
only if the speed has changed.  (Don't we need to cache the width as
well?)


> +static irqreturn_t pcie_bw_notification_irq(int irq, void *context)
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
> +	/* Print status from upstream link partner, not this downstream port. */
> +	list_for_each_entry(dev, &port->subordinate->devices, bus_list)
> +		__pcie_print_link_status(dev, false);
> +
> +	pcie_capability_write_word(port, PCI_EXP_LNKSTA, events);
> +	return IRQ_HANDLED;
> +}

You need to hold pci_bus_sem for the list iteration to protect against
simultaneous removal of child devices.

This may sleep, so request the IRQ with request_threaded_irq(), pass NULL
for the "handler" argument and pcie_bw_notification_irq for the "thread_fn"
argument.

You may want to call pcie_update_link_speed() to update the now stale
speed cached in the pci_bus struct.


> +	ret = devm_request_irq(&srv->device, srv->irq, pcie_bw_notification_irq,
> +			       IRQF_SHARED, "PCIe BW notif", srv);

The plan is to move away from port services as devices in the future,
so device-managed allocations should be avoided.

Apart from that, with a device-managed IRQ, if this service driver is
unbound, its IRQ handler may still be invoked if some other port service
signals an interrupt (because the IRQ is shared).  Which seems wrong.


> +	.port_type      = PCI_EXP_TYPE_DOWNSTREAM,

According to PCIe r4.0, sec 7.8.6, Link Bandwidth Notification Capability
is also required for root ports, so I think you need to match for
PCIE_ANY_PORT and amend pcie_link_bandwidth_notification_supported()
to check that you're dealing with a root or downstream port.


> +	.service	= PCIE_PORT_SERVICE_BwNOTIF,

All caps please.


> @@ -136,9 +136,12 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
>  	}
>  
>  	/* PME and hotplug share an MSI/MSI-X vector */
> -	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP)) {
> -		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pci_irq_vector(dev, pme);
> -		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pci_irq_vector(dev, pme);
> +	if (mask & (PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVICE_HP |
> +		    PCIE_PORT_SERVICE_BwNOTIF)) {
> +		pcie_irq = pci_irq_vector(dev, pme);
> +		irqs[PCIE_PORT_SERVICE_PME_SHIFT] = pcie_irq;
> +		irqs[PCIE_PORT_SERVICE_HP_SHIFT] = pcie_irq;
> +		irqs[PCIE_PORT_SERVICE_BWNOTIF_SHIFT] = pcie_irq;

Please amend the code comment with something like

-	/* PME and hotplug share an MSI/MSI-X vector */
+	/* PME, hotplug and bandwidth notification share an MSI/MSI-X vector */


> @@ -250,6 +253,9 @@ static int get_port_device_capability(struct pci_dev *dev)
>  	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER)
>  		services |= PCIE_PORT_SERVICE_DPC;
>  
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM)
> +		services |= PCIE_PORT_SERVICE_BwNOTIF;
> +

Also need to check for root ports, see above.


Otherwise LGTM.

Thanks,

Lukas
