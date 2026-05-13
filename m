Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03D737BE6B;
	Wed, 13 May 2026 05:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648480; cv=none; b=r4gv0bDI0w5PtyhsQ/RMsDrUX2hhdz2r6EPqZisSdAxbPI7YxqhmsxEToEuXhbQQ6hZWkuPiJHKN61kNXurFCByeoSNCtT4/ZDQ8WY67bXHoNNRxGnDqkx0dlEe5xdTQDnuKq0GDJSi0DqNTYghYdWWTCnyzvpixVTHyOl/Lfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648480; c=relaxed/simple;
	bh=n/stMvyJlEXzKn+ZF094sGM2wBa3LCnzIqinZ5s+tUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ib3VoKG1AguNGcdycG3jO0osFnugyRhnbkndT+41dmH0d0XR/lDjOZXViz0B2WQ71cTtBoQBaAam3bN3K2mrFFr6OVWseMRSnggx97E8AxDRrrO5rZFvGvKMDYutJH2NxaLoy6wZLw8is147KDlCKGV7Il/NTRtUrijJuEEhNQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TK4vsnIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TK4vsnIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B37AC2BCB7;
	Wed, 13 May 2026 05:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778648479;
	bh=n/stMvyJlEXzKn+ZF094sGM2wBa3LCnzIqinZ5s+tUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=TK4vsnIr9LuwE5Ldmr2NGJogwYvcr83QdkyDjxeVNxd12hP6/op2pFyepgfrZJVF1
	 1Y3Z9qdAPpRzrS7NP/KTvxiUKisoWzjQgLSAtJsrN82e7ZSJzDcPp2l3ctT2L7PJZL
	 xXYOns35LcVJGCJjH19Lsn/qSX6iMJV+CNnBsoch3HltKveH2SgKpMZMm7p1MEiS0b
	 BLPXB04/qsvMRAmX3LA66eSHglvqDljBaN17fiXp05I1RVfvg153J7lH1qw3BUpSN/
	 Qc+wvdSP6sXXQWSCSU23ltKLcQvFV0YH4u5fMUvhfTiAC+BFlCfnF554KZ7bbdOzzy
	 MomNMyGZyWOpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/2] PCI: imx6: Configure REF_USE_PAD before PHY
 reset for i.MX95
Reply-To: sashiko-reviews@lists.linux.dev
To: "Richard Zhu" <hongxing.zhu@nxp.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260512052244.49414-2-hongxing.zhu@nxp.com>
References: <20260512052244.49414-2-hongxing.zhu@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 05:01:19 +0000
Message-Id: <20260513050119.9B37AC2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware configuration error due to incorrect register usage for R=
EF_USE_PAD
--

commit 26a2cb6a0671cc76e166c2fbcbd3fac6623c8d77
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Configure REF_USE_PAD before PHY reset for i.MX95

This commit moves the REF_USE_PAD configuration before the PHY reset toggle
to comply with the required initialization sequence for the i.MX95 PCIe PHY.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index e35044cc52185..d2df0f4819bb0 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -247,6 +248,24 @@ static unsigned int imx_pcie_grp_offset(const struct=
 imx_pcie *imx_pcie)
>  	return imx_pcie->controller_id =3D=3D 1 ? IOMUXC_GPR16 : IOMUXC_GPR14;
>  }
> =20
> +static int imx95_pcie_init_pre_reset(struct imx_pcie *imx_pcie)
> +{
> +	bool ext =3D imx_pcie->enable_ext_refclk;
> +
> +	/*
> +	 * Regarding the Signal Descriptions of i.MX95 PCIe PHY, ref_use_pad is
> +	 * used to select reference clock connected to a pair of pads.
> +	 *
> +	 * Any change in this input must be followed by phy_reset assertion.
> +	 */
> +
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
> +			   IMX95_PCIE_REF_USE_PAD,
> +			   ext ? IMX95_PCIE_REF_USE_PAD : 0);

Does this code update the correct register?

In the original code below, IMX95_PCIE_REF_USE_PAD was written to
IMX95_PCIE_PHY_GEN_CTRL. Here it is being written to IMX95_PCIE_SS_RW_REG_0,
which could fail to select the reference clock and inadvertently corrupt
bit 17 of IMX95_PCIE_SS_RW_REG_0.

> +
> +	return 0;
> +}
> +
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
>  	bool ext =3D imx_pcie->enable_ext_refclk;
> @@ -269,9 +288,6 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_p=
cie)
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
>  			IMX95_PCIE_PHY_CR_PARA_SEL);
> =20
> -	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_PHY_GEN_CTRL,
> -			   IMX95_PCIE_REF_USE_PAD,
> -			   ext ? IMX95_PCIE_REF_USE_PAD : 0);
>  	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_0,
>  			   IMX95_PCIE_REF_CLKEN,
>  			   ext ? 0 : IMX95_PCIE_REF_CLKEN);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512052244.4941=
4-1-hongxing.zhu@nxp.com?part=3D1
