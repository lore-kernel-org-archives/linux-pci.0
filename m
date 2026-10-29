Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279863;
	b=LfMHXJw5JO6F7EksIDmHCB3xr7nQIzYCGWNThm7bRfSi3zrcqmDxasHpDpKraRXENhAn
	 FWF64alcWGE8J8UqZ1p4/Dp96G0LP/BqfStR17Z4Nb6WgCJPmboiY/GIDRr+6vKAQ1YeT
	 FFO1WS5Z49AZvEvNWbXtG2UhAU1d3KcnPVIzix4zjhgrbEyuqhAdXleyK98KU65/FQyWb
	 CLJy7F28bN4snRRTxP0he3kT2GQ0/iuhu64wNzIbs1CvehOHxA3h1LXKw5S43F7rADVcO
	 EUKAtfdefiNooMiKV8nP3eJtwbsHVafSUjJYy+QOAjld51sqy0HROd5hKwcOkzvw5bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279863;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aAGWgSUb0ydTyO589PzjqXAAAMQ5aws9tMzkXWJlies=;
	b=rRRFYqjfYvx6NHwqVFLzqMEz/XDKSGOIq4NAN3wYX1yeC/gcLJc8gXPxadpW1JERbiWf
	 vUw+4ttO5xdXW6aHlbzMGHyWh194O8QR2EcepEwELo54aU3uhRKgqxWsNZpNVa/1X7S3b
	 8L/nEF5hs4hB6j/rvF4YcjXjEwUARMJLvEAkVBNtlo01xarDzjMfdOorGCbgEimLWWn1P
	 5KzUjEKMgBf1MwmrzjgtKHCfj3TSx5ajrkvfZwYX0NeNuZHAF+s5ChYEZnmhJJrHmoPSG
	 Z8E/+fJYBG+rDIwhRWir0SuG7l4oOFn3qZ4TSRkWEQWSEvtfvOhH/VJpsOKHSYDB7Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHXE0NuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92583606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iHXE0NuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04EFA1F01828;
	Thu, 29 Oct 2026 13:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279863;
	bh=aAGWgSUb0ydTyO589PzjqXAAAMQ5aws9tMzkXWJlies=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=iHXE0NuYiAiDBHnDV479/SkYDqiBfyKrvlvNl+p8rqc1xAxVvOgXALJoVPTlgW5JW
	 Q9lPaFXLMt0dLLTYIjqe2dM2a4ozPifpRO/xoQ5GX4zmRqcgr4FZnlgz3n9fT0fm97
	 SrIBU+fLiMgo+2Anq7X50v2Se6YsCtOwRox5Aw0XdDxVi+DHTua1OgQwhEcv7M8qKW
	 arDcjGBy/Gdxfwrtmp/igaEmzigO3XOn34nEkyKIc66qlvAFyyZpM3Ox7VImhN0vfr
	 /HVik/BEU8ynWYh07c2505xsrjKcbQ/dC+aq84VKdUmXNWSqiISoKEw3SpJotO15qz
	 I7nAuscnIjr9Q==
Message-ID: <sashiko-outbox-189364@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: exynos: Handle PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:17:42 +0000
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
- [High] PCI: exynos: double phy_exit() on probe error after exynos_pcie_ho=
st_init()
- [High] PCI: exynos: unchecked exynos_pcie_host_init() in exynos_pcie_resu=
me_noirq()
--

commit e723b41ff1e9114786c14ad5226542ae1f9e3a1b
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PHY initialization errors

This commit checks the return values of phy_init() and phy_power_on() in
exynos_pcie_host_init() and calls phy_exit() if phy_power_on() fails.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..5ad07c0be8e51 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -225,13 +225,21 @@ static int exynos_pcie_host_init(struct dw_pcie_rp =
*pp)
>  {
>  	struct dw_pcie *pci =3D to_dw_pcie_from_pp(pp);
>  	struct exynos_pcie *ep =3D to_exynos_pcie(pci);
> +	int ret;
> =20
>  	pp->bridge->ops =3D &exynos_pci_ops;
> =20
>  	exynos_pcie_assert_core_reset(ep);
> =20
> -	phy_init(ep->phy);
> -	phy_power_on(ep->phy);
> +	ret =3D phy_init(ep->phy);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D phy_power_on(ep->phy);
> +	if (ret) {
> +		phy_exit(ep->phy);
> +		return ret;
> +	}

[Severity: High]
Does this cause an unbalanced phy_exit(ep->phy) call when probe fails in
exynos_pcie_probe() -> exynos_add_pcie_port() -> dw_pcie_host_init() ->
exynos_pcie_host_init()?

When phy_init(ep->phy) fails, ep->phy->init_count remains 0, and when
phy_power_on(ep->phy) fails, phy_exit(ep->phy) in exynos_pcie_host_init()
decrements ep->phy->init_count back to 0. Both dw_pcie_host_init() and
exynos_add_pcie_port() return that negative error code to
exynos_pcie_probe():

drivers/pci/controller/dwc/pci-exynos.c:exynos_pcie_probe() {
	...
	ret =3D exynos_add_pcie_port(ep, pdev);
	if (ret < 0)
		goto fail_probe;

	return 0;

fail_probe:
	phy_exit(ep->phy);
	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);

	return ret;
}

Because fail_probe unconditionally calls phy_exit(ep->phy), phy_exit() in
drivers/phy/phy-core.c decrements ep->phy->init_count from 0 to -1, which
prevents phy_init() from invoking phy->ops->init() on subsequent probe
attempts.

[Severity: High]
What happens during system resume in exynos_pcie_resume_noirq() if
exynos_pcie_host_init() returns early with an error here?

In exynos_pcie_host_init(), exynos_pcie_assert_core_reset(ep) is called
before phy_init(ep->phy) and phy_power_on(ep->phy). Returning early skips
exynos_pcie_deassert_core_reset(ep) and exynos_pcie_enable_irq_pulse(ep),
leaving the PCIe core held in reset and the PHY off, while
exynos_pcie_resume_noirq() does not check the return value of
exynos_pcie_host_init(pp):

drivers/pci/controller/dwc/pci-exynos.c:exynos_pcie_resume_noirq() {
	...
	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
	if (ret)
		return ret;

	/* exynos_pcie_host_init controls ep->phy */
	exynos_pcie_host_init(pp);
	dw_pcie_setup_rc(pp);
	exynos_pcie_start_link(pci);
	return dw_pcie_wait_for_link(pci);
}

Should exynos_pcie_resume_noirq() check the return value of
exynos_pcie_host_init(pp) and disable ep->supplies before returning the
error instead of calling dw_pcie_setup_rc(pp) and exynos_pcie_start_link(pc=
i)
while the controller core is in reset?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029131006.2744=
-1-sreekuttan2156239@gmail.com?part=3D1
