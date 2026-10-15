Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F953A3E7C;
	Thu, 15 Oct 2026 03:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035901; cv=none; b=PENYbGy8HpR9PXa3Ew9kSw9PohsKSjFXCtmmmvqOTs3JHLUUvLpDuU1V6pvYC9VIDPni6oMnOIaHe5Q08KQT7HKHZhe24e17SvSz8FuL9lrZ13gO9Sl5/h15vMjyDLx70vLC1t0NC2OQoBf5j0BlJ/ZBBXzIzTwO3BKIpgt/d0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035901; c=relaxed/simple;
	bh=3uYRfmuhLiIz9fVmB55/Yp0Gcc+BjiNpcngpc4KOLQ8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=PJBTdwBnOzJ/wIqe+C/QBm/jNb0hpSjfh3ZNhTfQNIB/GWRnlOmtRbi1Qt2gWgyG8KMpUKhan8Aosq396DvXk+5vyibZM9Ew0Cxo7/zgTdGcqW4Uuh+Iexoa/3R3sm/ZU+vgOjeciJMROopGphp366TOgOn5FG6HjWUJ7XWpIOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gh5RiXVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh5RiXVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56991F000C4;
	Thu, 15 Oct 2026 03:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035896;
	bh=fL4c1nQWp5Lcs/DXdsiSpPc5v6wpKTQtZQCF4bvfM8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gh5RiXVaHFQSD5xE0kELllPDcNWv/sahgaC6cBIZVIrArpl3CKBmcKV7Cvky4FE0J
	 XoYV4fgMHOuwcBu87io91Fe2x1c8uCkJBrTg/C0kG1M0NBIjQzDAyQiy5n7PxmZH9g
	 Hlw9yH0ktJett9flX0GGBA1tfFLLjo2Er9k2G7yFtCaFEGZ9NRBGo0KGsuTXhMSt0u
	 X5y4bfSLZ1fS6Fn3OtQqZroxzF8bwytBm59+IqUoLRQeqyexwUObnkWf9l5LGF5niB
	 WypaFMB89peS1hHq/wJDBcX0oe+q2rfzuIbRE2dT66JP545rteTphngZyxREXxUXqK
	 JnDog45CBwK0Q==
Message-ID: <sashiko-outbox-172223@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/18] PCI: rcar-gen4: Add Root Port reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261015033103.3076869-10-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-10-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:44:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] pci: rcar-gen4: PHY power leak on speed_control() failure
- [Medium] pci: rcar-gen4: memory leak of device_node refcount from of_msi_=
xlate
--

commit 50f3fefd40d6567632993d0a3d1141361fef7262
Author: Koichiro Den <den@valinux.co.jp>

PCI: rcar-gen4: Add Root Port reset support

Implement the host bridge reset_root_port() callback so PCI error
recovery can reset and reinitialize the R-Car controller. This also
provides the reset operation for the link-down handling added later.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index cbd22e6bb44b9..54260e62293b1 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c

[ ... ]

> @@ -661,14 +704,87 @@ static int rcar_gen4_pcie_host_setup(struct dw_pcie=
_rp *pp)
>  	return 0;
>  }
> =20
> +static void rcar_gen4_pcie_quiesce_irqs(struct rcar_gen4_pcie *rcar)
> +{
> +	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> +		rcar->reinit_pending =3D true;
> +		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +	}
> +}
> +
> +static void rcar_gen4_pcie_resume_irqs(struct rcar_gen4_pcie *rcar,
> +				       bool recovered)
> +{
> +	scoped_guard(raw_spinlock_irqsave, &rcar->app_lock) {
> +		rcar->reinit_pending =3D !recovered;
> +		rcar_gen4_pcie_app_irq_sync_locked(rcar);
> +	}
> +}
> +
> +/*
> + * R-Car Gen4 SoC PCIe controllers and R-Car Gen5 SoC PCIe4 controller h=
ave
> + * a single Root Port per instance, so the pci_dev is ignored and the wh=
ole
> + * controller is reset. The PCI core serializes the callers through its
> + * device locks.
> + */
> +static int rcar_gen4_pcie_reset_root_port(struct pci_host_bridge *bridge,
> +					  struct pci_dev *pdev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(bridge->dev.parent);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +	struct dw_pcie_rp *pp =3D &dw->pp;
> +	struct device *dev =3D dw->dev;
> +	int ret;
> +
> +	/* A failed resume may have left the controller powered down. */
> +	if (dw->suspended)
> +		return -EBUSY;
> +
> +	rcar_gen4_pcie_quiesce_irqs(rcar);
> +
> +	dw_pcie_stop_link(dw);
> +
> +	rcar_gen4_pcie_host_perst_assert(pp, true);
> +
> +	ret =3D rcar_gen4_pcie_common_reinit(rcar);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D rcar_gen4_pcie_host_setup(pp);
> +	if (ret)
> +		goto out;

[Severity: Medium]
Does calling rcar_gen4_pcie_host_setup() on every Root Port reset lead to
a device_node refcount leak?

rcar_gen4_pcie_host_setup() calls rcar_gen4_pcie_host_msi_init(), which
calls rcar_gen4_pcie_host_msi_addr(). Inside rcar_gen4_pcie_host_msi_addr():

drivers/pci/controller/dwc/pcie-rcar-gen4.c:rcar_gen4_pcie_host_msi_addr() {
    ...
    of_msi_xlate(dev, &msi_node, 0);
    if (!msi_node)
        return -ENODEV;

    if (!of_device_is_compatible(msi_node, "arm,gic-v3-its"))
        return dev_err_probe(...);
    ...
}

of_msi_xlate() internally acquires a reference to the matched device node,
which requires the caller to release it using of_node_put(). Since
rcar_gen4_pcie_host_msi_addr() does not appear to release this reference,
won't this leak a kobject reference dynamically on every reset event?

> +
> +	ret =3D dw_pcie_setup_rc(pp);
> +	if (ret)
> +		goto out;
> +
> +	ret =3D dw_pcie_start_link(dw);
> +	if (ret)
> +		goto out;

[Severity: Medium]
If dw_pcie_start_link() fails, can this leave the PHY permanently powered
on?

It looks like rcar_gen4_pcie_start_link() powers on the PHY via
ltssm_control(..., true) before calling speed_control(). For Gen5 devices,
rcar_gen5_pcie_speed_control() can fail. If this occurs, the error is
returned without calling ltssm_control(..., false).

When dw_pcie_start_link() returns an error here, the code jumps to out:
which skips dw_pcie_stop_link(), leaving the PHY powered on. Is there
a missing power off in this error path?

> +
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(dw);
> +	dev_dbg(dev, "Root Port reset completed\n");
> +
> +out:
> +	rcar_gen4_pcie_resume_irqs(rcar, !ret);
> +	if (ret)
> +		dev_err(dev, "Root Port reset failed (%d); interrupts stay masked unti=
l a reset succeeds\n",
> +			ret);
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D9
