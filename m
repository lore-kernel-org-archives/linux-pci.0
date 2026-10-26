Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016675;
	b=pZvfitu8azjsUp2zYoLUdhE8Ao9Wl5SKiR2dN652rhs19vu0ONtLZFpaMBaeZ1XUbAGG
	 iDzczOGzHapXIPxKdnfh+5RYRvZneOQ/MakwSvuY9VrIY0S3AuJ0AQC1yet9JtfFZBYKO
	 TRcBp+7NLDS0hwMt+WKHC+1l+AkAgaP548vpc6lbgMt50Kg2CiHDfOTg0XPOLBbEhs6kE
	 vISJNl1SlskUlm4DfUfjqfmSrerXyyOIl/FrbZPqOIPrie/M2FPAoburUtFqjtP6PxPIh
	 rfVMePUpLZxRJpkzUkfx2MoeaIrzsi3eXz9+UK47NGDp0NSIF5uMnloh5Ovhtz6LZUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016675;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8sHwlh4zlIZRYgYof5AkKe1QjtDKH6kPII2yHGPCHxg=;
	b=pVGDvYVr/PhjltagOGksoivvxUtZ8s+qDoU3x0C92CzBpgYxEtPG7Pjcr2i/2dD5z+mv
	 HLxyxdXzTaJRrpaurUpA/aZTz3PF1+7mIytsJ3/uEWqninX6PoKKpp9pR1KHob74d6jIO
	 ROgxJBBDjUoghz0ksoiS8nD0PPdun/IrKksYwZNREFb1VlYCV5bOjBvR51ERYhwX3a5tX
	 Ll8Fg/2fHtYdhF+GLniA9EgkTJ5EsXEGEFixGVeC3l19WYYt4DCEfWhHjx0xBAmP5McXQ
	 h1obSJdX+NYQMdz9cv8rwyIQeaj+oD7ySS++XJJlQbUQzdJMVo4vdHYFF6eJth5Dkeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BK43soQQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF27606A31B
	for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2026 12:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BK43soQQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D45C51F01825;
	Mon, 26 Oct 2026 12:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016675;
	bh=8sHwlh4zlIZRYgYof5AkKe1QjtDKH6kPII2yHGPCHxg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BK43soQQIfpKRkHiQdqNs669zf/yRf7+72Be1P/THuS4tHPAdIZVFj5+W52A93RH3
	 y3b9Us3Li/dnXNkuOXY6HuLVngt34u5fKxzVFVl64oeP33/wcMUJagBN8EpCLoI0Y7
	 csplKQBo/HxK+vYIjg8Wg7GsHpP6PqPF4mXgayKiNvUAS8U8NUYdxH0RWswnIjT3e+
	 OpPPD044M0mZVBgKgHw9cfgyxmLPUSBSp1/C3NKuw3FSuRjEDlxbwotPf/jGt+N/sl
	 8p98vALbPdRrIx/J3lqgm6mrIbo+WtxluOr/CQQNJo/0v9VyI0ZsGn9nLH3wpOKd2m
	 kgZ49ih7fbg7w==
Message-ID: <sashiko-outbox-185177@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Drive the Key E SDIO_RESET#
 signal
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Bright" <william.bright@imd-tec.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
References: <20261026-pwrseq-pcie-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:11:14 +0000
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
- [Medium] pwrseq: pcie-m2: regulator enable leak in pwrseq_pcie_m2_vregs_e=
nable()
- [Medium] pwrseq: pcie-m2: missing rollback on error in pwrseq_pcie_m2_vre=
gs_disable()
--

commit e3e29ad909cb95485a7ebf63430d7d702095bb39
Author: William Bright <william.bright@imd-tec.com>

power: sequencing: pcie-m2: Drive the Key E SDIO_RESET# signal

This commit requests the optional sdio-reset-gpios line asserted during pro=
be,
deasserts it after enabling the M.2 connector supplies, and asserts it again
before disabling the supplies.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c10..f8791e8080bdd 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -39,6 +39,7 @@ struct pwrseq_pcie_m2_ctx {
>  	struct notifier_block nb;
>  	struct gpio_desc *w_disable1_gpio;
>  	struct gpio_desc *w_disable2_gpio;
> +	struct gpio_desc *sdio_reset_gpio;
>  	struct device *dev;
>  	struct list_head pci_devices;
>  	struct mutex list_lock;
> @@ -47,13 +48,23 @@ struct pwrseq_pcie_m2_ctx {
>  static int pwrseq_pcie_m2_vregs_enable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	ret =3D regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +	if (ret)
> +		return ret;
> =20
> -	return regulator_bulk_enable(ctx->num_vregs, ctx->regs);
> +	return gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 0);
>  }

[Severity: Medium]
Does pwrseq_pcie_m2_vregs_enable() leak the regulator enable reference coun=
ts
in ctx->regs if gpiod_set_value_cansleep() fails (for example, when
sdio-reset-gpios is backed by an I2C GPIO expander)?

In drivers/power/sequencing/core.c, pwrseq_unit_enable() only disables
unit->deps when unit->enable() returns an error and does not increment
unit->enable_count or invoke unit->disable():

drivers/power/sequencing/core.c:pwrseq_unit_enable() {
	...
	if (unit->enable) {
		ret =3D unit->enable(pwrseq);
		if (ret) {
			dev_err(&pwrseq->dev,
				"Failed to enable target '%s': %d\n",
				unit->name, ret);
			pwrseq_unit_disable_deps(pwrseq, &unit->deps);
			return ret;
		}
	}

	unit->enable_count++;
	...
}

Should pwrseq_pcie_m2_vregs_enable() call regulator_bulk_disable(ctx->num_v=
regs,
ctx->regs) before returning when gpiod_set_value_cansleep() fails?

> =20
>  static int pwrseq_pcie_m2_vregs_disable(struct pwrseq_device *pwrseq)
>  {
>  	struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	ret =3D gpiod_set_value_cansleep(ctx->sdio_reset_gpio, 1);
> +	if (ret)
> +		return ret;
> =20
>  	return regulator_bulk_disable(ctx->num_vregs, ctx->regs);
>  }

[Severity: Medium]
Similarly, in pwrseq_pcie_m2_vregs_disable(), what happens if
regulator_bulk_disable(ctx->num_vregs, ctx->regs) fails after
ctx->sdio_reset_gpio has been asserted?

When unit->disable() fails in drivers/power/sequencing/core.c,
pwrseq_unit_disable() aborts without decrementing unit->enable_count and ro=
lls
back the dependent unit by calling its unit->enable() callback, leaving the
regulators and power sequencer state enabled while ctx->sdio_reset_gpio rem=
ains
asserted.

Should ctx->sdio_reset_gpio be deasserted again if regulator_bulk_disable()
returns an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-pwrseq-pci=
e-m2-sdio-reset-v1-1-02ecdafce518@imd-tec.com?part=3D1
