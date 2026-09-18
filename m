Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757F29C327;
	Fri, 18 Sep 2026 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702348; cv=none; b=IKG9Zklt6wImDrqu+QRjkiT/hlyuzS1UFgoM07d+oyVEY4vL0SC3HkwPUUmoWbwSIWAgU8WtNt3gaRWBfo0eB7hDZ0WZd7i4hEvr1LsIyjSpZxqRrOKjy26KT5MJJgOqEUqGsSIH6eKpEoMgaA3Uyd4ZuSJ9tOTgkZduoX+sEGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702348; c=relaxed/simple;
	bh=fD/glkWuZoZ0M2SweyBn/bkfWAVaMtK5NJpTSgYqcFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=np8xZnZGXzA8wLeknInznpV7OTN27G0esAF9X3DJaKcvL1zOrTX+X8/WQhdxmIy8i/5XXDH/rFlQUUeTXq7ieiNOt8eAhqImtcfzUCXL8x8rvnkyHbZHNpoydgBd2s6mOAc+/F0yoQDOT5yfLFg2SNn2BDSL+1e1mQL2hARXWBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cE//4DX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cE//4DX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9211F000FF;
	Fri, 18 Sep 2026 03:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702346;
	bh=w9CwkyB+53MSR67/cxYofrbEfkEN/5DqVXRKwINhyn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cE//4DX0yctL8fGIKek/TnlIoImC9+BJ41Dce2O3OMBItYL8Jr2NgigfmOZDOnUrz
	 P0zHcKxfk1ZSGl3CQsJqLTT6TBkH4pIhAztTqoqd0qIzo7QHAvBNGkHXOBFr4/xrWE
	 F8fRBlRQ1GOroGOnnwBRb24BiwZaeOT+oT6LvtpiissBkPDcaxwGxlXqIfWe8YRqRj
	 k5BZe0Tejj9ZXqyjeT/ZUrw5MbwXsiW8pmwOQEyV5s3FJdeAe8wApVxt7dBwqEh49Y
	 bCMngh2KAqnpIb64ENAqCnsVpIHCBLQwODMHHEQF5kx/64rzWIU5hAfZEY5uRLwJtA
	 53mZIKXZpIF+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] PCI: rcar-gen4: Route Root Port AER to a virtual
 Root Port IRQ
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260918032038.2216471-10-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:32:26 +0000
Message-Id: <20260918033226.8A9211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] subsystem: mixing goto and scoped_guard in rcar_gen4_pcie_rp_irq_in=
it()
--

commit 6f1a91ac675be05b5a2f016c1ae299cc233169a3
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: rcar-gen4: Route Root Port AER to a virtual Root Port IRQ

This commit routes the Root Port's AER notifications to a virtual Root Port
IRQ by falling back to INTx. It creates a single-entry virtual IRQ domain
for the Root Port and ensures the IRQ mask state is tracked in software for
recovery.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 238755852045e..c24ac82a1ec65 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> +static int rcar_gen4_pcie_rp_irq_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *dw =3D to_dw_pcie_from_pp(pp);
> +	struct rcar_gen4_pcie *rcar =3D to_rcar_gen4_pcie(dw);
> +	struct device *dev =3D dw->dev;
> +	int irq, ret;
> +
> +	irq =3D platform_get_irq_byname_optional(rcar->pdev, "aer");
> +	if (irq =3D=3D -ENXIO)
> +		irq =3D 0;	/* old DT: Root Port AER stays unavailable */
> +	else if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get AER IRQ\n");
> +
> +	/* Keep the notifications masked until a port service requests the IRQ.=
 */
> +	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> +		rcar->rp_irq_enabled =3D false;
> +		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +	}
> +	writel(RP_AER_MASK, rcar->base + PCIEINTSTS0CLR);
> +
[ ... ]
> +	if (irq) {
> +		/* Dispatch the child IRQ in hard IRQ context, including on PREEMPT_RT=
. */
> +		ret =3D devm_request_irq(dev, irq,
> +				       rcar_gen4_pcie_aer_irq_handler,
> +				       IRQF_NO_THREAD, "rcar-gen4-pcie-aer",
> +				       rcar);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Failed to request AER IRQ\n");
> +			goto err_dispose_mapping;
> +		}
> +		rcar->aer_irq =3D irq;
> +	}
> +
> +	/*
> +	 * The Root Port MSI capabilities are hidden (no_rp_msi), so the port
> +	 * services fall back to INTx; route it to the virtual IRQ.
> +	 */
> +	pp->bridge->map_irq =3D rcar_gen4_pcie_map_irq;
> +
> +	return 0;
> +
> +err_dispose_mapping:
> +	irq_dispose_mapping(rcar->rp_irq);
> +	rcar->rp_irq =3D 0;
> +err_remove_domain:

[Severity: Low]
Does rcar_gen4_pcie_rp_irq_init() mix scoped_guard with goto-based error
handling labels?

The subsystem guidelines in include/linux/cleanup.h state that mixing
goto-based cleanup and scope-based cleanup helpers in the same function
creates confusing ownership semantics, and is explicitly prohibited.

For a given routine, it's expected to either convert all resources to
scope-based cleanup, or convert none of them.

> +	irq_domain_remove(rcar->rp_irq_domain);
> +	rcar->rp_irq_domain =3D NULL;
> +err_free_fwnode:
> +	irq_domain_free_fwnode(rcar->rp_fwnode);
> +	rcar->rp_fwnode =3D NULL;
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D9
