Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322793A9635
	for <linux-pci@vger.kernel.org>; Sat, 22 Aug 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411831; cv=none; b=V/vKDKgOovib9bz8qrdt5pqryxtjzj2+YjzF6s3I8+4ozh0ZIxnjhfovpucu8BCd3kMVF8B57mrFqYuNVsIzpxN2gvXSdjwtVDBvzXgyDKgXv59ra0zGgDtW2rGg0Cicv+xtZxM0wWMZUrc233WdRjRmrsPkUDQ7WRqniPhZrtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411831; c=relaxed/simple;
	bh=ZHQiNvBwvAaRV42WkvQkeHz13P/E1L+Dagu/3Lraxuo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cB8BVU6Qa49hirPSThGgYFGqz5uuAQHkJH9/tMly3TZ+9swvLpfHDQpSxpj4U6fTPHdHRdQ8Ys2DoYynKIs4r8PTTHwVhyciJ9Ww/uEy21b8aJzQN5I+GJJFLSoEo5c7t4etpMXcIy8/tHgZc+IJB6iM2pzcY9cV66S4H3EmSe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3NnfcAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3NnfcAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F0C1F000E9;
	Sat, 22 Aug 2026 15:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787411829;
	bh=XDYQWC6gXxDNn2E5E+8SKFutmXBcUATxrdkkeQiHkCg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3NnfcAmx/qLO56gvWbzT9boflREBPvEBN6+5nJHIw7gZIOI41GrLXNVznrLoJS0z
	 0GdLavADSxf+1wKC6prHxli+n/AD/GoLYmyG/I/aK9zJCMt4IyQXm/bpis/mj9Lcox
	 mdNw7KdnoLTE5VojuXNm3jjrx5E4+oqYvyd9y9aLeGQo7ShUuozzNSet8gMyjO7HqL
	 cZ1cKxd1GB7oVDnMAIU7U83dUtBiCvnMVe/tMo1FubTlTiCYyHChdIzr63zkSqZjwp
	 VCsmq7mV54XMhzD2Z1ocI4vmIVygGGFcyD2VfhuDVT5fS1riXexEhsExedoCzsPFkl
	 ffSgdDAeul91Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: dra7xx: Fix device link leak when
 devm_phy_get() fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260822-dra7xx-v1-2-23e204d5548b@gmail.com>
References: <20260822-dra7xx-v1-0-23e204d5548b@gmail.com>
 <20260822-dra7xx-v1-2-23e204d5548b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 15:17:09 +0000
Message-Id: <20260822151709.A2F0C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup for IRQ domain and chained handler on probe failur=
e paths leads to an irq_domain memory leak and a severe Use-After-Free if t=
he interrupt fires after the probe fails.
--

--- Patch [2]: [PATCH 2/3] PCI: dra7xx: Fix device link leak when devm_phy_=
get() fails ---
commit d4c6de816ffa3fbf9a40c694558f1e94ac337fd8
Author: Felix Gu <ustc.gu@gmail.com>

PCI: dra7xx: Fix device link leak when devm_phy_get() fails
   =20
When devm_phy_get() fails, the code returned immediately and left the
already created device links behind.

Jump to the existing err_link cleanup instead so those links are
deleted on failure.

> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/contro=
ller/dwc/pci-dra7xx.c
> index d43253f7dea65..bf32b14436f97 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -740,8 +740,10 @@ static int dra7xx_pcie_probe(struct platform_device =
*pdev)
>  	for (i =3D 0; i < phy_count; i++) {
>  		snprintf(name, sizeof(name), "pcie-phy%d", i);
>  		phy[i] =3D devm_phy_get(dev, name);
> -		if (IS_ERR(phy[i]))
> -			return PTR_ERR(phy[i]);
> +		if (IS_ERR(phy[i])) {
> +			ret =3D PTR_ERR(phy[i]);
> +			goto err_link;
> +		}
> =20
>  		link[i] =3D device_link_add(dev, &phy[i]->dev, DL_FLAG_STATELESS);
>  		if (!link[i]) {

[Severity: High]
This is a pre-existing issue, but does the error path in dra7xx_pcie_probe()
and dra7xx_add_pcie_port() leak the IRQ domain and leave a chained handler
registered?

If dra7xx_add_pcie_port() fails after dra7xx_pcie_init_irq_domain()
(e.g., during devm_platform_ioremap_resource_byname() or dw_pcie_host_init(=
)),
or if dra7xx_pcie_probe() jumps to err_gpio or err_deinit later on, the
function returns without calling irq_domain_remove(dra7xx->irq_domain) or
irq_set_chained_handler_and_data(pp->irq, NULL, NULL).

Because the chained handler retains a pointer to pp (which is freed by
devres upon probe failure), could this lead to a Use-After-Free if the
interrupt fires later?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260822-dra7xx-v1-=
0-23e204d5548b@gmail.com?part=3D2
