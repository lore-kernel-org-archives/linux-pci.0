Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC54EB846;
	Mon, 28 Sep 2026 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790614999; cv=none; b=nb4E5hqReKjZbzrj2GLfb4cimJEIw0r8PcqRpB0sq48RtQOsco6qP3ep4bhehhcwLrcYCNJkAVlMhvPnjSuvEiAOPisYHQaAxazT1GBsf33/vgpgQm5ujZHk9Hli9D4WPzNbat0OnUA++IL+mMjVU8E7YxAFElnd6boZB5GtqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790614999; c=relaxed/simple;
	bh=3E7ZEnQXUmsCqp/1Q4/LMgh7cuLyR3/RVnvhgVYBIzE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OJ5lJmjCwQ9ZIsuhJtQTNYwYxwzxNI6e3a76We3+eV7GGBR+H80ZO7qhiG8UhocG2I1bU2yVT82sdhzoJCYoaB6/CX9TC1CVr9vIwM4yT3JQY3ymU9CYIUO7sxoCrr6R/FLSceS2wOfcoZD8i5xRiMOAqYjpyZJYT8D+FPHNBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4oEjM9J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4oEjM9J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B331F000FF;
	Mon, 28 Sep 2026 17:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790614998;
	bh=58RvXMu4EOg0WaVjNBQuqUC99RF3hVVojl92eOaatuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=R4oEjM9J3NZ4lLrCX3+VSiMtUntU+dNmIL0n3NFFgDDXSAM6gR+A38pdnwuoO1bg0
	 Gspu+eUuM4km95vB/WoW8UoAWB3Eo7l/2p+Nffyn5V/Uxhy/3rOeCYbe2HTFM6bZre
	 Ya4lWY7nyZi1RZIQYjtESkoUPhwYCC1+w5fZdVYnl5suoHnoxIJ8eYANsIgxlyiWl/
	 PmuXGOGhjkRLkW8kbAdSqvLTVLiw6/fEJYPGXwlcqUFqHi1uNAGgoZKta+G+f26teQ
	 IgtTHGWBCreDH9B+oDb7V6z9faEud+fJaWPofzxP/XjVs61WN89a87JcK0MyHHTwT4
	 U/xa2WuWMF/mA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928165230.3397664-10-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:03:17 +0000
Message-Id: <20260928170317.B0B331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] goto mixing: functions mix goto-based cleanup and guard() declarati=
ons
--

commit f67d0a2e310ff1eec161853a2c467d65ff545950
Author: Koichiro Den <den@valinux.co.jp>
PCI: rcar-gen4: Add Root Port reset support

This commit implements the reset_root_port() callback for the host bridge to
allow PCI error recovery to reset and reinitialize the controller. It also
adds synchronization around the APP interrupt enables during the reset.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index d1ea942727111..d3f04358bbe31 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -593,6 +619,7 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pci=
e_rp *pp)
>  	writel(0, rcar->base + AXIINTCCONT);
> =20
>  	/* Deconfigure MSI interrupt signal */
> +	guard(raw_spinlock_irqsave)(&rcar->app_lock);
>  	val =3D readl(rcar->base + PCIEINTSTS0EN);
>  	val &=3D ~MSI_CTRL_INT;
>  	writel(val, rcar->base + PCIEINTSTS0EN);

[Severity: Low]
Does this mix goto-based cleanup and guard() declarations within
rcar_gen4_pcie_host_msi_init()?

The cleanup subsystem guidelines recommend converting all resources to
scope-based cleanup or none at all in a given function to avoid confusing
ownership semantics. Since rcar_gen4_pcie_host_msi_init() still uses a
goto-based error path to reach this block, would it be better to avoid
injecting guard() here and stick to explicit locking, or convert the entire
function to scope-based cleanup?

[ ... ]
> @@ -691,14 +718,83 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie=
_rp *pp)
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
> +	rcar_gen4_pcie_host_perst_assert(pp, true);
> +
> +	ret =3D rcar->drvdata->reinit(rcar);
> +	if (ret)
> +		goto out;
[ ... ]
> +out:
> +	rcar_gen4_pcie_resume_irqs(rcar, !ret);
> +	if (ret)
> +		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked unti=
l a reset succeeds\n",
> +			ret);
> +
> +	return ret;
> +}

[Severity: Low]
Is it appropriate to mix guard(mutex) and goto-based cleanup flow in the
newly introduced rcar_gen4_pcie_reset_root_port() function?

Similar to the previous case, mixing goto labels with guard() can lead to
ambiguous cleanup paths. Could this function be written using entirely
scope-based constructs, or alternatively, entirely using manual lock
management to comply with the cleanup guidelines?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D9
