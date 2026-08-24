Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B7B3A5E78;
	Mon, 24 Aug 2026 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558994; cv=none; b=VGH3ei9Je/ZMqSc/C1tRw109cLBHv57HbFTLxR712Rd1cXIw7DOiD+un0tJAE5V4/AxjTmkuLvfsOOJiUZjUoZZiMqOtPc6HBod8g9k3sw0BkjzPEPpIBrbil0BG3jM9e39OEUk1E0hFKPs2k+r7d3VuLHjGrjkkBDIPCl9KeA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558994; c=relaxed/simple;
	bh=TLoQuLwfvFMPjIZqLBQN28UqWTFOCrR5NfIMMKvb0uw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YPYke3VCvXxOMCMrVX0C30u2qze2E4WDqs4poEXibgjEOc8Ys4KP95fthnnPjOXEgscZRmYVCetLcG9VzIcIwLZwvJlc+MXdG3lCATscJl8xZKwUERd9g3brRClMykKkPfQ8hvOtK5F5U1kAFHH0vTgeaF3kS9BODJzikK3dqYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pt0NE39V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pt0NE39V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040ED1F00A3D;
	Mon, 24 Aug 2026 08:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787558992;
	bh=LNl3ZxgO5KBk8xPxNy92Yfx+n3NY1x69TdfwZI6JdQM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pt0NE39VIoD66Eior2hHN8NWp+krtCChVEFy7KDksBupnRWvaCsErgq2CNAHmfVP6
	 RajCK2EWsAvLdIZnFYx6uXEX5cPoj2JlZVyI+Umm/A3uD7NkuqaNV5IYq2zhiX/4D4
	 UIhoUX78xWsHsV+0d6mYXkqJSk+GyvTnS8Ii1EJXY29b1J++JgFjDGLf96qkyDKnwT
	 v6MhSrpMjk+Un3WcLx6aePlAd+qb6H6OzIGrbaWfsBFf2wkJ2OZBKPDxPsJM5+xH+6
	 T/ejb3SoN5TydvRA/XhA/xSQBUMGzlveSB12kgOKhwPSg9kUyzbmJwXwDwDp0+0c/I
	 3IXPEUFjyG+uA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260824075512.3386898-1-hanzhijian1991@gmail.com>
References: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
 <20260824075512.3386898-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 08:09:51 +0000
Message-Id: <20260824080952.040ED1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Endpoint setup failure permanently leaks host resources and ignore=
s initialization errors from imx_pcie_host_init().
--

--- Patch [1]: [PATCH v3] PCI: imx6: fix resource leaks in probe error path=
s ---
commit a77762d63857f9ca84de44552a329e64c4d4176e
Author: hanzhijian <hanzhijian1991@gmail.com>

PCI: imx6: fix resource leaks in probe error paths

This commit fixes resource leaks in imx_pcie_probe() by introducing
imx_pcie_detach_pd() to properly release power domains and device links
when probing fails. It ensures these resources are cleaned up in reverse
order of acquisition.

Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..467006d839a60 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
[ ... ]
> @@ -1956,8 +1987,10 @@ static int imx_pcie_probe(struct platform_device *=
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
This is a pre-existing issue, but does imx_add_pcie_ep() leak host resources
on failure, and ignore initialization errors?

Looking at the implementation of imx_add_pcie_ep():

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
	...
	imx_pcie_host_init(pp);
	...
	ret =3D dw_pcie_ep_init(ep);
	if (ret) {
		dev_err(dev, "failed to initialize endpoint\n");
		return ret;
	}
	...
}

The return value of imx_pcie_host_init() is completely ignored, meaning err=
ors
during clock, regulator, or PHY state initialization aren't caught. If the
hardware fails to power on, the driver proceeds to initialize the endpoint
anyway.

Additionally, if dw_pcie_ep_init() fails, the function returns directly
without calling imx_pcie_host_exit(). Doesn't this bypass teardown and
permanently leak all acquired host resources?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824075512.3386=
898-1-hanzhijian1991@gmail.com?part=3D1
