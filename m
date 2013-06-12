Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:55003 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478Ab3FLC7Y (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 11 Jun 2013 22:59:24 -0400
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	devicetree-discuss@lists.ozlabs.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	linux-pci@vger.kernel.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Andrew Murray' <andrew.murray@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Jingoo Han <jg1.han@samsung.com>
References: <000d01ce6360$9504e7e0$bf0eb7a0$@samsung.com>
 <36071399.7aY6jgGn2d@wuerfel>
In-reply-to: <36071399.7aY6jgGn2d@wuerfel>
Subject: Re: [PATCH V3 1/3] Add PCIe driver for Samsung Exynos
Date: Wed, 12 Jun 2013 11:59:21 +0900
Message-id: <002401ce6718$d6bbc8f0$84335ad0$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, June 07, 2013 7:53 PM, Arnd Bergmann wrote:
> On Friday 07 June 2013 18:22:50 Jingoo Han wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> > new file mode 100644
> > index 0000000..3eb4a2d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/exynos-pcie.txt
> > @@ -0,0 +1,56 @@
> > +* Samsung Exynos PCIe interface
> > +
> > +Required properties:
> > +-compatible: should be "samsung,exynos5440-pcie"
> > +-reg: base addresses and lengths of the pcie conteroller,
> > +	additional register for the pcie controller,
> > +	the phy controller,
> > +	additional register for the phy controller.
> > +- interrupts: interrupt values for level interrupt,
> > +	pulse interrupt, special interrupt.
> > +- device_type, set to "pci"
> > +- bus-range: PCI bus numbers covered
> 
> Why is it that only a subset of bus numbers are used? Can't you address
> the entire range?

I will remove 'bus-range' property from DT.

> 
> > +- ranges: ranges for the PCI memory and I/O regions
> > +- reset-gpio: gpio pin number of power good signal
> 
> The 'reset-gpio' property seems incorrect. I think this should either
> use the gpio binding or the reset-controller binding. Specifying
> bare numbers to use as gpio pins does not work, since the number
> space for Linux internal gpio numbers is not necessarily the same
> as used by the hardware.

As you mentioned, other Exynos SoCs such as Exynos5250 set
GPIO properties in DT, as below:
(./arch/arm/boot/dts/exynos5250-smdk5250.dts)
	hdmi {
		hpd-gpio = <&gpx3 7 0>;
	};
	usb@12110000 {
		samsung,vbus-gpio = <&gpx2 6 0>;
	};

However, the situation of Exynos5440 GPIO is different.
The following bare numbers of GPIO work properly on Exynos5440.
(./arch/arm/boot/dts/exynos5440-ssdk5440.dts)
	pcie0@40000000 {
		reset-gpio = <5>;
	}
	pcie0@40000000 {
		reset-gpio = <22>;
	}

Thomas Abraham is the author of pinctrl driver for EXYNOS5440.
(./drivers/pinctrl/pinctrl-exynos5440.c)

Thomas Abraham or Kukjin Kim, can you confirm this?
If I am wrong, please let me know kindly. :)


> 
> I think you also need an interrupt-map property as mandated by
> the PCI binding, in order to use legacy interrupts, as well as
> #address-cells and #size-cells.
> 
> > +       pcie0@40000000 {
> > +               compatible = "samsung,exynos5440-pcie";
> > +               reg = <0x40000000 0x4000
> > +                       0x290000 0x1000
> > +                       0x270000 0x1000
> > +                       0x271000 0x40>;
> > +               interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > +               device_type = "pci";
> > +               bus-range = <0x0 0xf>;
> > +               ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> > +                         0x81000000 0 0          0x40200000 0 0x00004000   /* downstream I/O */
> > +                         0x82000000 0 0          0x40204000 0 0x10000000>; /* non-prefetchable memory */
> > +       };
> > +
> > +       pcie1@60000000 {
> > +               compatible = "samsung,exynos5440-pcie";
> > +               reg = <0x60000000 0x4000
> > +                       0x2a0000 0x1000
> > +                       0x272000 0x1000
> > +                       0x271040 0x40>;
> > +               interrupts = <0 23 0>, <0 24 0>, <0 25 0>;
> > +               device_type = "pci";
> > +               bus-range = <0x0 0xf>;
> > +               ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00200000   /* configuration space */
> > +                         0x81000000 0 0          0x60200000 0 0x00004000   /* downstream I/O */
> > +                         0x82000000 0 0          0x60204000 0 0x10000000>; /* non-prefetchable memory */
> > +       };
> 
> Is it intentional that in this example you set up both buses to
> have both memory and I/O space start at address 0 in bus space?

