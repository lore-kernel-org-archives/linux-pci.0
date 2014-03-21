Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor3.renesas.com ([210.160.252.173]:64274 "EHLO
	relmlie2.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751488AbaCUPCg (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 11:02:36 -0400
In-Reply-To: <1395412213.4554.17.camel@weser.hi.pengutronix.de>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>		 <1395397968-6242-6-git-send-email-phil.edworthy@renesas.com>
	 <1395401031.4554.9.camel@weser.hi.pengutronix.de>	 <OF03C9E23D.07B7D998-ON80257CA2.004E5877-80257CA2.004E9BFB@eu.necel.com> <1395412213.4554.17.camel@weser.hi.pengutronix.de>
To: Lucas Stach <l.stach@pengutronix.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OFC7DD5DAC.D378B300-ON80257CA2.0051ECEE-80257CA2.00529F98@eu.necel.com>
Date: Fri, 21 Mar 2014 15:02:29 +0000
Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree bindings
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lucas,

On: 21/03/2014 14:31, Lucas wrote:
> Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree 
bindings
> 
> Am Freitag, den 21.03.2014, 14:18 +0000 schrieb
> Phil.Edworthy@renesas.com:
> > Hi Lucas,
> > 
> > On 21/03/2014 11:24, Lucas wrote:
> > > Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree 
> > bindings
> > > 
> > > Am Freitag, den 21.03.2014, 10:32 +0000 schrieb Phil Edworthy:
> > > > This patch adds the bindings for the rcar PCIE driver. The driver
> > > > resides under drivers/pci/host/pcie-rcar.c
> > > > 
> > > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > > 
> > > I have one question below. If you can answer this with yes after
> > > thinking again about it, this is:
> > > 
> > > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 40 
> > ++++++++++++++++++++++
> > > >  1 file changed, 40 insertions(+)
> > > >  create mode 100644 
Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/
> > > Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > new file mode 100644
> > > > index 0000000..0e219b0
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > > @@ -0,0 +1,40 @@
> > > > +* Renesas RCar PCIe interface
> > > > +
> > > > +Required properties:
> > > > +- compatible: should contain one of the following
> > > > +   "renesas,r8a7779-pcie", "renesas,r8a7790-pcie", 
> > "renesas,r8a7791-pcie"
> > > > +- reg: base addresses and lengths of the pcie controller.
> > > > +- #address-cells: set to <3>
> > > > +- #size-cells: set to <2>
> > > > +- device_type: set to "pci"
> > > > +- ranges: ranges for the PCI memory and I/O regions
> > > > +- interrupts: interrupt values for MSI interrupt
> > > > +- #interrupt-cells: set to <1>
> > > > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > > > +   to define the mapping of the PCIe interface to interrupt
> > > > +   numbers.
> > > > +- clocks: from common clock binding: handle to pci clock.
> > > > +- clock-names: from common clock binding: should be "pcie"
> > > 
> > > You really only have one PCIe clock? So the controller is generating 
the
> > > PCIe bus clock from it's register clock? No need to enable any other
> > > clock for PCIe to work?
> > Yes, just the one clock. The PCIe bus clock is an external clock 
dedicated 
> > to PCIe and SATA, and we have no control over it.
> > 
> Is this some kind of always-on clock? If not you probably want a
> reference to it from the PCIe driver even if it's shared between SATA
> and PCIe. After all you don't want to end up unconditionally enabling
> this clock from the board or SoC level just to have PCIe working, right?
Ok, I see, I'll need a reference to a board clock, even if it's always on 
for these boards. 

> Regards,
> Lucas
> -- 
> Pengutronix e.K.                           | Lucas Stach |
> Industrial Linux Solutions                 | http://www.pengutronix.de/ 
|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 
|
> 

Thanks
Phil
