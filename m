Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1824B3C2781;
	Thu, 13 Aug 2026 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786615077; cv=none; b=GJlJ1mx/VjbYf309UEpkYJH9f0PCBr8fd5M/0Ca0wXTHeMHCucmxTVJqIh1N8hfgjobFW52jSfrHGAkd5/wWII5T+7kBjcfPVwSSyPdv4ZV0Bz4SxbRgpyS3isM2Nx/IlqThVkXfmggDXISB5RSPLzbc4DBgyTB6+Z2GHAHIs1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786615077; c=relaxed/simple;
	bh=NptURpICQd8N23fpZtmaU5+g6n8PgK1IHFXtYIrhcZk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Fop2qwMuM5wCGLa82fGuPjtKj0HZRk0r+5WnxgGLwABe4cTVJYJfENp3Ke9BrhL0YiOrz9nAIfNWnZgN2PhlPzXdEvRUn8aImbeQo6W/wAryWnKHId4QSGovsGTOY6+kYEdkzwsr1nbG4u+OtxdLGlaYOTeTvcqlkaL83IBngFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWPRVpan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWPRVpan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC41F00A3D;
	Thu, 13 Aug 2026 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786615075;
	bh=SZ4MasxWI7HX2m1vv3KvMGQUrs60c6qOCvFdDZkLdhc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DWPRVpanbT6hOPS2mNXzl3v3ObIGJp1iKpQA1MlPNLSGZ92yzW01sdsK8puEO63UN
	 xtCiBTtXp7jIajfETPOlpAlNZ55vBWgBrgGgL0mGrZWdR4wU3Q3q0f1rHovDDjrLjX
	 pwamfq/FPgjVApllo8/kGbp17/5/QIToopnbtef04M3MsRreEZbZnSI7Zi1qM2naCT
	 hNMCVRTQmU3yGpms2dZ727qL9K2Usy1s9x3hHUPDgsGnz25GXCqi4GjCbbR77fWGc1
	 Hco+rcu8lozAwYFMvM7lKTHDLULlCifLpwmev2GiqQqZELhfhEYWq1FHzpYsBfpoWV
	 Jx54kByqIcCYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Move clock enable after core reset
 assertion
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
In-Reply-To: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
References: <20260813095003.356062-1-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 09:57:54 +0000
Message-Id: <20260813095755.34AC41F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of `imx_pcie_host_init()` is ignored in `imx_add_=
pcie_ep()`, allowing initialization to proceed even if critical hardware re=
sources failed to enable.
--

--- Patch [1]: [PATCH v2] PCI: imx6: Move clock enable after core reset ass=
ertion ---
commit e96724a712688ba6f907245675d12f392129c5de
Author: Richard Zhu <hongxing.zhu@nxp.com>

PCI: imx6: Move clock enable after core reset assertion

Restores the sequence where clocks are enabled after asserting core reset
and configuring the controller type. Fixes a regression on i.MX6Q Apalis
platforms with ASM1061/ASM1062 SATA controllers connected.

Link: https://lore.kernel.org/all/bl7i3obu2clzsgeoct2a4mtfhv6typcjdqmgnerop=
f3hpgwve6@n2m5uhlduw57/T/#u
Link: https://lore.kernel.org/all/t65y5d54axtksbfs7r4olcefqhwm6m4dz3njgnrnf=
7fcotj74i@o7avoznlafbj/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..f7a2eb257c169 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -1415,6 +1409,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *p=
p)
> =20
>  	imx_pcie_configure_type(imx_pcie);
> =20
> +	ret =3D imx_pcie_clk_enable(imx_pcie);
> +	if (ret) {
> +		dev_err(dev, "unable to enable pcie clocks: %d\n", ret);
> +		goto err_pwrctrl_power_off;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to ignore the
return value of imx_pcie_host_init() in imx_add_pcie_ep()?

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
	...
	imx_pcie_host_init(pp);
	ep =3D &pci->ep;
	...
}

If imx_pcie_host_init() fails (for example, if imx_pcie_clk_enable() fails
here), the error is discarded and the endpoint initialization proceeds.

Could this lead to a kernel panic or synchronous external abort when
dw_pcie_ep_init() subsequently attempts to access unclocked or unpowered
PCIe registers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813095003.3560=
62-1-hongxing.zhu@oss.nxp.com?part=3D1
