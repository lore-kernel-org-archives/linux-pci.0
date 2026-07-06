Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CEA32BF51;
	Mon,  6 Jul 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322191; cv=none; b=ARjTtFqxluAZfG6mPa3da7raVsrgYebeNK5i4kprmtuKyyGgasIPolYDuQJBuaZC94yte8TxDEKu73S6FLvJ7f7+kwYcedb9x14aYsGD+pEbJw6Fq9e0WohXtpdiBCwLlIHtz3k2ZmuRxFgLy+jWMK7puMJk5Lz2sOMSOTgK0Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322191; c=relaxed/simple;
	bh=vhf9uXcex7k2N6XPeyNf1Tyo9Kddh7W3tmeLwr5lzFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CDJVnjJV89f1kMoB4Mko9bXdoqWcAmWajY9VLfZu31RhkHgWpoauhiOgK/cpr2yrSPcR+E5MWuTq2apoPk71GNMN/8WUnRO3Syg6Y3wBvFWO17ANR4nHW3lbZ6Wp+3fqs5mnt1oz+iNFmQg3YU+E4yBWvVHq9SK+H0fmun4QF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeEE7bZI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeEE7bZI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0131F00A3D;
	Mon,  6 Jul 2026 07:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783322182;
	bh=XDj9V3lEbzng4zI8JPb53YEMxSkcXXfLJdRzgXkEB0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QeEE7bZImNbmPXGFnoVraApO+P5mp2xlmp6RlrvquLbi5AMBkIguB9wBdkHMYES/t
	 U42hlXTRiKFK7b6O1zc0L+jeu85iLOGbp3LbJmdvqOrjhalkyXItiVwO7IdlcZyX/N
	 CjwuEW3ZnPgwAQNXBIAGihAYHhNB0VGenHREx7uPMvQKiFFSrdqR21DMpJEvtScb/n
	 f5i+++2kWSd7/GYptlAdW0TfXac4ScK296nfZ9zS616JRFkfD8Zd1aASrSPwGjQc6W
	 usDLiNiSo/bGM2nlyK1LtsEPh+ROCqaB5zztKECVHFi+2qqefan73g5ovgI5Xfw91L
	 CBhRqp5J8TdAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe
 Gen3 stability
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
References: <20260706070340.3603150-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 07:16:21 +0000
Message-Id: <20260706071622.1E0131F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Sleep in atomic context (NOIRQ) during PHY initialization causes a=
 kernel panic.
- [Medium] Non-atomic configuration of PHY register address and enable bits=
 potentially triggering spurious hardware accesses.
- [Low] Redundant initialization and arbitrary delay (fsleep) executed on e=
very PHY register write.
--

commit d6071da15c88ccfbb08be55ce1c9198ec88fd68c
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Update MPLLB bandwidth for i.MX95 PCIe Gen3 stability

Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
the default MPLLB_BINDWIDTH value. This margin degradation worsens
across voltage and temperature (VT) variations and different test
matrices, potentially causing link stability issues.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..e65def1620441 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -269,6 +278,20 @@ static int imx95_pcie_select_ref_clk_src(struct imx_=
pcie *imx_pcie)
>  	return 0;
>  }
> =20
> +static void imx95_pcie_phy_write(struct imx_pcie *imx_pcie, int addr, u1=
6 data)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_PHY_CR_PARA_SEL,
> +			   IMX95_PCIE_PHY_CR_PARA_SEL);
> +
> +	fsleep(200);

[Severity: Low]
Does this execute redundant initialization and an arbitrary delay on every =
single
PHY register write?

Because imx95_pcie_init_phy() calls imx95_pcie_phy_write() twice, this
IMX95_PCIE_PHY_CR_PARA_SEL configuration and 200us delay are performed on e=
very
register write.

Could this be a one-time initialization prior to the write sequence rather =
than
per-write overhead?


[Severity: High]
Does this fsleep() cause a sleep-in-atomic bug during system resume?

The imx_pcie_resume_noirq() callback runs with local interrupts disabled, a=
nd it
calls dw_pcie_resume_noirq() -> imx_pcie_host_init() -> imx95_pcie_init_phy=
() ->
imx95_pcie_phy_write().

For 200us, fsleep() resolves to usleep_range() which will attempt to schedu=
le
a sleep in this atomic context.

Should this use udelay(200) instead to safely wait?

> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_EN, IMX95_PCIE_PHY_REG_EN);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_ADDR,
> +			   IMX95_PCIE_PHY_REG_ADDR_MASK, addr);

[Severity: Medium]
Will this sequence trigger a spurious hardware access using the old address?

By setting IMX95_PCIE_PHY_REG_EN in IMX95_PCIE_PHY_REG_ADDR before updating=
 the
target address (IMX95_PCIE_PHY_REG_ADDR_MASK), the hardware might trigger an
access immediately upon the enable bit being set, using whatever old addres=
s was
left over in the register.

Should these bits be updated atomically in a single regmap_update_bits() ca=
ll?

> +	regmap_write(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_REG_DATA, data);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706070340.3603=
150-1-hongxing.zhu@oss.nxp.com?part=3D1
