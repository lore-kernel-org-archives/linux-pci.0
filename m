Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB1A48F839
	for <linux-pci@vger.kernel.org>; Thu,  6 Aug 2026 20:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047372; cv=none; b=b6u6HYDVxxHr+FWCUer7ZUxaumEJ0mQyjHA92a1WR+lV5Y5n6zDtT3X/PTACggFFgAYp7AtV8G9BFwyE3TzfsZJVnybC4eTYewXw+x43ua7+iQFTCwasvhunGra0bffi/tIj6efdv65IBZUc1bn7dQQvMjyRvoCK4tIxuk59Ddo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047372; c=relaxed/simple;
	bh=2EJbeSndWhqo9gpjqTM7z5t9i7FlYXx3btGW0yalF9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gPIVDBxVoMYpro1AmZrF/eSMvACrPCPScWVoLqN81VVClzn+OLuJHbJVhStar7sKQY6mK6fMWxydjjUO4xxEOp7bqyy5IyzRwrn0aSEpU47TbsiTS5gr+/9i5Bf8gASepzKfqniSJ0cXhgApuERLc+SJEVejT/vYwncCJXIKJZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9zZxBhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9zZxBhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A58A11F000E9;
	Thu,  6 Aug 2026 20:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786047350;
	bh=MZkmVMKLiVXRJzy9tkTR8JTHVgzhkNYCGrdpCjJBuqs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V9zZxBhIPZQIcATtZoU0pevjKxssmDMEgEYLyX2h2OV0nJFstW01dzTTyoy6g67HR
	 ASerL2mgLTwlva3aUMsVXfpl/PCjGB9JzcZnVacvu15PwEEBzCaveR4kQu7sT89epr
	 xOznUnRJFpFQwznEh4qMiKpv64knt767IQO+yxoPpNabHGQ+TEPt7WmG3NKZErZYNh
	 5N1vklSKt2N265eVgGRtse5w5r5uxJkP6vf3XqjTnZoDI2KAA4QcWI7IgQZg4fF7Uo
	 CqF94Ohb3GeCnaXEsf7PcRWThMSj3xMi4V2c3AuURRDHe9n9Zi1I65NdU7nznMajfy
	 d8n3kVESMXZ+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/8] PCI: vmd: Add support for second rootbus under
 VMD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260806221351.38592-8-szymon.durawa@linux.intel.com>
References: <20260806221351.38592-1-szymon.durawa@linux.intel.com>
 <20260806221351.38592-8-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 20:15:50 +0000
Message-Id: <20260806201550.A58A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] Incorrect MEMBAR2 resizing logic causes overlapping memory windows=
 for BUS0 and truncated memory windows for BUS1.
- [High] Double free of the PCI emulated domain IDA and redundant removal o=
f the IRQ domain on the VMD_BUS_0 creation error path.
- [High] Lockless modification of global resource tree pointers can race wi=
th concurrent readers.
- [High] Incorrect busn_start configuration for restriction type 3 assigns =
wrong root bus number to BUS0.

Pre-existing issues:
- [High] Missing pci_free_irq_vectors() in error paths and during device re=
moval causes a permanent IRQ vector leak.
--

--- Patch [7]: [PATCH v6 7/8] PCI: vmd: Add support for second rootbus unde=
r VMD ---
commit 59d38ef8140ce34f05ff3140bfb153eb7ddbc2c5
Author: Szymon Durawa <szymon.durawa@linux.intel.com>
Subject: PCI: vmd: Add support for second rootbus under VMD

Starting from Intel Arrow Lake VMD enhancement introduces second root bus
support with fixed root bus number (0x80). Add new BUS1 enumeration and
divide MMIO space to be shared between both root buses.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 786374965f74a..7c4379d565eaf 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -587,12 +619,24 @@ static void vmd_attach_resources(struct vmd_dev *vm=
d)
>  {
>  	vmd->dev->resource[VMD_MEMBAR1].child =3D &vmd->resources[VMD_RES_MBAR_=
1];
>  	vmd->dev->resource[VMD_MEMBAR2].child =3D &vmd->resources[VMD_RES_MBAR_=
2];
> +
> +	if (vmd->bus1_rootbus) {
> +		vmd->resources[VMD_RES_MBAR_1].sibling =3D
> +			&vmd->resources[VMD_RES_BUS1_MBAR_1];
> +		vmd->resources[VMD_RES_MBAR_2].sibling =3D
> +			&vmd->resources[VMD_RES_BUS1_MBAR_2];
> +	}
>  }

[Severity: High]
Does modifying the sibling pointers here race with concurrent readers?

Directly modifying the sibling pointers of resources that are part of the
global iomem_resource tree without acquiring the resource_lock rwlock can
cause data races.

Concurrent readers, such as /proc/iomem, traversing the resource tree
while the sibling pointers are being modified here in vmd_attach_resources()
or cleared in the vmd_enable_domain() fallback error path could experience
invalid memory access.

[ ... ]

> @@ -668,6 +712,19 @@ static int vmd_get_bus_number_start(struct vmd_dev *=
vmd)
>  		case 2:
>  			vmd->busn_start[VMD_BUS_0] =3D VMD_RESTRICT_2_BUS_START;
>  			break;
> +		case 3:
> +			if (!(features & VMD_FEAT_HAS_BUS1_ROOTBUS)) {
> +				pci_err(dev, "VMD Bus Restriction detected type %d, but BUS1 Rootbus=
 is not supported, aborting.\n",
> +					BUS_RESTRICT_CFG(reg));
> +				return -ENODEV;
> +			}
> +
> +			/* VMD (on root bus 0) secondary bus start number */
> +			vmd->busn_start[VMD_BUS_0] =3D VMD_RESTRICT_2_BUS_START;

