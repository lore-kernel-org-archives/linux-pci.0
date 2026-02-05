Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AABE86337;
	Thu,  5 Feb 2026 05:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770268580; cv=none; b=oqWdsvjjuq9Ovltu8Hl7ubTcx6qBZWQ9CYgRBXQoIGDbJ4xZb8kav/YdGdJ8I808wa1sVgya2rGGyA1tAJSbYmgcyKx79WyJgVS/7AoywNhkaeQ1GGUOsRgMj5PClD7jXSeE61mtjLFMV5T66xEciEsJY/U/SdOZj9+8ITvtW0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770268580; c=relaxed/simple;
	bh=bR9nFFmoAcRxZbvaDn5cDBKQP/mLOJ9Ye3HOlNHSsQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKLeVoypixBHuu0GaI6zj3pWnu2H/Iu8GW20Go212K1Xg1CaZSAGZLz8OFN9fav0QeJ40nR08nQfzy9/aDur7k61c/kfy0qw3QhkzlhStiS3SzfJfFDV7ePJPVIVVy78ymOxQ5HW1d+t12TmCY5BQG5fD2z7HioCuiltt/xMRFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGBw83VG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGBw83VG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3480C4CEF7;
	Thu,  5 Feb 2026 05:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770268579;
	bh=bR9nFFmoAcRxZbvaDn5cDBKQP/mLOJ9Ye3HOlNHSsQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGBw83VG9CxtDL5FKwi7AXjuQCKUyso9mkUCsz28XbEEAlr+oaV6PJPcz93nC2G/R
	 S5diu8cEroZX8aAHHR9QssKfxzKYr/4eHKgNC7wskplxAa7baKhj+PhHde0+8OGEcP
	 l4Gt2IDT3XUFkzQD4pW2TUjIRuRXJ5TWQDt0o/mHy1nmOt7MrGAKpXNM/nI26v5atd
	 axsL3FUSK0a2osM/HutZHpffi8cUeOFWHNWdo5jS/+/Un2OzbUky41ehda3ppH8jdv
	 U5ixAZ8/N/M5pPj2zOphpHO878H8ibWL5eJ/Y252Sjx25sfQRck6V5KHNqbiDI/1n2
	 460GLdajG85HQ==
Date: Thu, 5 Feb 2026 10:46:05 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Sherry Sun <sherry.sun@nxp.com>, Hongxing Zhu <hongxing.zhu@nxp.com>, 
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
Message-ID: <xx6hhc66xwlr2qmhhm625cocmdng35a2h5vochzrg3gxb5f6tt@465qo5ugahfg>
References: <20260203015614.2957479-1-sherry.sun@nxp.com>
 <20260203015614.2957479-4-sherry.sun@nxp.com>
 <mp25jwvoimpesfwtpmyeltdpbu7aznahxvkcn6jxg5jqzxck4i@pium66rnpdd3>
 <VI0PR04MB12114DBBE58AB89BEEDC28C019298A@VI0PR04MB12114.eurprd04.prod.outlook.com>
 <gshz5zc7qkfkqkla2mkpu7jjf3sctrqf5jo5vszzgxzpegxzni@yhdqkykyn2ar>
 <aYNkDWt89b26wJWf@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aYNkDWt89b26wJWf@lizhi-Precision-Tower-5810>

On Wed, Feb 04, 2026 at 10:21:49AM -0500, Frank Li wrote:
> On Wed, Feb 04, 2026 at 06:03:55PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Feb 04, 2026 at 06:44:07AM +0000, Sherry Sun wrote:
> > > > On Tue, Feb 03, 2026 at 09:56:07AM +0800, Sherry Sun wrote:
> > > > > Since describing the PCIe PERST# property under Host Bridge node is
> > > > > now deprecated, it is recommended to add it to the Root Port node, so
> > > > > creating the Root Port node and add the reset-gpios property in Root
> > > > > Port.
> > > > >
> > > > > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > > > > ---
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> > > > >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
> > > > >  3 files changed, 21 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > index ba29720e3f72..fe9046c03ddd 100644
> > > > > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > > > > @@ -754,11 +754,16 @@ lvds0_out: endpoint {  &pcie {
> > > > >  	pinctrl-names = "default";
> > > > >  	pinctrl-0 = <&pinctrl_pcie>;
> > > > > +	/* This property is deprecated, use reset-gpios from the Root Port
> > > > > +node. */
> > > > >  	reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> > > >
> > > > You should just remove this property.
> > >
> > > Hi Manivannan,
> > >
> > > Actually I have discussed with Frank about this in V1, Frank suggested add
> > > comments here instead of removing the old property, just in case the dts
> > > used by old kernel to avoid function break. Or maybe we can at least keep it
> > > for some kernel release, then remove it later.
> > >
> >
> > If the new DT breaks the old kernel, then the kernel needs to be upgraded. But
> > typically, one would update both kernel + DT or just the kernel, not just DT.
> 
> But it should not impact bisect. Driver and dts is not in branch. If driver
> applied ahead of dts patch, it should be fine to remove it. But default
> linux-next can't guaratee the merge order.
>

There is no need to worry about the bisectability in linux-next. You should only
worry about mainline. So if you ensure that both the driver and DTS gets into
the same release or even if the driver gets in first and DTS later, you are
good.
 
> To avoid merge complex, keep it for a whole, then clean up it later.

There is no complexity. We do this all the time. If you add a comment like this,
then you need to remember to delete it later, which unfortunately won't happen
all the time for us humans :)

- Mani

-- 
மணிவண்ணன் சதாசிவம்
