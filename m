Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F23144211B;
	Mon,  6 Jul 2026 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332677; cv=none; b=O0pQHS03cWaYS7JEvFWIjqGBSlp5HVYKdTj6wU2vxOz0VUao3nUkM1mt14OBZNkwMz6n4P/M0HMBhKK0Tg5Sv9byDXdzlRZ9mjH9YtIIhuov13JxZjy9WMeap0pFQ2uonUl80bWRNrYQg0iPcucRau5meRGWR7DEIkHgRRuKD6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332677; c=relaxed/simple;
	bh=XLJCpIqyZeJR3MaC+rGwOiu/ENSVIjHHPZxnvNPL0Qc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sz0eueiKyCIrw2TvU7L9xAXSO2NEVK/vhBFRAGjAxpcposSBkzqk4U1utnN48HJTeFYokvwfEba7OUQ0EStOpM59J6TWI6Kc2fKj1U2JgCH+H/y04TqE9RQ2CXRdTWWuKsLeS8syADou9ZIVG77q4VDhnXpeOiNVJHisPnoAYbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJgk3G6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJgk3G6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129681F000E9;
	Mon,  6 Jul 2026 10:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783332675;
	bh=MgovdVc4mJn8kTmi6osOtTdAyAEgyLg4UqymjNiprtE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nJgk3G6HsqVGeTknuTvDyn72NCeKEyEOOLvXaR8FcRu+ms1rKjj2wXUOAYgVe0b+m
	 1y51wdj6PP1KorP/8rFd7ic+8ZDmzdlV9YScbLh9ssTttPW5aF39i/VdO/msD9FPwo
	 8h4/H9W18COj9m/KlhqrzkljI2D9S3VW588Nm41EvFoHYTHo6vz8BoiGITB8yU3LWf
	 22bL3U9bbql53twXhAz2CRuQHFHtrfhJnrfneYkhxy5R2d6csA2uY+hFbZL0qTGslx
	 Ijyiyt8K03ZvKHbgMyNhjG1WbjSCBp3TpyF4Z6bzt9X/ESjWrtnP89myIJ1M4Gia54
	 9m7QslAYyUSMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] PCI: ultrarisc: get and enable DP1000 PCIe
 clocks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia Wang" <wangjia@ultrarisc.com>
Cc: linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260706-ultrarisc-pci-clk-v2-2-2f3fb6fba66b@ultrarisc.com>
References: <20260706-ultrarisc-pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com>
 <20260706-ultrarisc-pci-clk-v2-2-2f3fb6fba66b@ultrarisc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:11:13 +0000
Message-Id: <20260706101114.129681F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unconditional register access in suspend after a prior resume fail=
ure causes kernel panic.
--

commit 91b0a79d0e5b5b1e0d3c9731fd011273f668f0a9
Author: Jia Wang <wangjia@ultrarisc.com>

PCI: ultrarisc: get and enable DP1000 PCIe clocks

Add the required core, dbi, and aux clocks for the DP1000 PCIe
controller and enable them before initializing the DesignWare host.
Also manage the clocks across system suspend and resume.

> diff --git a/drivers/pci/controller/dwc/pcie-ultrarisc.c b/drivers/pci/co=
ntroller/dwc/pcie-ultrarisc.c
> index 6ee661ceff67a..6ed244770d538 100644
> --- a/drivers/pci/controller/dwc/pcie-ultrarisc.c
> +++ b/drivers/pci/controller/dwc/pcie-ultrarisc.c
[ ... ]
> @@ -135,14 +174,31 @@ static int ultrarisc_pcie_probe(struct platform_dev=
ice *pdev)
> =20
>  static int ultrarisc_pcie_suspend_noirq(struct device *dev)
>  {
> -	struct dw_pcie *pci =3D dev_get_drvdata(dev);
> +	struct ultrarisc_pcie *ultra =3D dev_get_drvdata(dev);
> +	struct dw_pcie *pci =3D &ultra->pci;
> +	int ret;
> +
> +	ret =3D dw_pcie_suspend_noirq(pci);

[Severity: High]
What happens here if a previous resume attempt failed to enable the clocks?

Looking at ultrarisc_pcie_resume_noirq() below, if clk_bulk_prepare_enable()
fails, the function returns an error while the clocks remain disabled and
pci->suspended remains true.

If the system then undergoes another suspend cycle, this function will call
dw_pcie_suspend_noirq(), which accesses hardware registers via
dw_pcie_link_up().

Since the clocks are disabled, could this register access cause a bus error
and subsequent kernel panic?

Should we check if the device is already suspended (or if the clocks are
already off) before calling dw_pcie_suspend_noirq()?

> +	if (ret)
> +		return ret;
> +
> +	if (pci->suspended)
> +		clk_bulk_disable_unprepare(ARRAY_SIZE(ultra->clks), ultra->clks);
> =20
> -	return dw_pcie_suspend_noirq(pci);
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
> =20
>  	return dw_pcie_resume_noirq(pci);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-ultrarisc-=
pci-clk-v2-0-2f3fb6fba66b@ultrarisc.com?part=3D2
