Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24B3DB64B;
	Sun, 20 Sep 2026 06:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789887298; cv=none; b=VTzDo9/Mb5P+QMye80cWq9TdkFmFb+QayWBmFkLa0JiqclXM9yilhwyUVjHdmouMLXUmqnpr9XPaviUCxMbjz3mugsYjBUJvXy3m0G2uYE5rVVcPetmq+bu4aIT/AMeTr5BnxyhSKYvABmAXE2x7l2udXMQFQb0Jm/vyFIqwIIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789887298; c=relaxed/simple;
	bh=w2U/G87lR2fJF/QQp/d8DFlfh8db9YZUafgy8ueCiCs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uwjeLNv04R08TaVcJM13TvkOmHo/gld4eRstS/pyeNdDFncKIABdT3LHFXKwX3PTp7PeS7THaaiLjJ3XRRkkF/Ap1vhzejI4jHQaZDEe8VOolImOALN/na1mIAM3KLBGb2Z5qpa9px3YEsR2NomKV7oG2gqXWmbAbUjNT9XmAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbjJltmB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbjJltmB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99D951F000FF;
	Sun, 20 Sep 2026 06:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789887297;
	bh=VdUGT7JhdnhiMe+TwqTYeXIrGneg9v/OjTMN8gRSFKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QbjJltmBK4aVAnSnKOcbH44t9Y18cmtrEZ2qPvTwGJadaieXnlkzqAoB673ZfNNQg
	 syjqE+4WNJDx3ndrYmIm8IFilUpg05QgJ9AzubluKrSMongRy2OXSWrlrsLXGirGRd
	 hWDPYmlegO6KVpCUD82nSTg3+3SR1utpiSVY3T8J902m6QtoUcaZydC6YkacguuT1N
	 kFjxTYa8hZK5gJMxDKo+1dmOb9iJbLcmH4/RWnRjMcGHald4oRrLJLiTvpSYxIyefK
	 9z+oQz8bUPdaw6EDO6M3ZObfZctBGijWXEZAzoJVqe9YhEiDOk8179PTtbzDl63Knd
	 U9Md1Pvd2w18A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 06/12] phy: freescale: s32g: Add SerDes subsystem
 PHY
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SmFuIFBldHJvdXMgKE9TUyk=?= <jan.petrous@oss.nxp.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org, olteanv@gmail.com, linux-phy@lists.infradead.org, Frank.Li@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, robh@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260919-s32g_serdes-v3-6-9d68868c1e89@oss.nxp.com>
References: <20260919-s32g_serdes-v3-0-9d68868c1e89@oss.nxp.com>
 <20260919-s32g_serdes-v3-6-9d68868c1e89@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 06:54:56 +0000
Message-Id: <20260920065456.99D951F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] mm: Use-After-Free in s32g_serdes_pcs_create() via lockless drvdat=
a access
- [High] driver: Race condition exposing PHY provider before hardware initi=
alization
- [High] pm: Sleep in atomic context via noirq sleep callbacks
- [Medium] driver: Infinite probe deferral on unconfigured XPCS instance
- [Medium] pm: Missing resource cleanup on resume error path
--

commit 179aba95589906304ef5b4ba6f8b771475155fa2
Author: Vincent Guittot <vincent.guittot@linaro.org>

    phy: freescale: s32g: Add SerDes subsystem PHY

    The S32G SoC family includes two SerDes subsystems, each made of one
    PCIe controller, two XPCS and a shared 2-lane combo PHY. The lanes can
    be configured to carry PCIe and/or SGMII.
   =20
    Add the SerDes subsystem PHY driver: the PCIe PHY, the shared combo-PHY
    bring-up, and the setup of the XPCS instances added by the previous
    patch.

> diff --git a/drivers/phy/freescale/phy-nxp-s32g-serdes.c b/drivers/phy/fr=
eescale/phy-nxp-s32g-serdes.c
> new file mode 100644
> index 0000000000000..e81878137f2e1
> --- /dev/null
> +++ b/drivers/phy/freescale/phy-nxp-s32g-serdes.c
> @@ -0,0 +1,1057 @@

[ ... ]

