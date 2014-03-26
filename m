Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from relmlor4.renesas.com ([210.160.252.174]:47764 "EHLO
	relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751130AbaCZJM2 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 26 Mar 2014 05:12:28 -0400
In-Reply-To: <5331E576.2000202@cogentembedded.com>
References: <1395766604-30926-1-git-send-email-phil.edworthy@renesas.com> <1395766604-30926-6-git-send-email-phil.edworthy@renesas.com> <5331E576.2000202@cogentembedded.com>
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
Message-ID: <OF926D4427.71CAF95D-ON80257CA7.00321EAE-80257CA7.0032919D@eu.necel.com>
Date: Wed, 26 Mar 2014 09:12:22 +0000
Subject: Re: [PATCH v5 5/9] dt-bindings: pci: rcar pcie device tree bindings
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Sergei,

On: 25/03/2014 19:22, Sergei wrote:
> Subject: Re: [PATCH v5 5/9] dt-bindings: pci: rcar pcie device tree 
bindings
> 
> Hello.
> 
> On 03/25/2014 07:56 PM, Phil Edworthy wrote:
> 
> > This patch adds the bindings for the R-Car PCIe driver. The driver
> > resides under drivers/pci/host/pcie-rcar.c
> 
> > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> > ---
> > v5:
> >   - Add PCIe bus clock reference
> >   - Add additional interrupt bindings
> >   - Use dma-ranges property to specify inbound memory regions
> > ---
> >   Documentation/devicetree/bindings/pci/rcar-pci.txt | 44 
++++++++++++++++++++++
> >   1 file changed, 44 insertions(+)
> >   create mode 100644 
Documentation/devicetree/bindings/pci/rcar-pci.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/rcar-pci.txt b/
> Documentation/devicetree/bindings/pci/rcar-pci.txt
> > new file mode 100644
> > index 0000000..61bf5ef
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/rcar-pci.txt
> > @@ -0,0 +1,44 @@
> > +* Renesas RCar PCIe interface
> > +
> > +Required properties:
> > +- compatible: should contain one of the following
> > +   "renesas,pcie-r8a7779", "renesas,pcie-r8a7790", 
"renesas,pcie-r8a7791"
> > +- reg: base addresses and lengths of the pcie controller.
> 
>     Hmm, need "registers" at end. And why plural?
Ok, & yes it should be singular.


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
> > +- clocks: from common clock binding: handle to pci clock.
> 
>     s/handle/phandle/, s/pci/PCI/.
>     Actually, it's a clock specifier consisting not only of phandle but 
also 
> of clock #. Looking at your example, it's even a pair of clock 
specifiers.
Right, and yes it's two clocks - I missed that when adding the PCI bus 
clock.

 
> > +- clock-names: from common clock binding: should be "pcie" and 
"pcie_bus".
> > +
> > +Example:
> > +
> > +SoC specific DT Entry:
> > +
> > +   pcie: pcie@fe000000 {
> > +      compatible = "renesas,pcie-r8a7791";
> > +      reg = <0 0xfe000000 0 0x80000>;
> > +      #address-cells = <3>;
> > +      #size-cells = <2>;
> > +      device_type = "pci";
> > +      ranges = <0x01000000 0 0x00000000 0 0xfe100000 0 0x00100000
> > +           0x02000000 0 0xfe200000 0 0xfe200000 0 0x00200000
> > +           0x02000000 0 0x30000000 0 0x30000000 0 0x08000000
> > +           0x42000000 0 0x38000000 0 0x38000000 0 0x08000000>;
> > +      dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 0 0x40000000
> > +               0x42000000 2 0x00000000 2 0x00000000 0 0x40000000>;
> 
>     Hmm, this prop looks board-dependent...
Initially I thought that it would be board dependent and map the actual 
DDR available. However, I then considered that it is probably ok to map 
all possible DDR ranges that the device is capable of using. I'm ok with 
either approach though...


> > +      interrupts = <0 116 4 0 117 4 0 118 4>;
> > +      #interrupt-cells = <1>;
> > +      interrupt-map-mask = <0 0 0 0>;
> > +      interrupt-map = <0 0 0 0 &gic 0 116 4>;
> > +      clocks = <&mstp3_clks R8A7791_CLK_PCIE>, <&pcie_bus_clk>;
> > +      clock-names = "pcie", "pcie_bus";
> > +      status = "disabled";
> > +   };
> 
> WBR, Sergei
> 

Thanks
Phil
