Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260452F7EF3;
	Tue,  2 Jun 2026 20:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430610; cv=none; b=eGlKG4Ntl/OC1+NRINR4jGZcBysLX02HUHwSrb7XcKRYoOlhHh3jby39fYXtyvaR1PPbMJIXVDmZlGxwdCC7LS4UXPIKoJtqhPRgBTHuuuFmzQLkcq22Nz2VYlhUqg+VVf6QrmPkLjgR9Q1qBthCBepy1eGBIbIh1TqDe1Nv+qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430610; c=relaxed/simple;
	bh=2S7zYuZiSnRMdevwHwNSGBWVVVzl2lkrKrqhFLXzNfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QWXDOnqYcfOgCgPLIgmGEmkl1p63lDCLcysr/J66qn2QmZthSd0OcFajFCFIh3wo5u/z+3LpnwJABvftDAGyh3iACxn0nGira7wLCwpkFtJ88RLpYFPFTmWyRXLo7rWqmFmijP+EG9as8JXhjrG5kc/UPCVaWPcHUgp8cwYIgO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nsN5D/l9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsN5D/l9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762B21F00893;
	Tue,  2 Jun 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430608;
	bh=B7KAa9FP34L6SmihAuP7NkokXs0YBAGkZg95xTzF05c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nsN5D/l9DE8gsw1NdvPpd+gpAcz2QHGfHxQS9H26qJ25FQzDuVjfthDLioJz7sjte
	 Dl1PiHBH7/wd+SLO8+zTDySkIeC6QOqX7EW29ICWphuaas/USezM3N2dNo2XXJuJ1e
	 QWYUwjsmpfciveUfbjVlyjBbIToAFiNyBnJWClHx9ezbFgVY0ixqfT1gRuM/67X5sf
	 4BjBg6gMaJnHzKSgvrOUx8XuyBFGXpTo9DqENW0o541MRMaMZCi+3CZ6KECv+KSoh/
	 r58bEfoxK5gjRHDnGWc9HIe19MvJDe7C33P/XvCTdSdrn4vREgHVLPXOZJxFCPTCDk
	 p0wEYJl/7AdWg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] PCI: rzg3s-host: Use shared reset controls for
 power domain resets
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260602195019.1798126-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 20:03:28 +0000
Message-Id: <20260602200328.762B21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Chained IRQ handlers are not removed during probe failure or teard=
own, leading to a potential Use-After-Free.
--

commit 8cee5b223d5c91e47fe4df2561360a3e326a556f
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s-host: Use shared reset controls for power domain resets

This commit switches to shared reset controls for PCIe power resets to prep=
are
for RZ/V2H(P) support. Multiple PCIe controllers share the same reset line =
on
this platform, which requires shared ownership of the reset control.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index d86e7516dcc29..a5192e4b58dfb 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1276,9 +1276,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct=
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
>  	if (ret)
>  		return ret;
> =20

[Severity: High]
This is a pre-existing issue, but I noticed a potential use-after-free
with the chained IRQ handlers in this driver during probe failure or teardo=
wn.

In rzg3s_pcie_init_irqdomain(), chained handlers are installed for each INTx
interrupt:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_init_irqdomain() {
	...
	for (i =3D 0; i < PCI_NUM_INTX; i++) {
		...
		irq =3D platform_get_irq_byname(pdev, irq_name);
		if (irq < 0)
			return dev_err_probe(dev, -EINVAL, ...);
	=09
		host->intx_irqs[i] =3D irq;
		irq_set_chained_handler_and_data(irq,
						 rzg3s_pcie_intx_irq_handler,
						 host);
	}
	...
}

If platform_get_irq_byname() fails on a subsequent loop iteration, the
function returns an error without unregistering the already installed
chained handlers.

Additionally, during teardown, rzg3s_pcie_teardown_irqdomain() does not
clear these handlers:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_teardown_irqdomain() {
	if (IS_ENABLED(CONFIG_PCI_MSI))
		rzg3s_pcie_teardown_msi(host);

	irq_domain_remove(host->intx_domain);
}

Because chained handlers are not managed by devres and persist after the
driver unbinds, could an interrupt on these lines cause
rzg3s_pcie_intx_irq_handler() to dereference the freed host pointer?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602195019.1798=
126-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
