Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from eu1sys200aog122.obsmtp.com ([207.126.144.153]:36903 "EHLO
	eu1sys200aog122.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752447AbaBKEYN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Mon, 10 Feb 2014 23:24:13 -0500
From: Mohit KUMAR DCG <Mohit.KUMAR@st.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pratyush ANAND <pratyush.anand@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Viresh Kumar <viresh.linux@gmail.com>,
	spear-devel <spear-devel@list.st.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Date: Tue, 11 Feb 2014 12:23:58 +0800
Subject: RE: [PATCH V5 7/8] pcie: SPEAr13xx: Add designware pcie support
Message-ID: <2CC2A0A4A178534D93D5159BF3BCB66189FD2CAAA9@EAPEX1MAIL1.st.com>
References: <cover.1391871170.git.pratyush.anand@st.com>
 <5c82e0b022ce6ce9c42afdc9e59081a95a9394ac.1391871170.git.pratyush.anand@st.com>
 <201402101643.23186.arnd@arndb.de>
In-Reply-To: <201402101643.23186.arnd@arndb.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Arnd,

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd@arndb.de]
> Sent: Monday, February 10, 2014 9:13 PM
> To: Mohit KUMAR DCG
> Cc: Pratyush ANAND; Jingoo Han; Viresh Kumar; spear-devel; linux-
> pci@vger.kernel.org
> Subject: Re: [PATCH V5 7/8] pcie: SPEAr13xx: Add designware pcie support
> 
> On Monday 10 February 2014, Mohit Kumar wrote:
> > diff --git a/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
> > b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
> > new file mode 100644
> > index 0000000..dc8ae44
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pci/spear13xx-pcie.txt
> > @@ -0,0 +1,7 @@
> > +Required properties:
> > +- compatible : should be "st,spear1340-pcie", "snps,dw-pcie".
> > +- pcie_is_gen1: pass <1> if forced gen1 initialization is needed to
> > +work with
> > +  some buggy cards else pass <0>.
> 
> Better make this an optional property that is only present if gen1 is forced,
> and then use of_property_read_bool to check it.

- OK

> 
> Also, use the common naming convention: "-" instead of "_", and you may
> want to prefix it with 'st,'.

- OK

> 
> > +- phys		    : phandle to phy node associated with pcie
> controller
> > +- phy-names	    : must be "pcie-phy"
> > +- All other definitions as per generic PCI bindings
> 
> Please send the binding to the devicetree mailing list, ideally as a separate
> patch.

- OK, prepare separate patch for this.

> 
> > diff --git a/arch/arm/boot/dts/spear1310.dtsi
> > b/arch/arm/boot/dts/spear1310.dtsi
> > index 64e7dd5..8d7aefe 100644
> > --- a/arch/arm/boot/dts/spear1310.dtsi
> > +++ b/arch/arm/boot/dts/spear1310.dtsi
> 
> Best split out the DT changes as well, since we may want to apply them
> through the arm-soc tree.

- split in v6.

> 
> > @@ -83,6 +83,63 @@
> >  			status = "disabled";
> >  		};
> >
> > +		pcie0: pcie@b1000000 {
> > +			compatible = "st,spear1340-pcie", "snps,dw-pcie";
> > +			reg = <0xb1000000 0x4000>;
> > +			interrupts = <0 68 0x4>;
> > +			interrupt-map-mask = <0 0 0 0>;
> > +			interrupt-map = <0x0 0 &gic 68>;
> > +			pcie_is_gen1 = <0>;
> > +			num-lanes = <1>;
> > +			phys = <&miphy0 1>;
> > +			phy-names = "pcie-phy";
> > +			#address-cells = <3>;
> > +			#size-cells = <2>;
> > +			device_type = "pci";
> > +			ranges = <0x00000800 0 0x80000000 0x80000000 0
> 0x00020000   /* configuration space */
> > +				0x81000000 0 0	 0x80020000 0 0x00010000   /*
> downstream I/O */
> > +				0x82000000 0 0x80030000 0xc0030000 0
> 0x0ffd0000>; /* non-prefetchable memory */
> > +			status = "disabled";
> > +		};
> 
> But keep the changes for the phy together with the pci changes.

