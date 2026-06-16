Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C8331A44
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781619697; cv=none; b=ozwYsGrJWzNYRaKy41scjtO03HMTiw6TV+XFwseumXD2BaPTQ0agQxUMiVJMo6y6viF9F8eqHSen68lmL8VRegEuhKSCV728v5Q8VPpI1HFa8GfnXjGYw6LcyOGg755pryWenWX7bGw7Grp8gwAXaaoOcdoR4g8qTdgQwVdgZVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781619697; c=relaxed/simple;
	bh=ZugJaEMIy9fftgfma5bPkB7MavEH9xnGpRMs7dzl1/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cpMCY+wtTkom1o0yKHZ8racYUGx1v334fFhvBauCe59K1AwglILKWAGG9wbNr9Yk/dE7vqPrVAWKZsJL/AUJOFZ2O/3nea0mCi81TZ2DKLB2+i9LvQxagT2Xer93swRZZuuJ9X9cv8dhYMnvFdnjPsLRndZsmf2smTw+SLcQ228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOP2Jccl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOP2Jccl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901141F000E9;
	Tue, 16 Jun 2026 14:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781619695;
	bh=Sm/KAzaCxMAvSCCLjJ5QaqSgzMRzPhbSFO6Rn8G6ykY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NOP2Jcclfd0fDSG9aN6nGkHFDzzORoO8pzLmGbmASMTkXvRfIhu9XroRee70bys5m
	 2xXTWjdxTVPAgrhP+0h8Y7WITzyy/ALCRVk1OYO9UU9ppOJIABTnm33fQYyU6BNg3P
	 X0z9MHgFUVM87NsXwFxxo8LHpE4V8Hr6eH862UdsD5f+GoE+kEox+254mtvLvFXGMc
	 9FPU35oU4Yy/DkztgGzFLIdACHNeGAzudmoE4346QiA5AX47Hy/5M76MwW6CG0w9Hj
	 GQVx1MJ60bOnTl9kS5ScUGJapKI7iVOGTYKexaC3PnvgkO5w7Oq2RWfH9l/GjoX+5i
	 o0dMUWRN2HRTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: xilinx-xdma-pl: fix refcount leak in
 xilinx_pl_dma_pcie_init_irq_domain()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616140949.1686840-1-vulab@iscas.ac.cn>
References: <20260616140949.1686840-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 14:21:34 +0000
Message-Id: <20260616142135.901141F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Calling `irq_domain_remove(port->intx_domain)` after `xilinx_pl_dm=
a_pcie_init_msi_irq_domain(port)` fails causes a NULL pointer dereference.
- [High] The probe function silently ignores the return value of `xilinx_pl=
_dma_pcie_setup_irq()`, allowing the device to probe successfully even if I=
RQ setup fails.
- [High] `port->pldma_domain` and `msi->bitmap` are leaked when `pci_host_p=
robe()` fails because `xilinx_pl_dma_pcie_free_irq_domains()` neglects to f=
ree them.
- [High] Missing `irq_dispose_mapping()` causing mapping leaks and potentia=
l WARN_ON() on domain removal.
- [High] Use-After-Free or NULL pointer dereference of `msi->dev_domain` du=
e to early registration of the MSI interrupt handler.
- [Medium] Leak of `port->cfg` if `devm_ioremap_resource` fails in `xilinx_=
pl_dma_pcie_parse_dt`.
- [Medium] Double initialization of `port->lock` raw spinlock.
--

commit 255f95990ff953845972471921209ec22fc3d8f6
Author: Wentao Liang <vulab@iscas.ac.cn>
Subject: PCI: xilinx-xdma-pl: fix refcount leak in xilinx_pl_dma_pcie_init_=
irq_domain()

This commit fixes an OF node reference leak in the error paths of
xilinx_pl_dma_pcie_init_irq_domain(). It introduces goto labels to ensure
proper cleanup of both the OF node and the PL DMA domain.

> diff --git a/drivers/pci/controller/pcie-xilinx-dma-pl.c b/drivers/pci/co=
ntroller/pcie-xilinx-dma-pl.c
> index b037c8f315e46..e7a83a758874b 100644
> --- a/drivers/pci/controller/pcie-xilinx-dma-pl.c
> +++ b/drivers/pci/controller/pcie-xilinx-dma-pl.c
[ ... ]
> @@ -597,13 +600,20 @@ static int xilinx_pl_dma_pcie_init_irq_domain(struc=
t pl_dma_pcie *port)
>  	ret =3D xilinx_pl_dma_pcie_init_msi_irq_domain(port);
>  	if (ret !=3D 0) {
>  		irq_domain_remove(port->intx_domain);
> -		return -ENOMEM;
> +		ret =3D -ENOMEM;
> +		goto out_remove_pldma;
>  	}

