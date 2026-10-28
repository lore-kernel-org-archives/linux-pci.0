Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793208949;
	b=jXK8CNHFTP3X6goBgKccvngv95Ka7ihFAgAbra/low7bR397VF1nHVSwoSADILgBTG+e
	 OYljJyNjSCnaVHzLp1poCL6u9KMm36HjHyqZkx5PeI8bfi/CJ1Q8hF1AO4WeajFypIBLO
	 E+EbrVdbWXpoqsKMBTlLsR6QOSIrhsEHe5LR7HRHxllBEgHcLdJt05LkGdL5MJ3hkgX3e
	 y7YfAmJ1xg18XKrFSudoFdxz5cqfQ8jakcWjKYJcmQ29ob0IbqXmseBtu8AMk+pgcNiii
	 Csa1BP8VuEb5eAr5aT/SaE5ILfL8ezPT8aSuteTl7PFN0eip9QLgOPZDbevGpGv0X/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793208949;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MmmWQGBsdDW5LBV2kVXp4jHKwDVP1y/XOMHg3rX6JY8=;
	b=o0/9zZxaqxlsQztHa2tr3W7pIAi0/ORYGl3EunR9xPdDPBTISljHDWUhNlMc2ig2jQZJ
	 CknnlZf/xWmfz+7RtFXRlj/qtqUcYC/95+xUXtPUKz3hg3dmoaLUSYc70bgBFlIEw+dmm
	 cUll6ZxNHJeEYyH1G6ZpsXYQ9UMZu2WF5v/ilqspE6jUquxalt0jlDTbo2KjkiaSJaAGs
	 ugu/W9QpWUXMvNxrSi0iKbONfEDprDIAB1dk3naSrOFmtXDiWTuGpi8l4Qt6HVZLjVMlU
	 qGQVVF+uH9cMTMejsxff3GfwoXuQrB/6s/lwUxILLji8d9DvM0xMpsJ8+Rto5ZnZeig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPZ7pkzD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A70E606A33F
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPZ7pkzD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061451F01829;
	Wed, 28 Oct 2026 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793208949;
	bh=MmmWQGBsdDW5LBV2kVXp4jHKwDVP1y/XOMHg3rX6JY8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gPZ7pkzDuOZy/pKGp/4eRUe0RxdCuzW9zwIUl0jlMau4hp4q4u96UoZaUO9HBaF6j
	 i981gLrCvEhH2iZI1Gn956tkD3M7ujYGL4xzzeiJOkBqSbLWsZkThkrPaEsT8bc34g
	 CXpkHbuHopee6UhCfeQnYDELDP9Sgu00MAyT82h+dqaO5DJPdHKR1JXVHnTa/T07y3
	 bLcKNKHt+6SDjvcFoZrhpN0dhASoRY1Jf2CuPD2ESAXGZ0oYVPikUPE5qN1YXguMtT
	 zPqGtYzqnPeQiS+YxmwMwmalM6AWFjqGJMYJuFmzWL9TJ2m9GAWQwXrcSE+p0EyRJf
	 ZwJKYVshbd/jQ==
Message-ID: <sashiko-outbox-188239@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with
 GPIO reset aux driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>, linux-pci@vger.kernel.org
Cc: wsa+renesas@sang-engineering.com
In-Reply-To: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
References: <20261028172133.20903-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 17:35:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] PCI: dwc: rcar-gen4: broken error handling in rcar_gen4_pcie_host_=
perst_get()
- [High] PCI: dwc: rcar-gen4: rcar->perst UAF across suspend/resume in host=
_deinit()
- [Medium] PCI: dwc: Kconfig: PCIE_RCAR_GEN4_HOST selects RESET_GPIO withou=
t dependencies
--

commit 5d439d30a4d77a2c89c803394ba82b6874d3a0c5
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: dwc: rcar-gen4: Replace pe_rst GPIO PERST with GPIO reset aux driver

