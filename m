Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05767262E;
	Tue, 23 Jun 2026 03:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186331; cv=none; b=Gy8vh4Zmqs4SAaFsBOb9/ljH77gnqJqkJRH1CpckmyOWC5CJvBcmrsfNQcJdB9ICuPByOLUZ0glda3DChTxvg3UmYPdYgtNpg/OCwFeWaWtEbaqM0TZnQs7LcSUV5P/lspsO53lNVQC4W8gWvNva0KraoVfPlI1Jf3tdDnWoi0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186331; c=relaxed/simple;
	bh=/HN0nrxItKbC8nRxhOZyQYmYhusr/XAzW28isU2Rjy4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iO30oujRrjqeBzMxPVWNZAclsiTHdnNBaRwcrYAKui1eQAnN2/FhiAXY7Va1b6TnMiLtB5aJyaDYTXw1EFBpL7gwdAN0z2r6Syh0O7GgPZQe/0OqFd2ttPhC/dZIU3hGm2a5tjBRxvIt2OwVIoM3PrRkVLFHQtQbx8ttoHDhXxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJMtMF2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJMtMF2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4875D1F000E9;
	Tue, 23 Jun 2026 03:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186329;
	bh=kI+qc4XZwh8A5SlVreLPAbFIplAi9j8zlui/S/fva0Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WJMtMF2U/3WUu1Hvfrb4TGRQWZ5na7JukXCq+y3KBuSjFogBPjc75R90UBdRHK/w4
	 kUe9jgwAsRO4gJ9ZRpMlLuJ3voiRgWPd5Cs3mNvMkuuoRd1EEYKc/nyTrGxUNwCF+I
	 uPmg0HholODx79yi9iOFoiPiglJn6AafhDljcsSxZ2xL9SxVJFrpfKc/9L56/ckBNs
	 aQcWxGtoroh5j2uNM5Xga1clXLqBis8CUcvM2N5AG5w4Idcd0Pl/RjouGfGki7Dbci
	 G6K4qjosK2t7+aJTVgVtP2jaECpZrO8DwbFcstB/n/AqvCvHeltijHGLeoc/z+5tSo
	 WwTpHDi9XDEvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/11] cxl: Cache endpoint decoder settings during
 PCI enumeration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260623032453.3404772-4-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-4-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:45:28 +0000
Message-Id: <20260623034529.4875D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Allocating devres resources during PCI device enumeration caus=
es driver probing to fail permanently with -EBUSY.
- [High] devm_cxl_pci_setup_hdm_info() falsely rejects devices using DVSEC =
emulation when their DVSEC range count differs from their HDM decoder count.
- [Medium] Missing release/acquire memory barriers when publishing and cons=
uming the `pdev->hdm` pointer allows concurrent readers to see uninitialize=
d memory.
--

commit e3058b1fc7aea013a57ebe41db76dc923a188403
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Cache endpoint decoder settings during PCI enumeration

Populate pci_dev->hdm from PCI capability initialization when a CXL.mem
function already has memory decoding enabled. This gives driver-free reset
paths an early HDM snapshot without enabling BAR decoding during
enumeration.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 83cda63f76a5a..0230ebfada42b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
[ ... ]
> @@ -107,9 +105,27 @@ static int devm_cxl_pci_setup_hdm_info(struct cxl_hd=
m *cxlhdm)
>  	}
> =20
>  	if (!dev_is_pci(uport))
> +		return NULL;
> +
> +	return to_pci_dev(uport);
> +}
> +
> +static int devm_cxl_pci_setup_hdm_info(struct cxl_hdm *cxlhdm)
> +{
> +	struct cxl_hdm_info *info;
> +	struct pci_dev *pdev;
> +
> +	pdev =3D cxl_hdm_to_pci_dev(cxlhdm);
> +	if (!pdev)
> +		return 0;
> +
> +	info =3D READ_ONCE(pdev->hdm);
> +	if (info) {
> +		if (info->decoder_count !=3D cxlhdm->decoder_count)
> +			return -ENXIO;

[Severity: High]
Will this strict equality check reject valid devices that fall back to DVSEC
emulation?

When the cxl_port driver probes, devm_cxl_setup_hdm() might fall back to
DVSEC emulation, which overwrites the local cxlhdm->decoder_count with
the number of DVSEC ranges. If that happens, this check against the raw
hardware HDM count will fail and return -ENXIO, breaking the probe.

>  		return 0;
> +	}
> =20
> -	pdev =3D to_pci_dev(uport);
>  	info =3D devm_kzalloc(&pdev->dev,
>  			    struct_size(info, settings, cxlhdm->decoder_count),
>  			    GFP_KERNEL);
[ ... ]
> diff --git a/drivers/cxl/core/reset.c b/drivers/cxl/core/reset.c
> index 14f024098e826..fc52d3abdb5b4 100644
> --- a/drivers/cxl/core/reset.c
> +++ b/drivers/cxl/core/reset.c
[ ... ]
> +int pci_cxl_hdm_init(struct pci_dev *pdev)
> +{
[ ... ]
> +	if (!info) {
> +		info =3D devm_kzalloc(&pdev->dev,
> +				    struct_size(info, settings,
> +						CXL_HDM_DECODER_MAX_COUNT),
> +				    GFP_KERNEL);

[Severity: Critical]
Does allocating devres memory during PCI enumeration prevent the device
from being probed later?

The driver core requires a device's devres_head to be empty before a
driver can bind to it. Since pci_cxl_hdm_init() is called during the early
pci_init_capabilities() enumeration phase, this devm_kzalloc() will attach
resources before probing.=20

Will really_probe() then abort with a resources present before probing
error and permanently prevent the cxl_pci driver from binding to the device?

> +		if (!info)
> +			return -ENOMEM;
> +		allocated_info =3D true;
> +	}
[ ... ]
> +	settings =3D info->settings;
> +	for (int i =3D 0; i < info->decoder_count; i++) {
> +		rc =3D cxl_pci_hdm_read_decoder(pdev, &settings[i],
> +					      regs.hdm_decoder, i);
> +		if (rc)
> +			goto out_unmap;
> +	}
> +
> +	WRITE_ONCE(pdev->hdm, info);

[Severity: Medium]
Are memory barriers needed here to ensure the initialized memory is visible
before the pointer is published?

Since WRITE_ONCE() and READ_ONCE() do not provide SMP memory barriers,
can the CPU reorder the devm_kzalloc() memory zeroing after the pointer
publication? If a concurrent sysfs reader accesses the pointer, it could
potentially see a non-zero garbage value for info->regs.hdm_decoder.

> +	if (allocated_info) {
> +		rc =3D devm_add_action(&pdev->dev, cxl_pci_hdm_clear, pdev);
> +		if (rc) {
> +			WRITE_ONCE(pdev->hdm, NULL);
> +			goto out_unmap;
> +		}
> +	}
> +	return 0;
[ ... ]
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b63cd0c310bc0..9e214446fd42f 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
[ ... ]
> @@ -2679,6 +2680,7 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  	pci_rebar_init(dev);		/* Resizable BAR */
>  	pci_dev3_init(dev);		/* Device 3 capabilities */
>  	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
> +	pci_cxl_hdm_init(dev);		/* CXL HDM Decoder Capability */
> =20
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D3
