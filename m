Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97B17A300
	for <linux-pci@vger.kernel.org>; Sat,  4 Jul 2026 12:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168591; cv=none; b=cMtpRJFN7qGtYE8fESGxV7yRht4KvfjZuFEIE5kDKCiS1hNYAAipDhJZorsjM2OEuaa8oIfpwjEN6vUOiAXhhAeBX5kzh4EWmtA4u0pHvalDVHI8/NB6fXRU8fpRaSyWTh3kqnpYl2+1QFHZK5coFhqSSdui2nJPWaX8/lsgC9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168591; c=relaxed/simple;
	bh=zDOdK4x/Ygu+SPOTV9kOSFZwsKtJ60k+qeYGPzFUM9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hNWa4kZJcEgOm0rnKl0mxwzET8irmk0od4Dvc4IpUIFYK8mAmLQS0qGLq3X8t+PwWoiCtscmF4Jv3Ya/ycr9Zg68o6tmgatIxKcR8WFU7r92b18rKzQkl5yCvQ1ERzfMMoY86gdzuIPm3rIZHDYiC/48QGbnWE5gUe4Op2meMKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtJsp6a9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtJsp6a9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383BA1F000E9;
	Sat,  4 Jul 2026 12:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783168589;
	bh=Liah/TcpHXJMxIn4ENLbe9BeY+z7bPzlqlnTGIdtynY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LtJsp6a93QpSg2Z18y1LiPANBcAH7E0KSzVSV3JuPtIJH6XpSuLv1OP/GGjm9WJm4
	 M5hRAzm6XVB2tUeJPdbAx8KORO6FzGILJQgasKkm7xq5TUZmBWccElm0/RAsIuS/LR
	 Z3eJE1UwMdJY9OCcqb7Oc1u9gnV20SCj12o0Gsu14sZ415uDe37BHHI0I5AnJ9vplH
	 ylChmJ2t3xi8rCCbScTnEIYSaOzrc3SvgpWys4jXYRCbClA3h4EnSxAONjuZJR8qEE
	 5z5m4GaCOM9QGyhPMFl4vvhhlZP03tYvg5WUawDdvxAN9mfBb7KrGBvHC0709ckt0M
	 BYqmPxqpELy+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: cadence: add missing MODULE_DEVICE_TABLE()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pengpeng Hou" <pengpeng@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
References: <20260704122835.14277-1-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 12:36:28 +0000
Message-Id: <20260704123629.383BA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Probe function silently masks initialization failures by returning=
 0 in its error path.
- [High] Driver data type mismatch leads to out-of-bounds memory access and=
 kernel panic on shutdown and suspend.
--

commit 614cbd9081a5fd803fcc9fe1b172469d540e733c
Author: Pengpeng Hou <pengpeng@iscas.ac.cn>

PCI: cadence: add missing MODULE_DEVICE_TABLE()

The driver has an OF match table wired to .of_match_table, but does
not export the table with MODULE_DEVICE_TABLE().

Add the missing MODULE_DEVICE_TABLE(of, ...) entry so module alias
information is generated for OF based module autoloading.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index b067a3296dd37..a1ea24fc3b63f 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -163,6 +163,7 @@ static const struct of_device_id cdns_plat_pcie_of_ma=
tch[] =3D {
>  	},
>  	{},
>  };
> +MODULE_DEVICE_TABLE(of, cdns_plat_pcie_of_match);
> =20
>  static struct platform_driver cdns_plat_pcie_driver =3D {
>  	.driver =3D {

[Severity: High]
This isn't a regression introduced by this patch, but I noticed a pre-exist=
ing
regression with error handling in the probe function in this file.

In drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_probe(=
):

	ret =3D cdns_pcie_ep_setup(ep);
	if (ret)
		goto err_init;
...
 err_init:
 err_get_sync:
	pm_runtime_put_sync(dev);
	pm_runtime_disable(dev);
	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
	phy_count =3D cdns_plat_pcie->pcie->phy_count;
	while (phy_count--)
		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);

	return 0;

Should this error path return the actual error code instead of returning 0?

Returning 0 unconditionally masks the probe failure. Does this cause the
driver core to register the device as successfully probed even when PHY or
host/endpoint setup fails, potentially leading to undefined behavior later?

[Severity: High]
This is also a pre-existing regression, but there appears to be a driver da=
ta
type mismatch that could lead to out-of-bounds memory access during shutdown
and suspend.

In drivers/pci/controller/cadence/pcie-cadence-plat.c:cdns_plat_pcie_probe(=
),
the driver data is set to a struct cdns_plat_pcie pointer:

	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
	...
	platform_set_drvdata(pdev, cdns_plat_pcie);

However, in cdns_plat_pcie_shutdown(), it is retrieved and cast as a
struct cdns_pcie pointer:

static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
{
	struct device *dev =3D &pdev->dev;
	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
	...
	cdns_pcie_disable_phy(pcie);
}

The same incorrect cast happens in drivers/pci/controller/cadence/pcie-cade=
nce.c
during suspend and resume operations:

static int cdns_pcie_suspend_noirq(struct device *dev)
{
	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);

	cdns_pcie_disable_phy(pcie);

	return 0;
}

static int cdns_pcie_resume_noirq(struct device *dev)
{
	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
	int ret;

	ret =3D cdns_pcie_enable_phy(pcie);
	...
}

Since struct cdns_plat_pcie is an 8-byte wrapper containing the actual stru=
ct
cdns_pcie pointer, does casting it directly to struct cdns_pcie cause
cdns_pcie_disable_phy() and cdns_pcie_enable_phy() to read out-of-bounds
memory when accessing fields like pcie->phy_count and pcie->phy?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260704122835.1427=
7-1-pengpeng@iscas.ac.cn?part=3D1
