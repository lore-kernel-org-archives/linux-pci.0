Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599C7493640;
	Sun, 23 Aug 2026 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787470045; cv=none; b=kZNNSxMSxUU0EIwDuZaQN8hUkmQswdGphwfGLnVf6zH2abnp+04GEmwY6hwvpjJ2KTK23baSkJdezrzpAmcdl/NoMFL9Jmz3epv0qMj5w+ebWTUZoxWaPJj0wXiSc6ZWMByGDNvr5Sw9lr6VvC4IJG5H1ciLXSq6FH0JTJFRbac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787470045; c=relaxed/simple;
	bh=OWDi9jL5zJxfDM9n+bhYxUME3C1opO1aOp7rkijGfiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GL4ahUoCFk0oVeYprHg18rQACZG24QaRlmF0YUhDcowYsjXApVhlPjiN7ZET1ttckWQoFYyzxMCoQPOtRcZMKlQo6PIIrb6xRvoZxiUkPp39WGufFMeIQXplUCWaK3bkubzQEyY/EcJlJ6KjXc+NR0H9Q5X2lBC6s7SFi9L0GAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZRNNwxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZRNNwxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1561F000E9;
	Sun, 23 Aug 2026 07:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787470044;
	bh=Sb2nqKHurp+jXB2/BqMdP4FBfASvJUHvgMlB/ahVtjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TZRNNwxWlbjfzuH/pcgKuo6p6EcXD8yhp2alMLMyEcoXwrAdYTUaDwYQ06S82PE+P
	 DHfw45Jt3ooAaoxiJdYpKxXXa4U3kHO2ZsHACvndTHroWJ72SR1+MV555wwpqmjdL2
	 LeKVB+uYYkvWYeohCSTNBPmkzFBdvNudNyL+Cg8IR3WtfwBjccvfpinqLnbvHCnTTM
	 d9WlHVpPz6QZxTLkEYTvlMw7jL6tHjbm6JJGYgcklZeyw0YYzikbu2bV9yPgbc+SI9
	 Iu/ZUxZOGk49tbF04vbAYJmApotIZUnxDd6BytvmML6OyNuFtsxWAGHxmPJFVmtzQh
	 iQpN0JGPe33ug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: hanzhijian <hanzhijian1991@gmail.com>
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260823071129.2980059-1-hanzhijian1991@gmail.com>
References: <20260823011125.2876504-1-hanzhijian1991@gmail.com>
 <20260823071129.2980059-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Aug 2026 07:27:23 +0000
Message-Id: <20260823072723.BF1561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The error path in imx_pcie_probe() calls imx_pcie_detach_pd() befo=
re pci_pwrctrl_destroy_devices(), violating the reverse-initialization orde=
ring.

Pre-existing issues:
- [High] imx_add_pcie_ep() ignores the return value of imx_pcie_host_init()=
. If imx_pcie_host_init() fails, it cleans up and returns an error, leaving=
 clocks and power domains disabled. Proceeding with endpoint initialization=
 will cause dw_pcie_ep_init_registers() to access unclocked PCIe DBI regist=
ers, leading to a synchronous external abort (kernel panic) on ARM systems.=
 It also leaves imx_pcie_host_exit() uncalled on subsequent error paths.
--

--- Patch [1]: [PATCH v2] PCI: imx6: fix resource leaks in probe error path=
s ---
commit 73509c01fd7cdd5762cd2dc7b8e74d13150be953
Author: hanzhijian <hanzhijian1991@gmail.com>

PCI: imx6: fix resource leaks in probe error paths

imx_pcie_probe() leaks both pwrctrl devices and power domains on failure.
Save the device links, add imx_pcie_detach_pd() to release the power domains
and device links in reverse order of acquisition, and call it from the probe
error paths.

Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..a2bae4a2c95ba 100644
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
This is a pre-existing issue, but does imx_add_pcie_ep() ignore the return
value of imx_pcie_host_init() when called here?

If imx_pcie_host_init() fails, it cleans up its state, disables clocks and
power, and returns an error code:

drivers/pci/controller/dwc/pci-imx6.c:imx_add_pcie_ep() {
    ...
    imx_pcie_host_init(pp);
    ep =3D &pci->ep;
    ...
}

If imx_add_pcie_ep() ignores this error and proceeds with initialization,
will dw_pcie_ep_init_registers() attempt to read from the unclocked PCIe
DBI registers?

Could this trigger a synchronous external abort or kernel panic on ARM
systems?

[ ... ]

> @@ -1999,6 +2032,7 @@ static int imx_pcie_probe(struct platform_device *p=
dev)
>  	return 0;
> =20
>  err_pwrctrl_destroy:
> +	imx_pcie_detach_pd(imx_pcie);
>  	if (ret !=3D -EPROBE_DEFER)
>  		pci_pwrctrl_destroy_devices(dev);
>  	return ret;

[Severity: High]
Does this error path violate the reverse-initialization ordering?

Earlier in the probe function, imx_pcie_attach_pd() attaches power domains,
and then pci_pwrctrl_create_devices() populates child devices.

If probe fails, imx_pcie_detach_pd() is called first, which detaches the
power domains and powers off the hardware. Then pci_pwrctrl_destroy_devices=
()
is called to remove the child devices.

Could the child drivers' remove callbacks attempt to access the
now-powered-off hardware or rely on the parent's power domain being
active, leading to a system crash or hardware lockup?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260823071129.2980=
059-1-hanzhijian1991@gmail.com?part=3D1
