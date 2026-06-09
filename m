Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A323815D9;
	Tue,  9 Jun 2026 03:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977246; cv=none; b=Go+/OQYa1nOpaXwejs653ze+q5qe0VwsL65zM37umJIdCMddtTtByPs/6KuGLOvosGlAPxMugZ2cHinPJEtksnBGMaDwyjO9QEICpA7syMYxsciCgsU2AR+j9zfbCSlA9EVve6OhDqCd2zSQ6PiEXeSfUBL0r8+gPzHn494z3zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977246; c=relaxed/simple;
	bh=DVt2N70Ge9RK+2Fe+LTuDnd6NvNllz8xU7VfJtlzDi8=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dV03vdTvstyTAPuPhSw5glGaaq3KYSOHanVAPp68apr3qz427osblnkHuBdpuV4n5qTKSx+9nsKLRTGsd/s99e9VP4w4EYY6bWqa37NthZiZg9XmyoGk/API+szDK2N7UvJDX/thklcX5/HL/PF2WzZTQJDexpAl5hvfDqFyoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2MctRn/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2MctRn/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBCAC1F00893;
	Tue,  9 Jun 2026 03:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780977245;
	bh=3wsmRwoh3u8MY5VATso62BKTwIJl0XYCh32QDxuC4NM=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=e2MctRn/qk5PAFnMeHzwOav8X2gTqIfUjXHbknGt9MuE7R1NFic3/nn9iPpo0Zi20
	 GJVxd0Bbhk5JZeVlD4wayA8WpQWxbXy3CkM9uEDEcYsXtQBUI111Wbw75NZVhO5/Bu
	 wgYBSoxjqx1hawqHLPaduD9nAfQK5wyKfz/xmvXJQLsYT6nE0ZUMqu+gw2BJ2BKL98
	 o/b8B35S3W1BEPsEBm+jzjK3qpfz0rdNkN/qkwlcY+ga9lgj2VMo1bk7NKfEB8rRMy
	 42x5TzAdsSASPV3vMMBaIIvgNCc01jgbeXhjJ/+bQDCByC/sXrjSj0xEGXNOxVYiiN
	 1/paZQOHv9uqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] power: sequencing: pcie-m2: Add 3.3Vaux supply
 support
Reply-To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, Frank.Li@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, imx@lists.linux.dev, devicetree@vger.kernel.org
In-Reply-To: <20260609033840.2006078-3-sherry.sun@oss.nxp.com>
References: <20260609033840.2006078-3-sherry.sun@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 03:54:04 +0000
Message-Id: <20260609035404.DBCAC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Data race on `ctx->vaux_enabled` and unprotected access to `ctx->v=
aux_reg` between `pwrseq_pcie_m2_remove()` and concurrent power sequencer c=
allbacks.
- [Medium] If `probe` fails after the power sequencer has been registered a=
nd a consumer has already utilized it, the `vaux_reg` regulator is never di=
sabled. This leaks the enable count and causes a `WARN_ON` during `devres` =
cleanup.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the `regulator_b=
ulk_enable()` error path will dereference an uninitialized `.supply` pointe=
r, leading to a kernel crash. This occurs because `of_regulator_bulk_get_al=
l()` allocates the consumers array without zeroing memory.
- [High] This problem wasn't introduced by this patch, but there is a NULL =
pointer dereference of `ctx->regs[i].consumer` causing a Use-After-Free ker=
nel crash if a consumer unbinds concurrently with or immediately after the =
provider's `remove()` function.
--

commit ecd4292236752225aeb9fc0b3242e75d18056e96
Author: Sherry Sun <sherry.sun@nxp.com>

power: sequencing: pcie-m2: Add 3.3Vaux supply support

