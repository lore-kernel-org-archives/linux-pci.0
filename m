Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C267A34040A
	for <linux-pci@vger.kernel.org>; Sun,  2 Aug 2026 22:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785709149; cv=none; b=emkymSxAwEHo59HqHpZXdMxpyUpsdTruDG4j+TU6yeGCOPHnyZBCQktQxk/Ee/3v5bu8hQEp+SeuI/YUR8eF/Xs4UID9Hh9ezKo80T3JJM/e5OUJ79Cq7duJqC8YYjyVeGtBCyAT0OAZmvq9+sjkEvSW/GUBLnZ3rUMPhX8O6+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785709149; c=relaxed/simple;
	bh=PEbcJvfFp3r2g/3f6lyav/Duh8YOlo2r0G+sdloxdsw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FLdDQpIjuB7Agxn6D55ubEFu64VWYD8STbIUduRgc5OysNFsYjyeCSkml7kxcFyAzc7Cnqoj0l/XFWz8tJp8JKe/rTVyn/qo651eH5M6AXm4fmBhVi8n0OpL2yB19ArWI12CmA+eg8yTqRHZgti7d7QlD18rTtDW1TgU3eydmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=II9M4So/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="II9M4So/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1B61F000E9;
	Sun,  2 Aug 2026 22:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785709148;
	bh=5wmSQ7FfvkG9jJbRu/YBoFz093ndpNdBJvhP2mj8RCw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=II9M4So/DCRLztBkoufCWyRh502w8Gn3cGRQdGT9JuRgQMy8wNoMF3FJrjCPfxdR4
	 MckY25VY7QLtVLsJn+jqbXFsjaR3jyEuuNxSathC/OxCqr37dS6HwXFSMmoeGsr5PJ
	 lDd1PrhUF61uvw3WULpHYOPj0NY7E0/egqjTWzo9I+eGkw4R97BXerjspTsnKbZf00
	 YYiL0dGt0lAljqNDR4BX0UI+GyxglwcpimmgXK/IrOg23MS9MFkwzyD7Z23TceS2s0
	 si9X1qLqeqynH8v8QLs6z8At0K+oLxuVpm2Ubth4HJpnz/sfIkiiWTbxrqgAL1KUtg
	 ej6lGtIbkeF0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] PCI: xgene: Use managed clock for PCIe controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuho Choi" <dbgh9129@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260802221146.573233-1-dbgh9129@gmail.com>
References: <20260802221146.573233-1-dbgh9129@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 22:19:07 +0000
Message-Id: <20260802221907.DF1B61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Spurious error messages logged when `devm_clk_get_enabled()` ret=
urns `-EPROBE_DEFER`.
--

--- Patch [1]: [PATCH v1] PCI: xgene: Use managed clock for PCIe controller=
 ---
commit 0cead2017a15cf2ef3dd587c853cc1410cad1d70
Author: Yuho Choi <dbgh9129@gmail.com>

PCI: xgene: Use managed clock for PCIe controller

This commit simplifies the xgene PCIe port initialization by replacing
manual clock retrieval and enablement with devm_clk_get_enabled(). This
automatically handles unwinding the clock on probe failure and device remov=
al.

> diff --git a/drivers/pci/controller/pci-xgene.c b/drivers/pci/controller/=
pci-xgene.c
> --- a/drivers/pci/controller/pci-xgene.c
> +++ b/drivers/pci/controller/pci-xgene.c
> @@ -321,18 +321,11 @@ static void xgene_pcie_linkup(struct xgene_pcie *po=
rt,
>  static int xgene_pcie_init_port(struct xgene_pcie *port)
>  {
>  	struct device *dev =3D port->dev;
> -	int rc;
> =20
> -	port->clk =3D clk_get(dev, NULL);
> +	port->clk =3D devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(port->clk)) {
>  		dev_err(dev, "clock not available\n");
> -		return -ENODEV;
> -	}
> -
> -	rc =3D clk_prepare_enable(port->clk);
> -	if (rc) {
> -		dev_err(dev, "clock enable failed\n");
> -		return rc;
> +		return PTR_ERR(port->clk);

[Severity: Medium]
Does this unconditional dev_err() cause log spam during boot if
devm_clk_get_enabled() returns -EPROBE_DEFER?

Could dev_err_probe() be used here instead?

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260802221146.5732=
33-1-dbgh9129@gmail.com?part=3D1
