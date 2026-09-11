Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7C43DED4
	for <linux-pci@vger.kernel.org>; Fri, 11 Sep 2026 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789124656; cv=none; b=EuzCtU9/RxadkRp6k1vNu87ezPUCO2sKujXcZCRqgFgV2hU+u7Lwnqe2lA0s2CxVTDB3aJYpJuLxkFkH55YefIlYGJ/h8YNGxgjxfjl/S9gtMgoXdf37zanIPe6Bs9UzmklK3HhnaePX1iYpaEQMLJ+zmhZ5GKwHn4YDNuZrZa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789124656; c=relaxed/simple;
	bh=bwRpAfEbhul35MFiGrpxWJGEV/qdZphG/WG7JVETKWA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z8tJ6u/OEcpxVrqqnS57tM7DXBmoxBiYoYMzuE/JueoyZNnADFoeXjXF6AQ0I4altz6qbDjLs6e5cQXUFWkDEVRibkWoiVSY9ntypjgjaEt8PqFnLtneJSLA023elWNFIYqI/Pz6Cod2obqbKNkKEbpulaw6DNTxvwaC1+4Ql78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+2CLZAK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+2CLZAK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D881F000FF;
	Fri, 11 Sep 2026 11:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789124654;
	bh=+ZtUg9g+oMgu5FH6LhzT//8WH4TJjjEAMAM9dw52nGw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+2CLZAKQOfwaDpfDYNUktrP2JUmKAID7SAtuAA5csW2N4yq01JLUXjMZA3cSKcLc
	 zgEBTSoPoKHHSU/vsPGl6yAaKBToUdS/jMeWtv8g2cI/PIkGAcNQzhMugt9Wspse14
	 WfxWerFCiafJ7/xUIVr6qN5Kf8l3/oWXqWF5T8bc/kigl6vUhh71W4ckruktWZtXzN
	 bQMk5YOPhe0pSbE2pXfJVhH4WAUBpwm9fUHgqayf+pP8iRy1363Zad9LwyGtC6S+22
	 TLYFmq6LKVA4vDvNu4PwfGGoYQvaCK6mDepvhDzTusHhwF/4N59J4SgGH4axwOsatP
	 DuWSdcJpSWaLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: rockchip: Skip the Tpvperl wait when power is
 already valid
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?RW5yaXF1ZSBIZXJuw6FuZGV6IEJlbGxv?= <ehbello@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260911104952.4190994-1-ehbello@gmail.com>
References: <20260911104952.4190994-1-ehbello@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 11:04:13 +0000
Message-Id: <20260911110414.28D881F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The driver unconditionally forces the 100ms T_PVPERL wait on resum=
e, which will cause the same endpoint enumeration failure on boards where t=
he 0.9V regulator remains on during suspend.
- [Medium] The logic to skip the PCIe T_PVPERL wait assumes that any enable=
d regulator was brought up by the bootloader and has been stable for >100ms=
, which fails for shared regulators enabled by recently probed drivers.

Pre-existing issues:
- [High] The chained IRQ handler for the 'legacy' interrupt is never remove=
d on probe failure or driver removal, leading to a Use-After-Free.
--

commit 4d72f1c6e9bdfdfe2b1710bb4e36490f981a6798
Author: Enrique Hern=C3=A1ndez Bello <ehbello@gmail.com>

PCI: rockchip: Skip the Tpvperl wait when power is already valid

This commit aims to fix PCIe endpoint enumeration failures on the rk3399 by
skipping the 100ms T_PVPERL wait if the PCIe regulators are already enabled
when the driver probes. It checks regulator_is_enabled() on the supplies and
sets a flag to skip the wait, while forcing the wait during system resume.

> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/co=
ntroller/pcie-rockchip-host.c
> index d203c4876d304..2c88e836dd2a6 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c

[ ... ]

> @@ -614,6 +616,23 @@ static int rockchip_pcie_set_vpcie(struct rockchip_p=
cie *rockchip)
>  	struct device *dev =3D rockchip->dev;
>  	int err;
> =20
> +	/*
> +	 * Tpvperl is counted from the supplies becoming valid, and the wait
> +	 * for it happens with PERST# asserted, so it also lengthens the reset.
> +	 * A supply that is already enabled before this driver enables it was
> +	 * brought up either by the bootloader or by the regulator core at boot,
> +	 * both of which precede this probe by far more than Tpvperl, so the
> +	 * requirement is already met and the wait can be skipped. Treat an
> +	 * error from regulator_is_enabled() as "not known to be on" and wait.
> +	 */
> +	rockchip->supplies_pre_enabled =3D
> +		(IS_ERR(rockchip->vpcie12v) ||
> +		 regulator_is_enabled(rockchip->vpcie12v) > 0) &&
> +		(IS_ERR(rockchip->vpcie3v3) ||
> +		 regulator_is_enabled(rockchip->vpcie3v3) > 0) &&
> +		regulator_is_enabled(rockchip->vpcie1v8) > 0 &&
> +		regulator_is_enabled(rockchip->vpcie0v9) > 0;

[Severity: Medium]
Could this logic cause a violation of the PCIe CEM T_PVPERL requirement?

If a PCIe supply (e.g., the 0.9V or 1.8V regulator) is shared with another =
IP
block like a USB PHY, and that driver probes and enables the regulator a few
milliseconds before the PCIe controller probes, regulator_is_enabled() will
return true.=20

Does this mean the PCIe driver will incorrectly assume the regulator was
enabled by the bootloader >100ms ago, skip the mandatory T_PVPERL wait, and
de-assert PERST# prematurely, preventing PCIe endpoint enumeration?

[ ... ]

> @@ -890,6 +909,9 @@ static int rockchip_pcie_resume_noirq(struct device *=
dev)
>  	struct rockchip_pcie *rockchip =3D dev_get_drvdata(dev);
>  	int err;
> =20
> +	/* The 0.9V supply was turned off on suspend, so Tpvperl applies. */
> +	rockchip->supplies_pre_enabled =3D false;
> +

[Severity: High]
Does this hardcoded assumption break endpoint enumeration on resume for boa=
rds
with always-on regulators?

In rockchip_pcie_suspend_noirq(), regulator_disable(rockchip->vpcie0v9) only
decrements the regulator use-count. On boards where this regulator is marked
regulator-always-on or is shared and remains in use, the power rail stays
physically on during suspend.

On resume, unconditionally setting supplies_pre_enabled =3D false forces
rockchip_pcie_host_init_port() to sleep for 100ms with PERST# asserted. Sin=
ce
power was already valid, won't this cause a 100ms warm reset, which is the
exact endpoint enumeration failure this patch intends to fix?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can the legacy IRQ handler cause a
use-after-free on probe failure or driver removal?

In rockchip_pcie_setup_irq(), the chained handler is registered:

	irq_set_chained_handler_and_data(irq,
					 rockchip_pcie_intx_handler,
					 rockchip);

However, there is no corresponding irq_set_chained_handler_and_data(..., NU=
LL)
call in the error path of rockchip_pcie_probe() or in rockchip_pcie_remove(=
).

If pci_host_probe() fails, the devres framework automatically frees the
bridge and rockchip memory. If the interrupt line is shared or spuriously
triggered after removal, won't rockchip_pcie_intx_handler() dereference the
freed rockchip pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911104952.4190=
994-1-ehbello@gmail.com?part=3D1
