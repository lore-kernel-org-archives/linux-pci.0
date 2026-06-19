Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DD367F25;
	Fri, 19 Jun 2026 11:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781868986; cv=none; b=WAK3yYxiFrhfaQsk6sBpWGTwrCtRc46r3f3IpDxV5UtWPYpA7Vnzu80Umz23tr1QLbPjdray2gOiPtSKS8lfHf+XjR1mNLLCNMXRascqwWpmtWDZn+3OhiDOed0p5z67cx0cPho1TVbGZsl+qVvk8UhZl6hIANHTZc+x9BWQKWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781868986; c=relaxed/simple;
	bh=Jwxt259GSkjPIskw9lcSfUqwPw+bJcMtdQnVnpzGFM0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BTxk4AWikTNNEbtmk9BUWaaSGnz5POjixQBUom+LbBPp8EMdxOIgNbo/iMU/uPRjmk5s/x7WCIYZK/VSBnomOin3MjAh/65MNxlfupE8iN4JozuOTravQKQOskOP5yBqsbUt/1eRX4OkOZh1lX33n+2zVI0Y0e5gqJR8O6/2EZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTqM8Wsr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTqM8Wsr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90AE1F000E9;
	Fri, 19 Jun 2026 11:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781868984;
	bh=IL/l/y6RXApnZ7FgA6sm9hEt1AkXKSYE1xKnRdUOaYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cTqM8WsrUzyX0rcGkovbzKh9vfSWQFl+wk8yCeHdU9hacvHFcoMvAxwCaNnz9WZs5
	 MAsqubtN6Jz9vfuTbWGCAx9TKqSeM3KhjdwTZPKUO6fYLRnw1Fr9zl1mDD7y/CWGZ9
	 EUqDw99EISlXjucsXxic3m8CfcBIXv8EEkNXRnbOP+5xy03+Vuid4yxEadrr4m113B
	 jtYdYHLDvGZKNDOdrBM50fRZ+rZ5B5Ty4g1RqFCZE7jy9+QGbydCqtwO2vMrm3tYcD
	 EJfvYt4FfwhLyFuBcwk8mdJndbX6p6A45vc8e0mzjtIJckQjMnOlEEm77yS3jEIXpK
	 XNJBFAfkg3P3w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] PCI: imx6: Use dev_err_probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
References: <20260619112535.1127850-1-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 11:36:24 +0000
Message-Id: <20260619113624.A90AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The return value of imx_pcie_host_init() is ignored in imx_add_pci=
e_ep(), leading to a system crash when pwrctrl devices trigger a probe defe=
rral.
--

commit 177305e0f76751d4a9bafb983aa8f962639d5a3b
Author: Alexander Stein <alexander.stein@ew.tq-group.com>

PCI: imx6: Use dev_err_probe

pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER resulting in
an error message. Use dev_err_probe to silence this non-error message.

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 98e1db751132a..b7a502e9a1c59 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1381,7 +1381,7 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
> =20
>  	ret =3D pci_pwrctrl_power_on_devices(dev);
>  	if (ret) {
> -		dev_err(dev, "failed to power on pwrctrl devices\n");
> +		dev_err_probe(dev, ret, "failed to power on pwrctrl devices\n");

[Severity: High]
This isn't a bug introduced by this patch, but since=20
pci_pwrctrl_power_on_devices() might return -EPROBE_DEFER (as anticipated by
this change), does this lead to a system crash during endpoint initializati=
on?

In drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep(),
imx_pcie_host_init() is called but its return value is ignored:

	imx_pcie_host_init(pp);
	ep =3D &pci->ep;

If imx_pcie_host_init() fails and returns -EPROBE_DEFER, imx_add_pcie_ep()
blindly proceeds to execute dw_pcie_ep_init_registers() and
imx_pcie_host_post_init() on unpowered hardware.

This causes the kernel to attempt MMIO reads and writes on unclocked and
unpowered PCIe Endpoint DBI registers, which triggers a synchronous external
abort and panics the system on ARM/i.MX platforms.

Could we add a check for the return value of imx_pcie_host_init() in
imx_add_pcie_ep()?

>  		goto err_pwrctrl_destroy;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619112535.1127=
850-1-alexander.stein@ew.tq-group.com?part=3D1
