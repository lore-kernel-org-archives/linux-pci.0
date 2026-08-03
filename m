Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE03515D7;
	Mon,  3 Aug 2026 22:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785797714; cv=none; b=ohXseoo4iO6D/UoyudxfOVyKkJrB6pYnuzyf/+FDGml0VlLGzG5lGE2+n7Dyw4ElroTKW9hTTJM+eu1CCgbq1iRq2qZ8Tqw0h1lXtPwPPzPFR/xzs9YAKgo96OxfBWnL1F7vgKRfNVLpaG6vTHSfmb61WusoTWFGXv2RATckU2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785797714; c=relaxed/simple;
	bh=gpuXy56iuA6qzt0PwPHHA9ClP8CWCo97xrpav5Q8i28=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hc890VHYDCVcgsMOEpYBcYilFxOvjfhkmVS7hq9COXx1XwHKYTlgRzP7Mnk2ukwvdhm8j2deaq6DQ2NpKdy/YAIBJ1NQ6s4xc+BF0ngUjKokEsS16kwy9dyBGSorZFyHTROLKOpkDzoWIvE8njkeVXGby66Y0YWXlLc+WTGTAeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EFLInAYx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EFLInAYx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154691F00A3D;
	Mon,  3 Aug 2026 22:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785797713;
	bh=MZeCDprr4hDSa6StMM52j//5F75Xpqvt9SjHfcLjyE4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EFLInAYx1UrpJCIMz/3vcPJiDchvfCJ0BcZaAr4mSMwMiae0HTIJXkob3K01lzrjE
	 zEKBoiNpkmOAK78cVcf9fW1FB6J9bg9kAi2LSirh1xXaHwdUPQ3Esha81vdI5lJMtO
	 WhViKref/c2vV/zTVl5qgDUK9PEte7q6oN5DGgzXRKYya/PzCu/kzWLAj6GhFbm6N8
	 kpRUw+RtFcEnw9/VZRwjMMZ6Lcowod3/uTFyA3NiKIlPv9yU/ZUl9/8sF4nNaFgBTB
	 mMKft1XvN3d9iGAg3f9LJ96hj8HdE7TgGAFmaC1ucS23LpL85ykSIvHhvM35uqlQ7b
	 YiZg6vF6B3IOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/14] PCI/CXL: Mask/Unmask CXL protocol errors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Terry Bowman" <terry.bowman@amd.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260803221810.3685703-14-terry.bowman@amd.com>
References: <20260803221810.3685703-1-terry.bowman@amd.com>
 <20260803221810.3685703-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 22:55:12 +0000
Message-Id: <20260803225513.154691F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting `ras =3D NULL` on devm_add_action_or_reset failure causes =
a deterministic kernel panic on subsequent uncorrectable errors.
- [High] Root port `dport->regs.ras` is exposed to concurrent error handler=
s before it is mapped, leading to a kernel panic.
--

--- Patch [13]: [PATCH v19 13/14] PCI/CXL: Mask/Unmask CXL protocol errors =
---
commit 882744bb847d3cd61f8f100025ea14b41fb68044
Author: Terry Bowman <terry.bowman@amd.com>

PCI/CXL: Mask/Unmask CXL protocol errors

CXL protocol errors must be unmasked to be reported. Add
pci_aer_mask_internal_errors() and pci_aer_unmask_internal_errors() helpers
to mask and unmask internal errors, and register a devm action to restore
the mask on teardown.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0254b7ec64c30..40a8a03070652 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -114,16 +114,64 @@ static void cxl_cper_prot_err_work_fn(struct work_s=
truct *work)
[ ... ]
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map =3D &dport->reg_map;
>  	struct device *dev =3D dport->dport_dev;
> =20
> -	if (!map->component_map.ras.valid)
> +	if (!map->component_map.ras.valid) {
>  		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(dev, "Failed to map RAS capability.\n");
> +		return;
> +	}
> +
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(dport_to_host(dport),
> +				     cxl_mask_proto_irqs, dev)) {
> +		dev_warn(dev, "failed to defer CXL proto-irq mask; CXL protocol error =
reporting disabled\n");
> +		dport->regs.component.ras =3D NULL;

[Severity: High]
Does setting ras to NULL here risk a kernel panic?

If a CXL protocol error triggers in the brief window between unmasking
and devm_add_action_or_reset() masking it again on failure, the AER IRQ=20
handler will enqueue the error to the kfifo.

When the kfifo worker dequeues the error and calls cxl_do_recovery(),
will it encounter a NULL ras_base and unconditionally call=20
panic("CXL: UCE with unmapped RAS registers")?

> +	}
>  }
[ ... ]
> @@ -165,8 +211,21 @@ void devm_cxl_port_ras_setup(struct cxl_port *port)
> =20
>  	map->host =3D &port->dev;
>  	if (cxl_map_component_regs(map, &port->regs,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +		return;
> +	}
> +
> +	dev =3D is_cxl_endpoint(port) ? port->uport_dev->parent : port->uport_d=
ev;
> +	if (!dev_is_pci(dev))
> +		return;
> +
> +	cxl_unmask_proto_interrupts(dev);
> +	if (devm_add_action_or_reset(&port->dev, cxl_mask_proto_irqs, dev)) {
> +		dev_warn(&port->dev,
> +			 "failed to defer CXL proto-irq mask; CXL protocol error reporting di=
sabled\n");
> +		port->regs.ras =3D NULL;

[Severity: High]
Can setting ras to NULL here also cause a panic?

Similar to the dport case, if an error is triggered and logged before the
devm action masks the interrupts again, will cxl_do_recovery() panic when it
accesses the NULL ras_base?

> +	}
>  }

[Severity: High]
Can exposing a partially initialized dport cause a panic?

Looking at __devm_cxl_add_dport() in drivers/cxl/core/port.c, the dport is=
=20
published to the xarray before its RAS registers are mapped:

drivers/cxl/core/port.c:__devm_cxl_add_dport() {
	...
	rc =3D add_dport(port, dport);
	if (rc)
		goto err;
	...
	devm_cxl_dport_ras_setup(dport);
	...
}

If firmware left CXL protocol errors unmasked, or if an error is already
pending in the kfifo, the kfifo consumer can execute concurrently. It
successfully looks up the partially initialized dport in the xarray and
passes it to cxl_do_recovery().

Because the mapping hasn't completed, to_ras_base() returns NULL, resulting
in an immediate panic("CXL: UCE with unmapped RAS registers").

Since cxl_do_recovery() was introduced earlier in this series, does this
make the race fatal?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803221810.3685=
703-1-terry.bowman@amd.com?part=3D13
