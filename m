Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793384742;
	b=IF7JpbCKZ09wkHPG3+IYtgkskcyMLQbxH5WpTmo+5njZ/cQ58ug4zSj3lejnXOsryawz
	 yPkehRjp1CjZuUybWnCZETKWtguq9DJc6LgXj4Hz2De5Zg62+vwxHm58EYhq18QBNVKJw
	 wAyaJVDqQoDkg348XKa01qTIr1SyKBnH4J70NrY+TSHTw7hNg7KWi8KeOKB10R788oPHs
	 EbCb3g20XAgTSayOrKWf/W96LrmouGW1LPw2Z+JVkCzfid7iaIO0vrrzIDkzsmvjcAuCr
	 kUqF+1blxnE47VI5EeC/Rk90V/jSYOUzWgOsuuXfzuhbEde++5OaIvZxb1fh/pa4cbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793384742;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PB/j0/WwKCbgEgR/4TiGl6KScJwnN5JAZpV6BXVtQfA=;
	b=32LkckStCgrS6jcuaY+lhjImQq0EeK9b/xz0DG+Yo3mZWAWs6zzx4n3JrWq/g0wJz+r8
	 ne3xIX0CQwjlm411gMKaHwaVWUtO56K53eyD3eKdEXy2TNOnYv/2h2BV/iR+J7bSLjQoS
	 +WG0hmB/Vh8ojkHAC/qKzXDNb0YHLLqr5DrYxtub23mMDqbt4bOM/boIKmiYQK3gskSIN
	 sMelArZvJxiW7pH1cs7Mn0zjAvGZIDwP3hxPyvsyzEOXV9v4qlgWKIytWIAvymyxJabD4
	 Rukv15X+DluDIsD1XZ4lHmIkaQM4Om7JqIHHno0mXqucjEhHs/kwiNSPpCc3KBOuLYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3ktNFRJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10BB606A31A
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T3ktNFRJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B6E1F000C1;
	Fri, 30 Oct 2026 18:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793384741;
	bh=PB/j0/WwKCbgEgR/4TiGl6KScJwnN5JAZpV6BXVtQfA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T3ktNFRJCGbz4SzcAxvqLXbLHrJIQozaOGLWOAsr061i4H9wtWBUQwImrO3hC5adv
	 ftQHjLCJIzdCej2+achVSkf9Tt3tMUXjH9vSbZUKh7Hc2qpJyZiZMrpR1hCgaBPd0K
	 8Gr2eFM9834883ioIQv8B5bfsKs+4+rVzzfwu+SVXthGEoLKI1ZU7uxvLGCS9/hLdn
	 HdLu6AZmd4cWWt5PKWAtykf1h7KuwIM2BOS2PsXFJIGcnulTzwNEr7HdSlpTeJK48u
	 0drspBdNupLsEdaEPxiOGrW7oeLJ6j6bbWfDC/C0Re275QKb00N9vl3HB757CZ4zQL
	 tTsjtVlbroLZg==
Message-ID: <sashiko-outbox-191406@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030180902.2589-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261030180902.2589-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:25:41 +0000
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
- [High] PCI: exynos: PHY and regulator ref leak in exynos_pcie_resume_noir=
q()
- [Low] PCI: exynos: commit message omits regulator tracking and reset chan=
ges
--

commit fc4bd96cfce4c0daa59d215a173d06803b550297
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks the return values of phy_init(), phy_power_on(), and
exynos_pcie_host_init(), tracks PHY and regulator state across probe, remov=
e,
suspend, and resume, and updates teardown and error recovery paths in the
Exynos PCIe driver.

>     PCI: exynos: Handle PCIe PHY initialization errors
>    =20
>     Check the return values of "phy_init()" and "phy_power_on()" to
>     avoid continuing PCIe host initialization when PHY setup fails.
>    =20
>     Track the PHY initialization and power state to ensure cleanup is
>     performed only when appropriate, avoiding double calls to
>     "phy_exit()" on probe failure.
>    =20
>     Also check the return value of "exynos_pcie_host_init()" during
>     resume and abort the resume sequence if PHY initialization fails.
>    =20
>     Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

[Severity: Low]
This isn't a bug, but could the commit message also describe the regulator
state tracking and reset handling changes introduced by this patch?

In addition to PHY state tracking, the patch introduces ep->supplies_enabled
across exynos_pcie_probe(), exynos_pcie_remove(), exynos_pcie_suspend_noirq=
(),
and exynos_pcie_resume_noirq(), disables regulators when
exynos_pcie_host_init() fails during resume, asserts core reset via
exynos_pcie_assert_core_reset() in the probe failure path when PHY setup was
reached, and logs teardown errors in remove and suspend. Since the revision
notes below the tear line are stripped when the patch is applied, these
changes would otherwise be missing from the commit log.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..0085c3ed0c2f5 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c

