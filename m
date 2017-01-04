Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qt0-f196.google.com ([209.85.216.196]:34479 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935451AbdADSCc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Jan 2017 13:02:32 -0500
From: "Jingoo Han" <jingoohan1@gmail.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>,
        "'Jaehoon Chung'" <jh80.chung@samsung.com>
Cc: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-samsung-soc@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <kgene@kernel.org>,
        <kishon@ti.com>, <vivek.gautam@codeaurora.org>,
        <pankaj.dubey@samsung.com>, <alim.akhtar@samsung.com>,
        <cpgs@samsung.com>
References: <20170104123435.30740-1-jh80.chung@samsung.com> <CGME20170104123436epcas1p10b52f24e7d6c00edb44e4331a1870e4d@epcas1p1.samsung.com> <20170104123435.30740-6-jh80.chung@samsung.com> <20170104175822.5zedyszx2phiehuv@kozik-lap>
In-Reply-To: <20170104175822.5zedyszx2phiehuv@kozik-lap>
Subject: Re: [PATCH V2 5/5] ARM: dts: exynos5440: support the phy-pcie node for pcie
Date: Wed, 4 Jan 2017 13:02:29 -0500
Message-ID: <000001d266b4$b7a27730$26e76590$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wednesday, January 4, 2017 12:58 PM, Krzysztof Kozlowski wrote:
> 
> On Wed, Jan 04, 2017 at 09:34:35PM +0900, Jaehoon Chung wrote:
> > Add phy-pcie node for using Exynos5440 pcie.
> > And use the reg-names as "elbi" and "config".
> 
> 'and' is only for joining in compound sentences, don't start with it.
> 
> > Because the getting configuratioin space address from ranges is old way.
> 
> Spell-check please.
> 
> > It also is helpful to distinguish more clearly.
> 
> Distinguish what? Please work on the commit msg, I am not picking
> >
> > Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> > ---
> > Changelog on V2:
> > - Removes the child-node
> > - Fixes the typo
> > - Removes the unnecessary comments
> >
> >  arch/arm/boot/dts/exynos5440.dtsi | 34 ++++++++++++++++++++++----------
> --
> >  1 file changed, 22 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/exynos5440.dtsi
> b/arch/arm/boot/dts/exynos5440.dtsi
> > index 2a2e570..feb074d 100644
> > --- a/arch/arm/boot/dts/exynos5440.dtsi
> > +++ b/arch/arm/boot/dts/exynos5440.dtsi
> > @@ -290,11 +290,22 @@
> >  		clock-names = "usbhost";
> >  	};
> >
> > +	pcie_phy0: pcie-phy@270000 {
> > +		#phy-cells = <0>;
> > +		compatible = "samsung,exynos5440-pcie-phy";
> > +		reg = <0x270000 0x1000>, <0x271000 0x40>;
> > +	};
> > +
> > +	pcie_phy1: pcie-phy@272000 {
> > +		#phy-cells = <0>;
> > +		compatible = "samsung,exynos5440-pcie-phy";
> > +		reg = <0x272000 0x1000>, <0x271040 0x40>;
> > +	};
> > +
> >  	pcie_0: pcie@290000 {
> >  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
> > -		reg = <0x290000 0x1000
> > -			0x270000 0x1000
> > -			0x271000 0x40>;
> > +		reg = <0x290000 0x1000>, <0x40000000 0x1000>;
> > +		reg-names = "elbi", "config";
> >  		interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -303,9 +314,9 @@
> >  		#address-cells = <3>;
> >  		#size-cells = <2>;
> >  		device_type = "pci";
> > -		ranges = <0x00000800 0 0x40000000 0x40000000 0 0x00001000
> /* configuration space */
> > -			  0x81000000 0 0	  0x40001000 0 0x00010000   /*
> downstream I/O */
> > -			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>; /*
> non-prefetchable memory */
> > +		phys = <&pcie_phy0>;
> > +		ranges = <0x81000000 0 0	  0x40001000 0 0x00010000
> > +			  0x82000000 0 0x40011000 0x40011000 0 0x1ffef000>;
> 
> I think the comments were useful. You can leave them.
> 
> >  		#interrupt-cells = <1>;
> >  		interrupt-map-mask = <0 0 0 0>;
> >  		interrupt-map = <0x0 0 &gic 53>;
> > @@ -315,9 +326,8 @@
> >
> >  	pcie_1: pcie@2a0000 {
> >  		compatible = "samsung,exynos5440-pcie", "snps,dw-pcie";
> > -		reg = <0x2a0000 0x1000
> > -			0x272000 0x1000
> > -			0x271040 0x40>;
> > +		reg = <0x2a0000 0x1000>, <0x60000000 0x1000>;
> > +		reg-names = "elbi", "config";
> >  		interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
> > @@ -326,9 +336,9 @@
> >  		#address-cells = <3>;
> >  		#size-cells = <2>;
> >  		device_type = "pci";
> > -		ranges = <0x00000800 0 0x60000000 0x60000000 0 0x00001000
> /* configuration space */
> > -			  0x81000000 0 0	  0x60001000 0 0x00010000   /*
> downstream I/O */
> > -			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>; /*
> non-prefetchable memory */
> > +		phys = <&pcie_phy1>;
> > +		ranges = <0x81000000 0 0	  0x60001000 0 0x00010000
> > +			  0x82000000 0 0x60011000 0x60011000 0 0x1ffef000>;
> 
> I think the comments were useful. You can leave them.

I think so, too.
Please leave the comments

Best regards,
Jingoo Han

> 
> This looks like depending on the changes in the driver, so I will need a
> tag or stable branch from PCIe maintainers.
> 
> Best regards,
> Krzysztof

