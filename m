Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CB3D954B
	for <linux-pci@vger.kernel.org>; Thu, 16 Jul 2026 11:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784202333; cv=none; b=Kc3x9ucyp4rKYj9hmoPzYLeVsFLWLfrRtE9KdcW0OANL9RWoP3z8i1/rz+a288/Dgf3z0lCs3EDWNENePO5pWk/hs2gO+8XoMSXXtwqWmll0971CbXPBPUOfoP/tjGq18LIALiugwN73zR6mdb0vSFuPp4H0DW458HzntjSEDu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784202333; c=relaxed/simple;
	bh=TRufC/rrq3Agu+2o8OkHBeWjrLwUNhLN1ThIGd3M1do=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XUV1mNZbF3OdnpPHdHnrTeQVjMCeLYMj5y1VezRLXl3ZLIN8/yEo59HlhjgjmBsJfRNKpXGM1xoc7P3Kgq6LY8NB+y3UgpEKwyJYwVzhS25VJy/TFvdVK/PfSrsBzgZ+wSPbNSopoaE1Ns6beyWxPhj+g7KJdZFqQDb90ZdBKLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtxAH55f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtxAH55f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D00E1F00A3A;
	Thu, 16 Jul 2026 11:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784202332;
	bh=x8/kRLjC8VJ/SO04vZBfS5+Z/r/eXhmvybLmzoicUjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AtxAH55fNNncpvXM0TiFKFyzK4tAZCzUrNjylb+WgvfAyTLoag/LkD9TPPgpD004b
	 Bm/LbUnmMh1bZQeULiUF3WBS1M1eqSc83XIwwQEdEnHSwmz5j0PdOZoa8YvlmdGRwu
	 ByQpDcvmU5OCB93deFa0v83xJc6DrmPVKNz8b7BGsHsJuL+1uFqvaiX44jaLs//nLG
	 hefW7qhAPMIQjw7AHFUmP0mo5P3fudeoncxlhOs4fJ7TpgARod5u2mqHMB1QEORHma
	 EOI5O3wCGIb5yND0SRoqDG4w9M411msiSDrG0KKdhd3mLAx0jfu0C+PQ5dwZfCGubM
	 J4lL2OIgb7M9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: mediatek-gen3: Initialize all resources before
 installing ISR
Reply-To: sashiko-reviews@lists.linux.dev
To: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260716113142.46742-1-angelogioacchino.delregno@collabora.com>
References: <20260716113142.46742-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 11:45:31 +0000
Message-Id: <20260716114532.4D00E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Incomplete Fix / NULL Pointer Dereference in MSI handler.

Pre-existing issues:
- [High] Lifecycle / SError Crash in teardown paths.
- [High] Concurrency / Hard Lockup due to unmapped bootloader interrupts.
--

--- Patch [1]: [PATCH] PCI: mediatek-gen3: Initialize all resources before =
installing ISR ---
commit d73aca9231cdee14919c7ffe3c94da11dd9f840a
Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: PCI: mediatek-gen3: Initialize all resources before installing ISR

This commit modifies the probe sequence to initialize resources before
installing the IRQ handler. It aims to prevent a NULL pointer dereference
when a pending bootloader interrupt fires before the controller structure
is fully initialized.

> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/co=
ntroller/pcie-mediatek-gen3.c
> index bcbd08c82a5ce..f8a98c0b2c453 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
[ ... ]
> @@ -1208,6 +1189,9 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pci=
e)
>  		}
>  	}
> =20
> +	/* All resources are now available: install the chained handler */
> +	irq_set_chained_handler_and_data(pcie->irq, mtk_pcie_irq_handler, pcie);
> +

[Severity: High]
Does this code initialize msi_set->base before the handler is installed?

The commit message states that all required resources are initialized before
installing the interrupt handler. However, if the bootloader leaves a pendi=
ng
MSI interrupt, mtk_pcie_irq_handler() will immediately call
mtk_pcie_msi_handler().

It appears msi_set->base is not initialized until mtk_pcie_enable_msi()
is called inside mtk_pcie_startup_port():

mtk_pcie_startup_port() {
    ...
    mtk_pcie_enable_msi() {
        msi_set->base =3D pcie->base + ...
    }
}

Would this sequence cause mtk_pcie_msi_handler() to dereference an
uninitialized pointer at msi_set->base + PCIE_MSI_SET_ENABLE_OFFSET?

[Severity: High]
This is a pre-existing issue, but does this installation safely handle
unmapped bootloader interrupts?

If the bootloader leaves an interrupt pending before child devices have
probed and mapped their IRQs, generic_handle_domain_irq() will fail and
bypass the irq_ack callback.

For MSI interrupts, the hardware status bit would never be cleared. Could
this cause the following loop in mtk_pcie_msi_handler() to spin infinitely
and hard-lock the CPU?

	do {
		msi_status =3D readl_relaxed(msi_set->base +
					   PCIE_MSI_SET_STATUS_OFFSET);
		msi_status &=3D msi_enable;
		if (!msi_status)
			break;
        ...
	} while (true);

Should we explicitly clear pending hardware interrupts before registering
the chained handler?

>  	/* Try link up */
>  	err =3D mtk_pcie_startup_port(pcie);
>  	if (err)
[ ... ]
> @@ -1248,13 +1235,14 @@ static int mtk_pcie_probe(struct platform_device =
*pdev)
>  		goto err_tear_down_irq;
>  	}
> =20
> +	host->ops =3D &mtk_pcie_ops;
> +	host->sysdata =3D pcie;
> +	platform_set_drvdata(pdev, pcie);
> +
>  	err =3D mtk_pcie_setup(pcie);
>  	if (err)
>  		goto err_destroy_pwrctrl;
> =20
> -	host->ops =3D &mtk_pcie_ops;
> -	host->sysdata =3D pcie;
> -
>  	err =3D pci_host_probe(host);
>  	if (err)
>  		goto err_power_down_pcie;

[Severity: High]
This is a pre-existing issue, but could the error teardown sequence cause
an SError crash?

If pci_host_probe() fails, the code jumps to err_power_down_pcie.
Looking at the error path execution:

err_power_down_pcie:
	mtk_pcie_devices_power_down(pcie);
	mtk_pcie_power_down(pcie);
err_destroy_pwrctrl:
    ...
err_tear_down_irq:
	mtk_pcie_irq_teardown(pcie);

The hardware is powered down before mtk_pcie_irq_teardown() removes the
chained IRQ handler.

As noted in the commit message, modifying or reading registers when the
hardware is powered down can result in an SError. If a shared or spurious
interrupt fires during this window, wouldn't mtk_pcie_irq_handler() read
from PCIE_INT_STATUS_REG while the hardware is powered off?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716113142.4674=
2-1-angelogioacchino.delregno@collabora.com?part=3D1
