Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754568AbcKUWmP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 21 Nov 2016 17:42:15 -0500
Date: Mon, 21 Nov 2016 16:42:10 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] PCI/PME: Drop unused support for PMEs from Root
 Complex Event Collectors
Message-ID: <20161121224210.GD4832@bhelgaas-glaptop.roam.corp.google.com>
References: <20161121214006.21036.11599.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161121214519.21036.33519.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <4459736.K6pDNqTrTR@vostro.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4459736.K6pDNqTrTR@vostro.rjw.lan>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 11:28:56PM +0100, Rafael J. Wysocki wrote:
> On Monday, November 21, 2016 03:45:19 PM Bjorn Helgaas wrote:
> > Since we register pcie_pme_driver only for PCI_EXP_TYPE_ROOT_PORT, the PME
> > driver never claims Root Complex Event Collectors.
> > 
> > Remove unused code related to Root Complex Event Collectors.
> > 
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pcie/pme.c |   17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> > 
> > diff --git a/drivers/pci/pcie/pme.c b/drivers/pci/pcie/pme.c
> > index 884bad5..9e8aa9d 100644
> > --- a/drivers/pci/pcie/pme.c
> > +++ b/drivers/pci/pcie/pme.c
> > @@ -319,23 +319,8 @@ static int pcie_pme_set_native(struct pci_dev *dev, void *ign)
> >  static void pcie_pme_mark_devices(struct pci_dev *port)
> >  {
> >  	pcie_pme_set_native(port, NULL);
> > -	if (port->subordinate) {
> > +	if (port->subordinate)
> >  		pci_walk_bus(port->subordinate, pcie_pme_set_native, NULL);
> > -	} else {
> > -		struct pci_bus *bus = port->bus;
> > -		struct pci_dev *dev;
> > -
> > -		/* Check if this is a root port event collector. */
> > -		if (pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC || !bus)
> > -			return;
> > -
> > -		down_read(&pci_bus_sem);
> > -		list_for_each_entry(dev, &bus->devices, bus_list)
> > -			if (pci_is_pcie(dev)
> > -			    && pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
> > -				pcie_pme_set_native(dev, NULL);
> > -		up_read(&pci_bus_sem);
> > -	}
> >  }
> >  
> >  /**
> 
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

I'm shocked :)  You mean we really don't care about PME from RC event
collectors?  Without the RCEC support, we won't see any PMEs from RC
integrated devices.  I mean, I don't think we see those PMEs today, but I
thought maybe we would *want* to.  No?

Bjorn
