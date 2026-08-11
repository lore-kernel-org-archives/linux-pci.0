Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133563FAE19
	for <linux-pci@vger.kernel.org>; Tue, 11 Aug 2026 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479401; cv=none; b=FcWXkugfmucNLAG6/PEOphwPs9svxVBuD36/Hh5Tv17EPizksZyHpuilCWecioiu1DDedoWEHL7CFRYVLGbiZqjSMu5woWf2Jun+fGy6zQF0yIuZ94COnkuRr8lk0MANnllANKSxbeT1hxntYDdX5tjKrRlARI7X5kL5t/qw2BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479401; c=relaxed/simple;
	bh=LeOPM1sG91Nkc9aEnA/lRZbTL2CLgTXyArQe37BU/5w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l6a5smy+TgOV7vwOvD4/oAPlB9jtDXQmFlW+3WmQc4f/GXzU8sPGN+TfX6WvCWC5fnMIvK4zBOqMV18mORY5rVyBJcxfjCVS/MYK+ze04bAKVLwDS/0UT7CKKXfAD2c1Rfurm3XkBB74go2OErFrR0+DLDxuE6Rk5Z2oSmRQqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hd0MA+P6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hd0MA+P6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 521741F000E9;
	Tue, 11 Aug 2026 20:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479399;
	bh=mLRy4B1qdg5TAZcddJYpe7PBUtyDdKJx6CH/AmNSjBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hd0MA+P689uFEtR+TTazLxCTLnUxokBgn7fsh0oK/VgPva+gOYjaZbnryRyNO4jeA
	 K+IKC07mCHvNI/4PxiHCEc+NADOnvFWeh+r2HtvYx1Sh9/Cfqukc6dEUgzJ6kMZm74
	 X6mBmlswfiVvs8m/CkoYdchpCyM1wqfN0C7MPRnFiVqpy1rP+luVmTw/5SaUjv3nl8
	 qdl5SMN2KXt8eu/2drHB3QTOaa2iClRQHC4w6kdlJ+Y6OnuJXbgb0F0Df6eFVv6w0t
	 IlKhfoJ2Yb5b+IZt15Wb8ei7xqK1EDGQHXe6X4HV9uqot8Wd/s0ghvGW5lrbDTEaLT
	 1mAXEC1EXsRNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] PCI: rzg3s: Disable refclk on probe failure
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260811200013.185956-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260811200013.185956-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260811200013.185956-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 11 Aug 2026 20:16:38 +0000
Message-Id: <20260811201639.521741F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] System suspend is unconditionally aborted due to incorrect pm_runt=
ime_put_sync() usage in the suspend_noirq phase.
- [High] Use-after-free vulnerability due to missing chained IRQ handler cl=
eanup on probe error paths.
--

--- Patch [1]: [PATCH v3 1/3] PCI: rzg3s: Disable refclk on probe failure -=
--
commit 7f97e9f3db5d36293fbc8938e90e7f9e5ceaa52c
Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

PCI: rzg3s: Disable refclk on probe failure

rzg3s_pcie_host_init_port() enables the PCIe reference clock using
clk_prepare_enable(), but if rzg3s_pcie_probe() subsequently fails, for
example because pci_host_probe() returns an error, the probe error path
only releases the clock handle with clk_put().

Balance clk_prepare_enable() by calling clk_disable_unprepare() in the
probe cleanup path before releasing the clock, ensuring the reference
clock is properly disabled on probe failure.

Fixes: 7ef502fb35b28 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 66f687304c1cb..bd6471a7fb7a1 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1762,6 +1762,7 @@ static int rzg3s_pcie_probe(struct platform_device =
*pdev)
>  	return 0;
> =20
>  host_probe_teardown:
> +	clk_disable_unprepare(host->port.refclk);
>  	rzg3s_pcie_teardown_irqdomain(host);

[Severity: High]
This is a pre-existing issue, but does this teardown path leave dangling
pointers in the chained IRQ handlers?

Looking at rzg3s_pcie_init_irqdomain(), chained handlers are registered
with the devres-managed host pointer:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_init_irqdomain() {
    ...
    irq_set_chained_handler_and_data(irq,
                                     rzg3s_pcie_intx_irq_handler,
                                     host);
    ...
}

But rzg3s_pcie_teardown_irqdomain() does not clear them:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_teardown_irqdomain() {
    if (IS_ENABLED(CONFIG_PCI_MSI))
        rzg3s_pcie_teardown_msi(host);
    irq_domain_remove(host->intx_domain);
}

If the probe fails and the host structure is freed, wouldn't a subsequent
spurious interrupt on any INTx line trigger a use-after-free when the chain=
ed
handler dereferences the freed host pointer?

Should this call irq_set_chained_handler_and_data() with NULL to clean up?

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing this file I
noticed a potential issue with the suspend sequence:

drivers/pci/controller/pcie-rzg3s-host.c:rzg3s_pcie_suspend_noirq() {
    ...
    ret =3D pm_runtime_put_sync(dev);
    if (ret)
        return ret;
    ...
}

Will this unconditionally abort the system suspend?

During the system suspend transition, the PM core disables runtime PM in the
suspend_late phase.

When suspend_noirq is later called, wouldn't pm_runtime_put_sync() return
-EACCES since runtime PM is disabled, causing the entire system suspend to
fail?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260811200013.1859=
56-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D1