[ ... ]

> @@ -55,8 +56,35 @@ struct exynos_pcie {
>  	struct clk_bulk_data		*clks;
>  	struct phy			*phy;
>  	struct regulator_bulk_data	supplies[2];
> +	bool phy_initialized;
> +	bool phy_powered;
> +	bool supplies_enabled;
>  };
> =20
> +static int exynos_pcie_phy_exit(struct exynos_pcie *ep)
> +{
> +	int ret =3D 0;
> +	int err;
> +
> +	if (ep->phy_powered) {
> +		err =3D phy_power_off(ep->phy);
> +		if (err)
> +			ret =3D err;
> +		else
> +			ep->phy_powered =3D false;
> +	}
> +
> +	if (ep->phy_initialized) {
> +		err =3D phy_exit(ep->phy);
> +		if (err)
> +			ret =3D err;
> +		else
> +			ep->phy_initialized =3D false;
> +	}
> +
> +	return ret;
> +}
> +
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>  {
>  	writel(val, base + reg);
> @@ -225,13 +253,23 @@ static int exynos_pcie_host_init(struct dw_pcie_rp =
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
> +	ep->phy_initialized =3D true;
> +
> +	ret =3D phy_power_on(ep->phy);
> +	if (ret)
> +		return ret;
> +
> +	ep->phy_powered =3D true;

[ ... ]

> @@ -332,22 +385,42 @@ static void exynos_pcie_remove(struct platform_devi=
ce *pdev)

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
> +		dev_err(dev, "failed to exit PCIe PHY during suspend: %d\n", ret);
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret)
> +			dev_err(dev, "failed to disable regulators during suspend: %d\n", ret=
);
> +		else
> +			ep->supplies_enabled =3D false;
> +	}
> =20
>  	return 0;
>  }
> =20
>  static int exynos_pcie_resume_noirq(struct device *dev)
>  {
>  	struct exynos_pcie *ep =3D dev_get_drvdata(dev);
>  	struct dw_pcie *pci =3D &ep->pci;
>  	struct dw_pcie_rp *pp =3D &pci->pp;
>  	int ret;
> +	int err;
> =20
>  	ret =3D regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep->supplies);
>  	if (ret)
>  		return ret;
> =20
> +	ep->supplies_enabled =3D true;
> +
>  	/* exynos_pcie_host_init controls ep->phy */
> -	exynos_pcie_host_init(pp);
> +	ret =3D exynos_pcie_host_init(pp);

[Severity: High]
As reported by Sashiko on v5 [1], can this sequence leak ep->supplies
regulator enable counts and ep->phy init_count/power_count on resume if
teardown fails during suspend?

In exynos_pcie_suspend_noirq(), if exynos_pcie_phy_exit() or
regulator_bulk_disable() fails, the error is logged, the corresponding state
flag (ep->phy_powered, ep->phy_initialized, or ep->supplies_enabled) remains
true, and the function returns 0 so suspend completes. At that point, the
underlying phy->power_count, phy->init_count, or regulator->enable_count is
still 1 (and in exynos_pcie_phy_exit(), phy_exit() is also called while the
PHY is still powered if phy_power_off() fails).

When exynos_pcie_resume_noirq() later runs, it unconditionally calls
regulator_bulk_enable() without checking !ep->supplies_enabled, and calls
exynos_pcie_host_init(), which unconditionally calls phy_init() and
phy_power_on() without checking !ep->phy_initialized and !ep->phy_powered.

Because the boolean flags only track a single reference, calling enable/init
again when a flag is already true increments regulator->enable_count,
phy->init_count, or phy->power_count to 2. In addition, phy_init() and
phy_power_on() only invoke phy->ops->init and phy->ops->power_on when the
counts transition from 0 to 1, so hardware PHY re-initialization is skipped
on resume even though core reset was asserted during suspend.

Later, when exynos_pcie_suspend_noirq(), the resume error path, or
exynos_pcie_remove() runs, regulator_bulk_disable(), phy_power_off(), and
phy_exit() are called at most once before clearing the booleans to false,
leaving the reference counts at 1 and triggering WARN_ON(regulator->enable_=
count)
on driver unbind.

Should exynos_pcie_resume_noirq() and exynos_pcie_host_init() guard
regulator_bulk_enable(), phy_init(), and phy_power_on() with checks on
ep->supplies_enabled, ep->phy_initialized, and ep->phy_powered, or otherwise
keep the state tracking in sync with the underlying reference counts?

[1] https://lore.kernel.org/r/20261030172350.2624-1-sreekuttan2156239@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030180902.2589=
-1-sreekuttan2156239@gmail.com?part=3D1
