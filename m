Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22C43E2ABC;
	Thu, 16 Jul 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222389; cv=none; b=FKN6UA/72xMTWSkoVr+ZImBKcyXKwQ+CaHaQnR2bWjAf5KQPNKXWA8ughZNmJzgwzkfTIzNHoA/yzZeCcWDwC9BOqBGvgEHi0LAgqUNa7oKarssR/n6ot7zEnlJdur+bwbSmSXH3OpPjyiv+TkPwB7s3H9BNpiWhK09DmWB3tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222389; c=relaxed/simple;
	bh=GJCbvkIcUlQMdOsyUZNQCmgHlzLZKY+q4r4jrhZINdU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cveqAuujqyoufdI3LxJugpAD2C4tX9nK3wz4tv/pQR194aejdxeU+rxIMsg24IU07ulPXjTqJG6Hs/yYp6njey0Ixgc/HNFgsizOdX8B8FhLd9HytazGABvhZWdAy6r4qzLIBW+Y2g5SJR962X9B7Oq5gRIZPD7eM3ls/Lz0260=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQIzg8Wz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQIzg8Wz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85D71F000E9;
	Thu, 16 Jul 2026 17:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784222387;
	bh=tZYZQ+ffPLOTaQKPdpuFvZgPf3ecV2J8nQ76HMEtQ/o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQIzg8Wzeu/Yi03GyeEQPSjZAwgv30blBisWdAmzsXE9wWNlWns/P6KW+iAIa6bcn
	 QIzZcNtJS7prP+jgioRPPcGlkltCO5vDkQZ+V8ZlUdpgYPS/A+9fLSCvCrOeJpDLzN
	 4w5QbDETDwX1iWcCeKidBUcGXWJe8XQ6PsIlVf1/Z/ZIj+WbckdJfi4fyjL+DXD7sQ
	 YOzft2bnv+pGmZtmqC1xhNngGcRSbQQ2t3CK6Eox11fiqEHK0jXPvLAAba2EOWfESM
	 23sXGY5GhfAdHTuR/MXXep6yJ2J+iO4IkhgaHXdMPLWfWSRhnTwoDcR4Vv0EgDVlRv
	 tGoX4jVDRgV2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
References: <20260716-tegra264-pcie-v8-0-23e51589229b@nvidia.com>
 <20260716-tegra264-pcie-v8-4-23e51589229b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 17:19:46 +0000
Message-Id: <20260716171946.E85D71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Heap out-of-bounds read on 32-bit platforms due to union aliasing =
of `pci_config_window->win`.
- [Medium] Missing runtime PM usage counter decrement on `pm_runtime_get_sy=
nc()` failure.
- [Low] Incorrect unit multiplier used in bandwidth request error message.
--

--- Patch [4]: [PATCH v8 4/6] PCI: tegra: Add Tegra264 support ---
commit 4da3b5a2d216f984d21597a5d585e8a8eb97b293
Author: Thierry Reding <treding@nvidia.com>

PCI: tegra: Add Tegra264 support
   =20
Add a driver for the PCIe controller found on NVIDIA Tegra264 SoCs. The
driver is very small, with its main purpose being to set up the address
translation registers and then creating a standard PCI host using ECAM.

> --- /dev/null
> +++ b/drivers/pci/controller/pcie-tegra264.c

[ ... ]

> +static void tegra264_pcie_icc_set(struct tegra264_pcie *pcie)
> +{
> +	u32 value, speed, width;
> +	int err;
> +
> +	value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);
> +	speed =3D FIELD_GET(PCI_EXP_LNKSTA_CLS, value);
> +	width =3D FIELD_GET(PCI_EXP_LNKSTA_NLW, value);
> +
> +	value =3D Mbps_to_icc(width * PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]=
));
> +
> +	/*
> +	 * We don't want to error out here because a boot-critical device
> +	 * could be connected to this root port. Failure to set the bandwidth
> +	 * request may have an adverse impact on performance, but it is not
> +	 * generally fatal, so we opt to continue regardless so that users
> +	 * get a chance to fix things.
> +	 */
> +	err =3D icc_set_bw(pcie->icc_path, value, value);
> +	if (err < 0)
> +		dev_err(pcie->dev,
> +			"failed to request bandwidth (%u MBps): %pe\n",
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
This isn't a bug, but does this log message print the wrong units?

The value calculated by Mbps_to_icc() appears to be in kilobytes per
second, but the message labels it as "MBps".

[ ... ]

> +static int tegra264_pcie_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	pcie->bpmp =3D tegra_bpmp_get_with_id(dev, &pcie->ctl_id);
> +	if (IS_ERR(pcie->bpmp))
> +		return dev_err_probe(dev, PTR_ERR(pcie->bpmp),
> +				     "failed to get BPMP\n");
> +
> +	err =3D devm_pm_runtime_set_active_enabled(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to enable runtime PM\n");
> +		goto err_put_bpmp;
> +	}
> +
> +	err =3D pm_runtime_get_sync(dev);
> +	if (err < 0) {
> +		dev_err_probe(dev, err, "failed to power on device\n");
> +		goto err_put_bpmp;
                ^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Does this error path leak the runtime PM usage counter?

When pm_runtime_get_sync() fails, it still increments the usage counter. By
jumping directly to err_put_bpmp, the counter is not decremented, which
could prevent the device from entering runtime suspend if probed again late=
r.

> +	}
> +
> +	/* sanity check that programmed ranges match what's in DT */
> +	if (!tegra264_pcie_check_ranges(pdev)) {
> +		err =3D -EINVAL;
> +		goto err_put_pm;
> +	}
> +
> +	pcie->cfg =3D pci_ecam_create(dev, res, bus->res, &pci_generic_ecam_ops=
);
> +	if (IS_ERR(pcie->cfg)) {
> +		err =3D dev_err_probe(dev, PTR_ERR(pcie->cfg),
> +				    "failed to create ECAM\n");
> +		goto err_put_pm;
> +	}
> +
> +	bridge->ops =3D (struct pci_ops *)&pci_generic_ecam_ops.pci_ops;
> +	bridge->sysdata =3D pcie->cfg;
> +	pcie->ecam =3D pcie->cfg->win;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can this assignment cause an out-of-bounds heap read on 32-bit platforms?

If the driver is compiled on a 32-bit architecture (e.g. via COMPILE_TEST)
where per_bus_mapping is true, the pci_config_window->win union aliases the
dynamically allocated cfg->winp array pointer.

When the driver later dereferences pcie->ecam using readw() in
tegra264_pcie_link_up():

    u16 value =3D readw(pcie->ecam + XTL_RC_PCIE_CFG_LINK_STATUS);

It will read from the heap array pointer instead of mapped I/O memory,
resulting in a crash or garbage read.

> +
> +	tegra264_pcie_init(pcie);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-tegra264-p=
cie-v8-0-23e51589229b@nvidia.com?part=3D4
