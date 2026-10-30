Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793378923;
	b=k+1/2n9srzF4QdtEh/2JatNWgKLzevOeGXOTBWsJluoKjiGkRcVSG7ZiTYIsP6IRNkRP
	 Z7bY4t9nD4OjXv5oVPDi0gV70efbv9B4aUjgsbjBS9XD4AeBf6lMI3RZ322AmVxOz6KP0
	 fKWnewob/xPkXklQrbcbOKBPGRHAOdpSzm04QWuTPDbpUABueODGcN12A1kulXHrMyaj9
	 lcaq6xzaq6DzDSWbYLc95JefBSqtHaYhS01At/ztqBwcc/khxuuJFWbdU37cT9Yd21Ln2
	 bK9aEW5uK2tPorwUidC++SIzGGwXpdU58jhDjJb7sI0u7fllin1NNuxxJggvrzhTN0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793378923;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m0SAr88sOR7sj3oIWBX+oNN0C9YwCUH0S4xmVApMxro=;
	b=AaOHC06p+TGFaKFI0hhXZr4KAlcnDuJu9TWT5HbTG0S7FGMj9jl8HL6kHbascrcOz7jX
	 kYHT3X8v0H2LWTfPUIa1FdcI0nVzCdT8R6h6zXXaXxfS6S0GVPrTMUB4Fcq5xHr/wqxki
	 yO6O+gg8XQ/VJoQOjTo4FOBQnosTdcitxLqX8ydy+RKmLnNH9J4DeqrPcEkWfdYSZ3zXX
	 i7DGRRDpzpVYlUM7I0R0Xz48rA5hwUfCORhjiNyIoPnKHLfM36b6sOAVEF8Wj1DeErHc/
	 hTm/0XcKFlhTjzvQ45MuINgd7ZpTRBgwp61zAy+Knde5hLDzCJMIdlSI9aJk7PvqsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLusL8Ma;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE26C606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 16:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MLusL8Ma
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D32A1F000C1;
	Fri, 30 Oct 2026 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793378922;
	bh=m0SAr88sOR7sj3oIWBX+oNN0C9YwCUH0S4xmVApMxro=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MLusL8Ma45sRExaRKnZCYWFwOiKSMzVE6H6FG5EeygZ4N/uzKqtd7qbXhAVMDaKpH
	 0qacrO2Y4n9PEdxNzSyGKBnEFtvzvgFTqT1gXsbFHJwJaCAiQSbGhZ1Q7tzwhT6kJO
	 QoQsC0t33l62V9IRfiDWoYOc37j58dZOsZD5zbaCo43+2Ax0/zts9AyYvheHbyAI+K
	 rZEoQtKrRLctBqIj/Ed6i0G4APfA7r8fm0St4CxB29Li5gdeNhkE7jzevwVbZ0jo+2
	 csXKlNosD8WWOXwEgyTJzx5chLJH4L0mc73VSpTZGbgSODCSMxGKtwjGpGQ+ogXFg1
	 kShOWL8bH8CNQ==
Message-ID: <sashiko-outbox-191278@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030163654.2733-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261030163654.2733-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 16:48:41 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] PCI: exynos: unrecovered PHY and RC state in exynos_pcie_suspend=
_noirq()
--

commit 7a778ecdb6665562ea191dff854d89384184c33b
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit adds error checking for phy_init() and phy_power_on() during ho=
st
initialization, tracks PHY and regulator state for cleanup, and handles host
initialization errors during resume.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..5b8d8f1ce8dcd 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c

[ ... ]

> @@ -332,24 +381,48 @@ static int exynos_pcie_probe(struct platform_device=
 *pdev)

[ ... ]

>  static int exynos_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct exynos_pcie *ep =3D dev_get_drvdata(dev);
> +	int ret;
> =20
>  	exynos_pcie_assert_core_reset(ep);
> -	phy_power_off(ep->phy);
> -	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +
> +	ret =3D exynos_pcie_phy_exit(ep);
> +	if (ret)
> +		goto err_deassert_reset;
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret)
> +			goto err_deassert_reset;
> +
> +		ep->supplies_enabled =3D false;
> +	}
> =20
>  	return 0;
> +
> +err_deassert_reset:
> +	exynos_pcie_deassert_core_reset(ep);
> +	return ret;
>  }

[Severity: Medium]
As reported by Sashiko on v3 [1], if exynos_pcie_phy_exit() or
regulator_bulk_disable() fails in exynos_pcie_suspend_noirq(), jumping to
err_deassert_reset only calls exynos_pcie_deassert_core_reset(ep) before
returning a negative error code.

By that point, exynos_pcie_assert_core_reset(ep) has already cleared
PCIE_CORE_RESET_ENABLE, PCIE_STICKY_RESET, and PCIE_NONSTICKY_RESET, and
exynos_pcie_phy_exit(ep) may have already powered off and exited the PHY
(which in exynos5433_pcie_phy_exit() gates the reference clock via
PCIE_REFCLK_GATING_EN and isolates the PHY in the PMU). Deasserting core
reset while the PHY is powered down and uninitialized violates the ordering=
 in
exynos_pcie_host_init(), where phy_init() and phy_power_on() precede
exynos_pcie_deassert_core_reset().

Furthermore, in exynos_pcie_phy_exit():

	if (ep->phy_powered) {
		ret =3D phy_power_off(ep->phy);
		if (ret)
			return ret;

		ep->phy_powered =3D false;
	}

	if (ep->phy_initialized) {
		ret =3D phy_exit(ep->phy);
		if (ret)
			return ret;

		ep->phy_initialized =3D false;
	}

if phy_power_off() succeeds and phy_exit() fails, ep->phy_powered is false
while ep->phy_initialized remains true with phy->init_count =3D=3D 1. Any
subsequent call to exynos_pcie_host_init() will call phy_init(ep->phy)
unconditionally, incrementing phy->init_count to 2 while ep->phy_initialized
only tracks a single boolean reference.

Finally, because exynos_pcie_suspend_noirq() returns a non-zero error to
device_suspend_noirq(), dev->power.is_noirq_suspended is not set and
exynos_pcie_resume_noirq() will not be called during suspend-abort recovery.

Would this leave the Root Complex active from the PM core's perspective whi=
le
its PHY remains powered down and uninitialized, and without restoring IRQ
pulse configuration, Root Complex setup, or the PCIe link?

[1] https://lore.kernel.org/r/20261030151701.3100-1-sreekuttan2156239@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030163654.2733=
-1-sreekuttan2156239@gmail.com?part=3D1
