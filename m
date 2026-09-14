Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB8248094D;
	Mon, 14 Sep 2026 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390146; cv=none; b=WwfFaFij3n8WrJ4pCz4vUAV6ErR3I4EkWLspakoolcdZXeOrfRtEdCgylddOODLqhZto8/9ElJLjYZPxdDRll078bVhiRWg26T0F5rtRV5dGgPl6d025LuHXQ3txW44p291JL1BbyK9xw4ZiFdM+QVYHNbiKWf6HGbZZnPiXJII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390146; c=relaxed/simple;
	bh=Vq6OODz2BCg/vn3bK26Ax+waxkjSGIIpxbW2p2ETn6E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=crV2TJLi+pYkRR74Dr7Q78qDIo76zMTy4pn4qYq1kyHqGakIyuAz4/LjHqW2CIE6pAHsmLWpKehmcM/FnYlKjq08BJJMmYe3TZ96Xkk5w6ufnnYwCTXrWr7ypB4R+wFUPEbxDF2BU7nIza5njAe7VFttxJ+SF6EPaGxD1C38rps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irz8mPe3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irz8mPe3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F9CC1F00893;
	Mon, 14 Sep 2026 12:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789390144;
	bh=cO8MfQgzbstSs3OjNMCZUD++0K4thea2LVqxZPsF3s0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=irz8mPe39YkjJkgZJJhdNXZ6hHsoE3XCcsbJuCtHZaA5/nU2BUthj39fjq7WuVcG3
	 1rXkeD6UDBqmRIubwn2R1nRnzMrjbyOqKHm0T0fdoLZ8G7HLcMC9OxR2EgOL4RKeG0
	 daAvyBcfSJLoyBFPMIlPqvEYn4vIcOObxXh/xOP4VzyGA/egmjdi/TiR+tydv+KgIa
	 ED8nHvjhmreM9NSiSxnG0l+pfvqJN/769RAo3po0yNpRV5XvrWitzfoX0MYw3IHdcE
	 khLQFYIDMEfOrK235deWBSxkt/Y4+J+uCnPhDSeRbhbzvWr9ziZQo+CLDt3nvDfRD6
	 u/YvkCX0Pv1gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Avoid dereferencing a NULL clock name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rudi Heitbaum" <rudi@heitbaum.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <aqfqE4OLhnN4a1lW@b65e9c1eb12f>
References: <aqfqE4OLhnN4a1lW@b65e9c1eb12f>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 12:49:03 +0000
Message-Id: <20260914124904.1F9CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of imx_pcie_host_init() is completely ignored in =
imx_add_pcie_ep().
--

commit 628ea0e01756defcb86187cc3b9ad1e2b8354965
Author: Rudi Heitbaum <rudi@heitbaum.com>

PCI: imx6: Avoid dereferencing a NULL clock name

This commit prevents a NULL pointer dereference when accessing clock IDs by
checking that clk_bulk_data::id is not NULL before using it in strncmp().
This fixes a probe crash caused by unpopulated clock names.

Link: https://lore.kernel.org/all/am8iBwJSEhYhWTqk@6cfee64030a6/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..f8dd83a88ddf7 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -542,7 +542,7 @@ static int imx_setup_phy_mpll(struct imx_pcie *imx_pc=
ie)
>  		return 0;
> =20
>  	for (i =3D 0; i < imx_pcie->num_clks; i++)
> -		if (strncmp(clks[i].id, "pcie_phy", 8) =3D=3D 0)
> +		if (clks[i].id && strncmp(clks[i].id, "pcie_phy", 8) =3D=3D 0)
>  			phy_rate =3D clk_get_rate(clks[i].clk);
> =20
>  	switch (phy_rate) {

[ ... ]

> @@ -1836,7 +1836,8 @@ static int imx_pcie_probe(struct platform_device *p=
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
This isn't a bug introduced by this patch, but I noticed a potential problem
with error handling in imx_add_pcie_ep() within this file:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
	imx_pcie_host_init(pp);
	ep =3D &pci->ep;
    ...
	ret =3D dw_pcie_ep_init(ep);
	if (ret) {
    ...
}

The return value of imx_pcie_host_init() is completely ignored. If hardware
initialization steps in imx_pcie_host_init() fail (e.g., regulator_enable or
clk_enable returning an error), it returns a negative error code.

Does ignoring this return value allow execution to proceed and initialize t=
he
endpoint on unpowered or unclocked hardware, triggering a system crash upon
register access in dw_pcie_ep_init()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/aqfqE4OLhnN4a1lW@b6=
5e9c1eb12f?part=3D1
