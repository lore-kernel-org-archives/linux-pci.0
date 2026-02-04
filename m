Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FB519D081;
	Wed,  4 Feb 2026 12:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770208452; cv=none; b=K7xUWjBZx5+E+1PCRZ228sXu3pWVqWbW+0SiFfjuXum+CQoxNQN7+Q0YpOnolhsD7ybii8Hw6kztM1dzYtLCpxBHd8GCEQ/4Lw6jAUjTh0hdlK5+T3BsCpmE4m9zw2m3TESu7jQliB3K+HGYTX8XAHKNXygEfTquwY4Py2lZw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770208452; c=relaxed/simple;
	bh=AHCivJDP5GD4OkZ5utB49/t1kFWdOSJ8prtPUFvZDG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMPxwFH3d4maIaUzQoqDblWqDMRKEzDCRIBHQ99yZtYO+N8pfzLwbEwLBbi/wu01LeO0MYGl3jsz4okKTo+LAc+yJ3KQjX1p23/DeraAxoHx2bHqhP55nUV7aTaQy3xU7W23DlI7FJyTW24TopytL0+5WKJC0YMt347ZYtsXVFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KiToyLjj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KiToyLjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46458C4CEF7;
	Wed,  4 Feb 2026 12:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770208451;
	bh=AHCivJDP5GD4OkZ5utB49/t1kFWdOSJ8prtPUFvZDG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KiToyLjjCR1nTGa50S+wkB8PvJazj2qYOSlcD/TRBD0REFefCrv0GR/ITEIQWBBKr
	 ZTMgraWW5tzNmc6J84Kbctoen0pRB/76UckTZ3Y8sWjIaeOO/sEx84pKV1tBeOJibd
	 VnMHyLqxHktn+OetUF07woScFMr9Fd1gPJjQDp1lLiNq4Sodx5s2nvjE2d+NsGDl6x
	 F8WP1Dj1nDwYgoYn3e1bJJ/NuBw/j5uNFIQP3Jy+ZeJ0sa0dBdj6QWr6F0WPNHai7N
	 sMIuECPEIE++t78svtxJ9mK27FhxbdcDbuncQ5yU/wz8WJq44Ag8bJ8maSjFazkq8z
	 JSjYzFdXEMF1g==
Date: Wed, 4 Feb 2026 18:03:55 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Frank Li <frank.li@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"festevam@gmail.com" <festevam@gmail.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V3 03/10] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Message-ID: <gshz5zc7qkfkqkla2mkpu7jjf3sctrqf5jo5vszzgxzpegxzni@yhdqkykyn2ar>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-4-sherry.sun@nxp.com>
 <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
 <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>

On Wed, Feb 04, 2026 at 06:44:07AM +0000, Sherry Sun wrote:
> > On Tue, Feb 03, 2026 at 09:56:07AM +0800, Sherry Sun wrote:
> > > Since describing the PCIe PERST# property under Host Bridge node is
> > > now deprecated, it is recommended to add it to the Root Port node, so
> > > creating the Root Port node and add the reset-gpios property in Root
> > > Port.
> > >
> > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > ---
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
> > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
> > >  3 files changed, 21 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > index ba29720e3f72..fe9046c03ddd 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > @@ -754,11 +754,16 @@ lvds0_out: endpoint {  &pcie {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_pcie>;
> > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > +node. */
> > >  	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> > 
> > You should just remove this property.
> 
> Hi Manivannan,
> 
> Actually I have discussed with Frank about this in V1, Frank suggested add
> comments here instead of removing the old property, just in case the dts
> used by old kernel to avoid function break. Or maybe we can at least keep it
> for some kernel release, then remove it later.
> 

If the new DT breaks the old kernel, then the kernel needs to be upgraded. But
typically, one would update both kernel + DT or just the kernel, not just DT.

- Mani

> Best Regards
> Sherry
> > 
> > >  	vpcie-supply = <&reg_pcie>;
> > >  	status = "okay";
> > >  };
> > >
> > > +&pcie_port0 {
> > > +	reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>; };
> > > +
> > >  &pwm1 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&pinctrl_pwm1>;
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > index 76e6043e1f91..eeb376193398 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi
> > > @@ -289,6 +289,17 @@ pcie: pcie@1ffc000 {
> > >  				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
> > >  			clock-names = "pcie", "pcie_bus", "pcie_phy";
> > >  			status = "disabled";
> > > +
> > > +			pcie_port0: pcie@0 {
> > > +				compatible = "pciclass,0604";
> > > +				device_type = "pci";
> > > +				reg = <0x0 0x0 0x0 0x0 0x0>;
> > > +				bus-range = <0x01 0xff>;
> > > +
> > > +				#address-cells = <3>;
> > > +				#size-cells = <2>;
> > > +				ranges;
> > > +			};
> > >  		};
> > >
> > >  		aips1: bus@2000000 { /* AIPS1 */
> > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > index c5b220aeaefd..6b12cab7175f 100644
> > > --- a/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts
> > > @@ -45,10 +45,15 @@ MX6QDL_PAD_GPIO_6__ENET_IRQ
> > 	0x000b1
> > >  };
> > >
> > >  &pcie {
> > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > +node. */
> > >  	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
> > >  	status = "okay";
> > >  };
> > >
> > > +&pcie_port0 {
> > > +	reset-gpios = <&max7310_c 5 GPIO_ACTIVE_LOW>; };
> > > +
> > >  &sata {
> > >  	status = "okay";
> > >  };
> > > --
> > > 2.37.1
> > >
> > 
> > --
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
