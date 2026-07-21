Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7D272816
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 13:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784640744; cv=none; b=nSauuW9k/b3wWwzkkAWgSyXAcRiaun8vo/rShlQB58HQl/CwD/EeVemh04pKhq2bp1PkYeIL/LABmp7tY7u8DIx2nzdGQ7Ih5vZhfRni6hfSXGUcBV4HUBeUf3O3U6mzuVEUkmuT6IJjZHrLiYijGcn6V3szGzEXrgFC673GbgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784640744; c=relaxed/simple;
	bh=XdtyRolBmEKYO9P+osinQa0tokzEYvqaeuyL2kF+rFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rhRhmfADjZmocJIjGEKjr52gBfLq09So0l1jEaOd1fYRdCkL1AWFbUN4adoKroXgex5sNJ2UULpsJM2CMXgj0mIYR3Mqz+zaVXxNfRtyFVBOmwbKz3GTYKMu3eSxwbNqf9VA/3JryLcKSmcFwyXpRBjspBlfyZ+QybSflwMkfZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlQdwlId; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlQdwlId"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831D31F00A3A;
	Tue, 21 Jul 2026 13:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784640742;
	bh=egRcJNwG0i4QOZBMoxhvmdJhFrfADpRPTCHAEyrc/lc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FlQdwlIdOTXX7j4vYx2/U/RuiueznZEbXGFLvrzVw81A+y5b5Xy6krliKd3FGb8tR
	 ITpJBynAgSPIkpGWim6w4gsxD5n3Wb0bB07XhHcOQE9ksOXlY2QtYHp029TonXevE/
	 qiglTmooobCKCST05xwJdWG/9uNR8a7cwFk1XbasqtC08AxMETkFdA3h1pLUZpMqKx
	 IVlRZNem4L9ixUhyWMMFzYuCi7cKZP8LjDPZyOjQTMv418IccUl/Tun6FSzL/ENhYy
	 6KAXb9FEcvPhScdil0brHrFJHfb76wi8mZjwux+swV6Vge0QAAn7+B7+vVTTHIl+MG
	 VE6XfqL2qwDBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: plda: Fix resource leaks on error paths in
 plda_init_interrupts()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260721131522.594267-1-alitariq45892@gmail.com>
References: <20260721130034.560632-1-alitariq45892@gmail.com>
 <20260721131522.594267-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 13:32:22 +0000
Message-Id: <20260721133222.831D31F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Error paths blindly clear chained handlers for uninitialized IRQ v=
ariables, potentially corrupting IRQ 0.
- [High] The patch fails to dispose event IRQ mappings on error paths, caus=
ing a resource leak and triggering a kernel WARN_ON during domain removal.
- [High] The error path disposes of the intx_irq mapping before clearing it=
s chained handler.
- [High] Freeing irq_domain while devres-managed IRQs still reference it le=
ads to a Use-After-Free during devres cleanup.
--

--- Patch [1]: [PATCH v2] PCI: plda: Fix resource leaks on error paths in p=
lda_init_interrupts() ---
commit f27fa706e161e83dc0578cd66d0f41f0380cf44a
Author: Ali Tariq <alitariq45892@gmail.com>
Date:   Tue Jul 21 13:15:22 2026 +0000

    PCI: plda: Fix resource leaks on error paths in plda_init_interrupts()

This commit adds shared error handling labels in plda_init_interrupts() to
deinitialize IRQ mappings and IRQ domains when initialization steps fail.

Link: https://lore.kernel.org/linux-pci/20260718120701.DF4111F000E9@smtp.ke=
rnel.org/

> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index f9a34f323ad8c..367d685244d05 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
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

[Severity: High]
If platform_get_irq() fails early, execution jumps to err_irq_domain_deinit.
Since port->msi_irq and port->intx_irq are not yet initialized (value 0),
will plda_pcie_irq_domain_deinit() attempt to clear the chained handler
for IRQ 0?

plda_pcie_irq_domain_deinit() {
        ...
        irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
        irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
        ...
}

This might inadvertently corrupt the system timer or other core system=20
interrupts assigned to IRQ 0.

[ ... ]
>  		if (event->request_event_irq)
>  			ret =3D event->request_event_irq(port, event_irq, i);
>  		else
>  			ret =3D devm_request_irq(dev, event_irq,
>  					       plda_event_handler,
>  					       0, NULL, port);
> =20
>  		if (ret) {
>  			dev_err(dev, "failed to request IRQ %d\n", event_irq);
> -			return ret;
> +			goto err_irq_domain_deinit;
>  		}

[Severity: High]
Are the event IRQ mappings leaked when taking this error path?

If a subsequent devm_request_irq() fails, the code jumps to
err_irq_domain_deinit, calling irq_domain_remove(pcie->event_domain).
However, the previously mapped event IRQs are not disposed of first. The
kernel's irq_domain_remove() function requires all mappings to be disposed
and will trigger a WARN_ON if mappings remain in the domain's radix tree.

[Severity: High]
Can this also lead to a use-after-free during devres cleanup?

When the probe function returns an error, devres cleanup will eventually ca=
ll
devm_irq_release() and free_irq(). The free_irq() function attempts to
deactivate the IRQ, which dereferences irq_data->domain:

free_irq() -> irq_shutdown() -> irq_domain_deactivate_irq()

Since irq_domain_remove(pcie->event_domain) was already called here in the
error path, will the devres cleanup dereference the freed domain structure?

[ ... ]
>  	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
> =20
>  	return 0;
> +
> +err_dispose_irq_mapping:
> +	irq_dispose_mapping(port->intx_irq);
> +err_irq_domain_deinit:
> +	plda_pcie_irq_domain_deinit(port);

[Severity: High]
Does this error path dispose of the intx_irq mapping before clearing its
chained handler?

When falling through to err_irq_domain_deinit, plda_pcie_irq_domain_deinit()
will call:

        irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);

Since irq_dispose_mapping() frees the VIRQ descriptor and makes the IRQ
number available for reuse, could clearing the chained handler here disrupt
another device that concurrently allocated this IRQ?

> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721131522.5942=
67-1-alitariq45892@gmail.com?part=3D1