This commit removes the pe_rst GPIO descriptor from the DesignWare PCIe core
and switches the R-Car Gen4 PCIe host driver to acquire PERST# as a reset
control via the reset-gpio auxiliary driver or from a root port subnode in
rcar_gen4_pcie_host_init().

> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/=
dwc/Kconfig
> index 0a0d56fcf0ac9..d65cf1e9d842b 100644
> --- a/drivers/pci/controller/dwc/Kconfig
> +++ b/drivers/pci/controller/dwc/Kconfig
> @@ -350,6 +350,7 @@ config PCIE_RCAR_GEN4_HOST
>  	depends on PCI_MSI
>  	select PCIE_DW_HOST
>  	select PCIE_RCAR_GEN4
> +	select RESET_GPIO

[Severity: Medium]
In drivers/reset/Kconfig, RESET_GPIO is guarded by if RESET_CONTROLLER and
has depends on GPIOLIB:

drivers/reset/Kconfig:
if RESET_CONTROLLER
...
config RESET_GPIO
	tristate "GPIO reset controller"
	depends on GPIOLIB
	select AUXILIARY_BUS

Since PCIE_RCAR_GEN4_HOST only depends on ARM64 && (ARCH_RENESAS ||
COMPILE_TEST) and PCI_MSI, can selecting RESET_GPIO here trigger Kconfig
unmet direct dependency warnings and build failures when RESET_CONTROLLER=
=3Dn
or GPIOLIB=3Dn (for example with COMPILE_TEST=3Dy)?

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index fceecbd16355c..d3bf01485e11d 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -594,19 +583,84 @@ static int rcar_gen4_pcie_enable_device(struct pci_=
host_bridge *bridge,
>  	return 0;
>  }
> =20
> +static int rcar_gen4_pcie_host_perst_get(struct dw_pcie *dw)
> +{
> +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> +	struct device_node *root_port;
> +	struct device *dev =3D dw->dev;
> +	struct reset_control *perst;
> +	int index;
[ ... ]
> +	index =3D reset_control_get_count(dev);
> +	if (index < 0)
> +		return index;
> +
> +	/* Attempt to request GPIO PERST# in PCIe controller node. */
> +	perst =3D of_reset_control_get_exclusive_by_index(dev->of_node, index);
> +	if (!IS_ERR(perst))
> +		goto exit;
> +
> +	/* No GPIO reset, test for root port subnode. */
> +	root_port =3D of_get_next_available_child(dev->of_node, NULL);
> +	if (!root_port)
> +		return dev_err_probe(dev, -EINVAL, "Failed to get PERST# in root port\=
n");
> +
> +	/* Attempt to request reset controller PERST# in root port subnode. */
> +	perst =3D of_reset_control_get_optional_exclusive(root_port, "perst");
> +	of_node_put(root_port);
> +	if (IS_ERR(perst))
> +		return dev_err_probe(dev, PTR_ERR(perst), "Failed to get PERST#\n");

[Severity: High]
What happens in rcar_gen4_pcie_host_perst_get() when reset-gpios is present
in dev->of_node, but of_reset_control_get_exclusive_by_index() returns
ERR_PTR(-EPROBE_DEFER) because the GPIO provider or the reset-gpio auxiliary
driver has not bound yet?

In drivers/reset/core.c:__fwnode_reset_control_get(), if reset-gpios is
present in the node, __reset_add_reset_gpio_device() or __reset_find_rcdev()
returns -EPROBE_DEFER until the GPIO device and the reset.gpio auxiliary
device are ready.

Because rcar_gen4_pcie_host_perst_get() does not check whether PTR_ERR(pers=
t)
is something other than -ENOENT before falling through to the root_port
lookup:

1. On R-Car V4H boards (such as r8a779g0.dtsi with White Hawk or Sparrow
Hawk), the controller node has a pci@0,0 child node without a "perst" reset
property while reset-gpios is in the controller node. Falling through on
-EPROBE_DEFER causes of_reset_control_get_optional_exclusive(root_port,
"perst") to return NULL, so rcar->perst is set to NULL and probe succeeds
without acquiring or deasserting the GPIO PERST#.

2. On R-Car S4 and V4M boards (such as r8a779f0.dtsi Spider and r8a779h0.dt=
si
Gray Hawk), there is no root port child node, so falling through on
-EPROBE_DEFER hits if (!root_port) and fails probe permanently with -EINVAL
instead of deferring.

3. Since reset-gpios is optional according to the binding and commit
description, if a controller node has neither reset-gpios nor a root port
child node, of_reset_control_get_exclusive_by_index() returns ERR_PTR(-ENOE=
NT)
and if (!root_port) now fails probe with -EINVAL instead of treating PERST#=
 as
optional.

Should this check for PTR_ERR(perst) !=3D -ENOENT after
of_reset_control_get_exclusive_by_index(), and allow a missing root_port wh=
en
PTR_ERR(perst) =3D=3D -ENOENT?

[ ... ]
> @@ -616,6 +670,10 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_r=
p *pp)
>  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
>  	int ret;
> =20
> +	ret =3D rcar_gen4_pcie_host_perst_get(dw);
> +	if (ret)
> +		return ret;
> +
>  	if (pp->bridge)
>  		pp->bridge->enable_device =3D rcar_gen4_pcie_enable_device;
> =20
> @@ -623,7 +681,7 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp=
 *pp)