This commit adds support for the 3.3Vaux supply to the PCIe M.2 power
sequencer. The supply is handled separately because it has a different
lifecycle and must remain enabled during system suspend for L2 link states.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index e82821655fc4b..6b8c77cf20a9c 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
[ ... ]
> @@ -48,8 +50,23 @@ struct pwrseq_pcie_m2_ctx {
>  static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	/* Enable 3.3Vaux if present and not already enabled. */
> +	if (ctx->vaux_reg && !ctx->vaux_enabled) {
> +		ret =3D regulator_enable(ctx->vaux_reg);
> +		if (ret)
> +			return ret;
> +		ctx->vaux_enabled =3D true;
> +	}
> =20
> -	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +	ret =3D regulator_bulk_enable(ctx->num_vregs, ctx->regs);

[Severity: High]
This is a pre-existing issue, but does this regulator_bulk_enable() error
path handle uninitialized pointers correctly?

If regulator_bulk_enable() fails, its error unwind path attempts to print
the name of the failing supply. However, of_regulator_bulk_get_all()
allocates the consumers array using kmalloc_objs() which does not zero
memory, leaving the .supply field uninitialized.

Could this lead to an out-of-bounds read and kernel panic when the error
message dereferences the uninitialized string pointer?

> +	if (ret && ctx->vaux_reg && ctx->vaux_enabled) {
> +		regulator_disable(ctx->vaux_reg);
> +		ctx->vaux_enabled =3D false;
> +	}
> +
> +	return ret;
>  }
[ ... ]
> @@ -497,10 +514,28 @@ static int pwrseq_pcie_m2_probe(struct platform_dev=
ice *pdev)
>  		return dev_err_probe(dev, -ENODEV,
>  				     "Failed to obtain platform data\n");
> =20
> +	/*
> +	 * Get 3.3Vaux separately for special handling. This supply has a
> +	 * different lifecycle - it must remain enabled during system suspend
> +	 * to support PCIe L2 link state and wake-up mechanisms.
> +	 */
> +	ctx->vaux_reg =3D devm_regulator_get_optional(dev, "vpcie3v3aux");
> +	if (IS_ERR(ctx->vaux_reg)) {
> +		if (PTR_ERR(ctx->vaux_reg) !=3D -ENODEV)
> +			return PTR_ERR(ctx->vaux_reg);
> +		ctx->vaux_reg =3D NULL;
> +	}
> +	ctx->vaux_enabled =3D false;
> +

[Severity: Medium]
If pwrseq_pcie_m2_probe() fails later on (for example, in
pwrseq_pcie_m2_create_serdev()), is the vaux_reg properly disabled?

When devm_pwrseq_device_register() succeeds, the power sequencer becomes
active and a consumer can synchronously bind and call pwrseq_power_on(),
setting ctx->vaux_enabled to true.

If the probe subsequently fails, the err_free_regulators error path calls
regulator_bulk_free() without explicitly disabling ctx->vaux_reg. When the
consumer is unbound by devres and calls pwrseq_power_off(), it skips
disabling vaux_reg because the driver relies on explicit cleanup.

Could this leak the enable count and cause a kernel warning during devres
cleanup?

>  	/*
>  	 * Currently, of_regulator_bulk_get_all() is the only regulator API that
>  	 * allows to get all supplies in the devicetree node without manually
>  	 * specifying them.
[ ... ]
> @@ -573,6 +608,11 @@ static void pwrseq_pcie_m2_remove(struct platform_de=
vice *pdev)
>  	pwrseq_pcie_m2_remove_serdev(ctx, NULL);
>  	mutex_destroy(&ctx->list_lock);
> =20
> +	if (ctx->vaux_reg && ctx->vaux_enabled) {
> +		regulator_disable(ctx->vaux_reg);
> +		ctx->vaux_enabled =3D false;
> +	}
> +

[Severity: High]
Are these accesses to ctx->vaux_enabled and ctx->vaux_reg protected against
concurrent modification?

This check and regulator_disable() are called without holding the
pwrseq->state_lock. Since devm_pwrseq_device_register() was used, the power
sequencer remains available to consumers until devres cleanup runs strictly
after pwrseq_pcie_m2_remove() completes.

If a consumer concurrently invokes pwrseq_power_on(),
pwrseq_pcie_m2_vregs_enable() executes and modifies ctx->vaux_enabled under
the lock.=20

Could this race lead to an unbalanced disable warning or leave the regulator
disabled prematurely while a consumer thinks the power sequence completed
successfully?

>  	regulator_bulk_free(ctx->num_vregs, ctx->regs);

[Severity: High]
This is a pre-existing issue, but does this regulator_bulk_free() call
introduce a risk of dereferencing a NULL pointer?

The regulator_bulk_free() call explicitly sets consumers[i].consumer to
NULL. However, because the device was registered with
devm_pwrseq_device_register(), it is still active in the pwrseq core until
devres callbacks run.

If a consumer unbinds concurrently and invokes pwrseq_power_off(),
pwrseq_pcie_m2_vregs_disable() securely calls regulator_bulk_disable().

Could this cause a kernel crash when the bulk disable function blindly
dereferences the consumers[i].consumer pointers that were just set to NULL?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609033840.2006=
078-1-sherry.sun@oss.nxp.com?part=3D2
