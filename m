Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFD4175A84;
	Mon, 29 Jun 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713401; cv=none; b=mMq6mUczSwQXlmlhv2QAIsqhnYLww1ek4uAO06PpCv742pJBAGFoXlXTM5FevBXoD38+IPjYncvcL8CtzHTVyQmQrjfpUUUVQRLB9EQDQkB24JNiywz/ggdLj9PIk0ZQLHqXlmRsf3hPMf6AnT/7/Rm+bbEJ7z1rjwZGarEUxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713401; c=relaxed/simple;
	bh=u6f83vy7cN2Yo1aUHkTDotIKOJfW7xdFX1xt+Pvoj50=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=d8Y76H2AP/gQhwFmaf2DyUxVV26nVa09uN0asQh9ubZD7C9k3NUYoglXdYGA4QmWpEMO3a2/BK9ZMxzkylEeJGCbX0PK3xZ0c/obPAgivHF/VGa5JAANSN7NybSGLmWKz+MJjNJuJf8s0MYlEnR3xLPb1mHKb/eLEyWT8F+01k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2201F000E9;
	Mon, 29 Jun 2026 06:09:59 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: ultrarisc: get and enable DP1000 PCIe clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang via B4 Relay" <devnull+wangjia.ultrarisc.com@kernel.org>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260629-ultrarisc-pci-clk-v1-2-5ea3308fdab3@ultrarisc.com>
References: <20260629-ultrarisc-pci-clk-v1-0-5ea3308fdab3@ultrarisc.com>
 <20260629-ultrarisc-pci-clk-v1-2-5ea3308fdab3@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 06:09:59 +0000
Message-Id: <20260629060959.7A2201F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] If dw_pcie_resume_noirq() fails, the driver disables the clocks, w=
hich will cause a bus fault and kernel crash on the next system suspend whe=
n the DWC core attempts to read the DBI registers.
--

commit 7bdde7bd97edc4ae25c337b51b52e18bb46e6424
Author: Jia Wang <wangjia@ultrarisc.com>

PCI: ultrarisc: get and enable DP1000 PCIe clocks

This commit adds the required core, dbi, and aux clocks for the DP1000 PCIe
controller and enables them before initializing the DesignWare host. It also
manages the clocks across system suspend and resume.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> index 6ee661ceff67a..74010a86244e7 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
[ ... ]
> @@ -135,16 +174,37 @@ static int ultrarisc_pcie_probe(struct platform_dev=
ice *pdev)
[ ... ]
>  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
>  {
> -	struct dw_pcie *pci =3D dev_get_drvdata(dev);
> +	struct ultrarisc_pcie *ultra =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &ultra->pci;
> +	int ret;
> +
> +	ret =3D dw_pcie_suspend_noirq(pci);
> +	if (ret)
> +		return ret;
> =20
> -	return dw_pcie_suspend_noirq(pci);
> +	if (pci->suspended)
> +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> +
> +	return 0;
>  }
> =20
>  static int ultrarisc_pcie_resume_noirq(struct device *dev)
>  {
> -	struct dw_pcie *pci =3D dev_get_drvdata(dev);
> +	struct ultrarisc_pcie *ultra =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &ultra->pci;
> +	int ret;
> +
> +	if (pci->suspended) {
> +		ret =3D clk_bulk_prepare_enable(ARRAY_SIZE(ultra->clks), ultra->clks);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret =3D dw_pcie_resume_noirq(pci);
> +	if (ret && pci->suspended)
> +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);

[Severity: High]
Will this cause a kernel crash on the next system suspend if
dw_pcie_resume_noirq() fails?

If dw_pcie_resume_noirq() fails (for example, due to a link training
timeout), it returns an error but leaves pci->suspended as true. This error
path then disables the clocks.

However, the PM core continues and marks the device as resumed. On the next
system suspend, ultrarisc_pcie_suspend_noirq() will unconditionally call
dw_pcie_suspend_noirq().

Since dw_pcie_suspend_noirq() accesses DBI registers by calling
dw_pcie_link_up(), and the clocks were left disabled, does this read
trigger a synchronous external abort and crash the kernel?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-ultrarisc-=
pci-clk-v1-0-5ea3308fdab3@ultrarisc.com?part=3D2
