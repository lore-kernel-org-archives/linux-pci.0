Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:34919 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177AbbDHSN5 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 8 Apr 2015 14:13:57 -0400
Received: by obbfy7 with SMTP id fy7so151302527obb.2
        for <linux-pci@vger.kernel.org>; Wed, 08 Apr 2015 11:13:56 -0700 (PDT)
Date: Wed, 8 Apr 2015 13:13:52 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Thierry Reding <thierry.reding@gmail.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 1/2] PCI: add helper function to find root port for
 device
Message-ID: <20150408181352.GA30967@google.com>
References: <1427712913-13678-1-git-send-email-l.stach@pengutronix.de>
 <1427726038.3643.913.camel@redhat.com>
 <1427731601.3370.14.camel@pengutronix.de>
 <1427734370.3643.949.camel@redhat.com>
 <1427804588.3370.19.camel@pengutronix.de>
 <1427810993.5567.90.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1427810993.5567.90.camel@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Mar 31, 2015 at 08:09:53AM -0600, Alex Williamson wrote:
> On Tue, 2015-03-31 at 14:23 +0200, Lucas Stach wrote:
> > Am Montag, den 30.03.2015, 10:52 -0600 schrieb Alex Williamson:
> > > On Mon, 2015-03-30 at 18:06 +0200, Lucas Stach wrote:
> > > > Am Montag, den 30.03.2015, 08:33 -0600 schrieb Alex Williamson:
> > > > > On Mon, 2015-03-30 at 12:55 +0200, Lucas Stach wrote:
> > > > > > This adds a simple way to get the root port a given device
> > > > > > is connected to.
> > > > > > 
> > > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > > ---
> > > > > > v2: new patch in v2
> > > > > > v3: rename to pci_find_rootport to fit better with other API
> > > > > > v4: - rename to make it obvious that this function is PCIe specific
> > > > > >     - fixes wrong assumption about what is a root bus in the presence
> > > > > >       virtual buses
> > > > > > ---
> > > > > >  drivers/pci/search.c | 20 ++++++++++++++++++++
> > > > > >  include/linux/pci.h  |  1 +
> > > > > >  2 files changed, 21 insertions(+)
> > > > > > 
> > > > > > diff --git a/drivers/pci/search.c b/drivers/pci/search.c
> > > > > > index a20ce7d5e2a7..d7c599103ae1 100644
> > > > > > --- a/drivers/pci/search.c
> > > > > > +++ b/drivers/pci/search.c
> > > > > > @@ -384,3 +384,23 @@ int pci_dev_present(const struct pci_device_id *ids)
> > > > > >  	return 0;
> > > > > >  }
> > > > > >  EXPORT_SYMBOL(pci_dev_present);
> > > > > > +
> > > > > > +/**
> > > > > > + * pcie_find_root_port - Returns the root port the given device is connected to.
> > > > > > + * @dev: PCI device for which the root port should be found.
> > > > > > + */
> > > > > > +struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
> > > > > > +{
> > > > > > +	struct pci_bus *bus = dev->bus;
> > > > > > +
> > > > > > +	/* if this device is located on the root bus, it is a root port */
> > > > > > +	if (pci_is_root_bus(bus))
> > > > > > +		return dev;
> > > > > 
> > > > > It could also be a root complex endpoint or a conventional PCI
> > > > > device/bridge sitting on the host bridge bus.
> > > > 
> > > > > > +
> > > > > > +	/* walk up the PCI hierarchy to the first level below the root */
> > > > > > +	while (bus->parent && bus->parent->parent)
> > > > > > +		bus = bus->parent;
> > > > > > +
> > > > > > +	return bus->self;
> > > > > > +}
> > > > > > +EXPORT_SYMBOL(pcie_find_root_port);
> > > > > 
> > > > > IMHO, this makes too many assumptions about the topology that it's
> > > > > working with for a generic interface.  Your usage may be fairly fixed,
> > > > > but there are too many cases where it could return something that's not
> > > > > a root port as a general interface.  Thanks,
> > > > > 
> > > > I'm open to suggestions on how to improve the detection. I really need
> > > > something which works reliable in the majority of cases, as the Tegra
> > > > quirk should not be executed on other platforms.
> > > > 
> > > > Do you think filtering out EP devices and conventional PCI bridges on
> > > > the root bus is enough?
> > > 
> > > I'm actually pretty confused by the implementation of the quirk as well,
> > > why do you even need this pcie_find_root_port() function?  Your fixup is
> > > called for every single PCI device in the system, so why do you need to
> > > go to the trouble of scanning the topology for the root port?  You'll be
> > > passed the root port eventually and it will match your ID table w/o any
> > > extra effort.  As coded, you're calling the set capability function
> > > multiple times per root port, once for itself and once for each device
> > > below it.
> > > 
> > > Personally, I'd probably do away with the table, declare a fixup for
> > > each entry for the specific vendor/device ID, and make a simple quirk
> > > callback that sets the capability bit.  Just my preference though.
> > > Thanks,
> > > 
> > No, you missed the point of the fixup here.
> > 
> > We need to apply this fixup on every device in the system if the root
> > port is a Tegra. So the fixup needs to get called for every device,
> > filtering on a specific vendor/device ID is not possible.
> > 
> > But on the other hand this fixup may be compiled into a multiplatform
> > kernel. If this kernel is strated on a device which isn't a Tegra (and
> > so has no Tegra root port) we don't want to apply the fixup at all.
> 
> Yes, you're right, sorry for the misinterpretation.  So the quirk works
> as expected, but I think at a minimum the helper function needs to be
> renamed to something like pci_find_root_bus_dev() since there is no
> attempt made to verify whether the returned device is actually a root
> port.  If you don't support hotplug, you could also apply the quirk from
> the root port down instead of searching from every device up.  Thanks,

How should we proceed here?  I agree with Alex's comments.

Bjorn
