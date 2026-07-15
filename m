Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3543D2DF136
	for <linux-pci@vger.kernel.org>; Wed, 15 Jul 2026 22:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784155518; cv=none; b=KKyYoOMPoJY9dpkUNBXbINlMXQqE3X41YInR3cvvGSWkO6pVzn/6gAy3yen0mrBidHyJMJoItl5hwKlzfdpkLCzUZvtjuk5e7v4+JuwDiweuCL0dN61qWoorPcVPPst/9DWgx89Z0jJ1WltaS4vsCm9Q24K7qH38Ro1BXRIKFIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784155518; c=relaxed/simple;
	bh=+yp4p2WaZej+SxMDgF/usEfmZw3+ck7Xzyiuh83+2PM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dV+B+AfpWS4m23XGdrDMZ/HbNpVghJMWzXp02GlBLLaO4v0DkQJ9Ws+YpLqP6GiCxXkAyX3lkRnkAD9tN2hlrNceE7IMUovDpVNAVCJX1YQFwsx5DiBFpu+A3LP6GLMmd2biIzNNWrLqhg6NKdZBloVuGeqsJ+njhde3ok0crjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn2E7HQP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn2E7HQP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9061C1F000E9;
	Wed, 15 Jul 2026 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784155516;
	bh=e8xf0S6i+rKGuUIUH8cVArjbsjFNV39S/fPow8sIGJc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dn2E7HQP0L9LxJbZq2ILTIhAEVSznQG9u1+GFIKlUR9SxX/9Ht/+CdKjJCg0IxhGz
	 IEsylWagacjDHo942od9QQUpBKGl8i9If4o7/Ossz62xVH7yUXPLmfjEGn/GysUzZe
	 rjDmLJCBHzUGIPRxJTsX34wPriqimLmqPfC0fsQ5PJqsZAXoSs17T67EHkp1543Y4G
	 bQOPbqJTyhh7xIG9YUFqvtCjyMS45dt2h6pwDy9TTWUq+OadfldcMoAtfvYoV7YZJq
	 ss2LD7oW6EEJy+A8kr/lGBf/XjdHAHE+VWz9Yl5yBCAMdRVRtsvg6ywW/ZtmpI9bMP
	 f43ThJr1aLXfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: rzg3s: Propagate platform_get_irq_byname()
 errors
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260715223019.3002237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260715223019.3002237-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260715223019.3002237-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:45:16 +0000
Message-Id: <20260715224516.9061C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to clear chained INTx IRQ handlers on error paths and duri=
ng teardown leads to a use-after-free on probe failure.
- [High] System suspend path accesses AXI registers after disabling the PM =
domain, causing an asynchronous external abort.
- [High] INTx handler calculates hardware IRQ index assuming virtual IRQs a=
re contiguous, which can lead to IRQ storms and lockups.
--

--- Patch [2]: [PATCH 2/3] PCI: rzg3s: Propagate platform_get_irq_byname() =
errors ---
commit 24fb1c19eb92c4744be36d3ec0690bbefc19cef4
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Propagate platform_get_irq_byname() errors

This commit modifies rzg3s_pcie_init_irqdomain() to propagate the specific
error code returned by platform_get_irq_byname() instead of overriding it
with -EINVAL. This ensures probe deferral works correctly if the interrupt
provider is not yet available.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index bd6471a7fb7a1..92371310d313b 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -975,7 +975,7 @@ static int rzg3s_pcie_init_irqdomain(struct rzg3s_pci=
e_host *host)
> =20
>  		irq =3D platform_get_irq_byname(pdev, irq_name);
>  		if (irq < 0)
> -			return dev_err_probe(dev, -EINVAL,
> +			return dev_err_probe(dev, irq,
>  					     "Failed to parse and map INT%c IRQ\n",
>  					     'A' + i);
> =20

[Severity: High]
This is a pre-existing issue, but returning directly from this loop on
error without cleaning up chained INTx handlers leads to a use-after-free.

If platform_get_irq_byname() fails for i > 0 (for example, by returning
-EPROBE_DEFER), does the driver leave chained handlers registered for the
previous iterations?

When the probe fails, the host structure is freed by devm.

If the parent interrupt fires during the probe deferral waiting period,
could the kernel execute rzg3s_pcie_intx_irq_handler() with a dangling
pointer?

Similarly, should rzg3s_pcie_teardown_irqdomain() clear these handlers?

It currently removes the IRQ domain but completely omits cleaning up the
INTx chained handlers, which might leave them dangling on unbind.


[Severity: High]
This is a pre-existing issue, but does the system suspend path access AXI
registers after disabling the PM domain?

In drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_suspend_noirq():

	ret =3D pm_runtime_put_sync(dev);
	if (ret)
		return ret;
=09
	clk_disable_unprepare(port->refclk);
=09
	/* SoC-specific de-initialization */
	ret =3D data->config_deinit(host);

This disables the power domain before executing SoC-specific
de-initialization.

For RZ/G3E, rzg3e_pcie_config_deinit() performs a writel_relaxed() to
host->axi + RZG3S_PCI_RESET.

Can accessing the AXI register space without clocks trigger a hardware faul=
t?


[Severity: High]
This is a pre-existing issue, but does the INTx handler incorrectly assume
virtual IRQs are strictly contiguous?

In drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_intx_irq_handler():

	unsigned int irq =3D irq_desc_get_irq(desc);
	u32 intx =3D irq - host->intx_irqs[0];

This calculates the hardware interrupt index assuming dynamically allocated
virtual IRQ numbers from platform_get_irq_byname() are contiguous.

Because this driver opts into PROBE_PREFER_ASYNCHRONOUS, concurrent IRQ
allocations by other drivers could mean virqs are not sequential.

If intx evaluates to an out-of-bounds index, generic_handle_domain_irq()
will fail to find the mapping.

Could this leave the level-triggered INTx line asserted but unserviced,
resulting in an IRQ storm?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715223019.3002=
237-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D2
