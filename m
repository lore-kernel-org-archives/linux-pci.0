Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5606171A.5000609@kernel.org>
References: <1442801587-3812-1-git-send-email-lftan@altera.com>
	<1442801587-3812-6-git-send-email-lftan@altera.com>
	<5606171A.5000609@kernel.org>
Date: Mon, 28 Sep 2015 13:38:39 +0800
Message-ID: <CAFiDJ59PuhRj3F288A_451pLiKnqPUKin9C2t5uuH2iNPnJfAg@mail.gmail.com>
Subject: Re: [PATCH v7 5/6] Documentation: dt-bindings: pci: altera pcie
 device tree binding
From: Ley Foon Tan <lftan@altera.com>
To: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Russell King <linux@arm.linux.org.uk>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Dinh Nguyen <dinguyen@opensource.altera.com>,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, Sep 26, 2015 at 11:55 AM, Rob Herring <robh@kernel.org> wrote:
>
> On 09/20/2015 09:13 PM, Ley Foon Tan wrote:
> > This patch adds the bindings for Altera PCIe host controller driver and
> > Altera PCIe MSI driver.
> >
> > Signed-off-by: Ley Foon Tan <lftan@altera.com>
> > ---
> >  .../devicetree/bindings/pci/altera-pcie-msi.txt    | 28 +++++++++++++
> >  .../devicetree/bindings/pci/altera-pcie.txt        | 49 ++++++++++++++++++++++
> >  2 files changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> >  create mode 100644 Documentation/devicetree/bindings/pci/altera-pcie.txt
> >
> > diff --git a/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> > new file mode 100644
> > index 0000000..53ad2388
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
> > @@ -0,0 +1,28 @@
> > +* Altera PCIe MSI controller
> > +
> > +Required properties:
> > +- compatible:        should contain "altr,msi-1.0"
> > +- reg:               specifies the physical base address of the controller and
> > +             the length of the memory mapped region.
> > +- reg-names: must include the following entries:
> > +             "csr": CSR registers
> > +             "vector_slave": vectors slave port region
> > +- interrupt-parent:  interrupt source phandle.
> > +- interrupts:        specifies the interrupt source of the parent interrupt
> > +             controller. The format of the interrupt specifier depends on the
> > +             parent interrupt controller.
> > +- num-vectors:       number of vectors, range 1 to 32.
> > +- msi-controller:    indicates that this is MSI controller node
> > +
> > +
> > +Example
> > +msi0: msi@0xFF200000 {
> > +     compatible = "altr,msi-1.0";
> > +     reg = <0xFF200000 0x00000010
> > +             0xFF200010 0x00000080>;
> > +     reg-names = "csr", "vector_slave";
> > +     interrupt-parent = <&hps_0_arm_gic_0>;
> > +     interrupts = <0 42 4>;
> > +     msi-controller = <1>;
>
> This should not have a value.
Okay.

>
> > +     num-vectors = <32>;
> > +};
> > diff --git a/Documentation/devicetree/bindings/pci/altera-pcie.txt b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> > new file mode 100644
> > index 0000000..4440db1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/altera-pcie.txt
> > @@ -0,0 +1,49 @@
> > +* Altera PCIe controller
> > +
> > +Required properties:
> > +- compatible :       should contain "altr,pcie-root-port-1.0"
> > +- reg:               a list of physical base address and length for TXS and CRA.
> > +- reg-names: must include the following entries:
> > +             "Txs" or "txs": TX slave port region
> > +             "Cra" or "cra": Control register access region
>
> Why both cases? Can we please just have one (or none is better IMO).
The PCIe IP on different device families use different register names.
And our device tree generator will auto generate the register names
based on the hardware description name. Too bad we can't change the
hardware description names now.
>
> txs contains the config space?
It is not the config space, but a memory slave port.

>
> > +- interrupt-parent:  interrupt source phandle.
> > +- interrupts:        specifies the interrupt source of the parent interrupt controller.
> > +             The format of the interrupt specifier depends on the parent interrupt
> > +             controller.
> > +- device_type:       must be "pci"
> > +- #address-cells:    set to <3>
> > +- #size-cells:       set to <2>
> > +- #interrupt-cells:  set to <1>
> > +- ranges:            describes the translation of addresses for root ports and standard
> > +             PCI regions.
> > +- interrupt-map-mask and interrupt-map: standard PCI properties to define the
> > +             mapping of the PCIe interface to interrupt numbers.
> > +
> > +Optional properties:
> > +- msi-parent:        Link to the hardware entity that serves as the MSI controller for this PCIe
> > +             controller.
> > +- bus-range: PCI bus numbers covered
> > +
> > +Example
> > +     pcie_0: pcie@0xc00000000 {
> > +             compatible = "altr,pcie-root-port-1.0";
> > +             reg = <0xc0000000 0x20000000>,
> > +                     <0xff220000 0x00004000>;
> > +             reg-names = "Txs", "Cra";
> > +             interrupt-parent = <&hps_0_arm_gic_0>;
> > +             interrupts = <0 40 4>;
> > +             interrupt-controller;
> > +             #interrupt-cells = <1>;
> > +             bus-range = <0x0 0xFF>;
> > +             device_type = "pci";
> > +             msi-parent = <&msi_to_gic_gen_0>;
> > +             #address-cells = <3>;
> > +             #size-cells = <2>;
> > +             interrupt-map-mask = <0 0 0 7>;
> > +             interrupt-map = <0 0 0 1 &pcie_0 1>,
> > +                                 <0 0 0 2 &pcie_0 2>,
> > +                                 <0 0 0 3 &pcie_0 3>,
> > +                                 <0 0 0 4 &pcie_0 4>;
> > +             ranges = <0x82000000 0x00000000 0x00000000 0xc0000000 0x00000000 0x10000000
> > +                         0x82000000 0x00000000 0x10000000 0xd0000000 0x00000000 0x10000000>;
> > +     };
> >
>
