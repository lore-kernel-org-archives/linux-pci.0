Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E203469F4;
	Mon, 16 Mar 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773639019; cv=none; b=pX5uwWwD30qQAmK1piKkmqDIuukFS9wYqLquy9mB5kzoXYstbaCGMaVg6GcEGDHvv2ML1sCaTKYM4LWzwiEcKPXyZSW7qvciHH1acKqKOb5jkugPIjdY/tMYIVLGQceT933UzA+I1ZSgKuL9/E19wazpnsqc72F8W5f/NU1S6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773639019; c=relaxed/simple;
	bh=8B9fuSdohsuu1CMnw79SUjkL9MjMlLUlCNTDA2w6noo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBdTUIta0eOUHRvtLX00MdoWevG7CGYpFBo4Bjr6kGTNtTgs0w+0DWisrgEv+XHxD8sXcrpmO9z1MCChruceXBLY3MSkg5TvnzcWsDkEjdzON44yObJM7auYBIs74H/PGC88R5HEo6+eCZw/eC0gtU6n80rUoxp1opJ2TXEZckg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kBtsWnDw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kBtsWnDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461E6C19425;
	Mon, 16 Mar 2026 05:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773639019;
	bh=8B9fuSdohsuu1CMnw79SUjkL9MjMlLUlCNTDA2w6noo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kBtsWnDwe7n0y74F0kwuhppOL3Jf1ovoELahhJv2KmO48mrDBsUpOFr6UnwcdDaSD
	 nS0n36nZvPz09OF8iIRxZSHpcJcHGcO2FblGqZsuTt0sUIK+D3ilx+EY5a7CP2fnj2
	 JU1z/PXpSEEHoUzAiW05d/SEqGl8gzn/+idUucciuX8W8tN8p9iogB62tRi4WwQ9jt
	 CyFDY7vdLq8Unov6pUmV/FxGfoYQNvV3rUtVD8GpgsdTLpQ1P/KEY6E3u2AmhyOzHd
	 OqWinSAJ4pHKYAoS+QMXvJUMoMrpnIwsNZMzWafBI2EoejO4Rl0jL3rAe2V9lvHQ9H
	 u+xNRn2dWbq+Q==
Date: Mon, 16 Mar 2026 11:00:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Sherry Sun <sherry.sun@nxp.com>, hongxing.zhu@nxp.com, 
	l.stach@pengutronix.de, Frank.Li@nxp.com, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	s.hauer@pengutronix.de, festevam@gmail.com, imx@lists.linux.dev, kernel@pengutronix.de, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 06/13] arm: dts: imx6qdl: Add Root Port node and PERST
 property
Message-ID: <wnbxqzsxq5v33rr4cweoz2inkxsq536bqxvtpdleboll76gx7k@rdhh4ntyydk4>
References: <20260313020823.1592389-1-sherry.sun@nxp.com>
 <20260313020823.1592389-7-sherry.sun@nxp.com>
 <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGb2v65dvWRqugwBAORB_dD+3Part+OieCe9hnSR781g-6NgZA@mail.gmail.com>

On Fri, Mar 13, 2026 at 02:08:05PM +0800, Chen-Yu Tsai wrote:
> On Fri, Mar 13, 2026 at 10:08 AM Sherry Sun <sherry.sun@nxp.com> wrote:
> >
> > Since describing the PCIe PERST# property under Host Bridge node is now
> > deprecated, it is recommended to add it to the Root Port node, so
> > creating the Root Port node and add the reset-gpios property in Root
> > Port.
> >
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> > ---
> >  arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi |  5 +++++
> >  arch/arm/boot/dts/nxp/imx/imx6qdl.dtsi         | 11 +++++++++++
> >  arch/arm/boot/dts/nxp/imx/imx6qp-sabreauto.dts |  5 +++++
> >  3 files changed, 21 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > index ba29720e3f72..fe9046c03ddd 100644
> > --- a/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > +++ b/arch/arm/boot/dts/nxp/imx/imx6qdl-sabresd.dtsi
> > @@ -754,11 +754,16 @@ lvds0_out: endpoint {
> >  &pcie {
> >         pinctrl-names = "default";
> >         pinctrl-0 = <&pinctrl_pcie>;
> > +       /* This property is deprecated, use reset-gpios from the Root Port node. */
> >         reset-gpio = <&gpio7 12 GPIO_ACTIVE_LOW>;
> 
> I'd say just remove the old description.
> 
> You're asking for trouble by describing the same thing in two different places.
> 
> >         vpcie-supply = <&reg_pcie>;
> 
> I would probably also take this chance to just convert to the proper PCI
> slot supply, and just add pwrctrl support into your PCIe driver.
> 

+1

- Mani

-- 
மணிவண்ணன் சதாசிவம்
