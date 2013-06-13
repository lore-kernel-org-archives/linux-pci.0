Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jingoo Han <jg1.han@samsung.com>
To: 'Arnd Bergmann' <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org
Cc: 'Kukjin Kim' <kgene.kim@samsung.com>,
	'Bjorn Helgaas' <bhelgaas@google.com>,
	'Thomas Petazzoni' <thomas.petazzoni@free-electrons.com>,
	'Jason Gunthorpe' <jgunthorpe@obsidianresearch.com>,
	linux-samsung-soc@vger.kernel.org,
	'Siva Reddy Kallam' <siva.kallam@samsung.com>,
	linux-pci@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	'Thierry Reding' <thierry.reding@avionic-design.de>,
	linux-kernel@vger.kernel.org,
	'Grant Likely' <grant.likely@secretlab.ca>,
	'Surendranath Gurivireddy Balla' <suren.reddy@samsung.com>,
	'Thomas Abraham' <thomas.abraham@linaro.org>,
	'Andrew Murray' <andrew.murray@arm.com>,
	Jingoo Han <jg1.han@samsung.com>
References: <003801ce6756$6578ff80$306afe80$@samsung.com>
 <3532163.SqzZzxO4BR@wuerfel>
In-reply-to: <3532163.SqzZzxO4BR@wuerfel>
Subject: Re: [PATCH V4 3/3] ARM: dts: Add pcie controller node for Samsung
 EXYNOS5440 SoC
Date: Thu, 13 Jun 2013 14:34:14 +0900
Message-id: <003a01ce67f7$a3fc7f60$ebf57e20$@samsung.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, June 12, 2013 7:56 PM, Arnd Bergmann wrote:
> 
> Thanks for the update! A few comments again:
> 
> On Wednesday 12 June 2013 19:20:00 Jingoo Han wrote:
> >
> > diff --git a/arch/arm/boot/dts/exynos5440-ssdk5440.dts b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> > index d55042b..efe7d39 100644
> > --- a/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> > +++ b/arch/arm/boot/dts/exynos5440-ssdk5440.dts
> > @@ -30,4 +30,12 @@
> >                         clock-frequency = <50000000>;
> >                 };
> >         };
> > +
> > +       pcie0@40000000 {
> > +               reset-gpio = <5>;
> > +       };
> > +
> > +       pcie1@60000000 {
> > +               reset-gpio = <22>;
> > +       };
> >  };
> 
> As mentioned before, please use the gpio binding to pass gpio numbers.

OK, I will use gpio binding.

> 
> > diff --git a/arch/arm/boot/dts/exynos5440.dtsi b/arch/arm/boot/dts/exynos5440.dtsi
> > index f6b1c89..2c15f9d 100644
> > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > @@ -216,4 +216,42 @@
> >                 clock-names = "rtc";
> >                 status = "disabled";
> >         };
> > +
> > +       pcie0@0x290000 {
> > +               compatible = "samsung,exynos5440-pcie";
> > +               reg = <0x290000 0x1000
> > +                       0x270000 0x1000
> > +                       0x271000 0x40>;
> > +               interrupts = <0 20 0>, <0 21 0>, <0 22 0>;
> > +               clocks = <&clock 28>, <&clock 27>;
> > +               clock-names = "pcie", "pcie_bus";
> > +               #address-cells = >;
> > +               #size-cells = <2>;
> > +               device_type = "pci";
> > +               ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00200000   /* configuration space */
> > +                         0x81000000 0 0          0x40200000 0 0x00010000   /* downstream I/O */
> > +                         0x82000000 0 0x40210000 0x40210000 0 0x10000000>; /* non-prefetchable memory */
> 
> I think you did not reply to my question regarding the size of the
> memory space. Does it extend from 0x40210000 to 0x50210000,
> or from 0x40210000 to 0x50000000. You probably meant the latter
> but wrote the former. If not, please add a comment for clarification.

OK, I see.
It extends to 0x60000000. I will modify it.

> 
> > +               #interrupt-cells = <1>;
> > +               interrupt-map-mask = <0 0 0 0>;
> > +               interrupt-map = <0x0 0 &gic 53>;
> > +       };
> 
> So all PCI IntA interrupts are mapped to a single gic interrupt? That
> sounds like a bottleneck when you have a lot of devices on the bus.
> Do you have MSI support?

INTA, INTB, INTC, and INTD are mapped to a single gic interrupt.
Exynos5440 PCIe has MSI support; however, MSI support patch will
be posted later.

> 
> 	Arnd