[Severity: High]
Should the BUS0 start number be VMD_RESTRICT_0_BUS_START (0x00) here?

By assigning VMD_RESTRICT_2_BUS_START (0xE0) to BUS0 for restriction
type 3, vmd_create_bus() is instructed to create the BUS0 root bus
with bus number 0xE0.

However, for Arrow Lake, the BUS0 root bus is physically expected to be
at 0x00, and its CFGBAR resource range is correctly parsed and adjusted
starting at 0x00. Passing 0xE0 to pci_create_root_bus() conflicts with
the CFGBAR start address and can break device discovery on the primary
VMD bus.

[ ... ]

> @@ -850,49 +962,135 @@ static int vmd_configure_membar1_membar2(struct vm=
d_dev *vmd,
>  {
>  	int ret;
> =20
> -	ret =3D vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0, 0);
> -	if (ret)
> -		return ret;

[ ... ]

> +		/*
> +		 * Resize BUS MEMBAR1 and MEMBAR2 ranges to make space
> +		 * for BUS1 owned devices by adjusting range end with values
> +		 * stored in VMD_MEMBAR1_OFFSET and VMD_MEMBAR2_OFFSET registers
> +		 */
> +		ret =3D vmd_configure_membar(vmd, VMD_RES_MBAR_1, VMD_MEMBAR1, 0,
> +					   mbar1_sz - bus1_mbar1_ofs);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D vmd_configure_membar(vmd, VMD_RES_MBAR_2, VMD_MEMBAR2,
> +					   mbar2_ofs, mbar2_sz - (bus1_mbar2_ofs + mbar2_ofs));
> +		if (ret)
> +			return ret;
> +
> +		ret =3D vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_1, VMD_MEMBAR1,
> +					   bus1_mbar1_ofs, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D vmd_configure_membar(vmd, VMD_RES_BUS1_MBAR_2, VMD_MEMBAR2,
> +					   mbar2_ofs + bus1_mbar2_ofs, 0);

[Severity: High]
Does this logic create overlapping memory windows for BUS0 and truncated
memory windows for BUS1?

The hardware splits MEMBAR2 based on bus1_mbar2_ofs, which is the
absolute offset from the BAR's base address. However, when configuring
vmd_configure_membar1_membar2(), the software-reserved shadow size
(mbar2_ofs) is added to the split point.

This extends the BUS0 region up to bus1_mbar2_ofs + mbar2_ofs - 1, and
sets the BUS1 start offset to mbar2_ofs + bus1_mbar2_ofs. Since hardware
routes based solely on bus1_mbar2_ofs, the OS will assign an overlapping
address range to BUS0 devices that hardware will incorrectly route to BUS1,
potentially breaking MMIO in the overlap region.

[ ... ]

> @@ -1036,7 +1244,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, u=
nsigned long features)
> =20
>  	sd->node =3D pcibus_to_node(vmd->dev->bus);
> =20
> -	ret =3D vmd_create_bus(vmd, sd, offset);
> +	ret =3D vmd_create_bus(vmd, VMD_BUS_0, sd, offset, VMD_PRIMARY_BUS0);
>  	if (ret) {
>  		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
>  		pci_bus_release_emul_domain_nr(sd->domain);
>  		vmd_remove_irq_domain(vmd);
>  		return ret;
>  	}

[Severity: High]
Will this result in a double free of the emulated domain IDA?

When pci_create_root_bus() fails for VMD_BUS_0 inside vmd_create_bus(),
the error path within that function now cleans up by calling
pci_bus_release_emul_domain_nr(sd->domain) and vmd_remove_irq_domain(vmd).

Since vmd_enable_domain() also checks the return code and repeats both
calls here, pci_bus_release_emul_domain_nr() is called twice on the
same domain index. This will trigger a kernel WARNING and corrupt the
IDA state structure.

[ ... ]

> @@ -1147,6 +1381,13 @@ static void vmd_remove(struct pci_dev *dev)
>  	pci_stop_root_bus(vmd->bus[VMD_BUS_0]);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_remove_root_bus(vmd->bus[VMD_BUS_0]);
> +
> +	if (vmd->bus1_rootbus && vmd->bus[VMD_BUS_1]) {
> +		pci_stop_root_bus(vmd->bus[VMD_BUS_1]);
> +		sysfs_remove_link(&vmd->dev->dev.kobj, "domain1");
> +		pci_remove_root_bus(vmd->bus[VMD_BUS_1]);
> +	}
> +
>  	vmd_cleanup_srcu(vmd);
>  	vmd_detach_resources(vmd);
>  	vmd_remove_irq_domain(vmd);
>  }

[Severity: High]
This is a pre-existing issue, but do we leak PCI IRQ vectors during device
removal and on probe error paths?

According to PCI subsystem guidelines, every error path after a successful
pci_alloc_irq_vectors() must explicitly call pci_free_irq_vectors() before
returning.

The device removal function vmd_remove() lacks a call to
pci_free_irq_vectors(). Furthermore, early returns in vmd_alloc_irqs()
and probe error paths in vmd_enable_domain() omit this cleanup. Unbinding
and rebinding the driver or failing probe will permanently leak PCI IRQ
vectors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806221351.3859=
2-1-szymon.durawa@linux.intel.com?part=3D7
