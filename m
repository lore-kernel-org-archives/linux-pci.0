Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8B44BD11B;
	Tue, 29 Sep 2026 08:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671660; cv=none; b=j1wIt0dW0MWfrTdJd+MEvseS79jx9YuE36kg0lofOuSFG6liBYr0J70BGzCDgr/4ZqJvsnrP2wq9AkQ5FJr+3l6yKXRzX30qcYwpI5c1686Sv1VyhBa9FyZsRb34bqXXgkwoxu2ttrklMJs9EeKL4ZD5vBhjWunCgQx+6KVIUO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671660; c=relaxed/simple;
	bh=UQzbOTBlCbUnVJqBLQPzFiY6VbNfHXU3K6r1pZ1FeBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=coiNVSWpKo5IIjgzDxJidAWz2kQwM8vPtfnBc16u3naAnvM+edW2+LTVoFFUpURdEb2xJE8YEfINcmFuSghATVtbGhZ4rMRQ2P66nkYawE4jogKta96dZFGU1rkKqiqbdI+MkBtIpBXAnJF+PP0hd23KcG9cjIt3k2Pw8suC9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CqM9cULQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CqM9cULQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3901F000FF;
	Tue, 29 Sep 2026 08:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671652;
	bh=WHH62zOyQX49uJEpTza2/fyAeqr23knoaXcVG9bwd8M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CqM9cULQfICv/oSPCvQakQiQywTdMn81iKNSZs9PXeCxdesgMeBsx28L6cVoDMGtt
	 AgxgBzLbOBNde9J7hpU/61Ii+ma9YB7PbAS47tAV8jP1roZ/ByZy9i/ijggnGeZNY/
	 njvLmtQE21Lp53s5yJeO/9rt2a+CpQ0bcLGX9of7i2ADzlZ9+sSkedMrt1qVPU3kb/
	 TSN69+82IOHMoviChk5nauiyfDwzGL64soyJWnGlNbI5fESCOXK0tJII900I/rPWwT
	 hGlajVR9dtMjXwIZqIVzJvgjUX6JNvx6mAN7yNRbyjztlholQYWiRTCA9EOQJi7duf
	 u0Nohqq05sKrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/6] PCI: spacemit-k1: Add multiple PHY handles
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Inochi Amaoto" <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260929083755.458238-3-inochiama@gmail.com>
References: <20260929083755.458238-1-inochiama@gmail.com>
 <20260929083755.458238-3-inochiama@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 08:47:31 +0000
Message-Id: <20260929084731.CE3901F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] undeclared dependency on non-existent phy_bulk API
--

commit fbbd5a12f65d0fd19aa308617ff68c1880b18ff5
Author: Inochi Amaoto <inochiama@gmail.com>

    PCI: spacemit-k1: Add multiple PHY handles support
   =20
    The PCIe controller on Spacemit K3 may use multiple PHYs at the
    same time. The feature is not supported by the current driver.
    So extend the PHY definition to support multiple PHY handles.

> diff --git a/drivers/pci/controller/dwc/pcie-spacemit-k1.c b/drivers/pci/=
controller/dwc/pcie-spacemit-k1.c
> index 0564c46e2f484..8c4f0b09fe24d 100644
> --- a/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> +++ b/drivers/pci/controller/dwc/pcie-spacemit-k1.c
> @@ -45,9 +45,20 @@

[ ... ]

>  struct k1_pcie {
>  	struct dw_pcie pci;
> -	struct phy *phy;
> +	const struct k1_pcie_device_data *data;
> +	struct phy_bulk_data *phys;

[Severity: Low]
Does struct phy_bulk_data exist in the kernel tree?

It looks like this introduces a dependency on a type that hasn't been
defined, which will cause a build failure.

> +	unsigned int phy_count;
>  	void __iomem *link;
>  	struct regmap *pmu;	/* Errors ignored; MMIO-backed regmap */
>  	u32 pmu_off;
> @@ -106,6 +117,25 @@ static void k1_pcie_disable_resources(struct k1_pcie=
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
Is devm_of_phy_bulk_get_all() implemented anywhere?

It appears to be an undeclared function, which will cause this to fail at
compile time.

> +	if (count < 0)
> +		return count;

[ ... ]

> @@ -161,12 +191,13 @@ static int k1_pcie_init(struct dw_pcie_rp *pp)
>  	 */
>  	regmap_set_bits(k1->pmu, reset_ctrl, DEVICE_TYPE_RC | PCIE_AUX_PWR_DET);
> =20
> -	ret =3D phy_init(k1->phy);
> -	if (ret) {
> -		k1_pcie_disable_resources(k1);
> +	ret =3D phy_bulk_init(k1->phy_count, k1->phys);

[Severity: Low]
Are the phy_bulk_init() and phy_bulk_power_on() functions available in
the current tree?

Calling non-existent APIs will result in a build breakage.

> +	if (ret)
> +		goto failed_phy_init;
> =20
> -		return ret;
> -	}
> +	ret =3D phy_bulk_power_on(k1->phy_count, k1->phys);
> +	if (ret)
> +		goto failed_phy_power_on;
> =20
>  	/* Deassert fundamental reset (drive PERST# high) */
>  	regmap_clear_bits(k1->pmu, reset_ctrl, PCIE_RC_PERST);

[ ... ]

> @@ -186,7 +225,8 @@ static void k1_pcie_deinit(struct dw_pcie_rp *pp)
>  	regmap_set_bits(k1->pmu, k1->pmu_off + PCIE_CLK_RESET_CONTROL,
>  			PCIE_RC_PERST);
> =20
> -	phy_exit(k1->phy);
> +	phy_bulk_power_off(k1->phy_count, k1->phys);
> +	phy_bulk_exit(k1->phy_count, k1->phys);

[Severity: Low]
Do phy_bulk_power_off() and phy_bulk_exit() exist?

It appears these functions are missing, which will prevent the driver from
compiling.

> =20
>  	k1_pcie_disable_resources(k1);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929083755.4582=
38-1-inochiama@gmail.com?part=3D2
