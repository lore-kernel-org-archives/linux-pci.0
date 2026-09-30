Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0014C9E0B
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790769162; cv=none; b=meXe1pv3g1OAL5muSM0tGaGS5h4/p6wXEUB55Qlu41xZam2FkWUx/DoqYDKcgXdYMqm3RNuXDXnbhITe+d/ZX4Vjx/LseH62Bdw4/diEhrIDIl2to0uRD7ZFBA4IF5FuS0m25mlqslsaz+1w2UhpHjpIS833ddVz/zwX+B3POvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790769162; c=relaxed/simple;
	bh=BdIxWachVR459y+6ZbAJBBugNZKqkJCSHnBMYrwnoss=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VaWJC5b4Gjs1t5yYMTwhE/eO6sc28CALp9HR+TTYCzA1StM9u1uIj1emW1TagkzVWjX1/QfOzWwtJtVCzphfXmYqcZUwWH69Wxbw25o8umX3+zJRJWRnFOMTUSNzKLk0MLRTgsMbhgwI3gat9zMzjCAIh1+tm+gPjvVYXupfW2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig2jPWED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig2jPWED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 516471F000FF;
	Wed, 30 Sep 2026 11:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790769160;
	bh=7WEylgxo8Zianlu26hEoLK+z0yCBB0+KAJNlYS1zMz4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ig2jPWEDudu4DdufmNnnus7nzapcZUwgBfElWMr6HMRG0ECSRrdJP16yi0raLpUT+
	 VrpL1JRKx1vI7n3pBRhUQfe8RxpBCW6tiGjQbEmoyTTkErO/TnuSzlrz8Gv8xDQkXY
	 Aof9xYmB0lwL/y3Lzr/o6qyYkh46OsIR8rqWlObPGEXSR/njlyZ5ka7fMF2dr1rt6R
	 qrvYeS+iy/6FLKx9V6Ap6H0LNYSUBldUvERSKdBT9XvVtdUnYAvUXdH+tlAAt9YfY5
	 IgY23TQwGQO/IVRHd8mZajnvBqffRCiKHvwjNokcL7yAqVHY0baX1jZQwBewrae9Rs
	 Itn+b55AnCa8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: mediatek: Fix integer truncation and handle
 oversized resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930114218.2655-1-sreekuttan2156239@gmail.com>
References: <20260930114218.2655-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 11:52:39 +0000
Message-Id: <20260930115240.516471F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: mediatek: build failure due to invalid port->dev access
--

commit 40759eff660bb6850cba10f5b37e699dc72c75cb
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

PCI: mediatek: Fix integer truncation and handle oversized resources

This commit fixes integer truncation issues when calculating the size order
for AHB to PCIe translation windows by using fls64(). It also adds checks
to return -EINVAL if the resource size exceeds the maximum supported 31-bit
window order.

> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/control=
ler/pcie-mediatek.c
> index 3a3e91cd0c211..1b0ab5a2c73cc 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
[ ... ]
> @@ -753,8 +756,18 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_=
port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	if (!size)
> +		return -EINVAL;
> +
> +	size_order =3D fls64(size - 1);
> +	if (size_order > 31) {
> +		dev_err(port->dev, "Memory resource size too large: %pa\n", &size);

[Severity: Low]
Does this code compile? Looking at the definition of struct mtk_pcie_port,
it does not appear to have a dev member.

Could this be causing a build failure, and should it use port->pcie->dev
instead?

> +		return -EINVAL;
> +	}
> +
>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);
>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);
[ ... ]
> @@ -829,8 +844,18 @@ static int mtk_pcie_startup_port_en7528(struct mtk_p=
cie_port *port)
>  		mtk_pcie_enable_msi(port);
> =20
>  	/* Set AHB to PCIe translation windows */
> +	size =3D resource_size(mem);
> +	if (!size)
> +		return -EINVAL;
> +
> +	size_order =3D fls64(size - 1);
> +	if (size_order > 31) {
> +		dev_err(port->dev, "Memory resource size too large: %pa\n", &size);

[Severity: Low]
This looks like the same build issue here. Should this use pcie->dev,
since struct mtk_pcie_port lacks a dev member?

> +		return -EINVAL;
> +	}
> +
>  	val =3D lower_32_bits(mem->start) |
> -	      AHB2PCIE_SIZE(fls(resource_size(mem)));
> +	      AHB2PCIE_SIZE(size_order);
>  	writel(val, port->base + PCIE_AHB_TRANS_BASE0_L);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930114218.2655=
-1-sreekuttan2156239@gmail.com?part=3D1
