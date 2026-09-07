Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276C63B9D86;
	Mon,  7 Sep 2026 11:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781071; cv=none; b=A6ZPf+TInEybX8uI/DSXEuJr3ab8Bl7+UULgiTI0nGH8GxJlJp/Q174xh2fRyHGkiHagcTPddNvvmz5zv3l9dRY+F5+LEuRw5qY7XfOdk81Kq4ppJDl07hRD4VsU2Yp3upYl3uU7+dPRSz+qCndFawBSUc1RxmJMFGg92HGsdzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781071; c=relaxed/simple;
	bh=9XcI2/WSm4+Q3talcLMaiCFxx5qqY+J7YaU7hpmURUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EK+P4MTZpKQsa+vOzcEsoaRqcxWcwNzYaouQsBk7JUskxyjI+XV2O9BijYJN68SRxWsTuX7Di11Abc4bNay7FYCUl67Ms6dEBdU7ANfdVwfweirT+fo7GWV6uRAlDy32OQZnYv12tfU9VT735GZTKIMLFEFUOPrTTU/pNTVNHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/aPLAM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/aPLAM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B11F00A3A;
	Mon,  7 Sep 2026 11:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781070;
	bh=vE2QTNxpnhUGZftPf1sKyRFWxmupQxadpZCwptgnVCk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z/aPLAM4BPujd8HlPsOf5WrMm0Al0ZBk/H6v9PkabYCWkEA0haGibJlPZJcMZ28VR
	 /O63+IqWFghCDhynggfSQ931gM3QmO95XK2GOzjCTtc4cNWzFKaztVuPok9NPYFics
	 OxV7xoZhnntganrb5FNhSAgWLNjJHAsviu0ghLUhvtzZa6atMBCl/o6meWbvgZmCeo
	 VaJp3ZlHuZU2e9hei2YnsQjIVbwkZd4ECzzFdPewIuyS3Iw04xVAwyBj4wW7s8UcfU
	 oKY6V/9f5ZRxysk5b8sNqT8HCvZZH2Iwfyz0B48K+AAxH47yzDDBPINESbAKYzIVsz
	 0mkZOWyry1NDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] PCI: spacemit-k1: Add multiple PHY handles
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20260907112606.465778-3-inochiama@gmail.com>
References: <20260907112606.465778-1-inochiama@gmail.com>
 <20260907112606.465778-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 11:37:49 +0000
Message-Id: <20260907113749.9E5B11F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch uses non-existent PHY bulk APIs (`struct phy_bulk_data`, =
`devm_of_phy_bulk_get_all`, `phy_bulk_init`, `phy_bulk_exit`), which will c=
ause an immediate build failure.
--

commit fe08b64098d53a53f4787c86d1612302f802dee7
Author: Inochi Amaoto <inochiama@gmail.com>

PCI: spacemit-k1: Add multiple PHY handles support

This commit extends the Spacemit K1 PCIe controller driver to support
multiple PHY handles by introducing bulk PHY API calls. It replaces single
PHY operations with bulk operations throughout the driver's initialization
and cleanup paths.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 9512556d45390..1049391beee83 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -51,12 +51,14 @@ struct k1_pcie_device_data {
>  	const struct dw_pcie_host_ops *host_ops;
>  	const struct dw_pcie_ops *ops;
>  	int (*parse_port)(struct k1_pcie *k1);
> +	unsigned int max_phy_count;
>  };
> =20
>  struct k1_pcie {
>  	struct dw_pcie pci;
>  	const struct k1_pcie_device_data *data;
> -	struct phy *phy;
> +	struct phy_bulk_data *phys;

[Severity: Low]
Does struct phy_bulk_data exist in the kernel? It appears this type is
undefined, which will cause a build failure here in k1_pcie.

> +	unsigned int phy_count;
>  	void __iomem *link;
>  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */

[ ... ]

> @@ -115,6 +117,23 @@ static void k1_pcie_disable_resources(struct k1_pcie=
 *k1)
>  	clk_bulk_disable_unprepare(ARRAY_SIZE(pci->app_clks), pci->app_clks);
>  }
> =20
> +static int k1_pcie_get_phy_handle(struct k1_pcie *k1, struct device_node=
 *node)
> +{
> +	const struct k1_pcie_device_data *data =3D k1->data;
> +	struct device *dev =3D k1->pci.dev;
> +	int count;
> +
> +	count =3D devm_of_phy_bulk_get_all(dev, node, &k1->phys);

[Severity: Low]
Is devm_of_phy_bulk_get_all() an upstream API? I'm unable to find this
function, and calling an undefined function will break the build during
k1_pcie_get_phy_handle().

> +	if (count < 0)
> +		return count;
> +	if (count =3D=3D 0 || count > data->max_phy_count)
> +		return -EINVAL;
> +
> +	k1->phy_count =3D count;
> +
> +	return 0;
> +}
> +
>  /* FIXME: Disable ASPM L1 to avoid errors reported on some NVMe drives */
>  static void k1_pcie_disable_aspm_l1(struct k1_pcie *k1)

[ ... ]

> @@ -170,7 +189,7 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 */
>  	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
> =20
> -	ret =3D phy_init(k1->phy);
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);

[Severity: Low]
Is phy_bulk_init() defined? Similar to the other bulk APIs used in this pat=
ch,
this appears to be an undefined function and will fail compilation in
k1_pcie_init().

>  	if (ret) {
>  		k1_pcie_disable_resources(k1);
> =20
> @@ -195,7 +214,7 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>  	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>  			PCIE_RC_PERST);
> =20
> -	phy_exit(k1->phy);
> +	phy_bulk_exit(k1->phy_count, k1->phys);

[Severity: Low]
Does phy_bulk_exit() exist? Like the initialization function, this seems to=
 be
undefined and will cause compilation to fail during k1_pcie_deinit().

> =20
>  	k1_pcie_disable_resources(k1);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907112606.4657=
78-1-inochiama@gmail.com?part=3D2
