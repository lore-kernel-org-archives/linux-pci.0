Return-Path: <SRS0=AzH2=ZN=pengutronix.de=l.stach@kernel.org>
Return-Path: <SRS0=AzH2=ZN=pengutronix.de=l.stach@kernel.org>
Message-ID: <1485858425.21479.31.camel@pengutronix.de>
Subject: Re: [PATCH] PCI: mvebu: change delay after reset to the PCIe spec
 mandated 100ms
From: Lucas Stach <l.stach@pengutronix.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Thomas Petazzoni
 <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>,
  linux-pci@vger.kernel.org, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org, patchwork-lst@pengutronix.de
Date: Tue, 31 Jan 2017 11:27:05 +0100
In-Reply-To: <20170130204740.GT20550@bhelgaas-glaptop.roam.corp.google.com>
References: <20170116111142.6866-1-l.stach@pengutronix.de>
	 <20170130204740.GT20550@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Am Montag, den 30.01.2017, 14:47 -0600 schrieb Bjorn Helgaas:
> On Mon, Jan 16, 2017 at 12:11:42PM +0100, Lucas Stach wrote:
> > The current default of 20ms cause some devices, which are slow to initialize,
> > to not show up during the bus scanning. Change this to the PCIe spec mandated
> > 100ms and document this in the DT binding.
> > 
> > From PCIe base spec rev 3.0, chapter "6.6.1. Conventional Reset":
> > 
> > "To allow components to perform internal initialization, system software must
> > wait a specified minimum period following the end of a Conventional Reset of
> > one or more devices before it is permitted to issue Configuration Requests to
> > those devices.
> > 
> > With a Downstream Port that does not support Link speeds greater than
> > 5.0 GT/s, software must wait a minimum of 100 ms before sending a
> > Configuration Request to the device immediately below that Port."
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/pci/mvebu-pci.txt | 3 ++-
> >  drivers/pci/host/pci-mvebu.c                        | 2 +-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/mvebu-pci.txt b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > index 08c716b2c6b6..2de6f65ecfb1 100644
> > --- a/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > +++ b/Documentation/devicetree/bindings/pci/mvebu-pci.txt
> > @@ -78,7 +78,8 @@ and the following optional properties:
> >    multiple lanes. If this property is not found, we assume that the
> >    value is 0.
> >  - reset-gpios: optional gpio to PERST#
> > -- reset-delay-us: delay in us to wait after reset de-assertion
> > +- reset-delay-us: delay in us to wait after reset de-assertion, if not
> > +  specified will default to 100ms, as required by the PCIe specification.
> >  
> >  Example:
> >  
> > diff --git a/drivers/pci/host/pci-mvebu.c b/drivers/pci/host/pci-mvebu.c
> > index 45a89d969700..0c9dd47ce74d 100644
> > --- a/drivers/pci/host/pci-mvebu.c
> > +++ b/drivers/pci/host/pci-mvebu.c
> > @@ -1162,7 +1162,7 @@ static int mvebu_pcie_powerup(struct mvebu_pcie_port *port)
> >  		return ret;
> >  
> >  	if (port->reset_gpio) {
> > -		u32 reset_udelay = 20000;
> > +		u32 reset_udelay = 100000;
> 
> Can we use "PCI_PM_D3COLD_WAIT * 1000" for the initial value to connect it
> with other similar cases?

Sure, I didn't know there is a define for this. Will send an updated
patch.

Regards,
Lucas
