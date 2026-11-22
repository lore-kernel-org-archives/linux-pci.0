Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795330852;
	b=Q+0i6Vc9++Z5PNfBlTR5kp5iuKLc8QX6SgXCmzUEgEY4gR+9he6FHjMdkGWfz8204bkQ
	 esRR9J9TaHzj6OQUq+vUd9QKOMCtfKjPRjd36hUU8qgvoY6ato5wlvK+7RWJ9ztt/W3DH
	 +PLKeinQX1518WdseQxf2bULrJ8PjInyWLCl6vHeUqcItdHRrCvOltB6GGbANcjT7xRI6
	 Y4YTMaX4ChDEQmjX7+2N9nU7ST7bqVcz0utSum1Et6yeaC/nC42cgFK/K1L8jq/XNYX2q
	 jirbNsXRCcBTaqcbg6P8jFqd7MzyWX5fRvfgG/p2B4/Z+qJuQgMTn1KVbZarR0KKlHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795330852;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4mtnUF0ZD+iD0QNuZlPCLnIZsxaQq88aTBKDapWOksA=;
	b=ZGVe1Mv9nvZlfo1AII9mwWrajoo0geybuIkqBMGw1G/+tysaBCM0gSIZ1YtXM7b7KkwO
	 NmdJfzNtyopUz1MUHrC++QO+Id0d6dlqUJfaDcxgN7pNsgCppsftklUukkSY4UApLGuB5
	 vEBDK0cD/iDvl6ZqLNmRk+sQVFUaiYzH4+wdjLIr9OGsMILKuNuCqWyrd4ZSN7F3TrA9l
	 9htguo65xoP8i7N6pPdKw+1DqbvqfOXjXRIcPgk8THj9mn9nGqJZ/g5RGnRrS0YKST54V
	 iB4b4f2YMaQdxpj+S5xkLm1WUrh5qpGp9b9TsrlTX7q1efXsPAAWy8kn+GkMFAGu+qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJNXawat;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F58606A32C;
	Sun, 22 Nov 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJNXawat
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09821F000C4;
	Sun, 22 Nov 2026 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795330852;
	bh=4mtnUF0ZD+iD0QNuZlPCLnIZsxaQq88aTBKDapWOksA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QJNXawatCuzqiN3ytxKy0Y3+FjNWDA/5lDMBbHZ94hYFhj0yNgbb8h9P3N6AO+Uld
	 qDMLLeY+8kezLGs7GQjgAJSyLSsMRltL3l+ZWIX9itT4JEmmts5omm3wJI8lr+CEbQ
	 40r5CEvrM/8bkldf++X5pqsU6ulPwG8ZL+mH8BWWdxsfx8KJB/J3o15UtheBNoKE5V
	 SPmJccodhEqstLCTwNm3GrPPnEU7njIzL3TB9hYQpBTnYZLoGkkRh/H/snniLa6ixo
	 GrCtRbErOUeg+0Ff19rz7OcJQPoUm+3b+ylb77zW2cH6sfESxpp2oKXsz21T3IxnET
	 O9hgJivA06Hew==
Message-ID: <sashiko-outbox-227775@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Krishna Chaitanya Chundru" <krishna.chundru@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com>
 <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 22 Nov 2026 07:00:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] power: sequencing: pcie-m2: regulator leak on GPIO error in
  pwrseq_pcie_m2_probe()
- [Low] power: sequencing: pcie-m2: missing GPIO rollback in
  pwrseq_pci_m2_b_pcie_enable()
--

commit 7e388f1a5a5b0e7dcbfd3500f89d85602dad1287
Author: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

power: sequencing: pcie-m2: Add support for PCIe M.2 Key B connectors

This commit adds power sequencing support for PCIe M.2 Key B connectors,
handling the power supplies along with the FULL_CARD_POWER_OFF#, RESET#,
and W_DISABLE1# GPIOs.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c10..8af4a059b5961 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
[ ... ]
> @@ -135,6 +137,45 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_=
e_pcie_unit_data =3D {
>  	.disable =3D pwrseq_pci_m2_e_pcie_disable,
>  };
> =20
> +static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrseq);
> +	int ret;
> +
> +	ret =3D gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +	if (ret)
> +		return ret;
> +
> +	return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);
> +}

[Severity: Low]
If gpiod_set_value_cansleep() fails on ctx->reset_gpio or
ctx->w_disable1_gpio, should this restore the earlier GPIOs back to 1
before returning?

When unit->enable() fails, pwrseq_unit_enable() disables the regulator
dependency units without calling unit->disable(), leaving
ctx->full_card_power_off_gpio (and ctx->reset_gpio) deasserted while
power is off.

[ ... ]

> @@ -577,6 +632,17 @@ static int pwrseq_pcie_m2_probe(struct platform_devi=
ce *pdev)
>  		goto err_free_regulators;
>  	}
> =20
> +	ctx->full_card_power_off_gpio =3D devm_gpiod_get_optional(dev, "full-ca=
rd-power-off",
> +								 GPIOD_OUT_HIGH);
> +	if (IS_ERR(ctx->full_card_power_off_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->full_card_power_off_gpio),
> +				     "Failed to get the FULL_CARD_POWER_OFF# GPIO\n");
> +
> +	ctx->reset_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIG=
H);
> +	if (IS_ERR(ctx->reset_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
> +				     "Failed to get the RESET# GPIO\n");
> +

[Severity: Medium]
Do these error paths leak ctx->regs and the regulator references acquired
by of_regulator_bulk_get_all()?

Unlike the w_disable1_gpio and w_disable2_gpio checks right above,
returning directly here bypasses the err_free_regulators label that calls
regulator_bulk_free() and kfree(ctx->regs).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261122-pcie6_fix-=
v2-0-2e0fe615d90b@oss.qualcomm.com?part=3D2
