Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793297240;
	b=wgxhSiejrnwYh6p98F/mxt+89Yn9wWY/llp65wc3qhT1l06SHAYuQ5lzPnkfdM1jr0Vk
	 pEkfcY8xg+FEphw/gUBz5ZlxELPdnPrZR+JiQgSJ29b1SYAjl9dU5QkPk0PWgW+Rp0AEx
	 qAHumJQmKL/kMVE1vU+pb2MLmvzfYEQZHfWTpQjgTxilPbRHIQIh7GxEAoq0LArFZy8dq
	 9vK5XcmvNRNhC8PiOOCuIAtzdaSAscJ+b1qAZ74bW/esU1Me2DqXCPQ2Iuo9Yt9Al3fpm
	 uM4dLaU0xXw5OH8KE+v+1cQ96eScloWBhhLUdKfzzRtqV4Sj0ILai6Mtp5J+Y/SWfKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793297240;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gLhhIoiNXPT6a0aZNepECQl6qDsdgCqJbSJbiVIxGfY=;
	b=wlmP1VpnALS2IbCX1uoWJwhkkm/ZOBBKkZgpVjJplZ9aUqQ1g1gCKYhBvttV8CABmkrS
	 8w/Is2jOk/Xj5mVXYnql4Lz/YeaXZ8Cxhq023UV9nFmfn8MG1HDwGZIoKIY/wVeqDBo7n
	 P0yVoXjpJNovCdF0+s2bCnMvrg2KWrelMdbjz1NIMraQ3iovcq3K47lvJXKDdWOgoRPyu
	 X4utb1xGGkujCrCY9kXM/8/JvFtZ3BFXHGi1K+17rO69MC9ZvV62V+JtwbUiJOna71Msr
	 9wQ5fvnza6rjx5/xQIc8TPKFcI9gC1V6VURHAwkpSyt9BzPHZOdZkNXG36TSJkV2AKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxicM4Fz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E045606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 18:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxicM4Fz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36871F01816;
	Thu, 29 Oct 2026 18:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793297240;
	bh=gLhhIoiNXPT6a0aZNepECQl6qDsdgCqJbSJbiVIxGfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DxicM4FzTgM2FW1Fr9IFgHCl791XqmPl0kwlIPetaQtUWmY5v9iUAzj4ejU2QS30I
	 SeIMJFeIszXmMHKr2UPY2bYppLDFjH6zUcOPOCpWDS+RJL9j7uZ3ZQ4Dlj89ROMVTF
	 1icyhmH9EStG3q8GgCQsqhXn2rcGa1GsZWqgDb+1q/ACFUtmNr5L+C2fnZIFt/moqo
	 LR1cjY2+jlysr6CeJw6MqBp/PNFZhm+yWketyEJK/HFMCf8MT7BvWU2bGrgvrmRqqT
	 FyQ275wqKiFCYkMPy2xAow4urwJtACGC9p2W5f1E2nE3vLOxiciJZRUFUH1ZcFUrWM
	 gYk1pSZFmk9Yg==
Message-ID: <sashiko-outbox-189762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029175439.8490-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261029175439.8490-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 18:07:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] PCI: exynos: unbalanced regulator disable and unpowered access on =
resume error
- [High] PCI: exynos: exynos_pcie_resume_noirq() powers down controller on =
-ENODEV
--

commit 7a2bc4e63574e4dca88761cb98d074446defd067
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks return values from phy_init() and phy_power_on() in
exynos_pcie_host_init(), tracks PHY initialization and power state in struct
exynos_pcie, and adds error handling in exynos_pcie_resume_noirq() to clean=
 up
the PHY and regulators on failure.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..f6b87c26ab36c 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c

[ ... ]

> @@ -364,10 +403,30 @@ static int exynos_pcie_resume_noirq(struct device *=
dev)
>  		return ret;
> =20
>  	/* exynos_pcie_host_init controls ep->phy */
> -	exynos_pcie_host_init(pp);
> +	ret =3D exynos_pcie_host_init(pp);
> +	if (ret)
> +		goto err_cleanup;
> +
>  	dw_pcie_setup_rc(pp);
>  	exynos_pcie_start_link(pci);
> -	return dw_pcie_wait_for_link(pci);
> +	ret =3D dw_pcie_wait_for_link(pci);
> +	if (ret)
> +		goto err_cleanup;

[Severity: High]
Should exynos_pcie_resume_noirq() power down the PHY and disable regulators
when dw_pcie_wait_for_link() returns a non-zero value such as -ENODEV?

In drivers/pci/controller/dwc/pcie-designware.c, dw_pcie_wait_for_link()
returns -ENODEV when no endpoint device is detected (LTSSM in
DW_PCIE_LTSSM_DETECT_QUIET or DW_PCIE_LTSSM_DETECT_ACT) and -EIO when a dev=
ice
is in Poll.Active or Poll.Compliance. During initial probe,
dw_pcie_host_init() only aborts on -ETIMEDOUT, so probe succeeds and regist=
ers
the host bridge with the PHY and regulators active even when the slot is
empty.

With this change, resuming a system with no connected or active PCIe endpoi=
nt
causes dw_pcie_wait_for_link() to return -ENODEV or -EIO and jump to
err_cleanup, shutting down ep->phy and ep->supplies while the PCI root bus
remains registered (and without asserting core reset after
exynos_pcie_deassert_core_reset() and exynos_pcie_start_link()).

> +
> +	return 0;
> +
> +err_cleanup:
> +	if (ep->phy_powered) {
> +		phy_power_off(ep->phy);
> +		ep->phy_powered =3D false;
> +	}
> +
> +	if (ep->phy_initialized) {
> +		phy_exit(ep->phy);
> +		ep->phy_initialized =3D false;
> +	}
> +	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	return ret;

[Severity: High]
What happens on subsequent PCI bus operations, the next system suspend, or
driver unbind if exynos_pcie_resume_noirq() fails and disables the PHY and
ep->supplies here?

During exynos_pcie_suspend_noirq(), the vdd18 and vdd10 supplies in
ep->supplies are disabled and the PHY is powered off and exited. If
exynos_pcie_resume_noirq() fails in regulator_bulk_enable(), or if
exynos_pcie_host_init() or dw_pcie_wait_for_link() fails and jumps to
err_cleanup, the PHY is powered off/exited and regulator_bulk_disable() bri=
ngs
the regulator enable count back to zero.

However, returning an error from a resume_noirq callback in
device_resume_noirq() does not unbind the driver or unregister the PCI host
bridge, and the PM core continues resuming subordinate PCI devices on the r=
oot
bus.

Because the controller and PHY reference clock are now powered down while t=
he
host bridge remains active, won't this lead to two issues:

1. Subsequent config space accesses via exynos_pcie_rd_own_conf() and
exynos_pcie_wr_own_conf(), shared IRQ handling, dw_pcie_host_deinit() in
exynos_pcie_remove(), and exynos_pcie_assert_core_reset() in
exynos_pcie_suspend_noirq() and exynos_pcie_remove() will perform MMIO
accesses to pci->dbi_base and pci->elbi_base while unpowered and unclocked.

2. Unlike ep->phy_powered and ep->phy_initialized, the regulator state of
ep->supplies is not tracked. On the next exynos_pcie_suspend_noirq() or
exynos_pcie_remove(), regulator_bulk_disable(ARRAY_SIZE(ep->supplies),
ep->supplies) will be called unconditionally on already-disabled regulators,
triggering an unbalanced regulator disable warning in _regulator_disable().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029175439.8490=
-1-sreekuttan2156239@gmail.com?part=3D1
