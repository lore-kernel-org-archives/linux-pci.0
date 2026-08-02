Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5163921C6;
	Sun,  2 Aug 2026 11:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669286; cv=none; b=sPw4jd/md6YB2Qq3ju52zEAbJ41DH0dKiVcLdYN7enbnvOcZliP/TE4z0gYkIcy+X2u7XO6qd+t2kyOsVImU4vdeYwsS0SVW7QKnXHwx+PZdJL3KC5a0FF07xWlvNIehbqgNRf310AcYqO/Iuqd3yQd6wsPSxAsoU4yl1XKJFQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669286; c=relaxed/simple;
	bh=x9o83p1zsjuLXyNfZCDCeWZzAvsAYMhbyNyylUykzeA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=glIACeqwXg8mmCuOVTtJF0rdgNflHG4EONSm/B3/qfNd6FbpspESvRy/rfZlvl/JyTL5n4mMhRH/YTvtyOQMi8xRKEdYDvrAJVVs19VleX9+bonPT77ULvOhTMvJIs/mcTXFQ0wZguF/7GbK5G2740Lag7oLgIcvQsUCVVzaNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErT9Ci90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErT9Ci90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952381F000E9;
	Sun,  2 Aug 2026 11:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785669284;
	bh=5yBL0Iwqu0wy/W23r+rmOtdbZncCkEumBLrN1hl2nVQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ErT9Ci90GGPTVmekf8BgS8JpDF2QFisdQb2nqg1B0Y6/17W1Pl22FKkcqYcmEEdXr
	 oXVQypVOmosSy4eFY11P2zJUebqYcvPTM4FPu2PczvckmfIi/dq5JJaxVgkyUtNiu0
	 3IkLr4K96nu62HzzefZoZcpzlfyInI77kIHwyPof1Y0YE7pePdgKz0wYr+1omFrQbU
	 ZYMJ2UYLZgGaZi8spZejvAslVAyZqn/8/yplaMAKrquMkCJIPvKDnNdhg9Y4kOmO2w
	 TXyMcZ8fkztKpl878WwjKzpXRWALX/ocryhTlk7iYfNgxQI6AymO5EaE/Y8qaVqLMN
	 WNL/rGWkUaNrQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, Frank.Li@kernel.org
In-Reply-To: <am8iBwJSEhYhWTqk@6cfee64030a6>
References: <am8iBwJSEhYhWTqk@6cfee64030a6>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Aug 2026 11:14:43 +0000
Message-Id: <20260802111444.952381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch successfully fixes a NULL pointer dereference in `imx_pc=
ie_probe()` by checking `imx_pcie->clks[i].id` before passing it to `strncm=
p()`, but it misses an identical preexisting vulnerability in `imx_setup_ph=
y_mpll()`.
--

--- Patch [1]: [PATCH] PCI: imx6: Avoid dereferencing a NULL clock name ---
commit 59f2384c27b018977b395ad505a6ac37e2ecf39a
Author: Rudi Heitbaum <rudi@heitbaum.com>

PCI: imx6: Avoid dereferencing a NULL clock name
   =20
This patch fixes a kernel oops in imx_pcie_probe() by checking if
clk_bulk_data::id is NULL before passing it to strncmp(). This happens
because of_clk_bulk_get() legally leaves the id as NULL for unnamed clocks.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..9a9efc2ab894a 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1826,7 +1826,8 @@ static int imx_pcie_probe(struct platform_device *p=
dev)
>  		return dev_err_probe(dev, imx_pcie->num_clks,
>  				     "failed to get clocks\n");
>  	for (i =3D 0; i < imx_pcie->num_clks; i++)
> -		if (strncmp(imx_pcie->clks[i].id, "extref", 6) =3D=3D 0)
> +		if (imx_pcie->clks[i].id &&
> +		    strncmp(imx_pcie->clks[i].id, "extref", 6) =3D=3D 0)
>  			imx_pcie->enable_ext_refclk =3D true;
> =20
>  	if (imx_check_flag(imx_pcie, IMX_PCIE_FLAG_HAS_PHYDRV)) {

[Severity: High]
This is a pre-existing issue, but this same vulnerability appears to exist
elsewhere in this driver.

In imx_setup_phy_mpll(), the driver iterates over the clocks and calls
strncmp() on the id without checking if it is NULL:

drivers/pci/controller/dwc/pci-imx6.c:imx_setup_phy_mpll() {
    ...
	for (i =3D 0; i < imx_pcie->num_clks; i++)
		if (strncmp(clks[i].id, "pcie_phy", 8) =3D=3D 0)
			phy_rate =3D clk_get_rate(clks[i].clk);
    ...
}

Could this cause a similar oops during probe when IMX_PCIE_FLAG_IMX_PHY is
used and an unnamed clock is present? Would it make sense to apply the same
NULL check to this loop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/am8iBwJSEhYhWTqk@6c=
fee64030a6?part=3D1
