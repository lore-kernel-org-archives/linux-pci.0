Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54606339362
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 20:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479167; cv=none; b=Qt4hZK3FX9go/gRTnosNiT4FiIYDO1BuivPy6UXSzM/cHA89BFlCblPpRq1bd3+bN0NJspbgxqVhKT7vZ1MNNRAW8Ff8BdsUw9sUm3Kb1y1v0YH4HNUMbxG+aKkr72YfB7aX1cz3J3KPI92RPNyo+YbxshlyepyMBxMXerjD+wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479167; c=relaxed/simple;
	bh=rwVHIQ+2FuCbuGk8btw8Ewl3RzEb4gDLY1l79QK+twY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YAe6zCu6eXa1IORd1kSu0zN88hN57k1aRHbAKSZBZP+U/Q5rRIHajvuW76eCzZdTVrhtXvuBTLs8f7QLYaqHUrtpsd+DDanSBAPzmYTqk6QFW6TjsNwnbdluO0n5poYD0iPYI/z/nsyDz0E/nmTLkOrCV6KT5wSlUL5n8a4AvfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eXm72QMo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eXm72QMo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 028D01F000E9;
	Tue, 11 Aug 2026 20:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479166;
	bh=vk+m3b0R7i+yaqkRp4N8wnVlPnXlnOkHFnOIA/8UAJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXm72QModdwsmknWH6FvBhG/h3eM7SaaD6OHlLfGLdXQQvMJi5SS4fOUc/nAgpxuD
	 p585bEAK+4tSqX+4bQxspPedfslnxoXGTV/Vb1APbdRF3rxMFBG0bCZ/0orvj+4trJ
	 y59NvmPRGV2UfRXbnxzffkPQEM/nK0ZG/3y+Bl5SZNY655FhbB+FJJ+SDa0ehjenTK
	 3wZGy7SqpsnR/f1s3c0Tiv3CuhGwmrPigsQ5DMOdkuMSGYxO3JpudESIdd4suWGpQ9
	 D6LAzIbMm9raOg/Xly54LIefNcMcR9/KKpOI6iabT5QPH3yYhl8G3DMuRder2hNOvb
	 Bv2u1TD1Ki8aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] PCI: rzg3s: Propagate platform_get_irq_byname()
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260811200013.185956-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260811200013.185956-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:12:45 +0000
Message-Id: <20260811201246.028D01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing cleanup of chained IRQ handlers triggers a Use-After-Free =
panic on probe failure.
- [High] Logic error due to false assumption of contiguous virtual IRQ numb=
ers leads to unhandled INTx interrupts.
--

--- Patch [2]: [PATCH v3 2/3] PCI: rzg3s: Propagate platform_get_irq_byname=
() errors ---
commit 398dc4c2681ec621a5ea3ee51113abc78f26854a
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Propagate platform_get_irq_byname() errors

platform_get_irq_byname() may return specific error codes such as
-EPROBE_DEFER, but rzg3s_pcie_init_irqdomain() replaces all failures
with -EINVAL. This commit propagates the original error code instead to
allow probe deferral.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index bd6471a7fb7a1..92371310d313b 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -975,7 +975,7 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pci=
e_host *host)
> =20
>  		irq =3D platform_get_irq_byname(pdev, irq_name);
>  		if (irq < 0)
> -			return dev_err_probe(dev, -EINVAL,
> +			return dev_err_probe(dev, irq,

[Severity: High]
This is a pre-existing issue, but does this error path leave chained handle=
rs
registered?

If rzg3s_pcie_init_irqdomain() successfully maps INTA but fails on a
subsequent INTx setup like an INTB probe deferral, returning directly leaves
the earlier chained handlers active. This same unhandled registration happe=
ns=20
if irq_domain_create_linear() fails later, or if the teardown function=20
omits unregistering the INTx chained handlers.

Since the device probe fails, the devres framework will free the host
structure. If the unhandled chained interrupt fires later, it will
dereference the freed host pointer, leading to a use-after-free panic:

rzg3s_pcie_intx_irq_handler()
    struct rzg3s_pcie_host *host =3D irq_desc_get_handler_data(desc);
    // UAF on host access

>  					     "Failed to parse and map INT%c IRQ\n",
>  					     'A' + i);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the INTx=20
handling in this file, I noticed a potential issue in=20
rzg3s_pcie_intx_irq_handler().

Is the calculation for the INTx index assuming contiguous virtual IRQ numbe=
rs?

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_intx_irq_handler() {
    ...
    u32 intx =3D irq - host->intx_irqs[0];
    ...
    generic_handle_domain_irq(host->intx_domain, intx);
}

If the OS allocates non-contiguous virqs (for example, due to concurrent IRQ
allocation or ID reuse by the IDR), this calculation will yield an invalid
out-of-bounds index or underflow.

Can this cause the generic handler lookup to fail? If so, leaving the INTx
interrupt unhandled might lead to an IRQ storm that permanently disables
the interrupt line and breaks downstream PCIe devices.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811200013.1859=
56-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
