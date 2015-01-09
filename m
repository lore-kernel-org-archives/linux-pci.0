Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46873 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755343AbbAILpW (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 9 Jan 2015 06:45:22 -0500
Message-ID: <1420803918.16381.9.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/2] PCI: tegra: apply relaxed ordering fixup only on
 Tegra
From: Lucas Stach <l.stach@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Alexandre Courbot <gnurou@gmail.com>,
	linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org
Date: Fri, 09 Jan 2015 12:45:18 +0100
In-Reply-To: <20150109113213.GE16465@ulmo>
References: <1418929903-8506-1-git-send-email-l.stach@pengutronix.de>
	 <1418929903-8506-2-git-send-email-l.stach@pengutronix.de>
	 <20150109113213.GE16465@ulmo>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 09.01.2015, 12:32 +0100 schrieb Thierry Reding:
> On Thu, Dec 18, 2014 at 08:11:43PM +0100, Lucas Stach wrote:
> > The fixup to enable relaxed ordering on all PCI devices was
> > executed unconditionally if the Tegra PCI host driver was
> > built into the kernel. This doesn't play nice with a
> > multiplatform kernel executed on other platforms which
> > may not need this fixup.
> > 
> > Make sure to only apply the fixup if the root port is
> > a Tegra.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> > v2:
> > - split out PCI hierarchy walk
> > - separate code from data by moving PCI IDs into own structure
> > ---
> >  drivers/pci/host/pci-tegra.c | 34 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 33 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
> > index 333a57afacc4..b77f417e1a3c 100644
> > --- a/drivers/pci/host/pci-tegra.c
> > +++ b/drivers/pci/host/pci-tegra.c
> > @@ -635,10 +635,42 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0bf1, tegra_pcie_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1c, tegra_pcie_fixup_class);
> >  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_NVIDIA, 0x0e1d, tegra_pcie_fixup_class);
> >  
> > +static const struct pci_device_id tegra_rootport_ids[] = {
> > +	{
> > +		/* Tegra20 4 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0bf0,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> > +	}, {
> > +		/* Tegra20 2 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0bf1,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> 
> The number of lanes is configurable, so I'm not sure exactly what this
> comment is supposed to indicate. Are you saying that port 0 has 0x0bf0
> and port 1 has 0x0bf1 as device IDs.
> 

No, the device ID of the root port is dependent on the number of lanes
configured for the specific port. So if you have a 4x1 configuration you
will get to see a single device with ID 0x0bf0, in a 2x2 configuration
you will see 2 devices with ID 0x0bf1.

> > +	}, {
> > +		/* Tegra30 4 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e1c,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> > +	}, {
> > +		/* Tegra30 2 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e1d,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> 
> Tegra30 has three ports, so does this second entry (0x0e1d) apply to
> ports 1 and 2, whereas the previous entry (0x0e1c) applies only to port
> 0?
> 
> > +	}, {
> > +		/* Tegra124 4 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e12,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> > +	}, {
> > +		/* Tegra124 1 lane root port */
> > +		.vendor = PCI_VENDOR_ID_NVIDIA, .device = 0x0e13,
> > +		.subvendor = PCI_ANY_ID, .subdevice = PCI_ANY_ID
> 
> Or perhaps what this signifies is that the first port is actually a
> different device because it supports up to 4 lanes, whereas the others
> support up to 2 lanes (or only 1 on Tegra124)? In that case:
> 
> Acked-by: Thierry Reding <treding@nvidia.com>


