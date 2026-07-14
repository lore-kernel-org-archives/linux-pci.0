Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD5F732ED54
	for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784052129; cv=none; b=XibDL+BnZ+xNlPDdfXA7BgR1X6bYlRXTwlRwUqDeNwOkjBdGyd/oV5r2+KQzb4XTTGwa6RYcFFI/X8FmV8QOVX3dTkPPhieYmoYnZMhTtHjWANYVlATvPdOwnrvUkLUVy2K5usJhrKaSMvliCiWsMFhKu184B4zgrVbOa4OcxJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784052129; c=relaxed/simple;
	bh=et3wh+cq5BdPByI4ta8+zsqPii6L1i+YQVSniQKlLK0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rCUNyS1C6MDa0RZL1Rfaii/Ztsxze2dYUS9e8fBy9qha/HZV5e3zrwnvtAtezhuZMEKej2Wg2ShH8KgpRG9o7JU7Ln3r9i7GfQTU/2wz2ATMrJ3aDYqoG8zqkqnR73+xcDKhD/zbpWMVB3gF1OKXYRFK4wcVzgl+7O1kpDzHGQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne6o/NAB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne6o/NAB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564791F000E9;
	Tue, 14 Jul 2026 18:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784052128;
	bh=I8L2aSD+b2SZU0OgIJhVWv33/fI5uD16OSjpVB1DOjw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ne6o/NABno8yHVQue2GhiQpUM2BVQgEX5aOet1nEm4ksdMT/ww0wQDFoIaev5nHQ7
	 SS/ey6KbxEFtxxrICCaxU4Xrm6Gm0UpdYJZA1Oox0YVT9owfYAX9zjeRqztO8PCJBf
	 Wgt6jdqfRjLg1yGivT4RCX+yDUjWxDHJAX72XUIxnZKL0hla7dY3Gcu6JpNs0JAjyJ
	 fkZiPv0rn2iw5St6JahJ38IwD5EIZEAlLu2FkZh7GnSqM+a5gFHgwMUWHce9dusR1k
	 d5bk0nF85sxzo+XGnoo20hQiD8naZAOqGl5Z0ZkxQfr+8vVrx6y47X4LIjFNJpTEl1
	 104rNwGUW6zGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: plda: Synchronize chained IRQs during
 deinitialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260714174345.1073909-1-alitariq45892@gmail.com>
References: <20260714174345.1073909-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 18:02:07 +0000
Message-Id: <20260714180208.564791F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] The added `synchronize_irq()` calls fail to wait for chained inter=
rupt handlers to complete, leaving the target race condition unresolved.

Pre-existing issues:
- [High] IRQ domains are removed without disposing of active hardware IRQ m=
appings, causing IRQ descriptor memory leaks and triggering a WARN_ON.
- [High] Invalid teardown order between `devm_request_irq()` and `irq_domai=
n_remove()` causes a Use-After-Free during driver removal.
- [High] Error paths bypass deinitialization, leaking IRQ domains and creat=
ing a Use-After-Free condition.
--

--- Patch [1]: [PATCH] PCI: plda: Synchronize chained IRQs during deinitial=
ization ---
commit acb2d28887c68b108c1cc032991a465e12053c05
Author: Ali Tariq <alitariq45892@gmail.com>
Subject: PCI: plda: Synchronize chained IRQs during deinitialization

This commit aims to fix a race condition during driver unbind or probe
failure teardown by adding synchronize_irq() calls after clearing chained
handlers. The intention is to guarantee that executing handlers have fully
completed before proceeding with interrupt domain removal.

> diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/c=
ontroller/plda/pcie-plda-host.c
> index f9a34f323ad8c..f6759e255c755 100644
> --- a/drivers/pci/controller/plda/pcie-plda-host.c
> +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> @@ -560,8 +560,13 @@ EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
>  static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
>  {
>  	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> +	synchronize_irq(pcie->irq);

[Severity: High]
Does synchronize_irq() actually wait for chained interrupt handlers to
complete on chips lacking irq_get_irqchip_state?

Chained interrupt handlers execute directly via desc->handle_irq and bypass
flow handlers like handle_irq_event(), meaning they never set the
IRQD_IRQ_INPROGRESS flag.

Because plda_event_irq_chip does not implement the .irq_get_irqchip_state()
callback, synchronize_irq() may return immediately without waiting, leaving
the original race condition unmitigated.

> +
>  	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
> +	synchronize_irq(pcie->msi_irq);
> +
>  	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
> +	synchronize_irq(pcie->intx_irq);
> =20
>  	irq_domain_remove(pcie->msi.dev_domain);

[Severity: High]
This is a pre-existing issue, but does this code permanently leak irq_desc
memory?

irq_domain_remove() explicitly requires that all mappings be disposed first.
Because plda_pcie_irq_domain_deinit() removes the domains without calling
irq_dispose_mapping() for the mappings created in plda_init_interrupts(),
this leaves dangling mappings that trigger a WARN_ON and leak memory.

[Severity: High]
This is also a pre-existing issue, but does explicitly destroying
event_domain here cause a use-after-free during driver removal?

The generic event IRQs mapped from event_domain are requested using devres
(devm_request_irq()), so their actions are automatically freed by the devres
cleanup loop after the driver's remove function returns.

However, plda_pcie_irq_domain_deinit() destroys event_domain during the
remove function. When devres eventually calls free_irq(), the interrupt core
executes irq_domain_deactivate_irq(), which dereferences irq_data->domain,
leading to a use-after-free.

[Severity: High]
This is a pre-existing issue, but does plda_pcie_host_init() leak IRQ
domains on probe failure?

In plda_pcie_host_init(), if plda_init_interrupts() fails, the code jumps
to err_host:, which intentionally bypasses plda_pcie_irq_domain_deinit():

drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_host_init() {
    ...
err_probe:
	plda_pcie_irq_domain_deinit(port);
err_host:
	if (port->host_ops && port->host_ops->host_deinit)
		port->host_ops->host_deinit(port);
    ...
}

The IRQ domains created by plda_pcie_init_irq_domains() are permanently
leaked. Additionally, because these domains use the devres-managed port
structure as their host_data, their internal pointers become dangling once
the probe fails and devres frees port, leading to a use-after-free if the
domains are queried later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714174345.1073=
909-1-alitariq45892@gmail.com?part=3D1
