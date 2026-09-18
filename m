Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982512AE68;
	Fri, 18 Sep 2026 03:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702185; cv=none; b=aVyVRh1ykBi498om9W0j+OFqSv5uu8mxZDdLSmW5gTGPTcQcARqord/LI5ShgpLybGoBbiQ43z91e4Arq/aKTARor67x4H3lj1/AwmQK6VqqeIXEE+CdqO7tM5VBoi2z6EBJ7Nrk57hIWd1jcycPT3vlyqnZnQkGXMS9YjcUiNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702185; c=relaxed/simple;
	bh=/DMIG0VdrbeRG1JkoK4ew0CMSOvx6sFcVq5FNdl049c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FmyFVr4zJOz1X48eceNDqPOIWaNzmeuZ+w+e5bIcChxsgOoNP1PTIq8AmxUQASbc7gCKzqBYZIGnJB3sgJTpT+ERiGuYMZzjcUUW6KIU5W9GXddq+A78m+gVGf7BezKyNTWo7RNe0h6eBXsb6iRwlfXHaZ3uYCWcI6uOPsTDG8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfIFPyf/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfIFPyf/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9E71F000FF;
	Fri, 18 Sep 2026 03:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702184;
	bh=7t9ZGiilRRC0QTxnItNRTskZ0QpvIitWQuYw5GlFkAA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bfIFPyf/2jLmXISd7GotXLxjzhW0hG8dGsk4KUnRck4Gcu1eMpxHZAnPEHGu1/qkM
	 XeDrW0TyIswCRfiuuXv26bEu95QiRlI78PfeQQP8QA+hUJXF0Pl74v4SjmMFAt8cAV
	 6n0lPcYF7MgfOELs9sdYFo8oW68okDZT05hH8N7YMPUlPMLVbijkTThkBqD2jOBUp8
	 MNamkH7CIiw6uXnLqMlPW4VSsAoZVzVNRyFxjCD/bQVtnySCXsTfpRYxVQ39CPdUSV
	 abKbvKPmuMa/29IPWKSP4qVBrvLc2vUdrMZVciiLzdS/mHZvBHaFUv85Lqe5BxJ7T6
	 3dTLm5yju7caQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/11] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260918032038.2216471-7-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:29:43 +0000
Message-Id: <20260918032943.DD9E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] cleanup: mixed goto and guard() in rcar_gen4_pcie functions
--

commit 85df5e9dd7b13dd7810d0fe2da4e91a4ae75ac30
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: rcar-gen4: Add Root Port reset support

This commit adds Root Port reset support for the R-Car Gen4 controllers. It
implements the host bridge reset_root_port() callback, serializes the reset
with a mutex, and handles masking/unmasking APP interrupt enables during the
reset.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 8a85f5f45cda9..5b983ef6dc47d 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -394,6 +427,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pci=
e_rp *pp)
>  	writel(0, rcar->base + AXIINTCCONT);
> =20
>  	/* Deconfigure MSI interrupt signal */
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
>  	val =3D readl(rcar->base + PCIEINTSTS0EN);
>  	val &=3D ~MSI_CTRL_INT;
>  	writel(val, rcar->base + PCIEINTSTS0EN);

[Severity: Low]
Does this code mix scope-based cleanup with goto-based error handling?

The function rcar_gen4_pcie_host_msi_init() relies on a goto err label for
its error path. Introducing a guard() here violates the cleanup subsystem
guidelines which advise against mixing goto paradigms and scope-based clean=
up
in the same function.

[ ... ]
> @@ -484,14 +518,77 @@ static int rcar_gen4_pcie_host_hw_init(struct dw_pc=
ie_rp *pp)
[ ... ]
> +static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +					  struct pci_dev *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(bridge->dev.parent);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	struct dw_pcie_rp *pp =3D &dw->pp;
> +	struct device *dev =3D dw->dev;
> +	int ret;
> +
> +	guard(mutex)(&rcar->reset_lock);
> +
> +	rcar_gen4_pcie_quiesce_irqs(rcar);
> +
> +	dw_pcie_stop_link(dw);
> +
> +	ret =3D rcar_gen4_pcie_host_hw_init(pp);
> +	if (ret) {
> +		dev_err(dev, "Host init failed: %d\n", ret);
> +		goto out;
> +	}

[Severity: Low]
Is it safe to combine a guard() declaration with goto out error handling in
rcar_gen4_pcie_reset_root_port()?

The cleanup subsystem guidelines explicitly forbid mixing goto-based error
handling and guard() declarations in the same function, as it creates code
prone to double-free or resource leak bugs during future modifications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D6
