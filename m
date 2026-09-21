Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2FF448BA8;
	Mon, 21 Sep 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023201; cv=none; b=BzbKTlSee6fIxh6PuaAnDsYFe2VofcuuxHmddGYv7JSgoBYMnLcwGDKgLxnGi6+EaDwf0490JsjGNkTnNSJ3wW2n6/CLi9HIjE7V2z+jOXQT0LgD/MfvWP9UOADTdVjhDIz54+B98IkrG/KNWzRe/txoyNc8zyFLOJHJ1Q4hTZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023201; c=relaxed/simple;
	bh=RrWHb0g55Jisdv7rMmnpRWoE0pErNYPSOX9KWd2EEVw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Oy0VrhdXqTmVJ8rKcD0V7WicE8kF1Bo+pNizG2kDBh4TOex5pTH+LAakfbOGpnGLFPF6fw71qwyMBksgzCTRqvCdRK5BI+i9yDtOqkidLxlAKG4uW167hKPyMJMp3MQXLveGBvuAOVXUVlADPOHbMRWZDzFmqs+Abb+cbvSkx9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLygnp04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLygnp04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961CC1F000FF;
	Mon, 21 Sep 2026 20:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023199;
	bh=i+rX6VDVe/Py9dgw8zfz0rbHTzt9zUJlrhhHcghAQog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QLygnp04uyAOxIWKXdmwK2yxuXU4AwuDbjb/Wvkdqc5sbT7QpHSiCumVg2xivaZWY
	 kP+442aac85x16x6V9mjjgIg2KQsZdn9NZNTkbAvPKQeqxn9TjJkeOOTTxq/T3Py1m
	 Ldrci4MZDHqjDnTvOWJSpHe9oSE0u2qWr07QrmRngskzM5hl47uDs4tjiIJnSnSZMe
	 s8dgQAvN28IuJa9qzga5FL69cRhiqEPy298Tl9z3jMGl91tOwp/K+gd3Yc9qxi+Vtw
	 HSirvz63CJcyjpDxcpB/h7wnUihrcJowVGVpPZYxI5fv4xEAr4SI1h9O46PTOWwBJx
	 qtge84t+sUc9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] PCI: dwc: rcar-gen4: Add support for R-Car X5H
 PCIe4
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260921202823.72620-7-marek.vasut+renesas@mailbox.org>
References: <20260921202823.72620-1-marek.vasut+renesas@mailbox.org>
 <20260921202823.72620-7-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 20:39:59 +0000
Message-Id: <20260921203959.961CC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] pci: dwc: rcar-gen4: unhandled reset deassertion in rcar_gen5_pc=
ie_init() error path
- [Medium] pci: dwc: rcar-gen4: ignored return value of phy_power_on() in r=
car_gen5_pcie_ltssm_control()
- [Medium] pci: dwc: rcar-gen4: NULL pointer dereference with malformed Gen=
4 DT
- [Low] pci: dwc: rcar-gen4: error masking in rcar_gen4_pcie_get_resources()
--

commit d7ef6825f8ed7b884f9b2940d56a8d85a5c57f6b
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>
PCI: dwc: rcar-gen4: Add support for R-Car X5H PCIe4

This commit adds support for the R8A78000 (R-Car X5H) PCIe4 controller. It
factors out the controller-specific initialization sequences into callbacks
and adds PHY driver bindings that are handled via the resource retrieval
routine.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index cf1f5de451820..0b7ae4a693085 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -285,6 +314,49 @@ static int rcar_gen4_v4h_v4m_pcie_init(struct rcar_g=
en4_pcie *rcar)
>  	return 0;
>  }
> =20
> +static int rcar_gen5_pcie_init(struct rcar_gen4_pcie *rcar)
> +{
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	int ret;
> +	u32 val;
> +
> +	/* R-Car Gen4 and Gen5 common initialization. */
> +	ret =3D rcar_gen4_pcie_common_init(rcar);
> +	if (ret)
> +		return ret;
> +
> +	/* R-Car Gen5 specific additional initialization. */
> +	ret =3D phy_init(rcar->phy);
> +	if (ret)
> +		goto err_unprepare;
[ ... ]
> +	return 0;
> +
> +err_unprepare:
> +	clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
> +
> +	return ret;
> +}

[Severity: Medium]
Will this leave the hardware reset unbalanced? rcar_gen4_pcie_common_init()
successfully deasserts the DW_PCIE_PWR_RST core reset. If the subsequent
phy_init() call fails, the code jumps to err_unprepare and disables the
clocks, but does not appear to reverse the reset deassertion by calling
reset_control_assert() or rcar_gen4_pcie_common_deinit(). Could this leave
the PCIe core in an undefined state?

[ ... ]
> @@ -322,8 +400,12 @@ static int rcar_gen4_pcie_get_resources(struct rcar_=
gen4_pcie *rcar)
>  	struct device_node *root_port;
> =20
>  	rcar->phy_base =3D devm_platform_ioremap_resource_byname(rcar->pdev, "p=
hy");
> -	if (IS_ERR(rcar->phy_base))
> -		return PTR_ERR(rcar->phy_base);
> +	if (IS_ERR(rcar->phy_base)) {
> +		rcar->phy_base =3D NULL;
> +		rcar->phy =3D devm_phy_get(dev, NULL);
> +		if (IS_ERR(rcar->phy))
> +			return PTR_ERR(rcar->phy);
> +	}

[Severity: Low]
Does this logic unintentionally mask original errors like -ENOMEM? If
devm_platform_ioremap_resource_byname() fails due to a memory allocation
issue, it will return -ENOMEM. The code falls back to devm_phy_get(), and if
that returns -ENODEV, the original -ENOMEM is lost. Should the fallback only
be attempted if the resource was explicitly missing (returning -EINVAL)?

[Severity: Medium]
Additionally, by setting rcar->phy_base to NULL and succeeding if
devm_phy_get() finds a PHY, could this cause a NULL pointer dereference on
older Gen4 controllers?=20

If a malformed device tree provides a phys property but no phy memory region
for a Gen4 controller, rcar->phy_base is set to NULL. The driver uses
rcar_gen4_pcie_ltssm_control() for Gen4, which unconditionally dereferences
rcar->phy_base via rcar_gen4_pcie_phy_reg_update_bits() and
readl_poll_timeout().

[ ... ]
> @@ -804,6 +886,28 @@ static int r8a779f0_pcie_ltssm_control(struct rcar_g=
en4_pcie *rcar, bool enable)
>  	return 0;
>  }
> =20
> +static int rcar_gen5_pcie_ltssm_control(struct rcar_gen4_pcie *rcar, boo=
l enable)
> +{
> +	u32 val;
[ ... ]
> +	if (enable)
> +		phy_power_on(rcar->phy);
> +	else
> +		phy_power_off(rcar->phy);
> +
> +	return 0;
> +}

[Severity: Medium]
Should the return value of phy_power_on() be checked here? If powering on t=
he
PHY fails, the function unconditionally returns 0 and swallows the error co=
de.
Could this falsely report success to the caller and lead to silent link
training failures or cryptic timeouts later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921202823.7262=
0-1-marek.vasut+renesas@mailbox.org?part=3D6
