Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91550474259
	for <linux-pci@vger.kernel.org>; Thu, 20 Aug 2026 14:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234704; cv=none; b=DvpDZO6WBwj8Qw/D4FuJhIFNpHLgXx2gyO2icRTh8MS5Qsf78lsCqaoxwQwbxv1o9kj0Ubmj+DyHTl81SUUH1iuSy9L144F0GKWx4j5e7shNI7c/qX/2OW3eNd6r6CipLI2blSKDY+5yKuSZOiXS9m77d1369n5aTvtVxnM6T2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234704; c=relaxed/simple;
	bh=/N4xKYP8wqi5/3Bhtjqxvawv40OFU5nfABTxaDjZoZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KtcXVk0YIlY+C+g/Mxe7TSjpA7ByDqWBL++Bdix0pVhRndQoAknKguXJxO0dHOqGCwVqQ+CH5dnbUVINi6qo53x9jAwImUiq9AUzSUTCx6y5s0fAJfxZSAY1nx18gZ+fc6OaXGGKjSVfngnI34M0hqlw/ZNiexp4AKjeHp5kZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDS/88BM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDS/88BM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C7151F00A3D;
	Thu, 20 Aug 2026 14:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787234703;
	bh=0Hf+FRGgvR+JPLE10JQeDsOtjl+k1ALf728Ilhr6twk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eDS/88BMFPu9x84d4G+KF1n/AMBo6/aulbZi93y4ugqYPT2PebS+8Bn2sY/XXTe8c
	 ukwg+GEvTf8amipgh+/CCObBhT3DmH6GRcY/u8tijJRB/fwYaWp6WdOupJeqjFpfPj
	 J+9S7Dz1kBMPFmyOEOKBRxB21/UscsuGKcTBwrRiWMLmY8GapXZ8ES69fyrMdMapgD
	 ce6d9HlN+iAWTShMFK1pSpu6QlIOoBo8lv+hCi9rXnZA5RWlAfytJfehBrizZoxRDV
	 LCftscGDubqI8/oV9pMutyB2DbktV72JwINOiwtxus7irLgmQCkEy/NC6FbaLjaUds
	 teX7kVZjMZOLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] xen/pcifront: Fix PCI device reference leak in AER
 handling
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260820135603.3901798-1-ruoyuw560@gmail.com>
References: <20260820135603.3901798-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:05:02 +0000
Message-Id: <20260820140503.4C7151F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Optional AER error handler callbacks are invoked unconditionally w=
ithout being checked for existence, leading to a NULL pointer dereference.
- [High] Unsafe lockless access to `pcidev->dev.driver` leads to a TOCTOU r=
ace condition and Use-After-Free against driver unbinding.
--

--- Patch [1]: [PATCH v2] xen/pcifront: Fix PCI device reference leak in AE=
R handling ---
commit e7640edce237b4072d2fc35f47ae61c01c1ebc16
Author: Ruoyu Wang <ruoyuw560@gmail.com>
Subject: xen/pcifront: Fix PCI device reference leak in AER handling

This commit fixes a PCI device reference leak in the Xen PCI frontend
driver's AER handling. It declares the looked-up device with the
__free(pci_dev_put) cleanup attribute. This ensures the reference is proper=
ly
dropped on all return paths.

Link: https://lore.kernel.org/r/20260813153138.3953222-1-ruoyuw560@gmail.co=
m/

> diff --git a/drivers/pci/xen-pcifront.c b/drivers/pci/xen-pcifront.c
> index cffc32d660327..0dea8a69fa36c 100644
> --- a/drivers/pci/xen-pcifront.c
> +++ b/drivers/pci/xen-pcifront.c
> @@ -579,16 +579,15 @@ static pci_ers_result_t pcifront_common_process(int=
 cmd,
>  	int bus =3D pdev->sh_info->aer_op.bus;
>  	int devfn =3D pdev->sh_info->aer_op.devfn;
>  	int domain =3D pdev->sh_info->aer_op.domain;
> -	struct pci_dev *pcidev;
> +	struct pci_dev *pcidev __free(pci_dev_put) =3D
> +		pci_get_domain_bus_and_slot(domain, bus, devfn);
> =20
>  	dev_dbg(&pdev->xdev->dev,
>  		"pcifront AER process: cmd %x (bus:%x, devfn%x)",
>  		cmd, bus, devfn);
> =20
> -	pcidev =3D pci_get_domain_bus_and_slot(domain, bus, devfn);
>  	if (!pcidev || !pcidev->dev.driver) {
>  		dev_err(&pdev->xdev->dev, "device or AER driver is NULL\n");
> -		pci_dev_put(pcidev);
>  		return PCI_ERS_RESULT_NONE;
>  	}
>  	pdrv =3D to_pci_driver(pcidev->dev.driver);

[Severity: High]
This isn't a bug introduced by this patch, but does accessing
pcidev->dev.driver locklessly here introduce a race condition?

If a device unbind races with an incoming AER event, to_pci_driver(__drv)
might evaluate pcidev->dev.driver to NULL on its second access, or the
driver could be unloaded before callbacks are invoked. Standard PCI AER
handlers usually hold device_lock(&dev->dev) to serialize against driver
binding and unbinding.

[Severity: High]
This is a pre-existing issue, but further down in pcifront_common_process(),
does the code invoke optional AER callbacks without checking if they exist?

While the error_detected callback is verified, optional callbacks appear to
be invoked unconditionally:

    case XEN_PCI_OP_aer_mmio:
        return pdrv->err_handler->mmio_enabled(pcidev);
    case XEN_PCI_OP_aer_slotreset:
        return pdrv->err_handler->slot_reset(pcidev);

If a bound driver lacks these optional callbacks, will processing these
commands from the backend result in a NULL pointer dereference?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820135603.3901=
798-1-ruoyuw560@gmail.com?part=3D1
