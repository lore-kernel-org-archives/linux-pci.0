Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C124E324E;
	Mon, 28 Sep 2026 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615097; cv=none; b=I2epMJdHTKKDTBlOD3dtrao9pNLcRDkcOiEYb2uQ/vhqOafoH3PEm8Ua4PriNLOUlD6SxmCw2RalXL/HgXc33Lx+zv/Cb4P/2hC5tGRzT+/FfzbAyn7lVWUh3G1LCClRkAsZT8zNghgYWSJO4J4NC9c7Ym1hZHMGBMxgJoxri8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615097; c=relaxed/simple;
	bh=7AULUbWBfIzxyiBH2lvL6F1x5UupacIdTj6CPRPzC4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W+wvEfNzuiHpCDTc5J48cqDQiHa5SGVzf6j35laJR95pOgAKmyhpPoUa4ZRV6jCXSreFnIyunCUBvZYUOAZpH/wZr6JkDCjGSF4FTk3XeiPweaWqBN6l4Olvl1wZ8Ruu/MEozjeFyRyXQOYZGwFe3AvZ1eMPLCIR3RNtmMBWOnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lR898Iw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lR898Iw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1555D1F000FF;
	Mon, 28 Sep 2026 17:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615095;
	bh=1wxylLMEtZkRcAks2WHbJmDyJLQGpZfOXIJaSYXs0Y0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lR898Iw+B5iUQ2BefJgOAEwD2oN9pt/csmdkGsVgedEFrHrkD0hcRA8cBzVhxYdSv
	 j5H5M3ILOkmvS8TzOiEfsg18ejpcsCUQIn46l88nkj5qHb3c02Pi6ApGU6MbJrgid3
	 SD6lBC8Ghb9B8Cs8kvjmE48w+i23SOqc300LWKharRjBpe9REifbEZuIX7vSCT7K94
	 rmVmgSG/s9QjSXxZJqByhhQO+Nx8MkLPMZrjSgb8wHemiFZC8C/ZQgjHFvNqUEaoCQ
	 1O3buCX0wupZsntCWwt5lP6hQFW8Au7jd6WAI9p07bormpQ0K1Y0X/tPQxWyY/i2LB
	 4l/rt8/5gpyfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] PCI: rcar-gen4: Take over the iMSI-RX
 interrupt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928165230.3397664-11-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:04:54 +0000
Message-Id: <20260928170455.1555D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] PCI: rcar-gen4: UAF in MSI IRQ domain due to early freeing in tear=
down
--

commit af654bd32d2cbf225a560670eb31511987c35382
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Take over the iMSI-RX interrupt

This patch requests the "msi" interrupt in the driver and demultiplexes
the MSIs to handle controller reset requests and Root Port notifications
on the same line. The driver takes ownership of the interrupt instead of
the DesignWare core.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index d3f04358bbe31..256410fb4b1cd 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -818,6 +878,9 @@ static void rcar_gen4_pcie_host_deinit(struct dw_pcie=
_rp *pp)
>  	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
>  	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> =20
> +	/* Stop the handler before asserting reset and disabling the clocks. */
> +	free_irq(rcar->msi_irq, rcar);
> +

[Severity: High]
Does this setup introduce a use-after-free risk during teardown?

During driver removal or probe failure, dw_pcie_host_deinit() calls
dw_pcie_free_msi() to free the MSI IRQ domain before it calls the driver's
.deinit callback:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_host_deinit() {
	...
	if (pp->use_imsi_rx)
		dw_pcie_free_msi(pp);

	if (pp->ops->deinit)
		pp->ops->deinit(pp);
	...
}

Because pp->msi_irq[0] is set to -ENODEV, the DWC core does not unhook any
handler. This means rcar_gen4_pcie_msi_irq_handler() remains active and
could execute before free_irq() is called in rcar_gen4_pcie_host_deinit().

If an MSI is latched just before the link is stopped, the active handler
will dispatch to the DWC core via dw_handle_msi_irq(&rcar->dw.pp) and
dereference the freed pp->irq_domain.

While the commit message acknowledges this as a gap that might require a
common DWC core fix, this patch actively introduces a crash path for this
driver that could be triggered reliably on driver unbind or probe error
with pending MSIs.

Could we synchronize or stop the handler earlier to prevent this dereferenc=
e?

>  	rcar_gen4_pcie_host_perst_assert(pp, true);
>  	rcar->drvdata->deinit(rcar);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D10
