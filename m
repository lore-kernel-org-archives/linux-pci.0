Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985813;
	b=UUeiEV8nMPYjPkc90eTJRml82Xtfcwd8LU1gvagnYHiwnBOwHlZWqp717kL832gUxvho
	 PiuKMZrv7N5SiIJfmlJXNDoO3gLBhjrIAYm4n5jISQut5kMxsuEnDpu46U3zp4x0PF0OH
	 CHpxDBIVh2vcNDNjqb1lzEXkj2Noxw1JCNjIJqbQvBjd7r5ftEjRJsSZHA3ShLggyIEAK
	 rvng5gwd0xvMq4nbCYV/Drknqvlj/DAdPjlwFsgVxKelq01LfZm8BflU5+6tjGa6AuwjJ
	 XBs1T78b8v8TkzqyVGw/sXRGFhFcUEBelAuw0Oa67H2071TiUM5UC4t/1Sltl7w9TwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985813;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Km0IIbUZUcdQkBZ22OOYekL49gQEwnUdJs3Kk3qJEfQ=;
	b=pF7PQpfxv1yg67748m4alC1ePhLGGO7W451gQjfkESZ4QB75pE2xSBEEAMBZYDE6Xswx
	 Bil19el7iwP4s3CJEaQkOHN6HHp7ax5XB/nfL4zrUiIeNqVX1fO3bpXbRGxLRfxn0mh1r
	 fmSmGwQI5PADyacjzAMzbbLc62ykf4kaMoLYkb7vJYz59pzyDRESSj024ZYxXrKszmNT9
	 nceSkGKq4+JwifnpqxXuq6J424Hb0nQF/3JaFFKvotQRZ9DpBBPW1T9xYRHX/gcZdxOWC
	 xhvoZ6QBTQJzMgVVorPbzssvOXTSq0BKJkiMtddWq7oznzTR1d8ZF5FVoO+IhuseuFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpTXFqD0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D89606A335
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 17:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpTXFqD0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51581F008A5;
	Fri,  6 Nov 2026 17:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985812;
	bh=Km0IIbUZUcdQkBZ22OOYekL49gQEwnUdJs3Kk3qJEfQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kpTXFqD0wgcDCWNqDHRo+a8HnTWQ39wgmIkTnSwnZ9Cup0yTQJbarXdI3m7omgxWx
	 t86tZlVAZYUI3eTwbW9SV31DF/uwgJ28Cxp8abznyc+0gI+G1Nfek3qdSmGxLIbQVl
	 1YqSHx1YEnLqpwI9lC78DzAQZC3+wyf5w3P8d5kOyH84tkqrIJIeEh6pXeoJiyJb9W
	 DguDMahDhQCBIbfrZAFKwTFDkBCqJfBsR5+0H6xTWyqMQKZ0RJIHf1Pp+dAQW7PiLF
	 p28hrvMrOEDp1nk6P8StyXVck8uPJTBq552J6Zyfj23IkKiNQm26zKOCzAsGRp67HS
	 BVgL8d/hMYJWg==
Message-ID: <sashiko-outbox-201916@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 7/7] PCI: vmd: Add support for second rootbus under
 VMD
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261106184256.4130-8-szymon.durawa@linux.intel.com>
References: <20261106184256.4130-1-szymon.durawa@linux.intel.com>
 <20261106184256.4130-8-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:23:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] PCI: vmd: overlapping busn_res and unisolated CFGBAR in
  vmd_create_bus()
- [Medium] PCI: vmd: missing VMD_BUSRANGE bounds check in
  vmd_configure_cfgbar()
- [Medium] PCI: vmd: wrong relative bus number for BUS1 in
  vmd_acpi_find_companion()
- [Medium] PCI: vmd: leak of srcu_struct on error paths in
  vmd_enable_domain()
--

commit e9682a58316a29ebd9d43933c4903d99f8a94e4b
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

PCI: vmd: Add support for second rootbus under VMD

This commit adds support for a second VMD root bus (BUS1) exposed via Bus
Restriction type 3 on Intel Arrow Lake and later platforms, partitioning
CFGBAR, MEMBAR1, and MEMBAR2 across two emulated PCI domains.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 5733faf972d10..6831d0a5c443a 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c

