Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:63508 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753766AbaCMK2P (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 13 Mar 2014 06:28:15 -0400
In-Reply-To: <33747243.K5i7Ah8L7o@wuerfel>
References: <1394704208-7490-1-git-send-email-phil.edworthy@renesas.com> <1394704208-7490-6-git-send-email-phil.edworthy@renesas.com> <33747243.K5i7Ah8L7o@wuerfel>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OFF61489EE.B9ED2F88-ON80257C9A.00386B74-80257C9A.00398025@eu.necel.com>
Date: Thu, 13 Mar 2014 10:28:03 +0000
Subject: Re: [PATCH 5/9] dt-bindings: pci: rcar pcie device tree bindings
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Arnd,

Thanks for your review.

On 13/03/2014 10:00, Arnd wrote:
> On Thursday 13 March 2014 09:50:04 Phil Edworthy wrote:
> > This patch adds the bindings for the rcar PCIE driver. The driver
> > resides under drivers/pci/host/pcie-rcar.c
> > 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> >  Documentation/devicetree/bindings/pci/rcar-pci.txt | 40 
++++++++++++++++++++++
> >  1 file changed, 40 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/rcar-pci.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/
> Documentation/devicetree/bindings/pci/rcar-pci.txt
> > new file mode 100644
> > index 0000000..0e219b0
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -0,0 +1,40 @@
> > +* Renesas RCar PCIe interface
> > +
> > +Required properties:
> > +- compatible: should contain one of the following
> > +   "renesas,r8a7779-pcie", "renesas,r8a7790-pcie", 
"renesas,r8a7791-pcie"
> > +- reg: base addresses and lengths of the pcie controller.
> > +- #address-cells: set to <3>
> > +- #size-cells: set to <2>
> > +- device_type: set to "pci"
> > +- ranges: ranges for the PCI memory and I/O regions
> 
> I see your description and example includes I/O regions, but the driver
> claims in a comment that these don't work. Do you also have a patch to
> make them work?
Are you referring to the comment "The controller does not support/use port 
I/O" in the driver for the internal PCI controller (pci-rcar-gen2.c)?
This is a separate block of hardware, it's a PCIe controller with external 
pins, for which we do support I/O regions.

> In case that patch is part of the 9-patch series, do you mind adding the
> arm kernel mailing list (and maybe me personally) to Cc the next time?
Sure, the rest of the patch set adds this new PCIe driver and adds it to 
the R-Car devices & boards.

> > +- interrupts: interrupt values for MSI interrupt
> > +- #interrupt-cells: set to <1>
> > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > +   to define the mapping of the PCIe interface to interrupt
> > +   numbers.
> > +- clocks: from common clock binding: handle to pci clock.
> > +- clock-names: from common clock binding: should be "pcie"
> > +
> > +Example:
> > +
> > +SoC specific DT Entry:
> > +
> > +   pcie: pcie@0x01000000 {
> > +      compatible = "renesas,r8a7790-pcie";
> > +      reg = <0 0xfe000000 0 0x80000>;
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      device_type = "pci";
> > +      ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> > +           0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> > +           0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> > +           0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> 
> I'm curious about why there are two non-prefetchable regions. What is
> the significance of this?
The devices that have this PCIe controller both have a number of fixed, 
non-contiguous memory regions that can be used as PCIe windows. The ranges 
here map onto those fixed windows, i.e. if the CPU addresses of the ranges 
change it won't work. The first couple of windows are small, we use the 
first one for I/O, we decided that we may as well use the next small 
window for memory - otherwise we need to figure out a way to tell the 
driver to skip a window.

> > +      interrupts = <0 116 4>;
> > +      #interrupt-cells = <1>;
> > +      interrupt-map-mask = <0 0 0 0>;
> > +      interrupt-map = <0 0 0 0 &gic 0 116 4>;
> > +      clocks = <&mstp3_clks R8A7790_CLK_PCIE>;
> > +      clock-names = "pcie";
> > +      status = "disabled";
> > +   };
> 
> Are you sure that there is only one legacy interrupt?  Most host
> controllers wire up IntA through IntD to different output pins.
Yes, and we've tested that as well.

> Otherwise looks good.
> 
>    Arnd

Thanks
Phil