> =20
>  	ret =3D rcar->drvdata->init(rcar);
>  	if (ret)
> -		return ret;
> +		goto err_init;
> =20
>  	/*
>  	 * According to the section 3.5.7.2 "RC Mode" in DWC PCIe Dual Mode
> @@ -646,6 +704,8 @@ static int rcar_gen4_pcie_host_init(struct dw_pcie_rp=
 *pp)
> =20
>  err:
>  	rcar->drvdata->deinit(rcar);
> +err_init:
> +	reset_control_put(rcar->perst);
>  	return ret;
>  }
> =20
> @@ -656,6 +716,7 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie=
_rp *pp)
> =20
>  	rcar_gen4_pcie_host_perst_assert(pp, true);
>  	rcar->drvdata->deinit(rcar);
> +	reset_control_put(rcar->perst);
>  }

[Severity: High]
Can moving rcar_gen4_pcie_host_perst_get() and reset_control_put(rcar->pers=
t)
into the dw_pcie_host_ops .init and .deinit callbacks cause a use-after-free
and double-free of rcar->perst across system suspend/resume followed by
driver removal?

In drivers/pci/controller/dwc/pcie-designware-host.c, the .deinit and .init
callbacks are also invoked during noirq suspend and resume:

dw_pcie_suspend_noirq()
  pci->pp.ops->deinit(&pci->pp)
    rcar_gen4_pcie_host_deinit()
      reset_control_put(rcar->perst);

dw_pcie_resume_noirq()
  pci->pp.ops->init(&pci->pp)
    rcar_gen4_pcie_host_init()
  ...
err_deinit:
  pci->pp.ops->deinit(&pci->pp)
    rcar_gen4_pcie_host_deinit()
      reset_control_put(rcar->perst);

When dw_pcie_suspend_noirq() runs, rcar_gen4_pcie_host_deinit() frees
rcar->perst via reset_control_put() while leaving the dangling pointer in
rcar->perst.

If the device is later unbound while suspended, or if dw_pcie_resume_noirq()
fails (either inside rcar_gen4_pcie_host_init() or at err_deinit: when link
training times out in dw_pcie_wait_for_link()), a subsequent
rcar_gen4_pcie_remove() -> dw_pcie_host_deinit() ->
rcar_gen4_pcie_host_deinit() will call reset_control_assert(rcar->perst) and
reset_control_put(rcar->perst) on the already-freed rcar->perst pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028172133.2090=
3-1-marek.vasut+renesas@mailbox.org?part=3D1
