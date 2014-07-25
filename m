Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:54675 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934873AbaGYAjo (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jul 2014 20:39:44 -0400
Received: from epcpsbgr4.samsung.com
 (u144.gpu120.samsung.co.kr [203.254.230.144])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0N980099USI6PS90@mailout1.samsung.com> for
 linux-pci@vger.kernel.org; Fri, 25 Jul 2014 09:39:42 +0900 (KST)
From: Jingoo Han <jg1.han@samsung.com>
To: 'Lucas Stach' <l.stach@pengutronix.de>
Cc: 'Bjorn Helgaas' <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	'Richard Zhu' <r65037@freescale.com>,
	'Mohit Kumar' <mohit.kumar@st.com>,
	'Marek Vasut' <marex@denx.de>,
	'Kishon Vijay Abraham I' <kishon@ti.com>,
	kernel@pengutronix.de, 'Jingoo Han' <jg1.han@samsung.com>
References: <1406137961-14684-1-git-send-email-l.stach@pengutronix.de>
 <1406137961-14684-3-git-send-email-l.stach@pengutronix.de>
 <001201cfa6f5$52863840$f792a8c0$%han@samsung.com>
 <1406190729.4590.8.camel@weser.hi.pengutronix.de>
 <002d01cfa71d$0f5a2590$2e0e70b0$%han@samsung.com>
 <1406192534.4590.12.camel@weser.hi.pengutronix.de>
In-reply-to: <1406192534.4590.12.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH 2/4] PCI: designware: get rid of pci_scan_root_bus
Date: Fri, 25 Jul 2014 09:39:42 +0900
Message-id: <003401cfa7a0$eca620b0$c5f26210$%han@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thursday, July 24, 2014 6:02 PM, Jingoo Han wrote:
> Am Donnerstag, den 24.07.2014, 17:55 +0900 schrieb Jingoo Han:
> > On Thursday, July 24, 2014 5:32 PM, Lucas Stach wrote:
> > > Am Donnerstag, den 24.07.2014, 13:11 +0900 schrieb Jingoo Han:
> > > > On Thursday, July 24, 2014 2:53 AM, Lucas Stach wrote:
> > > > >
> > > > > Use pci_create_root_bus() similar to other pci
> > > > > host controller drivers.
> > > > >
> > > > > The main problem with pci_scan_root_bus() is that
> > > > > not only it will create the root bus, but also try
> > > > > to activate all devices on the bus. This triggers
> > > > > PCI device drivers probe, which try to use the device
> > > > > but fail as resource allocation isn't done at that
> > > > > point in time.
> > > > >
> > > > > To work around this we made sure that the host
> > > > > controller driver is probed early and finishes resource
> > > > > allocation before any other device drivers are registered.
> > > > > Switching to pci_create_root_bus() allows us to get rid
> > > > > of this special handling.
> > > > >
> > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > ---
> > > > >  drivers/pci/host/pcie-designware.c | 15 +++++++--------
> > > > >  1 file changed, 7 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> > > > > index b13a830c8b0f..b869e202367c 100644
> > > > > --- a/drivers/pci/host/pcie-designware.c
> > > > > +++ b/drivers/pci/host/pcie-designware.c
> > > > > @@ -801,14 +801,13 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
> > > > >  	struct pci_bus *bus;
> > > > >  	struct pcie_port *pp = sys_to_pcie(sys);
> > > > >
> > > > > -	if (pp) {
> > > > > -		pp->root_bus_nr = sys->busnr;
> > > > > -		bus = pci_scan_root_bus(pp->dev, sys->busnr, &dw_pcie_ops,
> > > > > -					sys, &sys->resources);
> > > > > -	} else {
> > > > > -		bus = NULL;
> > > > > -		BUG();
> > > > > -	}
> > > > > +	pp->root_bus_nr = sys->busnr;
> > > > > +	bus = pci_create_root_bus(pp->dev, sys->busnr,
> > > > > +				  &dw_pcie_ops, sys, &sys->resources);
> > > > > +	if (!bus)
> > > > > +		return NULL;
> > > > > +
> > > > > +	pci_scan_child_bus(bus);
> > > >
> > > >
> > > > I think that we still need to check if pp is NULL.
> > > > Then, how about adding NULL check as below?
> > > >
> > > No I don't think it's needed as it doesn't provide any additional
> > > security.
> > >
> > > The only code path that is calling this dw_pci_scan_bus() is in
> > > pcibios_init_hw() which always fills sys->private_data with
> > > hw_pci->private_data. As we are always filling hw_pci->private_data with
> > > a pointer to our pcie_port structure in dw_pcie_host_init() the only way
> > > for pp to be NULL at this point would be for pp to be NULL in
> > > dw_pcie_host_init(). This would obviously crash a lot earlier.
> > >
> > > So this check is just adding to LOC without adding any value.
> >
> > Hi Lucas,
> >
> > I see what you mean. However, pcie-designware.c has been handled by
> > various engineers. So, it is not sure that the current sequence will
> > not change in the future. Anyway, thank you for your comment. :-)
> >
> I just looked this up and we we have a lot (and in some cases
> inconsistent checks) for this sprinkled through the driver. I would
> prefer to keep this patch as is and instead add this check to
> sys_to_pcie(). This way we could remove it from the various call sites
> while keeping the safety it provides. If you agree I can send a patch to
> do this.

Hi Lucas Stach,

OK, I agree with your suggestion. However, I want to get other opinions
from other CC'ed people. Thank you.

Best regards,
Jingoo Han

