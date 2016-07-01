Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:39086 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752023AbcGAOOz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Fri, 1 Jul 2016 10:14:55 -0400
Date: Fri, 1 Jul 2016 15:14:47 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Tomasz Nowicki <tn@semihalf.com>, linux-pci@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: Add new method for registering PCI hosts
Message-ID: <20160701141447.GB8609@e106497-lin.cambridge.arm.com>
References: <20160630151931.29216-1-thierry.reding@gmail.com>
 <5307392.exoejlJp9x@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5307392.exoejlJp9x@wuerfel>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 30, 2016 at 05:37:35PM +0200, Arnd Bergmann wrote:
> On Thursday, June 30, 2016 5:19:30 PM CEST Thierry Reding wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > This patch makes the existing pci_host_bridge structure a proper device
> > that is usable by PCI host drivers in a more standard way. In addition
> > to the existing pci_scan_bus, pci_scan_root_bus, pci_scan_root_bus_msi,
> > and pci_create_root_bus interfaces, this unfortunately means having to
> > add yet another interface doing basically the same thing, and add some
> > extra code in the initial step.
> 
> Thanks a lot for following up on my patches and getting them to work!
> 
> > As mentioned in a previous email, one open question is whether we want
> > to export a function for allocating a pci_host_bridge device in
> > combination with the per-device structure or let the driver itself
> > call kzalloc.
> > 
> > Changes in v2 (Thierry Reding):
> > - add a pci_host_bridge_init() helper that drivers can use to perform
> >   all the necessary steps to initialize the bridge
> 
> For these two points, the addition of pci_host_bridge_init() to me
> tips the balance in favour of having a separate allocation function
> that also does the initialization, something like
> 
> struct struct pci_host_bridge *pci_host_bridge_alloc(size_t priv)
> {
> 	struct pci_host_bridge *bridge;
> 
> 	bridge = kzalloc(sizeof(*bridge) + priv, GFP_KERNEL);
> 	if (!bridge)
> 		return NULL;
> 
> 	INIT_LIST_HEAD(&bridge->windows);
> 
> 	if (priv)
> 		bridge->private = &bridge[1];
> 
> 	return bridge;
> }

I'm confused. Why are we butchering the old pci_alloc_host_bridge() function
to then go back and add re-add it in a different form?

The old pci_alloc_host_bridge() was doing mostly what the above
function does minus the bridge->private line. And the &bridge[1] construct
could very well be pointing to the next struct pci_host_bridge aligned address,
which means parts of priv area are ignored.

Best regards,
Liviu

> 
> 	Arnd
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
