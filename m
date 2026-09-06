Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6682B3C4B93;
	Sun,  6 Sep 2026 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716864; cv=none; b=lj2OsAtX7kH2xpwMTO28C8SBblMGpoKNpCXkBLkJkYYFcpqVwtMdR6oa26hrQfPREpt5wJu4XSM7XjrJ7MblPi4KtK2y5SesBgJqYsM/whqasHpAHA9jN9B4wiZgBOzo5k0ayHUXLmHtge7zpeDBt106aYQxwdz8ey0+gmJUlp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716864; c=relaxed/simple;
	bh=HceRLgtJr4B+FajfwPP9CnMWesgtvGPT8tTwFuIkq6w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=io5JEy8bVwKM4sSmNUw7DmIljEticYllzdJJt6ZNzXTKiHZcgVpdXswWBmJvqwaTaSyUL6tz5+39a8SBmmRUsXf91yK672+P5k4vdrQ2qPOgT4v3giU/cTBsbWOCSw9IuerwRYydVINkw9iLoWTXq5tkQE4my8qQoY+y3sfrwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kutIwP4S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kutIwP4S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85CD1F00A3A;
	Sun,  6 Sep 2026 17:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788716863;
	bh=atf1hxRB+nOzsHTecSDg34K85X0ewHVN6EKewz3fjVU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kutIwP4SBGlkPQEcFllEkNO808OyiDa6ZIxpIB56FbeRdtRXpi9rp15ZLnqJD0Kh2
	 ZDmxOW2CP7EApiqJjq64fGrT1Fhuv2cWI9/eArsNaVOKUYWR7c99o2Ok3BrZcpWaZk
	 TU2VG3bMAB6cY2qw/NiI+cqBuIWdswrCyaPtZsgQcD5EWrJgwNwmkmJTvXbNLttn5L
	 fq18CHSDlFnyBnYXiaC0vZR+rt9XMss5J84TkajOTMlnhdqKNdxZCr5yJmNiVIPTbG
	 GgniNA/vEsKDx1GVRduBy2GXiHNjP9v1L1l9LCe9MsYB5WRRfVz60w73V2m0N5R81l
	 U6vL6pROYjWPg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC][PATCH] PCI: rcar-gen4: Add missing PM ops
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org, linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
References: <20260906173234.522400-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 17:47:42 +0000
Message-Id: <20260906174742.B85CD1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional calls to host-specific suspend/resume functions cras=
h when the controller operates in Endpoint (EP) mode.
- [High] Suspend/resume deadlock and unsafe GFP_KERNEL allocation via reque=
st_firmware() in the resume_noirq path.
--

commit 5af3966526dc17abac6d2f1a9c20afb491499031
Author: Marek Vasut <marek.vasut+renesas@mailbox.org>

PCI: rcar-gen4: Add missing PM ops

The commit adds suspend/resume PM ops to fix an issue where the controller
loses state during suspend on R-Car V4M. It registers generic suspend and
resume handlers to gracefully tear down and restart the PCIe link across
all R-Car Gen4 platforms.

> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/co=
ntroller/dwc/pcie-rcar-gen4.c
> index fbe465a29068f..8c3e41e9a8ba1 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -849,6 +849,22 @@ static int rcar_gen4_pcie_ltssm_control(struct rcar_=
gen4_pcie *rcar, bool enable
>  	return 0;
>  }
> =20
> +static int rcar_gen4_pcie_suspend_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +
> +	return dw_pcie_suspend_noirq(dw);

[Severity: High]
Does this crash when the controller operates in Endpoint mode?

Since the driver registers rcar_gen4_pcie_pm_ops for all matched devices,
including those in Endpoint mode (e.g., "renesas,rcar-gen4-pcie-ep"), this
unconditionally routes the suspend operation to the host-specific
dw_pcie_suspend_noirq() without verifying the controller mode.

In Endpoint mode, dw_pcie_host_init() is never called, leaving the Root
Port (pci->pp) structures uninitialized. If dw_pcie_suspend_noirq() is
called in Endpoint mode, it will dereference pci->pp.bridge which is
strictly NULL:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_suspend_noirq() {
    ...
	if (!pci_host_common_d3cold_possible(pci->pp.bridge, &pme_capable))
		return 0;
    ...
}

It will also dereference pci->pp.ops during the link-down fallback path:

drivers/pci/controller/dwc/pcie-designware-host.c:dw_pcie_suspend_noirq() {
    ...
stop_link:
    ...
	if (pci->pp.ops->deinit)
		pci->pp.ops->deinit(&pci->pp);
    ...
}

> +}
> +
> +static int rcar_gen4_pcie_resume_noirq(struct device *dev)
> +{
> +	struct rcar_gen4_pcie *rcar =3D dev_get_drvdata(dev);
> +	struct dw_pcie *dw =3D &rcar->dw;
> +
> +	return dw_pcie_resume_noirq(dw);

[Severity: High]
Can this cause a suspend/resume deadlock due to unsafe GFP_KERNEL allocatio=
ns?

When dw_pcie_resume_noirq() is called, it restarts the link which
ultimately invokes request_firmware() in the resume_noirq phase:

dw_pcie_resume_noirq()
  dw_pcie_start_link()
    rcar_gen4_pcie_start_link()
      rcar_gen4_pcie_ltssm_control()
        rcar_gen4_pcie_download_phy_firmware()
          request_firmware(&fw, RCAR_GEN4_PCIE_FIRMWARE_NAME, dw->dev);

Executing request_firmware() in a noirq phase is strictly unsafe because
device interrupts (including those for storage controllers) are disabled.
If the firmware is not cached, the request will hang indefinitely waiting
for filesystem I/O that cannot complete without interrupts. Even if
cached, request_firmware() allocates memory using GFP_KERNEL, which can
trigger page reclaim and block on disk I/O, similarly deadlocking the
system.

> +}
> +
>  static struct rcar_gen4_pcie_drvdata drvdata_r8a779f0_pcie =3D {
>  	.ltssm_control =3D r8a779f0_pcie_ltssm_control,
>  	.mode =3D DW_PCIE_RC_TYPE,

[ ... ]

> @@ -892,10 +908,14 @@ static const struct of_device_id rcar_gen4_pcie_of_=
match[] =3D {
>  };
>  MODULE_DEVICE_TABLE(of, rcar_gen4_pcie_of_match);
> =20
> +DEFINE_NOIRQ_DEV_PM_OPS(rcar_gen4_pcie_pm_ops,
> +			rcar_gen4_pcie_suspend_noirq, rcar_gen4_pcie_resume_noirq);
> +
>  static struct platform_driver rcar_gen4_pcie_driver =3D {
>  	.driver =3D {
>  		.name =3D "pcie-rcar-gen4",
>  		.of_match_table =3D rcar_gen4_pcie_of_match,
> +		.pm =3D &rcar_gen4_pcie_pm_ops,
>  		.probe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  	.probe =3D rcar_gen4_pcie_probe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906173234.5224=
00-1-marek.vasut+renesas@mailbox.org?part=3D1
