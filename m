Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8353314B96;
	Thu, 30 Jul 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395807; cv=none; b=YnarNTThOmOxZZk3hQpwVmaLwmBkA4rQBj1eHoWkzNVs5rcyn+rQVleJMVTJ8i1RqXJZISVeqB09NnjkBNUlcMg8JyTzPxZ7bUcGe510s1uhZrCbhXIB4NQSb392vmkJ5OUc/CgZfUHH/rbv8hMGANwkp+ucsd3q3/7ooFgB1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395807; c=relaxed/simple;
	bh=f0eucltI/WtcPpjuQYOMeNxyzKb4Hiu6YdC2ZkIf490=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9QfJokWKLbZBg1hFDg65TwcSuGAYUQFzoFV8ZduNGaPI206E958X7FnJEcX7tmN4ME9Q8kycjZsfunePneJopH5U0Gh3qtuDXFTERUxWvQ+t/nciQYQYFda2pyhWpsy9l2OczCxykfrtyiilUQ8Qb/IjWRSWl6h/EfErw27C1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aa0hUTrf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aa0hUTrf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D001F000E9;
	Thu, 30 Jul 2026 07:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785395805;
	bh=BtGPFV1kYoFZTFrLy90gnVl2h+XGluzuHcWVMW3IwCM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Aa0hUTrfug4tvPnKLC6dFH0seh0KgiZtNrvXKFSgZGpCkY7DZhM0vD26dekNyJAwL
	 bGY3NmCHgW5dxgMWepf0bffNF6fStuFOCsUmNAmO3bWG24u662Lx7pv0WJgS62v9XG
	 xtj4Z3UrNo6MXke36YLMISly2FeaW3lna3RYA7VMe2aI1v9gXkAHFl6OdaZ1vkGVnv
	 YW4eOpZ7JJ90yBKIuaQV6FDLb811zi3K/iG6rLDyZ+yBv8OJpFKYaqjQNuyuUZ16BA
	 2JpMv9QAu7Jre+P2D9QDnrq1NLF475N89vv7wvXHz3wCMsVN5V2vf82eA44ifsSOt9
	 X49eld/w9/DLA==
Date: Thu, 30 Jul 2026 09:16:35 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Hongxing Zhu (OSS)" <hongxing.zhu@oss.nxp.com>
Cc: Frank Li <frank.li@nxp.com>, 
	"l.stach@pengutronix.de" <l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org" <robh@kernel.org>, 
	"bhelgaas@google.com" <bhelgaas@google.com>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hongxing Zhu <hongxing.zhu@nxp.com>
Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Message-ID: <eugppi6xnusn27qgbcqfe4kwpj4euvwi5lhwniy56rnz7ep3qa@lxiumyyrgl2p>
References: <20260714024107.4113926-1-hongxing.zhu@oss.nxp.com>
 <jtpctss4hz3djqd4ukq634ujfk5jdud6c6r6apgo2syrsubqz2@jivsombtim3v>
 <GV2PR04MB120191536F2B3F4B093719D418CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <GV2PR04MB120191536F2B3F4B093719D418CC92@GV2PR04MB12019.eurprd04.prod.outlook.com>

