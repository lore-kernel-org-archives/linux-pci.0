Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43884 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753236AbbC3QJ6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 12:09:58 -0400
Message-ID: <1427731601.3370.14.camel@pengutronix.de>
Subject: Re: [PATCH v4 1/2] PCI: add helper function to find root port for
 device
From: Lucas Stach <l.stach@pengutronix.de>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 30 Mar 2015 18:06:41 +0200
In-Reply-To: <1427726038.3643.913.camel@redhat.com>
References: <1427712913-13678-1-git-send-email-l.stach@pengutronix.de>
	 <1427726038.3643.913.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 30.03.2015, 08:33 -0600 schrieb Alex Williamson:
> On Mon, 2015-03-30 at 12:55 +0200, Lucas Stach wrote:
> > This adds a simple way to get the root port a given device
> > is connected to.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: new patch in v2
> > v3: rename to pci_find_rootport to fit better with other API
> > v4: - rename to make it obvious that this function is PCIe specific
> >     - fixes wrong assumption about what is a root bus in the presence
> >       virtual buses
> > ---
> >  drivers/pci/search.c | 20 ++++++++++++++++++++
> >  include/linux/pci.h  |  1 +
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index a20ce7d5e2a7..d7c599103ae1 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -384,3 +384,23 @@ int pci_dev_present(const struct pci_device_id *ids)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(pci_dev_present);
> > +
> > +/**
> > + * pcie_find_root_port - Returns the root port the given device is connected to.
> > + * @dev: PCI device for which the root port should be found.
> > + */
> > +struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
> > +{
> > +	struct pci_bus *bus = dev->bus;
> > +
> > +	/* if this device is located on the root bus, it is a root port */
> > +	if (pci_is_root_bus(bus))
> > +		return dev;
> 
> It could also be a root complex endpoint or a conventional PCI
> device/bridge sitting on the host bridge bus.

> > +
> > +	/* walk up the PCI hierarchy to the first level below the root */
> > +	while (bus->parent && bus->parent->parent)
> > +		bus = bus->parent;
> > +
> > +	return bus->self;
> > +}
> > +EXPORT_SYMBOL(pcie_find_root_port);
> 
> IMHO, this makes too many assumptions about the topology that it's
> working with for a generic interface.  Your usage may be fairly fixed,
> but there are too many cases where it could return something that's not
> a root port as a general interface.  Thanks,
> 
I'm open to suggestions on how to improve the detection. I really need
something which works reliable in the majority of cases, as the Tegra
quirk should not be executed on other platforms.

Do you think filtering out EP devices and conventional PCI bridges on
the root bus is enough?

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

