Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDD38239C
	for <linux-pci@vger.kernel.org>; Sat, 18 Jul 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784376425; cv=none; b=tSwNS0cGp7REbXrSwhFVLPL2b0UZQX85mULYm3+bz9qyMzt5F3Hlq7KiV9OzszZKmKbqpzscj8Fz/Bd4wQn5RUDeV0Zj2hiMWM+h3biqXnTBiyKTPGzLacB3ZmMu498xMVTYQVsfpAhMeRGIkaIdG64mXvUZSm3v64vXMlQIJ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784376425; c=relaxed/simple;
	bh=h6BIzkEP0QVugnxz01tSHmEHq/kLwdHWfta7T4nrT+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L0OvSKTD3CdU1NG/FG1sq7sdgMidfEHaLz9pt2PjxSXU/S2nLySO5PfViB3sPO5A3PX3szHDDN0CegplHbSTFAfVxSbVrGtchJoJwCgecDtHBWOBiWJuRDQn2K+bvOuPGb8Wz3NHymTkadT/os15GQhvr1m2PanHXvyUmmIBPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SHpoDptN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SHpoDptN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4111F000E9;
	Sat, 18 Jul 2026 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784376422;
	bh=oG0xeVDbNMOlMqHZTqkNT63tQzpTLyNHD4AU+kZ8zGo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SHpoDptNR4+RDj/CskIpaKxJuzZt1wQMRylSZDhGksBXHsGqqa7Vvble2a/IHjmKk
	 xDeP2n6vDOcPfDnekQJJFB9F9NZC68QhEL/wHEuzbD39IJW1Uwx2ogb3NabYcAsE7o
	 5OUUW+63Byo78/JudafRQxO1Gu5Zxl+rauv6DkOpQrSkz4Xeg+ue6e5YKq24syBvY6
	 wiHJ2fOQnDKUlAQ446rO4toJ36pB6dUjoQXeoKbxfEAZc1mlik90woNzkc5eoFZpP7
	 6b6af7x0yiV6leWbxNe2e/qYKbQR9brF1dqy8oZdvNJWSXlTWPMwNM0IBpOTYQCwcr
	 UsGBzlVtfJ/EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: plda: Fix use-after-free of event IRQs during
 teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260718115022.231990-1-alitariq45892@gmail.com>
References: <20260718115022.231990-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 12:07:01 +0000
Message-Id: <20260718120701.DF4111F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing `irq_dispose_mapping()` before removing IRQ domains causes=
 descriptor leaks and triggers `WARN_ON`.
- [High] IRQ domains and mappings are permanently leaked if initialization =
fails in `plda_init_interrupts()`.
- [High] Partial domain creation failure leaks previously allocated domains=
 in `plda_pcie_init_irq_domains()`.
- [High] Unregistering chained interrupt handlers without synchronization l=
eads to Use-After-Free of IRQ domains.
- [Medium] Double registration of IRQ handlers for INTx and MSI events orph=
ans devres actions.
--

--- Patch [1]: [PATCH] PCI: plda: Fix use-after-free of event IRQs during t=
eardown ---
commit 9f5cef697b1d53b10380f6d82145d7cc265b3fb6
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: plda: Fix use-after-free of event IRQs during teardown

plda_pcie_irq_domain_deinit() removes pcie->event_domain via
irq_domain_remove(), but the per-event IRQs mapped from that domain
are requested with devm_request_irq() in plda_init_interrupts(). The
actual free_irq() for a devm-managed IRQ is deferred by devres until
after the calling probe()/remove() function returns.
   =20
This means irq_domain_remove() can free the domain's internal data
before the deferred free_irq() for IRQs still mapped into it has run.
When devres later processes that deferred cleanup, it can end up
dereferencing the already-freed domain.

Free each event IRQ explicitly with devm_free_irq() before removing
the domain. This triggers the free immediately and removes the IRQ
from the devres tracking list, so devres will not attempt to free it
a second time later.

Link: https://lore.kernel.org/linux-pci/20260714115343.4D49E1F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index f9a34f323ad8c..cda8fdb088fd6 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -559,10 +559,18 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
> =20
>  static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
>  {
> +	u32 i, event_irq;
> +
>  	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
>  	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
>  	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);

