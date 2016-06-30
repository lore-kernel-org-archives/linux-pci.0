Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.73]:64796 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbcF3PoC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2016 11:44:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>,
	Liviu Dudau <liviu.dudau@arm.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Date: Thu, 30 Jun 2016 17:37:35 +0200
Message-ID: <5307392.exoejlJp9x@wuerfel>
In-Reply-To: <20160630151931.29216-1-thierry.reding@gmail.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, June 30, 2016 5:19:30 PM CEST Thierry Reding wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This patch makes the existing pci_host_bridge structure a proper device
> that is usable by PCI host drivers in a more standard way. In addition
> to the existing pci_scan_bus, pci_scan_root_bus, pci_scan_root_bus_msi,
> and pci_create_root_bus interfaces, this unfortunately means having to
> add yet another interface doing basically the same thing, and add some
> extra code in the initial step.

Thanks a lot for following up on my patches and getting them to work!

> As mentioned in a previous email, one open question is whether we want
> to export a function for allocating a pci_host_bridge device in
> combination with the per-device structure or let the driver itself
> call kzalloc.
> 
> Changes in v2 (Thierry Reding):
> - add a pci_host_bridge_init() helper that drivers can use to perform
>   all the necessary steps to initialize the bridge

For these two points, the addition of pci_host_bridge_init() to me
tips the balance in favour of having a separate allocation function
that also does the initialization, something like

struct struct pci_host_bridge *pci_host_bridge_alloc(size_t priv)
{
	struct pci_host_bridge *bridge;

	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
	if (!bridge)
		return NULL;

	INIT_LIST_HEAD(&bridge->windows);

	if (priv)
		bridge->private = &bridge[1];

	return bridge;
}

	Arnd
