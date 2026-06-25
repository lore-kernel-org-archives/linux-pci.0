Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4836164D
	for <linux-pci@vger.kernel.org>; Thu, 25 Jun 2026 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782369050; cv=none; b=Ks3l92+LG9jUns82NtOrTbo8vM7ODpiTBgKi421hV+gSOs7OJD8RrHI1XXA95DKUoAchSpcORd0389RXfKsxdvfbBdQa0GElrzOYydxRZr4ZxI8QXVb8AnwvEn4l8OV6T94Bc6RPdgPDuVG7REiMkqRx58nD0XUfqiAGjvoA45E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782369050; c=relaxed/simple;
	bh=uvEi0IQJPUdLeI8mnPefGjwELI76jSW4u1pjvMFoOB0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ruZfVEs1hJX5PzeLXMiG8a0VfeP6RNv8YvqSSfKKT7gykR8LhQPkOyVPZb/ofFKkMufgCq104j/Aos9rOqLIZvdK75GhgXb3TgKSIG8r08OIBgt1phFeqWA0YQFci/NAlvEdJhgmmA9E27AxWof6nxmyf4htKBBPM/ZCoJAEcWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjxNf4f6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjxNf4f6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39961F000E9;
	Thu, 25 Jun 2026 06:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782369048;
	bh=xrJNxKQT4ZxobUg6FOMjJ7bXFUKivAoevGhfUqGBY9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZjxNf4f6Vzmp4RO+TyPl9dAiSPZRGElNicS5fhKztZGnOEkEApXgXwWIuxsAfq0vm
	 qP9bcCP36KeITh+ZZdkrm9vI/DIh7CrSKXvmkW1qQD3uCnkZ+PfZj+pGcnoYPKtq+w
	 75tIT8Gb6Eq+VmBTs3+ra1/WaDekZY5tw+8FxYzH1ioTxB+wlmpQGnCt+UN4olnNaH
	 btxcu5wvIhUtNnEqUpNJoCgTRzUOL7DyJoc7+Lyy2/Hp4N8I4R64PhKIu58KbpH8ah
	 0YZeS/i7VpquSat8VXutixlsZsCRyWpcIfjQ+TEYA0JVcf9T5+5gkjiC+k57VGeWvL
	 uceW42hQ9+cCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 8/8] PCI: vmd: Add workaround for bus number
 hardwired to fixed non-zero value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260625082940.1290740-9-szymon.durawa@linux.intel.com>
References: <20260625082940.1290740-1-szymon.durawa@linux.intel.com>
 <20260625082940.1290740-9-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:30:48 +0000
Message-Id: <20260625063048.B39961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Modifying `bus->number` dynamically after bus registration breaks =
PCI device naming conventions and sysfs topology consistency.

Pre-existing issues:
- [High] Missing cleanup of VMD_BUS_0 when VMD_BUS_1 creation fails, leadin=
g to a PCI root bus leak and a potential Use-After-Free.
--

commit daf784b1aba7feceb67edffc6d0d8a59f8bc2fb9
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value

The VMD BUS1 root bus number is fixed in hardware to 0x80. This patch adds
a workaround to bypass bus number reconfiguration by updating the BUS1
number to be the same as the BUS1 primary number.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index c68ea7837620d..d0527be78ebd5 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -440,8 +440,23 @@ static void vmd_remove_irq_domain(struct vmd_dev *vm=
d)
>  static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *b=
us,
>  				  unsigned int devfn, int reg, int len)
>  {
> -	unsigned int busnr_ecam =3D bus->number - vmd->busn_start[VMD_BUS_0];
> -	u32 offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> +	unsigned char bus_number;
> +	unsigned int busnr_ecam;
> +	u32 offset;
> +
> +	/*
> +	 * VMD workaround: for VMD BUS1, bus->number is set to VMD_PRIMARY_BUS1
> +	 * (see comment in vmd_enable_domain() under vmd_create_bus() for BUS1)
> +	 * but original value is 0xE1 which is stored in
> +	 * vmd->busn_start[VMD_BUS_1].
> +	 */
> +	if (vmd->bus1_rootbus && bus->number =3D=3D VMD_PRIMARY_BUS1)
> +		bus_number =3D vmd->busn_start[VMD_BUS_1];

[Severity: High]
Does this code undo the bus number mutation performed in vmd_enable_domain()
for config space accesses?

While this ensures config space accesses still work, it highlights the
mismatch that leaves the sysfs topology structurally inconsistent for
userspace.

> +	else
> +		bus_number =3D bus->number;
> +
> +	busnr_ecam =3D bus_number - vmd->busn_start[VMD_BUS_0];
> +	offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);
> =20
>  	if (offset + len >=3D resource_size(&vmd->dev->resource[VMD_CFGBAR]))
>  		return NULL;

[ ... ]

> @@ -1177,6 +1192,19 @@ static int vmd_enable_domain(struct vmd_dev *vmd, =
unsigned long features)
>  		 */
>  		vmd->bus[VMD_BUS_1]->primary =3D VMD_PRIMARY_BUS1;

[Severity: High]
This is a pre-existing issue, but does the error handling just above this
code leak VMD_BUS_0?

If vmd_create_bus() for VMD_BUS_1 fails:

vmd_enable_domain() {
    ...
    ret =3D vmd_create_bus(vmd, VMD_BUS_0, sd, offset);
    if (ret)
        return ret; // Succeeds
    ...
    if (vmd->bus1_rootbus) {
        ret =3D vmd_create_bus(vmd, VMD_BUS_1, sd, offset);
        if (ret) {
            pci_err(vmd->dev, "Can't create BUS1: %d\n", ret);
            return ret; // Leaks VMD_BUS_0
        }
    ...
}

The error path returns directly without calling pci_stop_root_bus() and
pci_remove_root_bus() for VMD_BUS_0.

Could this lead to a use-after-free if the PCI core retains a reference to
the leaked VMD_BUS_0 after the vmd device allocation is freed?

> +		/*
> +		 * This is a workaround for pci_scan_bridge_extend() code.
> +		 * It marks bridge invalid configuration when detecting a
> +		 * non-zero (0x80) the VMD BUS1 root bus number. Thus Primary Bus Numb=
er
> +		 * of Root Ports on BUS1 is deconfigured in the first pass of
> +		 * pci_scan_bridge() to be re-assigned to 0x0 in the second pass.
> +		 * As a result no subordinate bus number behind VMD BUS1 is found.
> +		 * Workaround: update vmd->bus[VMD_BUS_1]->number and
> +		 * vmd->bus[VMD_BUS_1]->primary to the same value, which
> +		 * bypasses bus number reconfiguration.
> +		 */
> +		vmd->bus[VMD_BUS_1]->number =3D VMD_PRIMARY_BUS1;

[Severity: High]
Does modifying the bus number dynamically after bus registration break PCI
device naming conventions and sysfs topology consistency?

Because the bus number is forcibly mutated after the VMD_BUS_1 root bus
device has already been registered with the PCI subsystem, child devices
downstream will be enumerated and registered using names derived from
0x80 (e.g., 0000:80:1c.0).

Meanwhile, their parent bus directory in sysfs remains named using the
original bus number (e.g., 0000:e1), which can break userspace tools
expecting standard PCI naming.

> +
>  		WARN(sysfs_create_link(&vmd->dev->dev.kobj,
>  				       &vmd->bus[VMD_BUS_1]->dev.kobj,
>  				       "domain1"),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625082940.1290=
740-1-szymon.durawa@linux.intel.com?part=3D8
