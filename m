Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29E360745;
	Mon, 29 Jun 2026 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771675; cv=none; b=QXdyueCe4FJjnkDCNxmfH8n9rtQmr7XQZpsg8YRth2YRpPiYRgdEB+ju9XmhUJ5R+4KkTV0EfxaLIfqZ3Lf+I37kRzCZiRfzyOc+fR7dy64mS59S85+xKY5btVAZEBLlB7BAM5ygky/U8//7u585TE92Gb0dFRCQqH1U26Vfy7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771675; c=relaxed/simple;
	bh=vJnoCaWTPT5xd6uLm7HEfSvKlcGNu1JUa1Obj3dCiew=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VfXphR0+n7BN6EeSbSKnt+4M50I6Xktat0s/miCR9sBc0eFFobpLHfSr9JCwNvlwy/rNwN1OqjC9j3vQclU3GiZ8leTXLuHxhSKymmVY7eaUi1K7nzIM1JylBQCtd8Fll4+KVFTR937HmX0KkJZBxlOpInPYKvGLgyKN/qwr7vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ccC3wqPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ccC3wqPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920291F000E9;
	Mon, 29 Jun 2026 22:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771674;
	bh=gPtk+R7hLbrzKwryL4yoz52Zwx61GiteIgNbDnfqves=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ccC3wqPht1SR1YWYU88cksUS9ZANDqpn8YOeISu4nV+DDtmt8QDI6PDlPKfzlXsFc
	 S5hvfjFyNk0gqimLVXz9MWrKAx/pIJpoawzSlySQr4WN1T9bfCau/YlS1+rUoaWUBP
	 zs4lbsILAQ8d0Qg/A1hvrFQWDSxqjhgFFaRQanB40KKbyMZpEuN1zNEz1n0BtFMFvr
	 SdKt1WBXCZWQm4/Ji3Qg+MFZvlg7CKOs+Q0hDnjCCIT1qmCs/MehM5Nvzi2Kiy9p3r
	 I+i1WF04fvjAvkK5xaxDV4vsaplyMiJFI06GJC84X2rctSuWUMjDCloJi6rRKCzH4+
	 C9sGrIndaIkDw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] PCI: rzg3s-host: Prepare System Controller
 handling for multiple controllers
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, robh@kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260629220932.861445-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260629220932.861445-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:21:13 +0000
Message-Id: <20260629222113.920291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to clear chained IRQ handlers in the error path leads to a=
 Use-After-Free of the `host` structure.
--

commit 9d15bfaf7ab0514922ec90d6892801c1f1eeb157
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s-host: Prepare System Controller handling for multiple controllers

This commit prepares the RZ/G3S PCIe driver to support multiple PCIe
controllers by extending the System Controller (SYSC) information storage.
It introduces an array of sysc_info structures indexed by a new controller
ID field. Existing single-controller SoCs remain functionally unchanged.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index cca2617f29157..03d79e98c9c99 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
[ ... ]
> @@ -1699,7 +1713,7 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
>  		return -ENOMEM;
> =20
>  	sysc =3D host->sysc;
> -	sysc->info =3D &host->data->sysc_info;
> +	sysc->info =3D &host->data->sysc_info[host->controller_id];

[Severity: High]
This is a pre-existing issue, but I noticed a potential memory safety conce=
rn
in the error handling path of rzg3s_pcie_probe().

If probe fails later and executes the error path, it calls
rzg3s_pcie_teardown_irqdomain(). Looking at rzg3s_pcie_teardown_irqdomain(),
it executes:

    irq_domain_remove(host->intx_domain);

However, it does not appear to clear the chained interrupt handlers.

Because the host structure is allocated via devm_pci_alloc_host_bridge(),
it will be automatically freed when the probe fails.

Could this leave a dangling pointer in the parent interrupt controller,
resulting in a use-after-free if the hardware triggers
rzg3s_pcie_intx_irq_handler() after the teardown?

> =20
>  	host->axi =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(host->axi))

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629220932.8614=
45-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D3