[Severity: High]
This isn't a bug introduced by this patch, but does clearing the chained
handlers without synchronization leave us exposed to a use-after-free?

Calling irq_set_chained_handler_and_data with NULL updates the flow
handler but doesn't wait for actively executing instances to complete.
Without an explicit synchronize_irq, a concurrent handler like
plda_handle_event could still be executing on another CPU.=20

If we then proceed to destroy the domains with irq_domain_remove below,
the concurrent handler might dereference the freed domains. Should there
be a synchronize_irq call here?

> +	for_each_set_bit(i, &pcie->events_bitmap, pcie->num_events) {
> +		event_irq =3D irq_find_mapping(pcie->event_domain, i);
> +		if (event_irq)
> +			devm_free_irq(pcie->dev, event_irq, pcie);
> +	}
> +
>  	irq_domain_remove(pcie->msi.dev_domain);
> =20
>  	irq_domain_remove(pcie->intx_domain);
>  	irq_domain_remove(pcie->event_domain);

[Severity: High]
This is a pre-existing issue, but does removing these IRQ domains without
disposing their mappings cause descriptor leaks?

While this patch explicitly frees the IRQs via devm_free_irq, the
underlying virtual IRQs were created using irq_create_mapping but are
never disposed via irq_dispose_mapping.

Removing an IRQ domain with active mappings triggers a warning in the core
IRQ code. This permanently leaks the underlying Linux IRQ descriptors and
radix tree nodes. Should the mappings be disposed before removing the
domains?

>  }

[ ... ]

Additional pre-existing issues were found in the same file:

[Severity: High]
This is a pre-existing issue, but does an error in plda_init_interrupts
leak the IRQ domains and mappings?

In plda_pcie_host_init:

	ret =3D plda_init_interrupts(pdev, port, plda_event);
	if (ret)
		goto err_host;
...
err_probe:
	plda_pcie_irq_domain_deinit(port);
err_host:
	if (port->host_ops && port->host_ops->host_deinit)
		port->host_ops->host_deinit(port);

	return ret;

If plda_init_interrupts fails partway through, the goto err_host path
bypasses plda_pcie_irq_domain_deinit. Since the domains and mappings
allocated up to the failure point are never cleaned up, does this result
in a permanent resource leak?


[Severity: High]
This is a pre-existing issue, but does a partial allocation failure during
domain creation leak previously created domains?

In plda_pcie_init_irq_domains:

	port->event_domain =3D irq_domain_create_linear( ... );
	if (!port->event_domain) { ... }

	...

	port->intx_domain =3D irq_domain_create_linear( ... );
	if (!port->intx_domain) {
		dev_err(dev, "failed to get an INTx IRQ domain\n");
		of_node_put(pcie_intc_node);
		return -ENOMEM;
	}

If the intx_domain allocation fails, the function returns -ENOMEM without
destroying the successfully created port->event_domain. Similarly, if
plda_allocate_msi_domains fails later, neither domain is freed.=20
Should this error path clean up the already-allocated domains?


[Severity: Medium]
This is a pre-existing issue, but does overwriting the flow handlers orphan
the previously registered actions?

In plda_init_interrupts:

	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
		event_irq =3D irq_create_mapping(port->event_domain, i);
		...
			ret =3D devm_request_irq(dev, event_irq,
					       plda_event_handler,
					       0, NULL, port);
		...
	}

	port->intx_irq =3D irq_create_mapping(port->event_domain,
					    event->intx_event);
	...
	/* Plug the INTx chained handler */
	irq_set_chained_handler_and_data(port->intx_irq, plda_handle_intx, port);

The events_bitmap typically includes intx_event and msi_event. The loop
registers a threaded irqaction via devm_request_irq for these events.
Immediately after, irq_set_chained_handler_and_data overwrites the flow
handler for the exact same virtual IRQs.

By replacing the generic flow handler with a custom chained handler, the
original action registered by devm_request_irq is permanently bypassed
and orphaned. Does this needlessly consume memory and leave inactive actions
until teardown?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718115022.2319=
90-1-alitariq45892@gmail.com?part=3D1
