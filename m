Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33644 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934297AbaGXIeJ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 04:34:09 -0400
Message-ID: <1406190729.4590.8.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 2/4] PCI: designware: get rid of pci_scan_root_bus
From: Lucas Stach <l.stach@pengutronix.de>
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Richard Zhu' <r65037@freescale.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	kernel@pengutronix.de
Date: Thu, 24 Jul 2014 10:32:09 +0200
In-Reply-To: <001201cfa6f5$52863840$f792a8c0$%han@samsung.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
	 <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
	 <001201cfa6f5$52863840$f792a8c0$%han@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Jingoo,

Am Donnerstag, den 24.07.2014, 13:11 +0900 schrieb Jingoo Han:
> On Thursday, July 24, 2014 2:53 AM, Lucas Stach wrote:
> > 
> > Use pci_create_root_bus() similar to other pci
> > host controller drivers.
> > 
> > The main problem with pci_scan_root_bus() is that
> > not only it will create the root bus, but also try
> > to activate all devices on the bus. This triggers
> > PCI device drivers probe, which try to use the device
> > but fail as resource allocation isn't done at that
> > point in time.
> > 
> > To work around this we made sure that the host
> > controller driver is probed early and finishes resource
> > allocation before any other device drivers are registered.
> > Switching to pci_create_root_bus() allows us to get rid
> > of this special handling.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/pci/host/pcie-designware.c | 15 +++++++--------
> >  1 file changed, 7 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > index b13a830c8b0f..b869e202367c 100644
> > --- a/drivers/pci/host/pcie-designware.c
> > +++ b/drivers/pci/host/pcie-designware.c
> > @@ -801,14 +801,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> >  	struct pci_bus *bus;
> >  	struct pcie_port *pp = sys_to_pcie(sys);
> > 
> > -	if (pp) {
> > -		pp->root_bus_nr = sys->busnr;
> > -		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
> > -					sys, &sys->resources);
> > -	} else {
> > -		bus = NULL;
> > -		BUG();
> > -	}
> > +	pp->root_bus_nr = sys->busnr;
> > +	bus = pci_create_root_bus(pp->dev, sys->busnr,
> > +				  &dw_pcie_ops, sys, &sys->resources);
> > +	if (!bus)
> > +		return NULL;
> > +
> > +	pci_scan_child_bus(bus);
> 
> 
> I think that we still need to check if pp is NULL.
> Then, how about adding NULL check as below?
> 
No I don't think it's needed as it doesn't provide any additional
security.

The only code path that is calling this dw_pci_scan_bus() is in
pcibios_init_hw() which always fills sys->private_data with
hw_pci->private_data. As we are always filling hw_pci->private_data with
a pointer to our pcie_port structure in dw_pcie_host_init() the only way
for pp to be NULL at this point would be for pp to be NULL in
dw_pcie_host_init(). This would obviously crash a lot earlier.

So this check is just adding to LOC without adding any value.

Regards,
Lucas

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