> +static int s32g_serdes_init(struct s32g_serdes *serdes)
> +{
> +	struct s32g_serdes_ctrl *ctrl =3D &serdes->ctrl;
> +	u32 reg0;
> +	int ret;
> +
> +	ret =3D clk_bulk_prepare_enable(ctrl->nclks, ctrl->clks);
> +	if (ret) {
> +		dev_err(serdes->dev, "Failed to enable SerDes clocks\n");
> +		return ret;
> +	}

[ ... ]

> +	/* Wait for the selection of working mode (as per the manual specs) */
> +	usleep_range(100, 110);

[ ... ]

> +static int s32g_serdes_create_pcie_phy(struct s32g_serdes *serdes,
> +				       struct device_node *child_node)
> +{
> +	struct phy_provider *phy_provider;
> +	struct device *dev =3D serdes->dev;
> +	struct phy *phy;
> +
> +	phy =3D devm_phy_create(dev, child_node, &serdes_pcie_ops);
> +	if (IS_ERR(phy))
> +		return PTR_ERR(phy);
> +
> +	phy_set_drvdata(phy, serdes);
> +
> +	phy->attrs.mode =3D PHY_MODE_PCIE;
> +	serdes->pcie.phy =3D phy;
> +
> +	phy_provider =3D devm_of_phy_provider_register(&phy->dev,
> +						     s32g_serdes_phy_xlate);

[Severity: High]
Does this expose the PHY provider before the hardware is initialized?=20

s32g_serdes_parse_lanes() registers the PHY provider via=20
devm_of_phy_provider_register(), making it visible to consumers. The hardwa=
re=20
clocks and resets aren't initialized until s32g_serdes_init() is called lat=
er=20
in s32g_serdes_probe().=20

If a consumer probes concurrently and calls phy_power_on(), could it access=
=20
unclocked registers and cause a synchronous external abort?

> +	if (IS_ERR(phy_provider))
> +		return PTR_ERR(phy_provider);
> +
> +	return 0;
> +}

[ ... ]

> +static int s32g_serdes_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	ret =3D s32g_serdes_parse_lanes(dev, serdes);
> +	if (ret)
> +		return ret;

[ ... ]

> +	ret =3D s32g_serdes_init(serdes);
> +	if (ret)
> +		return ret;

[ ... ]

> +static int s32g_serdes_resume(struct device *device)
> +{
> +	struct s32g_serdes *serdes =3D dev_get_drvdata(device);
> +	struct s32g_pcie_ctrl *pcie =3D &serdes->pcie;
> +	int ret;
> +
> +	ret =3D s32g_serdes_init(serdes);
> +	if (ret) {
> +		dev_err(device, "Failed to initialize\n");
> +		return ret;
> +	}
> +
> +	/* Restore PCIe phy power */
> +	if (pcie->powered_on) {
> +		ret =3D s32g_pcie_phy_power_on(serdes);
> +		if (ret)
> +			dev_err(device, "Failed to power-on PCIe phy\n");
> +	}
> +
> +	return ret;

[Severity: Medium]
Does this leak clock resources on the error path?

If s32g_pcie_phy_power_on() fails, the function returns an error without=20
undoing the hardware initialization performed earlier in s32g_serdes_init()=
.=20
The PM core will mark the device as having failed to resume, but the leaked=
=20
clock enables might prevent the power domain from fully shutting down.

> +}

[ ... ]

> +struct phylink_pcs *s32g_serdes_pcs_create(struct device *dev,
> +					   struct device_node *np)
> +{

[ ... ]

> +	serdes =3D platform_get_drvdata(pdev);
> +	if (!serdes) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);
> +	}

[Severity: High]
Can this race with driver unbind leading to a use-after-free?

This function is exposed to consumer drivers and reads drvdata locklessly.=
=20
If the SerDes driver is unbound concurrently via sysfs,=20
dev_set_drvdata(dev, NULL) is called and the devm_kzalloc'd serdes=20
structure is freed by devres.=20

If platform_get_drvdata() reads the pointer just before the unbind, won't=20
accessing serdes->xpcs.phys[instance] below dereference freed memory?

> +
> +	if (!serdes->xpcs.phys[instance]) {
> +		put_device(&pdev->dev);
> +		return ERR_PTR(-EPROBE_DEFER);

[Severity: Medium]
Will this cause an infinite probe deferral loop if the instance is unconfig=
ured?

If the SerDes has probed successfully (meaning drvdata is non-NULL) but=20
intentionally did not populate serdes->xpcs.phys[instance] due to lane=20
configuration mismatch, this instance will never be populated. Would it be=
=20
better to return an error rather than -EPROBE_DEFER in this case?

> +	}

[ ... ]

> +/* noirq, like the PCIe controller using this PHY */
> +static const struct dev_pm_ops s32g_serdes_pm_ops =3D {
> +	NOIRQ_SYSTEM_SLEEP_PM_OPS(s32g_serdes_suspend,
> +				  s32g_serdes_resume)

[Severity: High]
Does this call sleepable functions in an atomic context?

The driver assigns s32g_serdes_resume() to the .resume_noirq callback, whic=
h=20
executes with hardware interrupts disabled. However, s32g_serdes_resume() c=
alls=20
s32g_serdes_init(), which invokes clk_bulk_prepare_enable() (takes a mutex)=
=20
and usleep_range() (sleeps via hrtimers).

> +};

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919-s32g_serde=
s-v3-0-9d68868c1e89@oss.nxp.com?part=3D6
