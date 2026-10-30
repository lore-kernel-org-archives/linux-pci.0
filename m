Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381933;
	b=yX/deLbk2G6ghHMK2nEo8cU+tQv92KLLIn4f+hm5cRi0FzLCnmwR7/YY7ZBYphG8kPH0
	 aqR/EP8W2FHOf9cbXOtv/mf+YqzXHX0IEait56d8oPwWIZBbgEam6Ymy4ErZhKMHmgBHB
	 mz4dd448LfUxI40cULr2tHtpbxX5uicIVXrgQybPGbExDZlCz6L2c3n7DixOl6+CcJWpn
	 TTWyEMRkqmNBHiahjX6sRxfOe+eGyeUnhMGNotLZXRMPZMH8s1BVb6sfj13jx+GcCvcQV
	 crTA5Y30mjXuj799qJfbClZ9sw6cfmdXNhTr0sh+b0jHZFsWMhURoRNB5OSVt1PDkVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381933;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=t9SVp8La5YHF1f1Lk1E3f7csrSN7PeA5KYfqr+HV+oI=;
	b=hz2tqVl9Qcm/rsptphouwmgZPRez1WevBtrMvXSWBhdevF9IjnaF88py6NBDkE/A/q+f
	 O2wLwWv5E+3fTW5+10FN4rGxHcLdNUO2dXlhVVdxlizAO2Mf6rLmNaK7K05jkQSNIQAVj
	 YlUoFbxh7TovZmMF+m7nguqxFqUtWrk319Rkl8yTpDJcVTXduJeN9S0uh22akplcxukkC
	 OuDnKWlK14lvIMk4ZcG5lir12ie7iIdm3/SPuazBj6zFnsyv775fd5HWpabUDH281spyj
	 FXxny+qHw3x6oVnI5z0wVdeI6rm1xY/GoHs1i93tjhV88jWnY0XNsVyFiQtFuDy6dxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjv+kVk5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF41606A32D
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jjv+kVk5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB6B1F00A17;
	Fri, 30 Oct 2026 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793381932;
	bh=t9SVp8La5YHF1f1Lk1E3f7csrSN7PeA5KYfqr+HV+oI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jjv+kVk5DNhKjjFA5xLksaG2r4kY+tfjUx1oyWXhVayT/shj4kgcuoJamSP+aKVe1
	 8BLdx0QsTu0MsN2sBBZu3OsXUyXCf/gm7y60T6mSlUbIyXPoGsncw6Pn7sKwPJwEBj
	 VgFA0PFZyCL/eJJsA10Q81W7Txd0UMp9TT9CU/hyzSxqfpiX6/2IFrO3IbzYBfh7zK
	 EmOjKsvzVyUbZo9OlrVXvlZpU2WnzPgg1mRVFwi46cxWGPKXwg5RgQ6MG+R8ZickCY
	 HWn4WXYqe+c1Kju0qzOJw3Iz0s7f/NKin2VyPjMH9cuMaXQETOSsWIDs5IAsw9uXmo
	 rICROPK14mk1g==
Message-ID: <sashiko-outbox-191351@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261030172350.2624-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261030172350.2624-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:38:52 +0000
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
- [Medium] PCI: exynos: missing core reset assertion on post-init probe fai=
lure
--

