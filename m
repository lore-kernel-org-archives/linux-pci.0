Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor2.renesas.com ([210.160.252.172]:51005 "EHLO
	relmlie1.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751914AbaC0Lke (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 27 Mar 2014 07:40:34 -0400
In-Reply-To: <53340690.20006@cogentembedded.com>
References: <1395912416-20087-1-git-send-email-phil.edworthy@renesas.com> <1395912416-20087-6-git-send-email-phil.edworthy@renesas.com> <53340690.20006@cogentembedded.com>
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>,
	LAKML <linux-arm-kernel@lists.infradead.org>,
	linux-pci@vger.kernel.org, linux-sh@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Valentine Barshak <valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
From: Phil.Edworthy@renesas.com
Message-ID: <OF9F94FEE3.D67AC138-ON80257CA8.00401203-80257CA8.00401F68@eu.necel.com>
Date: Thu, 27 Mar 2014 11:40:24 +0000
Subject: Re: [PATCH v6 05/10] dt-bindings: pci: rcar pcie device tree bindings
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On: 27/03/2014 11:08, Sergei wrote:
> Subject: Re: [PATCH v6 05/10] dt-bindings: pci: rcar pcie device tree 
bindings
> 
> Hello.
> 
> On 27-03-2014 13:26, Phil Edworthy wrote:
> 
> > This patch adds the bindings for the R-Car PCIe driver. The driver
> > resides under drivers/pci/host/pcie-rcar.c
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> 
> > v6:
> >   - Correct DT bindings description for reg and clocks
> 
> > v5:
> >   - Add PCIe bus clock reference
> >   - Add additional interrupt bindings
> >   - Use dma-ranges property to specify inbound memory regions
> 
>     Put these under --- tear line, please.
> 
> > ---
> >   Documentation/devicetree/bindings/pci/rcar-pci.txt | 45 
++++++++++++++++++++++
> >   1 file changed, 45 insertions(+)
> >   create mode 100644 
Documentation/devicetree/bindings/pci/rcar-pci.txt
> 
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/
> Documentation/devicetree/bindings/pci/rcar-pci.txt
> > new file mode 100644
> > index 0000000..a97ebe6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -0,0 +1,45 @@
> > +* Renesas RCar PCIe interface
> > +
> > +Required properties:
> > +- compatible: should contain one of the following
> > +   "renesas,pcie-r8a7779", "renesas,pcie-r8a7790", 
"renesas,pcie-r8a7791"
> > +- reg: base address and length of the pcie controller registers.
> > +- #address-cells: set to <3>
> > +- #size-cells: set to <2>
> > +- device_type: set to "pci"
> > +- ranges: ranges for the PCI memory and I/O regions.
> > +- dma-ranges: ranges for the inbound memory regions.
> > +- interrupts: two interrupt sources for MSI interrupts, followed by 
interrupt
> > +   source for hardware related interrupts (e.g. link speed change).
> > +- #interrupt-cells: set to <1>
> > +- interrupt-map-mask and interrupt-map: standard PCI properties
> > +   to define the mapping of the PCIe interface to interrupt
> > +   numbers.
> > +- clocks: from common clock binding: phandles to PCIe controller and 
PCIe bus
> > +   clocks.
> 
>     I told it's not only phandles (e.g. &mstp3_clks) but the clock 
specifiers.
Ah, yes you did.

Thanks
Phil
