Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CF397329
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155430; cv=none; b=cRANnVortULMiDXQ1wWSpu3yJFjRJblZTwf7d353nwZ0fbCSMNHeaDaoVhK3ryriI6WRxluVtgpqMmZ/aaFdsNIshig5dh2MMueo5U836KBedP6zdgmN8T3o25vaYlVxSPVvjNzWIxhi2XiRzJ0kqiW9qOcDugoMOT0fmLq7Pcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155430; c=relaxed/simple;
	bh=JwUDyTt08Fi6P6gDON3AmZTLN8zsGIolYgt7RlDscWw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QIuEsM3lz/qOHA6+oD82h1mQtyGlhGitQBu1sJG67RwbAFdjdfkc7jJPFZEK8RtnGwiFy+Qkzbc0PYa+6picq7fXfqgpNYpe9UKZ+27zkeiZAVTqFxCc1b9WEM0BStohgS/Q5UWEWqY52HNhvoH+pw+hxZNpCBZGeyo9WUP8HCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eWbElRh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWbElRh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134DF1F000E9;
	Wed, 15 Jul 2026 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784155429;
	bh=9OaDAY7b3Np0J58uJHImIG1So0Zy0MyIe5MA12Zgtqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eWbElRh0hrtiroqw++zmObq/z5izETlParMUrbGikWKMc2VoXu0GaOM6+dHJaRxhM
	 GMkTFObMrOnKPUjyJWDDeLyLC5jou2c0vNsCblMdZoWZiwOxPHEApR7YzalN/lPpQm
	 uBoAgCsj6v2cPR6QfgTtygFsDMsJgBWHGqlLKqEWfiBpMwnfzx76Mo69O1UPLHYCIs
	 jwbkPBwY+qU0VkCx0vnd4UO4Zqk67D1PDzIASN0SzdOgFIhtNFTnFNC7NvwGfLR/8H
	 TjqdXXmAycNDRWdlt/3zYtWhi9Awr89+DBuZry5UzJdMdvDgCIdNOaCxFBrN921mF0
	 Id9+hhpDbSvBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:43:48 +0000
Message-Id: <20260715224349.134DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] The patch violates hardware teardown order by disabling the PCIe=
 reference clock before asserting controller resets.

Pre-existing issues:
- [Critical] Missing IRQ cleanup for chained INTx handlers on probe failure=
 leads to use-after-free.
- [High] MMIO register access after PM runtime clock gating in suspend path=
 causes system hang.
--

--- Patch [1]: [PATCH 1/3] PCI: rzg3s: Disable refclk on probe failure ---
commit 0d4ef239e6084c21b4710c1db03e3a6365363533
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: PCI: rzg3s: Disable refclk on probe failure

This commit disables the PCIe reference clock when the probe function fails.
It adds a call to clk_disable_unprepare in the error path, ensuring the
clock is balanced if initialization fails.

Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 66f687304c1cb..bd6471a7fb7a1 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1762,6 +1762,7 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
>  	return 0;
> =20
>  host_probe_teardown:
> +	clk_disable_unprepare(host->port.refclk);

[Severity: Medium]
Does this new addition violate the hardware teardown order by disabling the
reference clock before asserting controller resets?

During setup, the reference clock is enabled prior to calling
config_post_init() which deasserts resets. In this new error path,
clk_disable_unprepare() is called before host->data->config_deinit(host).

Could disabling the clock while the core is out of reset leave the state
machine hanging or undefined? Should the clock disable be moved after the
config_deinit() call to maintain strict LIFO initialization order?

>  	rzg3s_pcie_teardown_irqdomain(host);

[Severity: Critical]
This is a pre-existing issue, but does the teardown function fail to clean
up chained handlers on probe failure?

Looking at rzg3s_pcie_teardown_irqdomain(), it removes the IRQ domain but
does not unregister the chained INTx hardware handlers:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_teardown_irqdomain() {
        if (IS_ENABLED(CONFIG_PCI_MSI))
                rzg3s_pcie_teardown_msi(host);

        irq_domain_remove(host->intx_domain);
}

If pci_host_probe() fails and the devres mechanism frees the host structure,
could a shared or spurious INTx interrupt firing later cause
rzg3s_pcie_intx_irq_handler() to dereference the freed host pointer? Should
this call irq_set_chained_handler_and_data(irq, NULL, NULL) to prevent a
use-after-free?

>  	host->data->config_deinit(host);
>  rpm_put:

[Severity: High]
This is a pre-existing issue, but can the suspend path cause a system hang
due to MMIO access after PM runtime clock gating?

In rzg3s_pcie_suspend_noirq(), the driver disables the device PM domain
clocks before calling the hardware de-initialization routine:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_suspend_noirq() {
        ...
        ret =3D pm_runtime_put_sync(dev);
        if (ret)
                return ret;

        clk_disable_unprepare(port->refclk);

        /* SoC-specific de-initialization */
        ret =3D data->config_deinit(host);
        ...
}

For the RZ/G3E SoC, the de-initialization callback performs an MMIO write:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3e_pcie_config_deinit() {
        writel_relaxed(0, host->axi + RZG3S_PCI_RESET);
        return 0;
}

Will accessing this MMIO region while the bus clock is gated trigger a fatal
bus fault on ARM64 during system suspend? Should the de-initialization
happen before pm_runtime_put_sync() is called?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715223019.3002=
237-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
