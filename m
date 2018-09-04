Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:45943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbeIDTRB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Sep 2018 15:17:01 -0400
Date: Tue, 4 Sep 2018 08:53:00 -0600
From: Keith Busch <keith.busch@intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Sinan Kaya <okaya@kernel.org>,
        Thomas Tai <thomas.tai@oracle.com>,
        "poza@codeaurora.org" <poza@codeaurora.org>
Subject: Re: [PATCH 04/16] PCI/ERR: Use slot reset if available
Message-ID: <20180904145300.GB18241@localhost.localdomain>
References: <20180831212639.10196-1-keith.busch@intel.com>
 <20180831212639.10196-5-keith.busch@intel.com>
 <20180901172011.haapzq6o7ivuiq4g@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180901172011.haapzq6o7ivuiq4g@wunner.de>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 01, 2018 at 10:20:11AM -0700, Lukas Wunner wrote:
> On Fri, Aug 31, 2018 at 03:26:27PM -0600, Keith Busch wrote:
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > +int pci_bus_error_reset(struct pci_dev *bridge)
> > +{
> > +	struct pci_bus *bus = bridge->subordinate;
> > +
> > +	if (!bus)
> > +		return -ENOTTY;
> > +
> > +	if (!list_empty(&bus->slots)) {
> > +		struct pci_slot *slot;
> > +
> > +		list_for_each_entry(slot, &bus->slots, list)
> > +			if (pci_probe_reset_slot(slot))
> > +				goto bus_reset;
> > +		list_for_each_entry(slot, &bus->slots, list)
> > +			if (pci_slot_reset(slot, 0))
> > +				goto bus_reset;
> > +		return 0;
> > +	}
> 
> I don't see any locking to protect the slots list access.  It seems
> pci_slot_mutex is meant to serve this purpose, but it's scoped to slot.c.
> Which begs the question if this function should live there as well?

Thanks for pointing that out. I think we ought to have all the needed
locking between pci_bus_sem and pci_rescan_remove_lock. I'll see if we
can make pci_slot_mutex unnecessary.
