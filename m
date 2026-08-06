Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE553EAC8B
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047750; cv=none; b=fCt3u3y7JA1HAqmSjimY+yJC+uppKpCE5XB/KWeK7AFK9So9OFce9eIynghz+CJ+ixo/YvuYUU/oCxVGsZkHulUefzbZJMWpwD5pyLSLGbtocZ/KS05aeCYx8T9ASyrediKHYN/fc+3BaTYDyigX+JXBaFgxuA0r46AEVdciMKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047750; c=relaxed/simple;
	bh=oDe2u2TpT4/I/Jnytp6+waVES07tZXA/fW6jfcVOuKg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GhICO1uz0YbDEz2Mku3cSSivv8zNMW0RjbaCpYQPIabnFpVqC8T4/bYbisqal9s0Zy5zC4IcHla0W5kBMQQwZuduZEk4DBUb1TX2C674PdmzViSTt51dvlA2ZTwjwGtEovoE6p3/S9/V+gCQhJyHZOCi0bN24ICSPzeN/RP9Bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJT4b0gI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJT4b0gI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFD91F00A3D;
	Thu,  6 Aug 2026 20:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047748;
	bh=8JvXqasMvVmStaDOI/2mZ3v0nP3VTSoh6WuwawX9N60=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kJT4b0gI6YbyVmxZftNL1VSZyGLgpC5045ExQwW9AMsa7JXW75semYPQnvzojNbi9
	 Uaw/GOfPbrnHktOqKTsWakAeK/B9S6lNXxwGcVFtTtpqPR25m/N4J27WwvTl+HIW48
	 NbCIS6VlyI23BzXFDQrG16KsBe146qi8Ub4NJTlHWPWUStAPiZ69Qa0WMg6+2oiasc
	 7d0O1fwfSBJjulL+hH093oAhqoM/Hd6+A1S00EdiVdb2XX2nSXAKQUmSYQnPI8xYJV
	 t7OBS30AReiU6nTr75aQo6ic5u7t3Kp7UrRu5ZD/wFIfYqjLrrVJ7FakR6kwHHmdoF
	 /AcgKF3z+SPug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 8/8] PCI: vmd: Add workaround for bus number
 hardwired to fixed non-zero value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-9-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-9-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:22:26 +0000
Message-Id: <20260806202228.4FFD91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Dynamic bus assignment (e.g., for hotplugged switches or unconfigu=
red bridges) behind VMD BUS1 is broken due to incomplete logical-to-physica=
l bus number translation, leading to configuration space access failures an=
d broken ACPI matching.
- [High] Double free of IRQ domain and emulated domain number on VMD_BUS_0 =
creation failure.
--

--- Patch [8]: [PATCH v6 8/8] PCI: vmd: Add workaround for bus number hardw=
ired to fixed non-zero value ---
commit 1dce6e841a4c83aa7c67d1d1cd42002341425bb7
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add workaround for bus number hardwired to fixed non-zero value