- ok
> 
> > @@ -338,6 +338,7 @@
> >  				reg = <0xe07008c4 0x4>;
> >  				thermal_flags = <0x7000>;
> >  			};
> > +
> >  		};
> >  	};
> >  };
> 
> I assume this change was not intentional.
> 
- :-).

> > diff --git a/arch/arm/configs/spear13xx_defconfig
> > b/arch/arm/configs/spear13xx_defconfig
> > index 1e0bb6f..96ede50 100644
> > --- a/arch/arm/configs/spear13xx_defconfig
> > +++ b/arch/arm/configs/spear13xx_defconfig
> > @@ -11,6 +11,8 @@ CONFIG_ARCH_SPEAR13XX=y
> CONFIG_MACH_SPEAR1310=y
> > CONFIG_MACH_SPEAR1340=y  # CONFIG_SWP_EMULATE is not set
> > +CONFIG_PCI_MSI=y
> > +CONFIG_PCIE_SPEAR13XX=y
> >  CONFIG_SMP=y
> >  # CONFIG_SMP_ON_UP is not set
> >  # CONFIG_ARM_CPU_TOPOLOGY is not set
> 
> This change can also get folded into patch 3.
> 
- ok

> > diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
> > index 7e7f1b0..701b6c3 100644
> > --- a/arch/arm/mach-spear/Kconfig
> > +++ b/arch/arm/mach-spear/Kconfig
> > @@ -28,6 +28,7 @@ config ARCH_SPEAR13XX
> >  	select USE_OF
> >  	select MFD_SYSCON
> >  	select PHY_ST_MIPHY40LP
> > +	select PCI
> >  	help
> >  	  Supports for ARM's SPEAR13XX family
> >
> 
> This doesn't seem right: You are making it impossible to turn off PCI here.
> Better use MIGHT_HAVE_PCI instead to make CONFIG_PCI a user-selectable
> option.
> 
- will replace with MIGHT_HAVE_PCI.

> > diff --git a/drivers/pci/host/Kconfig b/drivers/pci/host/Kconfig index
> > 47d46c6..df52fad 100644
> > --- a/drivers/pci/host/Kconfig
> > +++ b/drivers/pci/host/Kconfig
> > @@ -33,4 +33,9 @@ config PCI_RCAR_GEN2
> >  	  There are 3 internal PCI controllers available with a single
> >  	  built-in EHCI/OHCI host controller present on each one.
> >
> > +config PCIE_SPEAR13XX
> > +	bool "STMicroelectronics SPEAr PCIe controller"
> > +	depends on ARCH_SPEAR13XX
> > +	select PCIEPORTBUS
> > +	select PCIE_DW
> >  endmenu
> 
> This can probably be "tristate" instead of "bool. You need to add a help text.
> 
- ok

> > diff --git a/drivers/pci/host/Makefile b/drivers/pci/host/Makefile
> > index 13fb333..42a491d 100644
> > --- a/drivers/pci/host/Makefile
> > +++ b/drivers/pci/host/Makefile
> > @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
> >  obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
> >  obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
> >  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
> > +obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
> 
> I'd use the "pci" naming instead of "pcie" here for consistency.
> 

- No, let it be pcie as SPEAr13xx soc has pci controller as well , though  PCI is
not used on current eval boards.

> > +
> > +/* SPEAr13xx PCIe driver does not allow module unload */
> > +
> > +static int __init pcie_init(void)
> > +{
> > +
> > +	return platform_driver_probe(&spear13xx_pcie_driver,
> > +				spear13xx_pcie_probe);
> > +}
> 
> This should be platform_driver_register() so you can support deferred
> probing, e.g. if the phy driver gets loaded after the PCI driver.
> 
- ok

Thanks
Mohit
> 	Arnd
