Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666674F3EA6;
	Mon, 28 Sep 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615279; cv=none; b=irjxLCgz/7N7K7hfBZumKhvkdM4+m+YoRpy03UIJpqkOsUVuC7Ztb5LQgNWLwllzmS446/GAeBnZEz5u0qEyvS2+TR2jKZ2gu/WjqW1r26Vaz8jUXZ/9mhPmaGJVrdw0PK/FNzF39ZHTItgeeEHf0qB3iLC7LBXECmw2gX98X5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615279; c=relaxed/simple;
	bh=5vGjf+WTtuPy7wC39SC7cEVFqw4515jDGhIuVuRS04Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JD0O9fmCJFDJeBYSD4CNcqftLmTAes1yhhjICwbeTz7Xb8Wl7PP0hquKplzNMN2p+2H33YJLPMWcbpLOgpllMFTc66IAZkTRDQRyTgretp75o1OicmU8Xsqx4y00Z7ASZ4HxVUFU+2p2aeH9tvk/LY49noJYRqJYpUUSzfnmpJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vjed7odv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vjed7odv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C71FC1F000FF;
	Mon, 28 Sep 2026 17:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615278;
	bh=X0MXB7o+Qno7Vs3vEzRJF1SbePOgpZTN9bS8baquaFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vjed7odvIvlTPwAKDUPQwLx3YpyAddq6Q+x87CN+frBp9hmpWgpaCKenLmzhTWaVq
	 h5BTPU+kQSTVoEMrg6D0AOBaRg4AjvQ+fiBCXVkwjoqUeMrgsotDRmF8M73e5+cjGq
	 eCsRxoDmF1r2mLc9WVqLJprCUZVRns1B9rOZ4zwis6B0DkAdGbW2p6jJP9xDWJ8k1B
	 NmVaIR43fUq+KKFwEKy2cxvkaN93TrKHBSzo2MmERhae26HRMM6gjgQgUUm/eYXub6
	 bx9j3rTrYYuuq3ihzh+EZSSya181ETBo6hnWpb5OkWl8j+1hhvdDaSdGcCxWgQ+Ror
	 eRXOzRN7vZW8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/15] PCI: rcar-gen4: Recover the Root Port on link
 down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20260928165230.3397664-12-den@valinux.co.jp>
References: <20260928165230.3397664-1-den@valinux.co.jp>
 <20260928165230.3397664-12-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 17:07:57 +0000
Message-Id: <20260928170757.C71FC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] pci: use-after-free of MSI IRQ domain during host teardown
- [Medium] pci: controller permanently wedged if Root Port removed during l=
ink down
--

commit 82b6de1b742f3cf8c20cc9550ebcd54c8a744889
Author: Koichiro Den <den@valinux.co.jp>
Subject: PCI: rcar-gen4: Recover the Root Port on link down

This patch adds handling for link down events on the R-Car PCIe controller.
It introduces a mechanism to defer Root Port recovery to a workqueue to
avoid host hangs from DBI accesses while the link is down. It also arms
this detection post-enumeration and disarms it during driver removal.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index 256410fb4b1cd..aa80232afabad 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
[ ... ]
> @@ -559,15 +575,35 @@ static int rcar_gen4_pcie_host_msi_addr(struct dw_p=
cie_rp *pp, u32 *msi_addr)
>  static void rcar_gen4_pcie_app_irq_sync_locked(struct rcar_gen4_pcie *rc=
ar)
>  {
[ ... ]
> +	/*
> +	 * Note that rcar->rp_events_armed is not checked here because device
> +	 * removal may still need iMSI-RX interrupts after Root Port events have
> +	 * been disarmed.
> +	 */
>  	if (!rcar->reinit_pending && pp->use_imsi_rx && pci_msi_enabled())
>  		val |=3D MSI_CTRL_INT;
>  	writel(val, rcar->base + PCIEINTSTS0EN);
[ ... ]
> @@ -630,6 +666,44 @@ static int rcar_gen4_pcie_host_msi_init(struct dw_pc=
ie_rp *pp)
[ ... ]
> +static void rcar_gen4_pcie_link_down_work(struct work_struct *work)
> +{
> +	struct rcar_gen4_pcie *rcar =3D
> +		container_of(work, struct rcar_gen4_pcie, link_down_work);
> +	struct pci_dev *port;
> +
> +	/* Hold a reference: the Root Port can be removed through sysfs. */
> +	port =3D pci_get_slot(rcar->dw.pp.bridge->bus, PCI_DEVFN(0, 0));
> +	if (!port)
> +		return;

[Severity: Medium]
If the Root Port has been removed via sysfs and pci_get_slot() returns NULL,
does this early return leave reinit_pending set to true?

Since rcar_gen4_pcie_handle_link_down() sets reinit_pending to true before
scheduling this work, bypassing the reset sequence here would fail to clear
reinit_pending. Could this result in MSI interrupts being permanently maske=
d?

> +
> +	pci_host_handle_link_down(port);
> +	pci_dev_put(port);
> +}
[ ... ]
> @@ -640,6 +714,10 @@ static irqreturn_t rcar_gen4_pcie_msi_irq_handler(in=
t irq, void *data)
[ ... ]
> +	/* Check reset requests before MSI handling, which accesses DBI. */
> +	if (rcar_gen4_pcie_handle_link_down(rcar))
> +		return IRQ_HANDLED;
> +
>  	status =3D readl(rcar->base + PCIEINTSTS0) &
>  		 readl(rcar->base + PCIEINTSTS0EN);
>  	if (!(status & MSI_CTRL_INT))
>  		return IRQ_NONE;
> =20
>  	dw_handle_msi_irq(&rcar->dw.pp);
> =20
>  	return IRQ_HANDLED;
>  }
[ ... ]
> @@ -918,6 +1023,8 @@ static int rcar_gen4_add_dw_pcie_rp(struct rcar_gen4=
_pcie *rcar)
[ ... ]
>  static void rcar_gen4_remove_dw_pcie_rp(struct rcar_gen4_pcie *rcar)
>  {
> +	/* Cancel recovery work before removing the PCI bus */
> +	rcar_gen4_pcie_rp_events_disarm(rcar);
>  	dw_pcie_host_deinit(&rcar->dw.pp);
>  }

[Severity: High]
During host teardown, rcar_gen4_pcie_rp_events_disarm() is called which lea=
ves
MSI interrupts enabled via rcar_gen4_pcie_app_irq_sync_locked().

The teardown then continues into the core:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_host_deinit() {
    ...
    if (pp->use_imsi_rx)
        dw_pcie_free_msi(pp);

    if (pp->ops->deinit)
        pp->ops->deinit(pp);
    ...
}

Because dw_pcie_free_msi() frees the irq_domain before the driver's .deinit
callback has a chance to call free_irq(), what happens if a hardware
interrupt fires in this window?

Would rcar_gen4_pcie_msi_irq_handler() execute and call dw_handle_msi_irq(),
leading to a use-after-free when it dereferences the freed pp->irq_domain?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928165230.3397=
664-1-den@valinux.co.jp?part=3D11
