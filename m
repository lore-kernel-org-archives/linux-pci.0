Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1511280730.6989.30.camel@perches.com>
Subject: Re: [PATCH] PCI: designware-ep: use ffz() instead of
 find_first_zero_bit()
From: Joe Perches <joe@perches.com>
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Niklas Cassel <niklas.cassel@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Niklas Cassel <niklass@axis.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Tue, 21 Nov 2017 08:12:10 -0800
In-Reply-To: <20171117113835.GB21148@red-moon>
References: <20171116183438.12613-1-niklas.cassel@axis.com>
         <20171117113835.GB21148@red-moon>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, 2017-11-17 at 11:38 +0000, Lorenzo Pieralisi wrote:
> Please follow Bjorn's request for patch formatting:
> 
> https://marc.info/?l=linux-pci&m=150905742808166&w=2
> 
> I would mention in the commit title that this is a fix.
> 
> eg "PCI: designware-ep: Fix find_first_zero_bit() usage"
> 
> On Thu, Nov 16, 2017 at 07:34:38PM +0100, Niklas Cassel wrote:
> > find_first_zero_bit()'s parameter 'size' is defined in bits,
> > not in bytes.
> > 
> > find_first_zero_bit() was called with bytes rather than bits,
> 
> "was called with size in bytes"...

This code also uses set_bit/clear_bit.

I suggest not intermixing set_bit/clear_bit calls and ffz
on the same object.

Use either (&/~/ffz) or (set_bit/clear_bit/find_first_zero_bit)

BITS_PER_LONG would work fine for find_first_zero_bit

> > which thus defined a too low upper limit, causing
> > dw_pcie_ep_inbound_atu() to assign iatu index #4 to both bar 4
> > and bar 5, which made bar 5 overwrite the settings set by bar 4.
> > 
> > ./pcitest.sh
> > BAR tests
> > BAR0:		OKAY
> > BAR1:		OKAY
> > BAR2:		OKAY
> > BAR3:		OKAY
> > BAR4:		NOT OKAY
> > BAR5:		OKAY
> 
> Sorry but this example is pretty much useless - either you add
> a self-explanatory kernel log or you just remove it.
> 
> > Fix this by using replacing find_first_zero_bit() with ffz(),
> > since ffz() only works on a single 'unsigned long' and therefore
> > does not need a size argument.
> > 
> > Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>
> 
> We need a Fixes: tag at least, see Bjorn's post above.
> 
> Thanks,
> Lorenzo
> 
> > ---
> >  drivers/pci/dwc/pcie-designware-ep.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/dwc/pcie-designware-ep.c b/drivers/pci/dwc/pcie-designware-ep.c
> > index d53d5f168363..ab9a9e160daf 100644
> > --- a/drivers/pci/dwc/pcie-designware-ep.c
> > +++ b/drivers/pci/dwc/pcie-designware-ep.c
> > @@ -70,8 +70,7 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, enum pci_barno bar,
> >  	u32 free_win;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > -	free_win = find_first_zero_bit(&ep->ib_window_map,
> > -				       sizeof(ep->ib_window_map));
> > +	free_win = ffz(ep->ib_window_map);
> >  	if (free_win >= ep->num_ib_windows) {
> >  		dev_err(pci->dev, "no free inbound window\n");
> >  		return -EINVAL;
> > @@ -96,8 +95,7 @@ static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep, phys_addr_t phys_addr,
> >  	u32 free_win;
> >  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> >  
> > -	free_win = find_first_zero_bit(&ep->ob_window_map,
> > -				       sizeof(ep->ob_window_map));
> > +	free_win = ffz(ep->ob_window_map);
> >  	if (free_win >= ep->num_ob_windows) {
> >  		dev_err(pci->dev, "no free outbound window\n");
> >  		return -EINVAL;
> > -- 
> > 2.14.2
> > 
