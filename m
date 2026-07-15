Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3F36E46F
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 01:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784078995; cv=none; b=PlqIzYGalN5wEevkAEqWbGtaHGkFf0e6wmqeKpxYURDFuBR6sNwJ8yCLWFGySM5bsH+Y2LewlNmie76invuUpCeduitgh2te+9Vxa+TYIYKj6uQF86JNavjzilGBr5ueAbTq3HCGg7lfnK4DxV2ItCeeOvWBOpFA8pktg71yoYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784078995; c=relaxed/simple;
	bh=2arMObr9ZlO5cK1/z423dI8n/qMRZqD4gxMTFotfvjg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uuDQXiV3/KjxKDQty2afKQ7d+zksg3XNvBJpV4j33LXv0kI/NhxvNAhLf2JjrkFIRscQOm3xxuVUb2pNFLi+PB8/45QeYlXx8Nkxacge3D4htHOqaA+mBwAxYpJ6RLaCyB8CIC9Jvg+PgYOQHjoKP4WiT1ra2wyQzTysbGd/Or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=REjVcBDp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="REjVcBDp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4031F000E9;
	Wed, 15 Jul 2026 01:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784078993;
	bh=W+AXc3b3D69mTUs/7Yzw5UX1hQLEAdEXQgERi7WZjUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=REjVcBDpFjNIwo1WNUvfFAGlwNMuhCvB1PO/APOv3z0iXr8/YExN+WImjvM/qhAmC
	 jLau3JzIcxpJ50YL1w3p9d2dJFzO9JRU2zB4dOsCtd23oA/0DHP3H8FZxkH1MU2J61
	 KRpvJFfFY+ATyrFK8Q5YX1WjJcNHonpvTQ2lGc0SbrjQ8wIcN3auzpiCOHPkGctWBB
	 VpRaFt5rMw029NPWrMel5dmUmWJXreKr0+GS43xnJ0kAMlayi0jOOc7RwnCR16GG7n
	 vmLWg3+x2lZYaSjdeRURf5zpiKJ6AIhzdyKpN7PlLwcHRDlDMbZ//mFNmuhU7xHhhU
	 Wsj9dP+/D4cFA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: dwc: uniphier: use fwnode API for
 legacy-interrupt-controller
Reply-To: sashiko-reviews@lists.linux.dev
To: "Rosen Penev" <rosenp@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260715011215.1263935-1-rosenp@gmail.com>
References: <20260715011215.1263935-1-rosenp@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 01:29:52 +0000
Message-Id: <20260715012953.6F4031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The patch claims to propagate the error code from `fwnode_irq_ge=
t()`, but actively masks it by overwriting `ret` with `-EINVAL`, breaking p=
robe deferral.

Pre-existing issues:
- [High] The chained IRQ handler and IRQ domain are not cleaned up if probe=
 fails after `uniphier_pcie_config_intx_irq()` succeeds, leading to a poten=
tial use-after-free.
--

--- Patch [1]: [PATCH] PCI: dwc: uniphier: use fwnode API for legacy-interr=
upt-controller ---
commit 3514429fcfd9e126f916318af07e40df60df2ea1
Author: Rosen Penev <rosenp@gmail.com>

PCI: dwc: uniphier: use fwnode API for legacy-interrupt-controller

This patch converts uniphier_pcie_config_intx_irq() from the OF-specific
API to the generic firmware-node API. It switches out of_get_child_by_name()
and irq_of_parse_and_map() for their fwnode equivalents.

> Unlike irq_of_parse_and_map(), fwnode_irq_get() returns a positive IRQ
> or a negative errno and never 0 (it rewrites 0 to -EINVAL), so check
> pp->irq < 0 and propagate the error. pp->irq is an int, so the negative
> value is preserved.

> diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/con=
troller/dwc/pcie-uniphier.c
> index 297e7a3d9b368..6516264fdfc18 100644
> --- a/drivers/pci/controller/dwc/pcie-uniphier.c
> +++ b/drivers/pci/controller/dwc/pcie-uniphier.c
[ ... ]
> @@ -262,27 +262,27 @@ static int uniphier_pcie_config_intx_irq(struct dw_=
pcie_rp *pp)
[ ... ]
> -	pp->irq =3D irq_of_parse_and_map(np_intc, 0);
> -	if (!pp->irq) {
> -		dev_err(pci->dev, "Failed to get an IRQ entry in legacy-interrupt-cont=
roller\n");
> +	pp->irq =3D fwnode_irq_get(fw_intc, 0);
> +	if (pp->irq < 0) {
> +		dev_err(dev, "Failed to get an IRQ entry in legacy-interrupt-controlle=
r\n");
>  		ret =3D -EINVAL;

[Severity: Medium]
The commit message states it will "propagate the error", but does this
hardcode the return value to -EINVAL instead?

If fwnode_irq_get() returns -EPROBE_DEFER, will overwriting it with -EINVAL
cause the PCI host driver to permanently fail probe rather than retrying
when the interrupt controller is ready?

>  		goto out_put_node;
>  	}
[ ... ]
> @@ -291,7 +291,7 @@ static int uniphier_pcie_config_intx_irq(struct dw_pc=
ie_rp *pp)
>  					 pp);

[Severity: High]
This is a pre-existing issue, but does this setup lack corresponding cleanup
in the probe failure path?

If a subsequent step in dw_pcie_host_init() fails, the probe aborts and
devres frees the uniphier_pcie struct, which contains the pp pointer.

Since there is no .deinit callback in uniphier_pcie_host_ops to call
irq_set_chained_handler_and_data(pp->irq, NULL, NULL) or remove the IRQ
domain, could a spurious interrupt fire and execute a dangling chained
handler with a freed pp pointer?

> =20
>  out_put_node:
> -	of_node_put(np_intc);
> +	fwnode_handle_put(fw_intc);
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715011215.1263=
935-1-rosenp@gmail.com?part=3D1
