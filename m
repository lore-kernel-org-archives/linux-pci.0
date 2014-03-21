Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45747 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753331AbaCUOa7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 21 Mar 2014 10:30:59 -0400
Message-ID: <1395412213.4554.17.camel@weser.hi.pengutronix.de>
Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree bindings
From: Lucas Stach <l.stach@pengutronix.de>
To: Phil.Edworthy@renesas.com
Cc: devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	LAKML <linux-arm-kernel@lists.infradead.org>
Date: Fri, 21 Mar 2014 15:30:13 +0100
In-Reply-To: <OF03C9E23D.07B7D998-ON80257CA2.004E5877-80257CA2.004E9BFB@eu.necel.com>
References: <1395397968-6242-1-git-send-email-phil.edworthy@renesas.com>
		 <1395397968-6242-6-git-send-email-phil.edworthy@renesas.com>
	 <1395401031.4554.9.camel@weser.hi.pengutronix.de>
	 <OF03C9E23D.07B7D998-ON80257CA2.004E5877-80257CA2.004E9BFB@eu.necel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Freitag, den 21.03.2014, 14:18 +0000 schrieb
Phil.Edworthy@renesas.com:
> Hi Lucas,
> 
> On 21/03/2014 11:24, Lucas wrote:
> > Subject: Re: [PATCH v4 5/9] dt-bindings: pci: rcar pcie device tree 
> bindings
> > 
> > Am Freitag, den 21.03.2014, 10:32 +0000 schrieb Phil Edworthy:
> > > This patch adds the bindings for the rcar PCIE driver. The driver
> > > resides under drivers/pci/host/pcie-rcar.c
> > > 
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > 
> > I have one question below. If you can answer this with yes after
> > thinking again about it, this is:
> > 
> > Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> > > ---
> > >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 40 
> ++++++++++++++++++++++
> > >  1 file changed, 40 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/
> > Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > new file mode 100644
> > > index 0000000..0e219b0
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > > @@ -0,0 +1,40 @@
> > > +* Renesas RCar PCIe interface
> > > +
> > > +Required properties:
> > > +- compatible: should contain one of the following
> > > +   "renesas,r8a7779-pcie", "renesas,r8a7790-pcie", 
> "renesas,r8a7791-pcie"
> > > +- reg: base addresses and lengths of the pcie controller.
> > > +- #address-cells: set to <3>
> > > +- #size-cells: set to <2>
> > > +- device_type: set to "pci"
> > > +- ranges: ranges for the PCI memory and I/O regions
> > > +- interrupts: interrupt values for MSI interrupt
> > > +- #interrupt-cells: set to <1>
> > > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > > +   to define the mapping of the PCIe interface to interrupt
> > > +   numbers.
> > > +- clocks: from common clock binding: handle to pci clock.
> > > +- clock-names: from common clock binding: should be "pcie"
> > 
> > You really only have one PCIe clock? So the controller is generating the
> > PCIe bus clock from it's register clock? No need to enable any other
> > clock for PCIe to work?
> Yes, just the one clock. The PCIe bus clock is an external clock dedicated 
> to PCIe and SATA, and we have no control over it.
> 
Is this some kind of always-on clock? If not you probably want a
reference to it from the PCIe driver even if it's shared between SATA
and PCIe. After all you don't want to end up unconditionally enabling
this clock from the board or SoC level just to have PCIe working, right?

Regards,
Lucas
-- 
Pengutronix e.K.                           | Lucas Stach                 |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-5076 |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