This commit implements a workaround for the VMD BUS1 root bus number
being fixed to 0x80 in hardware. It deconfigures the root bus number in
the first pass of pci_scan_bridge() and translates configuration accesses
and ACPI matching to work around the fixed root bus number.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 7c4379d565eaf..8da2e6727282b 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -440,8 +440,22 @@ static void vmd_remove_irq_domain(struct vmd_dev *vm=
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
> +	 * BUS1 is registered with logical bus number 0x80 to avoid bridge
> +	 * reconfiguration, but cfg accesses must target the original BUS1
> +	 * restricted range start.
> +	 */
> +	if (vmd->bus1_rootbus && bus->number =3D=3D VMD_PRIMARY_BUS1)
> +		bus_number =3D vmd->busn_start[VMD_BUS_1];
> +	else
> +		bus_number =3D bus->number;
> +
> +	busnr_ecam =3D bus_number - vmd->busn_start[VMD_BUS_0];
> +	offset =3D PCIE_ECAM_OFFSET(busnr_ecam, devfn, reg);

[Severity: High]
Does this logic correctly handle subordinate buses dynamically assigned beh=
ind
BUS1?

Since vmd_cfg_addr() only remaps the exact bus number 0x80 to its physical
restricted range (e.g., 0xE1), subordinate buses like 0x81 would fall throu=
gh
to the else branch.

If bus->number is 0x81, subtracting vmd->busn_start[VMD_BUS_0] (which is
0xE0) would underflow the unsigned busnr_ecam integer. This results in a
massive ECAM offset that silently fails the VMD_CFGBAR bounds check below,
returning all FFs and breaking configuration space access for dynamically
assigned buses.

[ ... ]

> @@ -520,18 +534,37 @@ static struct pci_ops vmd_ops =3D {
>  static struct acpi_device *vmd_acpi_find_companion(struct pci_dev *pci_d=
ev)
>  {
>  	struct pci_host_bridge *bridge;
> -	u32 busnr, addr;
> +	struct vmd_dev *vmd;
> +	u32 addr;
> +	int busnr;
> +	u8 pci_bus_number;
> +	u8 bridge_bus_number;
> =20
>  	if (pci_dev->bus->ops !=3D &vmd_ops)
>  		return NULL;
> =20
> +	vmd =3D vmd_from_bus(pci_dev->bus);
>  	bridge =3D pci_find_host_bridge(pci_dev->bus);
> -	busnr =3D pci_dev->bus->number - bridge->bus->number;
> +	pci_bus_number =3D pci_dev->bus->number;
> +	bridge_bus_number =3D bridge->bus->number;
> +
> +	/*
> +	 * BUS1 is registered with logical root number 0x80. For ACPI companion
> +	 * matching, compute the relative bus number against the original BUS1
> +	 * restricted range base.
> +	 */
> +	if (vmd->bus1_rootbus && bridge->bus =3D=3D vmd->bus[VMD_BUS_1]) {
> +		bridge_bus_number =3D vmd->busn_start[VMD_BUS_1];
> +		if (pci_bus_number =3D=3D VMD_PRIMARY_BUS1)
> +			pci_bus_number =3D vmd->busn_start[VMD_BUS_1];
> +	}
> +
> +	busnr =3D pci_bus_number - bridge_bus_number;
>  	/*
>  	 * The address computation below is only applicable to relative bus
>  	 * numbers below 32.
>  	 */
> -	if (busnr > 31)
> +	if (busnr < 0 || busnr > 31)
>  		return NULL;

[Severity: High]
Can this relative bus depth calculation produce negative values for OS-assi=
gned
subordinate buses?

For a subordinate bus like 0x81, pci_bus_number remains 0x81, while
bridge_bus_number is remapped to the physical base (e.g., 0xE1). This resul=
ts
in busnr being 0x81 - 0xE1 =3D -0x60, which fails the new busnr < 0 check a=
nd
breaks ACPI companion matching.

[ ... ]

> @@ -1045,6 +1078,7 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum=
 vmd_rootbus bus_number,
>  			  struct pci_sysdata *sd, resource_size_t *offset,
>  			  u8 primary)
>  {
> +	u8 root_busnr;
>  	u8 cfgbar =3D bus_number * 3;
>  	u8 membar1 =3D cfgbar + 1;
>  	u8 membar2 =3D cfgbar + 2;
> @@ -1057,8 +1091,27 @@ static int vmd_create_bus(struct vmd_dev *vmd, enu=
m vmd_rootbus bus_number,
>  	pci_add_resource_offset(&resources, &vmd->resources[membar2],
>  				offset[1]);
> =20
> -	vmd_bus =3D pci_create_root_bus(&vmd->dev->dev,
> -				      vmd->busn_start[bus_number], &vmd_ops, sd,
> +	/*
> +	 * Register BUS1 with its logical root number (0x80) up front so PCI co=
re
> +	 * bridge scanning does not see a post-registration bus-number mutation.
> +	 *
> +	 * This is a workaround for pci_scan_bridge_extend() code.
> +	 * It marks bridge invalid configuration when detecting a
> +	 * non-zero (0x80) the VMD BUS1 root bus number. Thus Primary Bus Number
> +	 * of Root Ports on BUS1 is deconfigured in the first pass of
> +	 * pci_scan_bridge() to be re-assigned to 0x0 in the second pass.
> +	 * As a result no subordinate bus number behind VMD BUS1 is found.
> +	 * Workaround: VMD_BUS_1 bus number shall be set to VMD_PRIMARY_BUS1 so=
 it has
> +	 * the same value as vmd->bus[VMD_BUS_1]->primary, it will bypass bus n=
umber
> +	 * reconfiguration.
> +	 */
> +
> +	if (bus_number =3D=3D VMD_BUS_1 && vmd->bus1_rootbus)
> +		root_busnr =3D VMD_PRIMARY_BUS1;
> +	else
> +		root_busnr =3D vmd->busn_start[bus_number];
> +
> +	vmd_bus =3D pci_create_root_bus(&vmd->dev->dev, root_busnr, &vmd_ops, s=
d,
>  				      &resources);
> =20
>  	if (!vmd_bus) {

[Severity: High]
Is there a double free of the IRQ domain and emulated domain number when
VMD_BUS_0 creation fails?

Inside vmd_create_bus(), the error path for !vmd_bus explicitly cleans up:

    if (bus_number =3D=3D VMD_BUS_0) {
        pci_bus_release_emul_domain_nr(sd->domain);
        vmd_remove_irq_domain(vmd);
    }
    return -ENODEV;

However, the caller vmd_enable_domain() intercepts this error return and
mistakenly executes the exact same cleanup operations:

    ret =3D vmd_create_bus(vmd, VMD_BUS_0, sd, offset, VMD_PRIMARY_BUS0);
    if (ret) {
        pci_err(vmd->dev, "Can't create bus: %d\n", ret);
        pci_bus_release_emul_domain_nr(sd->domain);
        vmd_remove_irq_domain(vmd);
        return ret;
    }

Because vmd_remove_irq_domain() does not set vmd->irq_domain to NULL, this
appears to trigger an immediate double free of the fwnode and irq domain
structure. The IDA structure also gets freed twice.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D8
