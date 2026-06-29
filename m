Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0AF30EF9B;
	Mon, 29 Jun 2026 22:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771595; cv=none; b=dRt+gXzyGjAbePmfyP/C9TKBpbA8/VTosduI7zN19UiN6cBvCSfqnjhbOPc6xkTB9gFWdEWfAtFb5pz/A91cYm75E6MVdq1/XqUIHsbJtKgZ0h0qjpUvvy2xuFdvxag8R3110bLvu2lEZoB3sTLwD3Mdw7GNGoGidPQSuwELuxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771595; c=relaxed/simple;
	bh=+lnRhzM0rVCZ7DoCHdgHQB0Wr2zcenKVrHKy2OXYxvk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vb902DJUoGNUo9jxexCGzMxHENs/CYIfPp2WD12ZD6yTlw8g0fqa/Wgu2ABiWy0IRaNO9FuVmWmNZ1cMfRqYiFAnB87vNfvwQ4NPGszVMhMePdu46lqAcmBKm6/Fk4oEeqh0GP9SFv69lCz2k8z0LpgjNssR97BfRgpjefi76eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTEM9bPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTEM9bPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E3F11F000E9;
	Mon, 29 Jun 2026 22:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771594;
	bh=KSdPYNcXfulqbtnNuAE7hceMgNDks1Ok9ejaXdnYI1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iTEM9bParlP8BY3j3FkXF1blR9FRiuZra/q9hBgTrBC0sQViWkK0SDw6H/VcFlDlj
	 NIJ0izBLMyUGAtAeuQPavxfiYaLOkM/UChaUjjtyXurCzuQci/rzf5k3ldsvU83b6A
	 9+Bpa2tEoOrmywUgKTboB57wbYWCQUjcvNyTsIPZ3/tpRVny514Faiywx4edQHf+TS
	 0D8KB09xB53vf56qyzmk+kv6yFYhXX0a3+3zO3BShZue6QKjl7roy/7yS909bjB9zd
	 e0IgV89lPq5r8ebGZMIxsVPBNTxQu0emjWg6LoaPyUoZIO5g8EnrISDSGeWfL5TBAc
	 uNypX4YO84pUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260629220932.861445-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260629220932.861445-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:19:53 +0000
Message-Id: <20260629221954.0E3F11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The PCIe reference clock (`port->refclk`) is permanently leaked (e=
nable count imbalance) if `pci_host_probe()` fails during driver probe.
- [High] Hardware access violation in `rzg3s_pcie_suspend_noirq()` causes s=
ystem crash by writing to unclocked AXI registers.
- [High] Missing chained IRQ handler cleanup on probe error paths leads to =
Use-After-Free.
--

commit f0476ca1c132af88924c762e84517c32e45ebd21
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s-host: Use shared reset controls for power domain resets

This commit switches the PCIe power resets to use shared reset controls
to prepare for RZ/V2H(P) support. On this platform, multiple PCIe
controllers share the same reset line.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 66f687304c1cb..cca2617f29157 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1277,9 +1277,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct=
 rzg3s_pcie_host *host)
>  	for (i =3D 0; i < data->num_cfg_resets; i++)
>  		host->cfg_resets[i].id =3D data->cfg_resets[i];
> =20
> -	ret =3D devm_reset_control_bulk_get_exclusive(host->dev,
> -						    data->num_power_resets,
> -						    host->power_resets);
> +	ret =3D devm_reset_control_bulk_get_shared(host->dev,
> +						 data->num_power_resets,
> +						 host->power_resets);

[Severity: High]
This isn't a bug introduced by this patch, but looking at rzg3s_pcie_probe(=
),
is it possible we are leaking the reference clock enable count on probe fai=
lure?

In rzg3s_pcie_host_init_port(), the clock is prepared and enabled:

	ret =3D clk_prepare_enable(port->refclk);
	if (ret)
		return dev_err_probe(dev, ret, "Failed to enable refclk!\n");

If pci_host_probe() fails later in the probe sequence, the cleanup path
drops the reference without disabling it:

port_refclk_put:
	clk_put(host->port.refclk);

Could this keep the reference clock and its parent PLLs permanently enabled,
preventing the SoC from reaching deep sleep states?


[Severity: High]
This is a pre-existing issue, but does rzg3s_pcie_suspend_noirq() have a
hardware access violation?

The runtime PM domain and clocks are gated by pm_runtime_put_sync() before
invoking the de-initialization callback:

	ret =3D pm_runtime_put_sync(dev);
	if (ret)
		return ret;

	clk_disable_unprepare(port->refclk);

	/* SoC-specific de-initialization */
	ret =3D data->config_deinit(host);

When rzg3e_pcie_config_deinit() is called, it accesses the controller's
AXI register space:

static int rzg3e_pcie_config_deinit(struct rzg3s_pcie_host *host)
{
	writel_relaxed(0, host->axi + RZG3S_PCI_RESET);
	return 0;
}

Can writing to a memory-mapped peripheral register while its bus clock is
gated cause an immediate bus fault or system crash during suspend?


[Severity: High]
This isn't a bug introduced by this patch, but is there a use-after-free
risk in rzg3s_pcie_teardown_irqdomain() if a probe failure occurs?

During rzg3s_pcie_init_irqdomain(), chained handlers are registered and a
pointer to the host context is installed into the underlying interrupt:

		irq_set_chained_handler_and_data(irq,
						 rzg3s_pcie_intx_irq_handler,
						 host);

If the probe fails downstream, rzg3s_pcie_teardown_irqdomain() removes the
domain but doesn't clear the chained handlers:

static void rzg3s_pcie_teardown_irqdomain(struct rzg3s_pcie_host *host)
{
	if (IS_ENABLED(CONFIG_PCI_MSI))
		rzg3s_pcie_teardown_msi(host);

	irq_domain_remove(host->intx_domain);
}

Since the host structure is allocated with devm_pci_alloc_host_bridge(),
it gets freed when probe returns an error. Would an interrupt firing after
this point lead to a kernel panic by dereferencing the freed host pointer?

>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629220932.8614=
45-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
