Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D94043F087;
	Mon, 24 Aug 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585347; cv=none; b=ZBIMwmLovqPxgNctRu8ULs5vw+x4QVv8ZAiHiXJd8jUcUvtMi0YwaMmqcKrpHsMh1gWdBJGJjTzEj9PmIusHnwTscl6ZM+0L8a/0wXuXNJmY/jeiX0H4hJpFtDYiP1ueMFn7PGs7G0cBJrm/VNZPqeF+vyJwV+QjGigDc8mgYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585347; c=relaxed/simple;
	bh=zw5wAGZd/2Zkhj2jL0Hlx0UVt5uwIsUxF7S2TUHWABo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DfYzEQ4FYgilov2bPk7PTaphMUvs6Aa+HE8txqPZNuvjOITtHsSYFkUAE/wyS2hxK5OEnNSetXfMT6wbWRSUmps1183lax6aRdHD/LviXgT5ih3ZBZ11u3NynfVwL/6W25dzNN1inO2ASvzHfPfIANTKmey4FyEotvBM/w12Ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UE53kjqm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UE53kjqm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9771F00A3D;
	Mon, 24 Aug 2026 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585338;
	bh=8hK7cciXGv+L+sYcePgqk3FJVmlGe9hqZt6ZxEprXEY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UE53kjqm9Wf5A4wOwhvVkrmf97aDOkPe9IEIpLw3yOtATA46YfgbQpV5Kk0OJ7Lp/
	 VQLlLN1zPc34nsFwxFvdWRv9BJPAFQxu1il1OcpK+4pHkIVSOx7gteuORZZZwBA6hw
	 kZEBa7kq7njrS6l3x6Zu4wJpwTK2rPh9nUATIWb8LY01PWE3vQy9XBKoX5AsufVHcN
	 BIjA/LhNgZ3l7InZ+R8xo8D7ZPJzQzoFzCUNaoOjeuqqFFz+T2fTdgKmqM5mMdNvIy
	 PjqJTExwdrNo+Fh9ofhA5A2VIQcwf+Ch9ajSVhT1WAbiIDrYlfrFIfI6W2OkQObAfX
	 4I1rPxIGPReGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
References: <20260824150454.3511203-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:28:57 +0000
Message-Id: <20260824152857.DB9771F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded resource leak (clocks, regulators, PHYs) during repeated=
 endpoint probe deferrals.
--

--- Patch [1]: [PATCH v4] PCI: imx6: fix resource leaks in probe error path=
s ---
commit 4146a6183d1b75bd09bf97a22116274151dfc0ca
Author: Zhijian Han <hanzhijian1991@gmail.com>

PCI: imx6: fix resource leaks in probe error paths

This commit addresses resource leaks in the imx6 pcie probe error paths by
introducing imx_pcie_detach_pd() to clean up power domains and pwrctrl
devices. It also adds DL_FLAG_AUTOREMOVE_CONSUMER to device links so they
are cleaned up automatically.

Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..0b42093654f04 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -1956,8 +1974,10 @@ static int imx_pcie_probe(struct platform_device *=
pdev)
>  		return ret;
> =20
>  	ret =3D pci_pwrctrl_create_devices(dev);
> -	if (ret)
> +	if (ret) {
> +		imx_pcie_detach_pd(imx_pcie);
>  		return dev_err_probe(dev, ret, "failed to create pwrctrl devices\n");
> +	}
> =20
>  	pci->use_parent_dt_ranges =3D true;
>  	if (imx_pcie->drvdata->mode =3D=3D DW_PCIE_EP_TYPE) {

[Severity: High]
This is a pre-existing issue, but does imx_add_pcie_ep() leak hardware
resources such as clocks, regulators, and PHYs if endpoint initialization
fails or defers?

Looking at imx_add_pcie_ep(), it allocates hardware resources via
imx_pcie_host_init(pp), but if dw_pcie_ep_init(ep) returns an error
(like -EPROBE_DEFER), it returns directly without cleaning them up:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
	ret =3D dw_pcie_ep_init(ep);
	if (ret) {
		dev_err(dev, "failed to initialize endpoint\n");
		return ret;
	}
    ...
}

Similarly, if dw_pcie_ep_init_registers(ep) fails, it calls
dw_pcie_ep_deinit(ep) but still misses cleaning up the host resources:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
	ret =3D dw_pcie_ep_init_registers(ep);
	if (ret) {
		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
		dw_pcie_ep_deinit(ep);
		return ret;
	}
    ...
}

Should these error paths call imx_pcie_host_exit(pp) to avoid permanently
leaking power and resource references during repeated probe deferrals?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824150454.3511=
203-1-hanzhijian1991@gmail.com?part=3D1