commit e18d30d63d8279f6ed367a47b2c6e198b4bb8418
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks return values from phy_init(), phy_power_on(), and
exynos_pcie_host_init(), and introduces boolean flags on struct exynos_pcie
to track PHY and regulator states across probe, remove, suspend, and resume.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..d82bdfea1f17b 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -55,8 +56,34 @@ struct exynos_pcie {
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
> +	int ret;
> +
> +	if (ep->phy_powered) {
> +		ret =3D phy_power_off(ep->phy);
> +		if (ret)
> +			return ret;
> +
> +		ep->phy_powered =3D false;
> +	}
> +
> +	if (ep->phy_initialized) {
> +		ret =3D phy_exit(ep->phy);
> +		if (ret)
> +			return ret;
> +
> +		ep->phy_initialized =3D false;
> +	}
> +
> +	return 0;
> +}
> +
>  static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>  {
>  	writel(val, base + reg);
> @@ -225,13 +252,23 @@ static int exynos_pcie_host_init(struct dw_pcie_rp =
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
> =20
>  	exynos_pcie_deassert_core_reset(ep);
>  	exynos_pcie_enable_irq_pulse(ep);
> @@ -314,6 +351,7 @@ static int exynos_pcie_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		return ret;
> =20
> +	ep->supplies_enabled =3D true;
>  	platform_set_drvdata(pdev, ep);
> =20
>  	ret =3D exynos_add_pcie_port(ep, pdev);
> @@ -323,8 +361,19 @@ static int exynos_pcie_probe(struct platform_device =
*pdev)
>  	return 0;
> =20
>  fail_probe:
> -	phy_exit(ep->phy);
> -	regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +	if (exynos_pcie_phy_exit(ep))
> +		dev_err(&pdev->dev, "failed to exit PCIe PHY\n");
> +
> +	if (ep->supplies_enabled) {
> +		int err;
> +
> +		err =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (err)
> +			dev_err(&pdev->dev, "failed to disable regulators: %d\n", err);
> +		else
> +			ep->supplies_enabled =3D false;
> +
> +	}

[Severity: Medium]
When dw_pcie_host_init() fails after exynos_pcie_host_init() has already
succeeded (for example, if dw_pcie_wait_for_link() returns -ETIMEDOUT or
pci_host_probe() fails), exynos_pcie_host_init() has already deasserted core
reset via exynos_pcie_deassert_core_reset(ep) and enabled pulse interrupts.

Because exynos_pcie_host_ops does not provide a .deinit callback for the
err_deinit_host path in dw_pcie_host_init(), control returns to fail_probe =
in
exynos_pcie_probe(), which powers off and exits ep->phy and disables
ep->supplies without calling exynos_pcie_assert_core_reset(ep) first (unlike
exynos_pcie_remove() and exynos_pcie_suspend_noirq()). Note that calling
exynos_pcie_assert_core_reset(ep) unconditionally in fail_probe would not be
safe either, since fail_probe is also reached when exynos_add_pcie_port()
fails before dw_pcie_get_resources() maps pci->elbi_base.

Would it be cleaner and safer to unwind phy_init(ep->phy) locally inside
exynos_pcie_host_init() when phy_power_on(ep->phy) fails, and implement
dw_pcie_host_ops.deinit to call exynos_pcie_assert_core_reset(ep),
phy_power_off(ep->phy), and phy_exit(ep->phy), thereby ensuring core reset =
is
asserted on post-init probe failures and avoiding manual boolean state
tracking across probe, remove, suspend, and resume?

>  	return ret;
>  }

[ ... ]

> @@ -332,22 +381,42 @@ static void exynos_pcie_remove(struct platform_devi=
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
As reported by Sashiko on v4 [1], in exynos_pcie_suspend_noirq(), if
exynos_pcie_phy_exit(ep) or regulator_bulk_disable() fails, the error is
logged and 0 is returned so system suspend proceeds, while ep->phy_powered,
ep->phy_initialized, or ep->supplies_enabled remains true. Furthermore, if
phy_power_off(ep->phy) fails in exynos_pcie_phy_exit(), it returns early
without calling phy_exit(ep->phy) (which also leaks phy->init_count in
fail_probe and exynos_pcie_remove()), and exynos_pcie_suspend_noirq() still
proceeds to call regulator_bulk_disable() on the vdd18 and vdd10 supplies
while the PHY remains powered on.

When exynos_pcie_resume_noirq() subsequently runs, it unconditionally calls
regulator_bulk_enable() and exynos_pcie_host_init(pp) -> phy_init(ep->phy) /
phy_power_on(ep->phy) without checking whether ep->supplies_enabled,
ep->phy_initialized, or ep->phy_powered are already true.

Because regulator_bulk_disable(), phy_power_off(), and phy_exit() leave the=
ir
internal enable_count, power_count, and init_count at 1 on failure, calling
regulator_bulk_enable(), phy_init(), or phy_power_on() again increments tho=
se
counts to 2 while struct exynos_pcie only tracks state with single booleans.
In addition, phy_init() and phy_power_on() only invoke phy->ops->init and
phy->ops->power_on when init_count =3D=3D 0 and power_count =3D=3D 0, so ha=
rdware PHY
re-initialization is skipped on resume. Subsequent teardown in
exynos_pcie_remove() or the next suspend then decrements the counts only on=
ce
(from 2 to 1) before clearing the booleans to false.

Doesn't this permanently leak the PHY and regulator reference counts and sk=
ip
hardware PHY re-initialization on resume?

[1] https://lore.kernel.org/r/20261030163654.2733-1-sreekuttan2156239@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030172350.2624=
-1-sreekuttan2156239@gmail.com?part=3D1
