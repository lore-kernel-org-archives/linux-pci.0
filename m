Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54941 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbbC3Kga (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 30 Mar 2015 06:36:30 -0400
Message-ID: <1427711786.3370.3.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/2] PCI: add helper function to find root port for
 device
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Mon, 30 Mar 2015 12:36:26 +0200
In-Reply-To: <20150123223424.GN29776@google.com>
References: <1421179048-25370-1-git-send-email-l.stach@pengutronix.de>
	 <20150123223424.GN29776@google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 23.01.2015, 16:34 -0600 schrieb Bjorn Helgaas:
> On Tue, Jan 13, 2015 at 08:57:27PM +0100, Lucas Stach wrote:
> > This adds a simple way to get the root port a given device
> > is connected to.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2: new patch in v2
> > v3: rename to pci_find_rootport to fit better with other API
> > ---
> >  drivers/pci/search.c | 20 ++++++++++++++++++++
> >  include/linux/pci.h  |  1 +
> >  2 files changed, 21 insertions(+)
> > 
> > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > index a20ce7d5e2a7..7254f126096d 100644
> > --- a/drivers/pci/search.c
> > +++ b/drivers/pci/search.c
> > @@ -384,3 +384,23 @@ int pci_dev_present(const struct pci_device_id *ids)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL(pci_dev_present);
> > +
> > +/**
> > + * pci_find_root_port - Returns the root port the given device is connected to.
> > + * @dev: PCI device for which the root port should be found.
> > + */
> > +struct pci_dev *pci_find_root_port(struct pci_dev *dev)
> 
> This seems a little too generic.  There are still PCI (non-PCIe) systems,
> and on those this will return some non-Root Port device, the meaning of
> which is unclear.  I'm happy to put something like this in pci-tegra.c, but
> until there are other potential users and we sort out the PCI/PCIe-ness of
> the interface, I don't really want to make it global and exported.
> 
I moved it out of the Tegra PCIe driver on your request. Also I can
already see this being useful for the Keystone PCI host driver to
shorten the MTRS quirk function.

I will rename this to pcie_find_root_port() so it is clear that this is
PCIe specific, but keep it in the current location.

> > +{
> > +	struct pci_bus *bus = dev->bus;
> > +
> > +	/* If there is no bridge on the bus the passed device is a root port. */
> 
> This assumption is false -- see the comment at pci_is_root_bus().
> 
Right, will change this.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

