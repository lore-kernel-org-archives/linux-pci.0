Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F39B21254B
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639517; cv=none; b=U+Rkn/wcl8f9Xl12lbDtIcG2JvIo/JECi3eKI2MEKv3UHlU/SANhLaMpacMjgmFbjEM2wQqgkJZuZ34jvPgylWcxFDPcz6xlIcK0lhpoSz2s9jolHY9KrZs8Eo8iGt+HHOlGY7bFnAqMtMoSoUWmfDoJRNL2o/oqByK/htHINRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639517; c=relaxed/simple;
	bh=ECBOQtIsw2zpS5r4+bEZekvGJsDLdFUFzYilnxECOJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IGyyCifGoZucbuPa/kAZJ9vzkr8bjW4+FR52CcBfBHz9BObnShJdItZLc0m4jMtqTj0dbiv4nIiipj1IqAgB0xBHpbNzAHa/zT81wZQTDYv7CuYgU9g7xURpuuDqPmx5mTJS5iM/lrSM9e1EknaFpqsapIHPyScYnTc9qeVSqoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H60sZvit; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H60sZvit"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B5281F000E9;
	Tue, 21 Jul 2026 13:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784639516;
	bh=WGmk7lIdq8/FO4pY8GvtNxgoTpeYodi4E+BwPy9ips0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H60sZvitm5dhfRKnfL++MDRs7nIuuqOQyzGgVPpzrJ910VQjT0A+ZC4bMpXykp1zR
	 5cDZbb3lhTahscNvYQCs4Z4mwb7w4XIg7YH5NrTVI1hZOHU5Jw8ANHKGPqGDdAfck4
	 OBFxaslNj+eJWd9uuE0/GHgEeDCJXmL2qTL5dUs6J6Rtu84zZ7wyPbPzOS8Oky7c7s
	 4BUTpC2p7xVL7+vkOxu4VQTULcU37iUGuxesgFuhpz3NtLlQbO0z1qKSy8zbfJhV9q
	 e+24JKrZBaetA/jtsnI9EzaRY2EGtJVW7WdFxSt4ufGCO+USUsgwe2xgvALKJI/pQn
	 pILjvyD05RGNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] Fix resource leaks on error paths in
 plda_init_interrupts()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721130034.560632-1-alitariq45892@gmail.com>
References: <20260721130034.560632-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:11:55 +0000
Message-Id: <20260721131156.3B5281F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unwinding paths call `plda_pcie_irq_domain_deinit()`, which blindl=
y clears chained handlers for uninitialized or explicitly disposed IRQs.
- [High] The newly introduced error paths destroy IRQ domains without first=
 disposing dynamically mapped `event_irq`s, leading to descriptor leaks, ke=
rnel `WARN_ON` triggers, and Use-After-Free crashes.
--

--- Patch [1]: [PATCH] Fix resource leaks on error paths in plda_init_inter=
rupts() ---
commit c246e8c073fd516ae7484006a7fd3cf6cd55adf8
Author: Ali Tariq <alitariq45892@gmail.com>

Fix resource leaks on error paths in plda_init_interrupts()

This commit attempts to fix resource leaks in plda_init_interrupts() by
adding shared error handling labels. It aims to deinitialize IRQ domains and
mappings when initialization steps fail.

Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index f9a34f323ad8c..367d685244d05 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c

[ ... ]

> @@ -440,14 +442,17 @@ int plda_init_interrupts(struct platform_device *pd=
ev,
>  	}
> =20
>  	port->irq =3D platform_get_irq(pdev, 0);
> -	if (port->irq < 0)
> -		return -ENODEV;
> +	if (port->irq < 0) {
> +		ret =3D -ENODEV;
> +		goto err_irq_domain_deinit;
> +	}
> =20
>  	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
>  		event_irq =3D irq_create_mapping(port->event_domain, i);
>  		if (!event_irq) {
>  			dev_err(dev, "failed to map hwirq %d\n", i);
> -			return -ENXIO;
> +			ret =3D -ENXIO;
> +			goto err_irq_domain_deinit;
>  		}

[Severity: High]
Are the previously mapped event IRQs properly disposed here?

If irq_create_mapping() fails on a subsequent iteration of this loop, the
error path jumps to err_irq_domain_deinit and removes the domains via
irq_domain_remove().

Because the previously mapped event IRQs are never disposed,
irq_domain_remove() will enforce that the radix tree is empty and trigger a
warning. The undisposed descriptors still reference the freed domain, which
can cause a use-after-free during subsequent cleanup by the IRQ core.

[ ... ]

> @@ -485,6 +494,13 @@ int plda_init_interrupts(struct platform_device *pde=
v,
>  	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
> =20
>  	return 0;
> +
> +err_dispose_irq_mapping:
> +	irq_dispose_mapping(port->intx_irq);
> +err_irq_domain_deinit:
> +	plda_pcie_irq_domain_deinit(port);
> +
> +	return ret;
>  }

[Severity: High]
Could this error path operate on uninitialized or disposed IRQs?

If platform_get_irq() fails earlier in the function, port->msi_irq and
port->intx_irq are still uninitialized (0). The code jumps to
err_irq_domain_deinit and calls plda_pcie_irq_domain_deinit(), which blindly
clears chained handlers without checking if they were set:

plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie) {
    irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
    irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
    irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
    ...
}

Operating on IRQ 0 inadvertently disables its handler, which can freeze the
system if it happens to be the system timer.

Additionally, if the MSI interrupt mapping fails, the code falls through
from err_dispose_irq_mapping:

err_dispose_irq_mapping:
    irq_dispose_mapping(port->intx_irq);
err_irq_domain_deinit:
    plda_pcie_irq_domain_deinit(port);

This explicitly disposes port->intx_irq, but then falls through to
plda_pcie_irq_domain_deinit() which attempts to clear the chained handler
using the just-disposed virtual IRQ descriptor.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721130034.5606=
32-1-alitariq45892@gmail.com?part=3D1