No, it is not intentional.
I will fix it.

> 
> I think it would be more logical to have non-overlapping addresses.
> You can also choose to have an identity mapping for memory
> space where a PCI bus address maps directly to the physical address
> used to access it, although that will prevent you from using legacy
> VGA cards that require the use of the low 16 MB.
> 
> Using a 16kb I/O space rather than a 64KB I/O space per port will
> lead to pci_ioremap_io() map the start of your memory space into
> PCI_IO_VIRT_BASE, which you probably didn't intend.
> 
> If your hardware cannot handle a full 64KB window, I would recommend
> to at least leave a hole before the start of the memory window.

OK, I see.
I will fix both MEM space and I/O space.

> 
> > +struct pcie_port {
> > +	struct device		*dev;
> > +	u8			controller;
> > +	u8			root_bus_nr;
> > +	void __iomem		*dbi_base;
> > +	void __iomem		*va_dbi_base;
> > +	void __iomem		*elbi_base;
> > +	void __iomem		*va_elbi_base;
> > +	void __iomem		*base;
> > +	void __iomem		*phy_base;
> > +	void __iomem		*va_phy_base;
> > +	void __iomem		*purple_base;
> > +	void __iomem		*va_purple_base;
> > +	void __iomem		*cfg0_base;
> > +	void __iomem		*va_cfg0_base;
> > +	void __iomem		*cfg1_base;
> > +	void __iomem		*va_cfg1_base;
> > +	void __iomem		*io_base;
> > +	void __iomem		*mem_base;
> > +	spinlock_t		conf_lock;
> > +	struct resource		io;
> > +	struct resource		mem;
> > +	struct resource		busn;
> 
> A lot of the fields above appear to be duplicated. If you
> pass a physical address, that needs to be a phys_addr_t,
> not void __iomem*. I think most of the physical addresses
> can be removed there, and you just keep the virtual addresses
> but drop the va_ prefix.

OK, I see.
I will use the 'phys_addr_t' and remove redundant physical
addresses.

> 
> > +static int add_pcie_port(struct pcie_port *pp, struct platform_device *pdev)
> > +{
> > +	struct resource *dbi_base;
> > +	struct resource *elbi_base;
> > +	struct resource *phy_base;
> > +	struct resource *purple_base;
> > +	int ret;
> > +
> > +	dbi_base = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	if (!dbi_base) {
> > +		dev_err(&pdev->dev, "couldn't get dbi base resource\n");
> > +		return -EINVAL;
> > +	}
> > +	if (!devm_request_mem_region(&pdev->dev, dbi_base->start,
> > +				resource_size(dbi_base), pdev->name)) {
> > +		dev_err(&pdev->dev, "dbi base resource is busy\n");
> > +		return -EBUSY;
> > +	}
> > +	pp->dbi_base = (void __iomem *) (unsigned long)dbi_base->start;
> 
> That will also let you get rid of the casts here.

Yes, I will remove unnecessary casts.

> 
> 
> > +static int __exit exynos_pcie_remove(struct platform_device *pdev)
> > +{
> > +	return 0;
> > +}
> > +
> 
> an empty 'remove' function seems incorrect. I don't know what a
> removable PCI should be doing here, but at least you need to undo
> everything you set up in the probe function.

I will remove the empty 'remove' function.

Thank you for your comments. :)
I will fix it and send v4 patch, soon.


Best regards,
Jingoo Han

> 
> 
> 	Arnd

