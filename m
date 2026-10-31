Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793430883;
	b=R/G/r6gPTnaIvrEMoinCBglt75faPKug++20vS3jovcUa6gcbg+BW87pC8XmQbKmmqVO
	 uzwpTSRTetEIHOlszDH+qRom/a/uDar3ZIm7omL9ycdu2nOvZTu2esnZ7/FyLT/ZRBDw0
	 sQA0j8w3iwfiHi/EkX0KfIt/zG9HTYemCHsRl/qHVqdJXKLpYpXJEA3c5XMibJTW+FJ4f
	 UyKTofTfFQYl9JN6a07yEFrwSuKnMfkJt9nwvmfeQ0WrHpyO6CSQ9+xKsiwT2xtE0t7YV
	 XiOkA23IgvhTTYau5L2bnpk7i7Wq5XcKAXtevLQrW2/POx0Amw5HCpUBYqZkKZL1hDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793430883;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UwBY18AmiGi1eQ3ZjWrPXKgU8ksoBZHD0I0P57F9KdE=;
	b=qY4M7JwHSyK1goD+/iCh37mXRZumPLwSz+DQSoPRfOadAaZSGEwPm0Sh1b/Z8NAu0QeN
	 SvVKHYkjLb0Ddv2ri6SoiGxOwo+pfoD77sW/s7vOIS+tooutiGKbIoP7IOLD6zaO1gdzK
	 IC7Z62jZRT6wYf+N8pFDQSVrDlnrZiKvYbnPYf7mGpkT592R22OtTJpfNBo13/eVJdkjV
	 apfUhCMSON3oEf4lYqZ5E6HSS9yTpaPEDvPR2kGi8gZfM7CR9bYXqnDYpLKDPA8qmEYbQ
	 ISZpes+9xZ88osaKg/4nXR0GhVHfjgVZSDGADAftlSOCP+DcBlh4bW/jKSBYXliN/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCQmCiiU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96267606A31A
	for <linux-pci@vger.kernel.org>; Sat, 31 Oct 2026 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCQmCiiU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38321F000C1;
	Sat, 31 Oct 2026 07:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793430883;
	bh=UwBY18AmiGi1eQ3ZjWrPXKgU8ksoBZHD0I0P57F9KdE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FCQmCiiU9HxobfHRoIPm6JPAdGbMDZ9iZqe6FQ4iDUT5vyjDpYiCvP1wuV0NvrLmx
	 Hooq2CSgLkpOA3uc1cdMTRPsakGFFIJsXWca7ST7LAn9rTrQai2E0O/3gkOYO6SMar
	 Upssyyqypueg5R48FQ4WcOFiYaAqOdXVq75nu5d0RRd24e6Rh/Wfs2i13V7dEDQ1Ae
	 KSm2zIsOsrc+3FZb9/D2111/mx2vZ/3yV1d+5MJyNedag0Vtz5w9EwaMc7JE3d0d4m
	 /PDk4LJiElaq7oqGTkQPLUeWwPN7JGtNKPDKAT99gdFybvGjeQFj5anvYQ9MYfV9WO
	 qdIzPhVL6uvjw==
Message-ID: <sashiko-outbox-191794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] PCI: exynos: Handle PCIe PHY initialization errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261031070111.3130-1-sreekuttan2156239@gmail.com>
References: <20261029131006.2744-1-sreekuttan2156239@gmail.com>
 <20261031070111.3130-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 07:14:42 +0000
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
- [High] PCI: exynos: controller left in reset when exynos_pcie_suspend_noi=
rq() fails
- [Medium] PCI: exynos: exynos_pcie_phy_exit() calls phy_exit() when phy_po=
wer_off() fails
--

commit fdc1ec02af91afa2f7f426dbdec623fdb1841665
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: exynos: Handle PCIe PHY initialization errors

This commit checks return values from phy_init(), phy_power_on(), and
exynos_pcie_host_init(), and tracks PHY and regulator state across probe,
remove, suspend, and resume to prevent unbalanced cleanup calls.

> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/contro=
ller/dwc/pci-exynos.c
> index e3c05ade381bb..3e76a818a45c5 100644
> --- a/drivers/pci/controller/dwc/pci-exynos.c
> +++ b/drivers/pci/controller/dwc/pci-exynos.c
> @@ -11,6 +11,7 @@
> =20
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> +#include <linux/device.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
>  #include <linux/init.h>
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

[Severity: Medium]
As reported by Sashiko on v6 [1], if phy_power_off() fails in
exynos_pcie_phy_exit() in drivers/pci/controller/dwc/pci-exynos.c when
ep->phy_powered is true, should this function avoid calling phy_exit() while
the PHY is still powered on?

In drivers/phy/phy-core.c:phy_power_off(), a failure returns before
decrementing phy->power_count:

	if (phy->power_count =3D=3D 1 && phy->ops->power_off) {
		ret =3D phy->ops->power_off(phy);
		if (ret < 0) {
			dev_err(&phy->dev, "phy poweroff failed --> %d\n", ret);
			mutex_unlock(&phy->mutex);
			return ret;
		}
	}
	--phy->power_count;

Because exynos_pcie_phy_exit() continues into the if (ep->phy_initialized)
block even when phy_power_off() failed, it calls phy_exit() on a still-powe=
red
PHY. If phy_exit() succeeds, phy->init_count drops to 0 while
phy->power_count remains 1 (and ep->phy_initialized becomes false while
ep->phy_powered stays true), which then triggers a warning in
drivers/phy/phy-core.c:phy_init() on a subsequent re-initialization:

	if (phy->power_count > phy->init_count)
		dev_warn(&phy->dev, "phy_power_on was called before phy_init\n");

[ ... ]

> @@ -332,22 +389,46 @@ static int exynos_pcie_probe(struct platform_device=
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
> +	if (ret) {
> +		dev_err(dev, "failed to exit PCIe PHY during suspend: %d\n", ret);
> +		return ret;
> +	}
> +
> +	if (ep->supplies_enabled) {
> +		ret =3D regulator_bulk_disable(ARRAY_SIZE(ep->supplies), ep->supplies);
> +		if (ret) {
> +			dev_err(dev, "failed to disable regulators during suspend: %d\n", ret=
);
> +			return ret;
> +		}
> +
> +		ep->supplies_enabled =3D false;
> +	}
> =20
>  	return 0;
>  }

[Severity: High]
When exynos_pcie_phy_exit() or regulator_bulk_disable() fails in
exynos_pcie_suspend_noirq() in drivers/pci/controller/dwc/pci-exynos.c, can
returning a non-zero error code leave the PCIe Root Complex held in reset
with its PHY powered down after suspend aborts?

exynos_pcie_suspend_noirq() unconditionally calls
exynos_pcie_assert_core_reset(ep) and then exynos_pcie_phy_exit(ep). If
exynos_pcie_phy_exit() or regulator_bulk_disable() returns an error,
drivers/base/power/main.c:device_suspend_noirq() jumps to End before setting
dev->power.is_noirq_suspended:

Run:
	error =3D dpm_run_callback(callback, dev, state, info);
	if (error) {
		WRITE_ONCE(async_error, error);
		dpm_save_failed_dev(dev_name(dev));
		pm_dev_err(dev, state, async ? " async noirq" : " noirq", error);
		goto End;
	}

Skip:
	dev->power.is_noirq_suspended =3D true;

During the resulting suspend-abort recovery in
dpm_resume_noirq() -> device_resume_noirq() in drivers/base/power/main.c, t=
he
PM core checks dev->power.is_noirq_suspended and skips calling
exynos_pcie_resume_noirq():

	if (!dev->power.is_noirq_suspended) {
		if (dev_pm_skip_suspend(dev))
			dev->power.must_resume =3D false;

		goto Out;
	}

Wouldn't this leave the controller in core reset with its PHY exited while
downstream PCI devices (which suspended before the host bridge) are resumed?

[1] https://lore.kernel.org/r/20261030180902.2589-1-sreekuttan2156239@gmail=
.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031070111.3130=
-1-sreekuttan2156239@gmail.com?part=3D1
