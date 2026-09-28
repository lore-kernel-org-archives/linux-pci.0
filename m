Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611694F3EB5;
	Mon, 28 Sep 2026 17:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615290; cv=none; b=ceX3GcJp0YxmF5NkAweF/OLrsXNz5wus2jXpOjGEsu1rX+bB6JP6shRgL736QrJW7vn/vI1OrN0DPm2ezDsZBx/7QdgAnlTM/NemSbEMQwo0Mg8MJr6cuS7D++JEX/7ah08vTndv9YsVS0L+mveNT1wAOHdh67YA4+Y2gxlwbuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615290; c=relaxed/simple;
	bh=FARrQwDT4EW+D9Qj+ryx/t5BCduhf0OghzVcXRuKGG8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDKSSvW1GJb3tWZqE+JRUar19GLcbBpjs/h4YMEH1SW1rqZebf+p2Ht7XX44WkuGQYgmuTNgD+Oe3z2qgBJO77aUiubyJH9YyxdO6kKWFoWCS0z3wcQCDhGZvbFB2NGfsofQrwkKfE0xzmpAwergjF51X7fcYU2LbySGaG8SlBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEcuiMUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEcuiMUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20D71F000FF;
	Mon, 28 Sep 2026 17:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615289;
	bh=i9cQxVOPqXD381rLomz2LeW6qLIMSddf8BQs4GbzRUU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MEcuiMUvErtuDOR6hk+HVyCRao075RyGnHR8Q1JBaA1NhPcZtuI2f9LDfbFN8J+Nm
	 rsi/QiyOauTUlB+9DxCOCn6yiH6j7YutITuI8qjoQNPR+RIwC/Jjytwo7cf9ykcGKD
	 CyZ1wsDqc5eKEf4T/pXwGLtfJ+M7cva/U53d6NOgtwqko4agaUD038gxxY7qUyqAMi
	 qZGEXVJ0n/4nc9qhwIM1+AgmOx8ODj5Sg4n3tvAlxw8WOEPOtV4VJZPp1bHLgnmve2
	 Xz57PKkiFmvqd7IEi5DDZlEGOPte1bYKp1RAqzyAajU+F3RcKggMxf34BEUiGd2vZL
	 hEiyAVbwXjScg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/15] PCI: rcar-gen4: Route Root Port PME and
 bandwidth notifications
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <20260928165230.3397664-15-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-15-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:08:08 +0000
Message-Id: <20260928170808.A20D71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: rcar-gen4: lock nesting violation when dispatching Root Port =
IRQ
--

commit 1ab146ed20149ad07e070a26f36acae4f7dc256f
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Route Root Port PME and bandwidth notifications

The Root Port's PME and link bandwidth notifications are reported in
PCIEINTSTS0 and routed to intreq_pcim_sub, the interrupt shared with the
integrated MSI receiver and the reset requests. Dispatch these
notifications to the virtual Root Port IRQ from the "msi" IRQ handler
after handling any pending iMSI-RX interrupts.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index c01f157a7198b..319f917f90270 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -753,12 +766,12 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(i=
nt irq, void *data)
> =20
>  	status =3D readl(rcar->base + PCIEINTSTS0) &
>  		 readl(rcar->base + PCIEINTSTS0EN);
> -	if (!(status & MSI_CTRL_INT))
> -		return IRQ_NONE;
> +	if (status & MSI_CTRL_INT)
> +		dw_handle_msi_irq(&rcar->dw.pp);
> +	if (status & RP_SUB_MASK)
> +		rcar_gen4_pcie_rp_irq_dispatch(rcar);

[Severity: High]
Does this code introduce a lock nesting violation when dispatching the Root
Port IRQ?

When handling PME or bandwidth notifications, this path calls
rcar_gen4_pcie_rp_irq_dispatch(), which wraps the generic IRQ dispatch
inside a raw spinlock:

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_rp_irq_dispatch(=
) {
    ...
    guard(raw_spinlock_irqsave)(&rcar->rp_irq_lock);
    ...
    generic_handle_domain_irq(rcar->rp_irq_domain, 0);
}

The generic IRQ core will then execute leaf handlers, such as pcie_pme_irq(=
),
which acquire standard spinlocks:

drivers/pci/pcie/pme.c:pcie_pme_irq() {
    ...
    spin_lock_irqsave(&data->lock, flags);
    ...
}

Acquiring a standard spinlock while holding a raw spinlock violates lock
nesting rules and will trigger a lockdep warning when
CONFIG_PROVE_RAW_LOCK_NESTING=3Dy.

The generic IRQ core normally avoids this by dropping its own raw spinlocks
before running action handlers, but wrapping the dispatch inside the driver=
's
own raw spinlock defeats that protection.

Could the generic IRQ dispatch be safely performed outside of the
rp_irq_lock?

> =20
> -	dw_handle_msi_irq(&rcar->dw.pp);
> -
> -	return IRQ_HANDLED;
> +	return status & (MSI_CTRL_INT | RP_SUB_MASK) ? IRQ_HANDLED : IRQ_NONE;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D14