[Severity: High]
This is a pre-existing issue, but does this error path cause a NULL pointer
dereference?

If xilinx_pl_dma_pcie_init_msi_irq_domain() fails, it cleans up by calling
xilinx_pl_dma_pcie_free_irq_domains(). This function frees port->intx_domain
and sets it to NULL. When execution returns here, irq_domain_remove() is
called on the already-nullified port->intx_domain, which dereferences the
pointer unconditionally.

> =20
>  	of_node_put(pcie_intc_node);
>  	raw_spin_lock_init(&port->lock);
> =20
>  	return 0;

[Severity: Medium]
This is a pre-existing issue, but is the port->lock initialized twice?

It appears xilinx_pl_dma_pcie_init_msi_irq_domain() already calls
raw_spin_lock_init(&port->lock) right before returning successfully. Calling
it again here could destroy the active lock state or trigger lockdep
warnings if an interrupt handler has already acquired it.


[Severity: High]
This is a pre-existing issue, but does xilinx_pl_dma_pcie_free_irq_domains()
leak port->pldma_domain and msi->bitmap?

When pci_host_probe() fails in xilinx_pl_dma_pcie_probe(), the cleanup path
calls xilinx_pl_dma_pcie_free_irq_domains():

drivers/pci/controller/pcie-xilinx-dma-pl.c:xilinx_pl_dma_pcie_free_irq_dom=
ains() {
    ...
    if (port->intx_domain) {
        irq_domain_remove(port->intx_domain);
        port->intx_domain =3D NULL;
    }
    ...
}

This teardown helper removes intx_domain and msi->dev_domain, but completely
misses port->pldma_domain. Additionally, msi->bitmap is allocated in
xilinx_pl_dma_pcie_init_msi_irq_domain() but does not seem to be freed
anywhere in the driver.


[Severity: High]
This is a pre-existing issue, but does the probe function ignore IRQ setup
failures?

In xilinx_pl_dma_pcie_probe():

drivers/pci/controller/pcie-xilinx-dma-pl.c:xilinx_pl_dma_pcie_probe() {
    ...
    err =3D xilinx_pl_dma_pcie_setup_irq(port);
   =20
    bridge->sysdata =3D port;
    bridge->ops =3D &xilinx_pl_dma_pcie_ops.pci_ops;
   =20
    err =3D pci_host_probe(bridge);
    ...
}

The result of xilinx_pl_dma_pcie_setup_irq() is immediately overwritten by
pci_host_probe(). If IRQ mapping or requesting fails, the driver proceeds
anyway, which might leave the hardware in a broken state without functional
interrupts.


[Severity: High]
This is a pre-existing issue, but are we missing irq_dispose_mapping() for
the IRQs mapped during setup?

In xilinx_pl_dma_pcie_setup_irq():

drivers/pci/controller/pcie-xilinx-dma-pl.c:xilinx_pl_dma_pcie_setup_irq() {
    ...
    irq =3D irq_create_mapping(port->pldma_domain, i);
    ...
}

The driver creates these mappings but never provides corresponding
irq_dispose_mapping() calls in error paths or driver teardown. If the domain
is ever removed, irq_domain_remove() might trigger a WARN_ON because the
undisposed mappings remain in the radix tree.


[Severity: Medium]
This is a pre-existing issue, but does xilinx_pl_dma_pcie_parse_dt() leak
port->cfg?

drivers/pci/controller/pcie-xilinx-dma-pl.c:xilinx_pl_dma_pcie_parse_dt() {
    ...
    port->reg_base =3D devm_ioremap_resource(dev, res);
    if (IS_ERR(port->reg_base))
        return PTR_ERR(port->reg_base);
    ...
}

If devm_ioremap_resource() fails, the function returns immediately without
calling pci_ecam_free(port->cfg), leaving the previously allocated ECAM
structure stranded.


[Severity: High]
This is a pre-existing issue, but could early registration of the MSI
interrupt handlers cause a NULL pointer dereference or use-after-free?

In xilinx_pl_dma_pcie_parse_dt(), xilinx_request_msi_irq() is called:

drivers/pci/controller/pcie-xilinx-dma-pl.c:xilinx_pl_dma_pcie_parse_dt() {
    ...
    err =3D xilinx_request_msi_irq(port);
    ...
}

This registers the MSI interrupt handlers before the IRQ domains are create=
d.
If an interrupt fires immediately, xilinx_pl_dma_pcie_msi_handler_low() rea=
ds
msi->dev_domain (which is still NULL) and passes it to irq_find_mapping().

Also, if xilinx_pl_dma_pcie_init_msi_irq_domain() fails later and frees
msi->dev_domain, an interrupt firing during that window could result in a
use-after-free.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616140949.1686=
840-1-vulab@iscas.ac.cn?part=3D1