[ ... ]

> @@ -989,6 +1133,62 @@ static void vmd_configure_cfgbar(struct vmd_dev *vm=
d)
>  		.end   =3D busn_end,
>  		.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
>  	};
> +
> +	if (vmd->bus1_rootbus) {
> +		int ret;
> +		u16 bus0_range =3D 0;
> +		u16 bus1_range =3D 0;
> +		u8 bus0_start, bus0_end;
> +		u8 bus1_start, bus1_end;
> +
> +		ret =3D pci_read_config_word(vmd->dev, VMD_BUSRANGE0, &bus0_range);
> +		if (ret) {
> +			pci_err(vmd->dev, "Failed to read VMD_BUSRANGE0: %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		ret =3D pci_read_config_word(vmd->dev, VMD_BUSRANGE1, &bus1_range);
> +		if (ret) {
> +			pci_err(vmd->dev, "Failed to read VMD_BUSRANGE1: %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		bus0_start =3D VMD_BUS_START(bus0_range);
> +		bus0_end =3D VMD_BUS_END(bus0_range);
> +		bus1_start =3D VMD_BUS_START(bus1_range);
> +		bus1_end =3D VMD_BUS_END(bus1_range);
> +
> +		if (bus0_start > bus0_end || bus1_start > bus1_end) {
> +			pci_err(vmd->dev,
> +				"Invalid bus range(s): BUS0 [%02x-%02x], BUS1 [%02x-%02x]\n",
> +				bus0_start, bus0_end, bus1_start, bus1_end);
> +			return -EINVAL;
> +		}
> +
> +		if (!(bus0_end < bus1_start || bus1_end < bus0_start)) {
> +			pci_err(vmd->dev,
> +				"Overlapping bus ranges: BUS0 [%02x-%02x], BUS1 [%02x-%02x]\n",
> +				bus0_start, bus0_end, bus1_start, bus1_end);
> +			return -EINVAL;
> +		}
> +
> +		/*
> +		 * Resize BUS0 CFGBAR range to make space for BUS1
> +		 * owned devices by adjusting range end with value stored in
> +		 * VMD_BUSRANGE0 register.
> +		 */
> +		vmd->resources[VMD_RES_CFGBAR].start =3D bus0_start;
> +		vmd->resources[VMD_RES_CFGBAR].end =3D bus0_end;
> +
> +		vmd->resources[VMD_RES_BUS1_CFGBAR] =3D (struct resource){
> +			.name =3D "VMD CFGBAR BUS1",
> +			.start =3D bus1_start,
> +			.end =3D bus1_end,
> +			.flags =3D IORESOURCE_BUS | IORESOURCE_PCI_FIXED,
> +		};
> +	}
> +
> +	return 0;
>  }

[Severity: Medium]
Does vmd_configure_cfgbar() need to validate that bus0_start and bus1_start
are above vmd->busn_start[VMD_BUS_1] (0xe1) and that bus0_end and bus1_end
do not exceed busn_end?

If firmware leaves VMD_BUSRANGE0 or VMD_BUSRANGE1 at 0x0000 when one root
bus has no subordinate devices, or reports an end bus beyond the VMD_CFGBAR
aperture, the checks above still pass and overwrite the bus resources with
an inverted range such as [0xe0..0x00] or an out-of-bounds bus number.

[ ... ]

> @@ -1040,55 +1241,132 @@ static int vmd_configure_membar1_membar2(struct =
vmd_dev *vmd,
>  static int vmd_create_bus(struct vmd_dev *vmd, enum vmd_rootbus bus_numb=
er,
>  			  struct pci_sysdata *sd, resource_size_t *offset,
>  			  bool vmd_in_guest, u8 primary)
>  {
> +	u8 cfgbar =3D bus_number * 3;
> +	u8 membar1 =3D cfgbar + 1;
> +	u8 membar2 =3D cfgbar + 2;
> +	struct pci_bus *vmd_bus;
>  	LIST_HEAD(resources);
> =20
> -	pci_add_resource(&resources, &vmd->resources[VMD_RES_CFGBAR]);
> -	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_1],
> +	pci_add_resource(&resources, &vmd->resources[cfgbar]);
> +	pci_add_resource_offset(&resources, &vmd->resources[membar1],
>  				offset[0]);
> -	pci_add_resource_offset(&resources, &vmd->resources[VMD_RES_MBAR_2],
> +	pci_add_resource_offset(&resources, &vmd->resources[membar2],
>  				offset[1]);
> =20
> -	vmd->bus[VMD_BUS_0] =3D pci_create_root_bus(&vmd->dev->dev,
> -						  vmd->busn_start[VMD_BUS_0],
> -						  &vmd_ops, sd, &resources);
> -	if (!vmd->bus[VMD_BUS_0]) {
> +	vmd_bus =3D pci_create_root_bus(&vmd->dev->dev,
> +				      vmd->busn_start[bus_number], &vmd_ops, sd,
> +				      &resources);

[Severity: High]
Can VMD_BUS_0 and VMD_BUS_1 allocate and scan each other's ECAM bus numbers
when a root port bridge is unconfigured?

vmd_configure_cfgbar() sets vmd->resources[VMD_RES_CFGBAR] to
[bus0_start..bus0_end] (for example [0xe2..0xf0]) and
vmd->resources[VMD_RES_BUS1_CFGBAR] to [bus1_start..bus1_end] (for example
[0xf1..0xff]).  However, pci_create_root_bus() -> pci_register_host_bridge()
ignores res->start and inserts bus->busn_res starting at bus->number:

drivers/pci/probe.c:pci_register_host_bridge() {
    ...
	resource_list_for_each_entry(window, &bridge->windows) {
		res =3D window->res;
		if (resource_type(res) =3D=3D IORESOURCE_BUS)
			pci_bus_insert_busn_res(bus, bus->number, res->end);
	}
    ...
}

As a result, VMD_BUS_0 gets busn_res [0xe0..0xf0] (which includes 0xe1, the
root bus of VMD_BUS_1) and VMD_BUS_1 gets busn_res [0xe1..0xff] (which
includes 0xe2..0xf0, the subordinate bus range of VMD_BUS_0), while
vmd_cfg_addr() maps bus->number directly into the shared vmd->cfgbar
without checking which domain owns that bus number.  When
pci_scan_child_bus_extend() encounters an unconfigured bridge on VMD_BUS_1
(or on VMD_BUS_0 before max passes 0xe0), Pass 1 assigns max + 1 (0xe2 on
VMD_BUS_1, or 0xe1 on VMD_BUS_0), scanning and reprogramming devices that
belong to the other VMD root bus.

[ ... ]

> @@ -1213,11 +1511,38 @@ static int vmd_enable_domain(struct vmd_dev *vmd,=
 unsigned long features)
> =20
>  	sd->node =3D pcibus_to_node(vmd->dev->bus);
> =20
> -	ret =3D vmd_create_bus(vmd, sd, offset, vmd_in_guest);
> +	if (vmd->bus1_rootbus) {
> +		vmd->sysdata[VMD_BUS_1].vmd_dev =3D vmd->dev;
> +		vmd->sysdata[VMD_BUS_1].node =3D pcibus_to_node(vmd->dev->bus);
> +		vmd->sysdata[VMD_BUS_1].domain =3D pci_bus_find_emul_domain_nr(0, 0x10=
000, INT_MAX);
> +		if (vmd->sysdata[VMD_BUS_1].domain < 0) {
> +			pci_warn(vmd->dev,
> +				 "Can't allocate BUS1 domain: %d, continuing with BUS0 only\n",
> +				 vmd->sysdata[VMD_BUS_1].domain);
> +			vmd_disable_bus1(vmd);
> +		}
> +	}
> +
> +	ret =3D vmd_attach_resources(vmd);
> +	if (ret) {
> +		pci_bus_release_emul_domain_nr(sd->domain);
> +		if (vmd->bus1_rootbus && vmd->sysdata[VMD_BUS_1].domain >=3D 0)
> +			pci_bus_release_emul_domain_nr(vmd->sysdata[VMD_BUS_1].domain);
> +
> +		vmd_remove_irq_domain(vmd);
> +		return ret;
> +	}
> +
> +	ret =3D vmd_create_bus(vmd, VMD_BUS_0, sd, offset, vmd_in_guest,
> +			     VMD_PRIMARY_BUS0);
>  	if (ret) {
>  		pci_err(vmd->dev, "Can't create bus: %d\n", ret);
>  		pci_bus_release_emul_domain_nr(sd->domain);
> +		if (vmd->bus1_rootbus && vmd->sysdata[VMD_BUS_1].domain >=3D 0)
> +			pci_bus_release_emul_domain_nr(vmd->sysdata[VMD_BUS_1].domain);
> +
>  		vmd_remove_irq_domain(vmd);
> +		vmd_detach_resources(vmd);
>  		return ret;
>  	}

[Severity: Medium]
Do these error paths leak the per-vector srcu_struct instances initialized
by vmd_alloc_irqs()?

When MSI remapping is enabled, vmd_alloc_irqs() calls init_srcu_struct() on
each vmd->irqs[i].srcu, which allocates per-CPU memory not managed by
devres.  If vmd_attach_resources() or vmd_create_bus() fails, returning
without calling vmd_cleanup_srcu(vmd) leaks that memory and leaves active
srcu_struct objects in devm-allocated vmd->irqs memory.

>  	WARN(sysfs_create_link(&vmd->dev->dev.kobj,
>  			       &vmd->bus[VMD_BUS_0]->dev.kobj, "domain"),
>  	     "Can't create symlink to domain\n");
> =20
> +	if (vmd->bus1_rootbus && vmd->sysdata[VMD_BUS_1].domain >=3D 0) {
> +		ret =3D vmd_create_bus(vmd, VMD_BUS_1, &vmd->sysdata[VMD_BUS_1], offse=
t,
> +				     vmd_in_guest, VMD_PRIMARY_BUS1);
> +		if (ret) {
> +			pci_warn(vmd->dev,
> +				 "Can't create BUS1: %d, continuing with BUS0 only\n",
> +				 ret);
> +
> +			release_resource(&vmd->resources[VMD_RES_BUS1_MBAR_2]);
> +			release_resource(&vmd->resources[VMD_RES_BUS1_MBAR_1]);
> +			pci_bus_release_emul_domain_nr(vmd->sysdata[VMD_BUS_1].domain);
> +			vmd_disable_bus1(vmd);
> +		}
> +
> +		if (vmd->bus1_rootbus && vmd->sysdata[VMD_BUS_1].domain >=3D 0) {
> +			WARN(sysfs_create_link(&vmd->dev->dev.kobj,
> +					       &vmd->bus[VMD_BUS_1]->dev.kobj,
> +					       "domain1"),
> +			     "Can't create symlink to domain1\n");
> +		}
> +	}
> +
>  	vmd_bus_enumeration(vmd->bus[VMD_BUS_0], features);
> =20
> +	if (vmd->bus1_rootbus && vmd->sysdata[VMD_BUS_1].domain >=3D 0)
> +		vmd_bus_enumeration(vmd->bus[VMD_BUS_1], features);

[Severity: Medium]
Does vmd_acpi_find_companion() compute the wrong relative bus number when
enumerating VMD_BUS_1?

drivers/pci/controller/vmd.c:vmd_acpi_find_companion() {
    ...
	bridge =3D pci_find_host_bridge(pci_dev->bus);
	busnr =3D pci_dev->bus->number - bridge->bus->number;
    ...
	addr =3D (busnr << 24) | ((u32)pci_dev->devfn << 16) | 0x8000FFFFU;

	return acpi_find_child_device(ACPI_COMPANION(bridge->dev.parent), addr,
				      false);
}

Both host bridges share &vmd->dev->dev as bridge->dev.parent, where the
relative bus number in the ACPI _ADR is the offset from VMD_BUS_0's start
bus (0xe0).  Because bridge->bus->number for VMD_BUS_1 is 0xe1, subtracting
bridge->bus->number yields busnr =3D=3D 0 for root ports on 0xe1 (matching
VMD_BUS_0's ACPI companion objects) and shifts all VMD_BUS_1 subordinate bus
_ADR lookups down by one.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106184256.4130=
-1-szymon.durawa@linux.intel.com?part=3D7