On Thu, Jul 30, 2026 at 07:07:58AM +0000, Hongxing Zhu (OSS) wrote:
> > -----Original Message-----
> > From: Manivannan Sadhasivam <mani@kernel.org>
> > Sent: Wednesday, July 29, 2026 9:58 PM
> > To: Hongxing Zhu (OSS) <hongxing.zhu@oss.nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>; l.stach@pengutronix.de; lpieralisi@kernel.org;
> > kwilczynski@kernel.org; robh@kernel.org; bhelgaas@google.com;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com; linux-
> > pci@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.linux.dev;
> > linux-kernel@vger.kernel.org; Hongxing Zhu <hongxing.zhu@nxp.com>
> > Subject: Re: [PATCH v3] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
> > Gen3 PCIe stability
> > 
> > On Tue, Jul 14, 2026 at 10:41:07AM +0800, hongxing.zhu@oss.nxp.com wrote:
> > > From: Richard Zhu <hongxing.zhu@nxp.com>
> > >
> > > Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> > > the default MPLLB_BANDWIDTH value. This margin degradation worsens
> > > across voltage and temperature (VT) variations and different test
> > > matrices, potentially causing link stability issues.
> > >
> > > Testing with MPLLB_BANDWIDTH value of 140 (0x8c) shows significant
> > > improvement in bandwidth margins across all VT conditions and test
> > > scenarios.
> > >
> > > Implement PHY register write helper function and configure:
> > > - MPLLB_BW_OVRD_IN = 140 (0x8c) for improved bandwidth margin
> > > - MPLLB_BW_OVRD_EN to enable the override
> > >
> > > This ensures robust PCIe Gen3 performance across all operating
> > > conditions.
> > >
> > > Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> > > ---
> > > Changes in v3:
> > > Regarding Frank's comments, refine naming consistency and clarity.
> > >
> > > Changes in v2:
> > > Update the register name and bit definitions.
> > > Don't move IMX95_PCIE_PHY_CR_PARA_SEL settings.
> > > ---
> > >  drivers/pci/controller/dwc/pci-imx6.c | 26 ++++++++++++++++++++++++++
> > >  1 file changed, 26 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/dwc/pci-imx6.c
> > > b/drivers/pci/controller/dwc/pci-imx6.c
> > > index 53f3da6ab30d5..fadf14de10f7c 100644
> > > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > > @@ -80,6 +80,17 @@
> > >  #define IMX95_SID_MASK				GENMASK(5, 0)
> > >  #define IMX95_MAX_LUT				32
> > >
> > > +#define IMX95_PCIE_PHY_REG_ADDR			0x3008
> > > +#define IMX95_PCIE_PHY_REG_EN			BIT(31)
> > > +#define IMX95_PCIE_PHY_REG_ADDR_MASK		GENMASK(15, 0)
> > > +#define IMX95_PCIE_PHY_REG_DATA			0x300c
> > > +#define IMX95_PCIE_PHY_MPLLB_OVRD_IN		0x2004
> > > +/* BIT(10): Override enable for mpllb_bandwidth[15:0] */
> > > +#define IMX95_PCIE_PHY_MPLLB_OVRD_BW_EN		0x400
> > 
> > Use BIT(10) please.
> Okay, will change to BIT(10).
> 
> > 
> > > +/* Register offset: Override value for mpllb_bandwidth[15:0] */
> > > +#define IMX95_PCIE_PHY_MPLLB_BW_IN		0x2005
> > > +#define IMX95_PCIE_PHY_MPLLB_BW_VAL		0x8c
> > 
> > Is it possible to define individual bits?
> > 
> This is a 16-bit bandwidth value (140 decimal = 0x8c) recommended by the IC
> designers. It appears to be a complete value rather than a bit field, but
> please let me know if you'd prefer a different representation.
> 

Fine then.

> > > +
> > >  #define IMX95_PCIE_RST_CTRL			0x3010
> > >  #define IMX95_PCIE_COLD_RST			BIT(0)
> > >
> > > @@ -269,6 +280,16 @@ static int imx95_pcie_select_ref_clk_src(struct
> > imx_pcie *imx_pcie)
> > >  	return 0;
> > >  }
> > >
> > > +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr,
> > > +u16 data) {
> > > +	udelay(200);
> > 
> > Why is this delay at the start of this function?
> A proper delay is required between the assertion of IMX95_PCIE_PHY_CR_PARA_SEL
> (in imx95_pcie_init_phy) and each subsequent PHY register write operation.
> Without this delay, the values cannot be successfully written to the PHY
> registers. Placing the delay at the start of the helper function ensures it's
> applied before every PHY write.
> 

Then the delay should be moved to imx95_pcie_init_phy() with a comment.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
