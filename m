Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0477A35DA55
	for <linux-pci@vger.kernel.org>; Fri, 14 Aug 2026 02:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676070; cv=none; b=ASKpuQ+29GdxWhQQCHq7Si16kwxCJuM6iP2z+XSJSFfReBsY4lDsphfIMdhVh8yvTGXJDk5iYKnsUdfHuMkCfE+oOlg3HwKJCHDs2T+8AyNNrGhtHLHWIPrUEPC7m28n8XTULwwDr4LfPIWA45A0agHM3MPnmZtLAYlwhtcjmAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676070; c=relaxed/simple;
	bh=pUkTwuqsnwG4CV5FIWNbIYJ838dZW1O7puQfHAuiCOo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dEHjttcwC0IYFaqHuWx3g1mU67NG4CZm1YIukZgc+gqMCWhodTBpaHGwasB5KsM8BB3nebB0ds6pp45t9rbuqXzl9MFNvgALxgag7vp/nrOKfGVRwQydkJcwvHwOCayoVUqeZiCBv/5vIsKtI143epvxm5xkkIr0H0CW7t9xP5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=baDEpcmk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="baDEpcmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7754D1F000E9;
	Fri, 14 Aug 2026 02:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786676068;
	bh=6TSzIlnJTD0Pbo6excl5nqJztFepIsJsdPUALNLc/Dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=baDEpcmkpVzv7Vk58GcLn1tPPveBT19GPvbRrs1Y2EWPYd9u/4PwZklBUjSoikXmV
	 8ic1nA50Io2twHP9GSsBnBu7FcZ3nSg9/PKYK7Sp12pVRzr5mhIs8MMLPac2vHorUy
	 eZK8DhhhIskS1Ii2p/W1DTMaHCvctuvNKiZSxCpkKBg5Abq+IDVXbTnlZyQtsDsWFE
	 A2N8G8XYvbqykissS0TPeXCygQrlDIGuT2skdmjbmzq8SYnkEzY1M5H7jmsP6fI9eG
	 YTYVOHs+QCCLK8pH+FZ/cjrYtnVuFYr1+CLnvIHl31KCkQL7MIGb54Y4z0zA0y+XZA
	 GMXlfs4n7lNIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] iommu/amd: Split probe error paths to preserve
 IRQ remapping
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pranjal Shrivastava" <praan@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260814015647.3370124-4-praan@google.com>
References: <20260814015647.3370124-1-praan@google.com>
 <20260814015647.3370124-4-praan@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 02:54:24 +0000
Message-Id: <20260814025428.7754D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Skipping iommu_disable_device_dma() on probe configuration failure=
s leaves the device's DTE dangerously active, leading to memory corruption =
or IOMMU faults.

Pre-existing issues:
- [High] A hardware-triggered Peripheral Page Request (PPR) can cause a NUL=
L pointer dereference if the device's IOMMU probe previously failed or was =
aborted.
--

--- Patch [3]: [PATCH v2 3/5] iommu/amd: Split probe error paths to preserv=
e IRQ remapping ---
commit e8c6c05e87391c978351a97a7ecc5fb4ef5a2b22
Author: Pranjal Shrivastava <praan@google.com>

iommu/amd: Split probe error paths to preserve IRQ remapping

This commit splits the error paths in amd_iommu_probe_device() to skip
calling iommu_disable_device_dma() on configuration failures. This aims to
preserve the rlookup_table entry required for IRQ remapping.

Closes: https://lore.kernel.org/all/20260529153216.2AD1E1F00899@smtp.kernel=
.org/

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 91d551f29ed12..9ad3412f0ade8 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c

[ ... ]

> @@ -2564,6 +2563,10 @@ static struct iommu_device *amd_iommu_probe_device=
(struct device *dev)
>  		goto out_err;
>  	}

[Severity: High]
Does skipping iommu_disable_device_dma() on probe configuration failures
leave the device's Device Table Entry (DTE) dangerously active?=20

If the DTE is not properly cleared (e.g., clearing the TV and V bits), could
the AMD hardware continue to intercept DMA using stale or uninitialized sta=
te?
This might lead to memory corruption if a kexec environment leaves valid pa=
ge
tables active, or IOMMU target aborts if a normal boot leaves the page table
root at 0, breaking direct DMA fallback for the device.

> =20
> +	return iommu_dev;
> +
> +err_deinit:
> +	iommu_disable_device_dma(iommu, dev);
>  out_err:

[Severity: High]
This is a pre-existing issue, but does leaving the DTE active on probe
failures expose a NULL pointer dereference in the hardware PPR handler?

If the hardware generates a Peripheral Page Request (PPR) because the old
kexec PPR configuration was left active, the interrupt handler is called:

drivers/iommu/amd/ppr.c:iommu_call_iopf_notifier() {
    ...
    dev_data =3D dev_iommu_priv_get(&pdev->dev);
    if (event.fault.prm.pasid =3D=3D 0 ||
        event.fault.prm.pasid >=3D dev_data->max_pasids) {
    ...
}

Since the IOMMU core frees dev->iommu on probe failure, dev_data would be
NULL. Won't unconditionally reading dev_data->max_pasids cause a kernel pan=
ic
here?

>  	return iommu_dev;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814015647.3370=
124-1-praan@google.com?part=3D3
