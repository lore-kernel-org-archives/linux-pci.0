Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809718;
	b=bwBKWHniuCckJF5yMMSz7YiKEiY/bP3EqivI9ma0TEb042wZQuWOdvdzdchSKQ+P/w93
	 twWlFrzsKGvNufH8Bdmylg18uDR/UNmgCnFURhStQkjWhRwhG3qHnibvWIGaElGZO2yiK
	 2zTKG8Wdks20CJUwXs5/hYIojeHTc/2qkNwUaEHMQdgAENGZowUoMAEZMhjWCNFNMWt52
	 H1a4LEZpNn4PzFI1TJT+nubab/6kmfAfRB/8LSfdPEXULKsFKxkjIq/R+0ie4UtJcfPOU
	 Zl3/W4wTa75IgMig+O8+8M+CVM2GylDXzxXS2p/H4Fddm394SQp8FfnqRZqqCJGkahw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n4Azmtwx10Hkr1nN9mYjmqWcR6hOmNR+KEtibBwFiqs=;
	b=NrRCC2DYBLdyomsnyUjeHtahTePb5iXdpAuCYB73obyMdStE0LsjZJkpM3lAjombqjqH
	 na2dyDif4Yk1T+sVH6HlHoF5iOr8KXDzo0FPqSgopsvyJ8xUKxK4lX9ZNEPHE9BYEWyVN
	 T1eNzvZ7dKVv2nc8RWFMBKMOrWcgqFs1TqhKCH986jbM+T9IWwWibHiZ5yb6c4iJmSFe5
	 EqQqUzUaro4NaYOOtyAzGjRDJ5H5MO5g5opB5knpbl8CFiiGMUWDI8zU5iwij9TcuD/8W
	 EdLPkfCidqEs4C6FdIBhxhU4v9Vvcn3z9rtpXaQR9uJZE+y1XgCZO2ffrusgIOUULRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0RUG6Bl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B067606A328
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z0RUG6Bl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C8D1F0093A;
	Wed,  4 Nov 2026 16:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809718;
	bh=n4Azmtwx10Hkr1nN9mYjmqWcR6hOmNR+KEtibBwFiqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z0RUG6BlZTTdzudumDfKg0oFy3eiugufbOT+bE1ubx1ct7QBeMh5UpvyVfwP4Z53u
	 TgOe8VMn6Ij5r0H5ymHAcZ50WaMEp54ZY6/erKRwGDHZJWQSl5XfakbvyMmCgD25hx
	 N1Mif77c4JHBPR3Ygm87uQ8Px/xnnCvv3rP3t/Bk2id/Fv7g542aXh7RUrmzpt5oZt
	 OatjYxadXVi6r12lzTiLQVFd+BKAA8Rlof4y2PAmcwb72ApfTK90e17CCfGZ+n21Rs
	 PqN180ks8PecBTREedPfi1+BIFNEluZ+XNP64kPUCZiDEmVFBKeYB8WTjElvv6iLB6
	 +HbjJhfGTzeyQ==
Message-ID: <sashiko-outbox-197610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: fix use-after-free in
 pwrseq_pcie_m2_vregs_enable()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com>
References: <20261104-pwrseq-pcie-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:28:37 +0000
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
- [High] power: sequencing: overwritten ret zeroes num_vregs in pwrseq_pcie=
_m2_probe()
--

commit 4538b4fe7cf3308c45ac12f332947a46b82e94d0
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enab=
le()

This commit replaces manual regulator cleanup in pwrseq_pcie_m2_remove() and
the pwrseq_pcie_m2_probe() error path with a devres action so that the
regulator array is freed only after devm_pwrseq_device_unregister() runs.

> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c10..a794e2ad6a9c8 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -533,6 +533,14 @@ static int pwrseq_pcie_m2_create_serdev(struct pwrse=
q_pcie_m2_ctx *ctx)
>  	return ret;
>  }
> =20
> +static void pwrseq_pcie_m2_free_regulators(void *data)
> +{
> +	struct pwrseq_pcie_m2_ctx *ctx =3D data;
> +
> +	regulator_bulk_free(ctx->num_vregs, ctx->regs);
> +	kfree(ctx->regs);
> +}
> +
>  static int pwrseq_pcie_m2_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> @@ -561,21 +569,21 @@ static int pwrseq_pcie_m2_probe(struct platform_dev=
ice *pdev)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to get all regulators\n");
> =20
> +	ret =3D devm_add_action_or_reset(dev, pwrseq_pcie_m2_free_regulators, c=
tx);
> +	if (ret)
> +		return ret;
> +
>  	ctx->num_vregs =3D ret;

[Severity: High]
In drivers/power/sequencing/pwrseq-pcie-m2.c, pwrseq_pcie_m2_probe() stores
the number of regulators returned by of_regulator_bulk_get_all() in ret, but
then overwrites ret with the return value of devm_add_action_or_reset()
before setting ctx->num_vregs =3D ret.

When devm_add_action_or_reset() succeeds, ret is 0, so ctx->num_vregs is
always set to 0. Doesn't this cause pwrseq_pcie_m2_vregs_enable() and
pwrseq_pcie_m2_vregs_disable() to pass 0 to regulator_bulk_enable() and
regulator_bulk_disable(), leaving the M.2 connector regulators unpowered?

Also, because ctx->num_vregs is 0 both during devm_add_action_or_reset() and
afterward, pwrseq_pcie_m2_free_regulators() will call
regulator_bulk_free(0, ctx->regs) and leak the struct regulator references =
in
ctx->regs before freeing the array. Should ctx->num_vregs =3D ret be assign=
ed
before calling devm_add_action_or_reset()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104-pwrseq-pci=
e-m2-uaf-v1-1-0ae1bbea9533@oss.qualcomm.com?part=3D1
