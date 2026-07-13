Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A694313543
	for <linux-pci@vger.kernel.org>; Mon, 13 Jul 2026 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783955028; cv=none; b=hIksAWRwswyWqXVaxbZDD6CLSEcbYGuUP33t8lZt60T9Iqo53/myLeNMWbcQp5p5qrvbXNZfHPhkHLF3VyIdvbD6TIa1RUWYA0RtFzlEd819pyG+daB3vlfBEF815FkNU2F7LM568BqXFcBRpuClVA+Vl5VBnoN0AbnCGUj9XbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783955028; c=relaxed/simple;
	bh=DkjWNv6PxAkfZDIfhFkw5cybhxapB2yvP8aad88fs5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OO+A0/Q4YVBI1TFF68kCj/M8//3HQBLrouaU8g96JqtDDYZHhPUhZgfp/lnPa+c12cnRmGVPuIMRocPaWiE49j1LG4RWSIgS1991NpK6fIVCSOIOIjLNNE+sQo3HRIBZCgVjmKj6aHlKRUnBqxvAhixKCfAI4g/7zKma1AAHzc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ReUJEg5d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReUJEg5d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57F11F000E9;
	Mon, 13 Jul 2026 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783955026;
	bh=n9vB0jUnG655kQfJPZDRIunsWpJSIGNCo/9mchANznw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ReUJEg5dgKVaN5dxGNt/UGbKwWqm7VA87t2R3tq2RgnwhRxt+FYGsodcEaten/MjF
	 56uRfjm9PDwy7w+OdXXP3OvYWM46c/pexSNXRw+/P56KXVdXb3qQKgfWArEdSJ7JvN
	 TtebErD9ej7loXhSLRcxGMuLzpWzAeTRJMMTFw0szv/p1PQZ5l0BP5ylMwL0VjuLsE
	 Ppc6PckxYkUi2+sp4VlHLlW8YhNYZKbirEGOl6lXWLnQr5DKW2xYK0/iDiCbyfcpey
	 7jGXeZkDlKEhsUNmySSlfZE92TL0zhFlrnqfy8Lhf4HJxio/g5Ce0zG/geUFJzk372
	 DJUkLpClPV10A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: starfive: Fix Runtime PM handling and teardown
 ordering
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ali Tariq" <alitariq45892@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260713145014.740898-1-alitariq45892@gmail.com>
References: <20260713145014.740898-1-alitariq45892@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 15:03:46 +0000
Message-Id: <20260713150346.B57F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The driver fails to check the return value of `pm_runtime_get_sync=
()` during probe, risking a kernel panic.
- [High] `starfive_pcie_host_init()` leaks PHY resources and completely ign=
ores `regulator_enable()` failures.
- [High] Unsynchronized teardown of chained IRQ handlers risks a race condi=
tion and kernel panic.
- [Medium] IRQ domains created in `plda_pcie_init_irq_domains()` are perman=
ently leaked on probe failure.
- [Medium] IRQ domains are removed without first disposing of their active =
IRQ mappings, triggering a kernel warning.
- [Medium] `starfive_pcie_hide_rc_bar()` incorrectly relies on exact equali=
ty checks, allowing its protection to be bypassed via unaligned accesses.
--

--- Patch [1]: [PATCH] PCI: starfive: Fix Runtime PM handling and teardown =
ordering ---
commit 179d6c49f89a16ca3a07a0fadbdedce7703762df
Author: Ali Tariq <alitariq45892@gmail.com>

PCI: starfive: Fix Runtime PM handling and teardown ordering

The starfive_pcie_remove() path incorrectly disabled runtime PM
before executing plda_pcie_host_deinit(),
which can cause unmanaged hardware register access
while power domains or clocks are disabled.

> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/co=
ntroller/plda/pcie-starfive.c
> index 298036c3e7f94..6b439378e82eb 100644
> --- a/drivers/pci/controller/plda/pcie-starfive.c
> +++ b/drivers/pci/controller/plda/pcie-starfive.c
> @@ -436,9 +436,9 @@ static void starfive_pcie_remove(struct platform_devi=
ce *pdev)
>  {
>  	struct starfive_jh7110_pcie *pcie =3D platform_get_drvdata(pdev);
> =20
> -	pm_runtime_put(&pdev->dev);
> -	pm_runtime_disable(&pdev->dev);
>  	plda_pcie_host_deinit(&pcie->plda);
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
>  	platform_set_drvdata(pdev, NULL);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but doesn't starfive_pcie_probe()
ignore the return value of pm_runtime_get_sync()?

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_probe() {
    ...
	pm_runtime_enable(&pdev->dev);
	pm_runtime_get_sync(&pdev->dev);

	plda->host_ops =3D &sf_host_ops;
    ...
}

If pm_runtime_get_sync() fails, won't it return a negative error code but l=
eave
the device suspended?  Since the usage counter is still incremented on fail=
ure,
does the lack of error handling cause a PM usage count leak and risk hardwa=
re
access on powered-off devices during the subsequent plda_pcie_host_init()?

[Severity: High]
This is a pre-existing issue, but does starfive_pcie_host_init() leak PHY
resources and ignore regulator enable failures?

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_host_init() {
    ...
	ret =3D starfive_pcie_clk_rst_init(pcie);
	if (ret)
		return ret;

	if (pcie->vpcie3v3) {
		ret =3D regulator_enable(pcie->vpcie3v3);
		if (ret)
			dev_err_probe(dev, ret, "failed to enable vpcie3v3 regulator\n");
	}
    ...
}

If starfive_pcie_clk_rst_init() fails, doesn't it return immediately without
calling starfive_pcie_disable_phy(), permanently leaving the PHY powered on?

Also, if regulator_enable() fails, shouldn't there be a return statement af=
ter
the dev_err_probe() call to prevent initializing the controller without pow=
er?

[Severity: Medium]
This isn't a bug introduced by this patch, but are IRQ domains permanently
leaked on probe failure?

drivers/pci/controller/plda/pcie-plda-host.c:plda_init_interrupts() {
    ...
	port->irq =3D platform_get_irq(pdev, 0);
	if (port->irq < 0)
		return -ENODEV;
    ...
}

If this returns an error, its caller plda_pcie_host_init() handles it here:

drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_host_init() {
    ...
err_host:
	if (port->host_ops && port->host_ops->host_deinit)
		port->host_ops->host_deinit(port);

	return ret;
}

Doesn't this err_host cleanup path omit the required call to
plda_pcie_irq_domain_deinit(), permanently leaking the IRQ domains and their
memory?

[Severity: High]
This is a pre-existing issue, but is there an unsynchronized teardown of
chained IRQ handlers here?

drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_irq_domain_deinit() {
    ...
	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);

	irq_domain_remove(pcie->msi.dev_domain);
    ...
}

Since irq_set_chained_handler_and_data() doesn't wait for executing handlers
to finish, could an interrupt fire on another CPU and execute concurrently
with the teardown process?

If the hardware clocks are disabled in host_deinit(), could this trigger a
fatal bus fault when the executing handler reads un-clocked PCIe registers?
Should synchronize_irq() be called here?

[Severity: Medium]
This isn't a bug introduced by this patch, but are IRQ domains removed with=
out
disposing of their active mappings?

drivers/pci/controller/plda/pcie-plda-host.c:plda_pcie_irq_domain_deinit() {
    ...
	irq_domain_remove(pcie->msi.dev_domain);

	irq_domain_remove(pcie->intx_domain);
	irq_domain_remove(pcie->event_domain);
    ...
}

Since hardware interrupts were mapped using irq_create_mapping() during
initialization, doesn't directly removing the domains without calling
irq_dispose_mapping() trigger a warning in the core IRQ subsystem?

[Severity: Medium]
This is a pre-existing issue, but can the protection in
starfive_pcie_hide_rc_bar() be bypassed?

drivers/pci/controller/plda/pcie-starfive.c:starfive_pcie_hide_rc_bar() {
    ...
	if (pci_is_root_bus(bus) && !devfn &&
	    (offset =3D=3D PCI_BASE_ADDRESS_0 || offset =3D=3D PCI_BASE_ADDRESS_1))
		return true;

	return false;
}

Because this uses an exact equality check, what happens if there is a 1-byte
or 2-byte access at an unaligned offset (e.g., offset =3D 0x11)?

Does this evaluate to false and pass the access through, bypassing the
hardware protection boundary?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713145014.7408=
98-1-alitariq45892@gmail.com?part=3D1
