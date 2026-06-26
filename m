Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFE30C167
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489436; cv=none; b=uZiQnsgYUKOywX7afgikiT9+oHR2n1lzXAbW8RGUu/qXjZa6NjXsB3ssn1B2Dbo6Nw6/rhjoEf7QPD8TDvXrG7ZB5hAHnHS6Hi33sBOmwDRRWgkYxtMQHVRHGVIDUQ8Xkn7Nzuk9bxvefXnGFPMoOsB8h1sq4XHrLRVNm+lKwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489436; c=relaxed/simple;
	bh=ladzju9YpnnDRzvBIlHqU8PhHE+9dX+Fl3mcJfFVd8g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YIwm6NUV0OipkVdtuf4hv2HZDMP9iYSkewkuLjTiwB/MDGFB5pxncioROxNsIIMpS4nCjoqmic1OuP9r3Cx+t6VXi0rtdaDIDHtr77P9iPYMKY7Yd7/RQLplD8l39yg7bPHEmdtzADDb4++wQguxdr7GxamAp82XL3oevsBa+vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXe9NN74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXe9NN74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01EAC1F000E9;
	Fri, 26 Jun 2026 15:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782489435;
	bh=4EP8eUg4EBnrPKX1GtOYZwhG19vnpU2uyNyST6US1Os=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gXe9NN744e6Nw+aC8n18W//Pa1puXXlbOeHh/uPxKdDDVAy9MzUytJrh3N9RiqvjA
	 /My7dXXnpfMWZwHJy5wxnUqU9/LH1jZec6NAEK782bxwuLIVhe7wfjPQnC34dyL+py
	 xWvj1I1Z77Kj/Z1BHniyvOBhwgPcuMClPMaEZCsax19OIjzR8TcNAp6NTad8YIt196
	 RZ/usdksKiuXUpuWBAAvUHhu4g2IZXzOw1TGJS9CaAq9pXaqMlf08DD3rtS8+7MXaX
	 ovXuiqg9f4p4fc9LxQlfD9X6S6W8BXe5h1B9tF+mf6upEoJfGE8Bq/h/99sQijdspk
	 1ywKHJH6yRxmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing
 device_link_del on phy   error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "WenTao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260626154809.53770-1-vulab@iscas.ac.cn>
References: <20260626154809.53770-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:57:14 +0000
Message-Id: <20260626155715.01EAC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double cleanup of PHY resources on error path.
- [Low] Compilation error due to undefined label `err_link`.
--

commit 51479d1472b27aa065c936360d150e8e275d37b6
Author: WenTao Liang <vulab@iscas.ac.cn>

fix: PCI: dra7xx: dra7xx_pcie_probe: fix missing device_link_del on phy err=
or paths
   =20
This commit addresses a device link leak in the phy error paths of
dra7xx_pcie_probe(). It changes the error paths to jump to the err_link
label to properly call device_link_del() for each link. It also updates
the phy enable error paths.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index 3fc889944f021..c54d68cf0e412 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c

[ ... ]

> @@ -766,7 +768,8 @@ static int dra7xx_pcie_probe(struct platform_device *=
pdev)
>  	ret =3D dra7xx_pcie_enable_phy(dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -		return ret;
> +		dra7xx_pcie_disable_phy(dra7xx);
> +		goto err_link;
>  	}

[Severity: High]
Does this cause a double cleanup of the PHY resources?

When dra7xx_pcie_enable_phy() fails, it already cleans up any partially=20
enabled PHYs internally before returning. Calling dra7xx_pcie_disable_phy()=
=20
here will repeat the cleanup on the same PHYs, which could lead to=20
unbalanced reference counts in the PHY framework (underflowing power_count=
=20
and init_count).

[ ... ]

> @@ -909,7 +912,8 @@ static int dra7xx_pcie_resume_noirq(struct device *de=
v)
>  	ret =3D dra7xx_pcie_enable_phy(dra7xx);
>  	if (ret) {
>  		dev_err(dev, "failed to enable phy\n");
> -		return ret;
> +		dra7xx_pcie_disable_phy(dra7xx);

[Severity: High]
Similar to the probe function, could this cause a double cleanup of the=20
PHY resources since dra7xx_pcie_enable_phy() handles its own cleanup on=20
failure?

> +		goto err_link;

[Severity: Low]
Does this label exist in this function?

It appears that the err_link label is not defined anywhere in=20
dra7xx_pcie_resume_noirq(), which will result in a compilation error.

>  	}
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626154809.5377=
0-1-vulab@iscas.ac.cn?part=3D1
