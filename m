Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B324973AC
	for <linux-pci@vger.kernel.org>; Mon, 21 Sep 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790001244; cv=none; b=FHYTyFaBw4t2mNcnAZ25LK9VHPiBU7DNmnbJaqYPrM3Xb8TqpDt2xhRd2r6KS6e5T4W3+W7xt83I/c1x9iEduHrBtE6M5Q1MBxIyVB8029mbPtQ4HvFx++AxGm15jj/hoDkh20EHXACyTXoTRCa6pJbwODG3MT5FX+aqwUz64zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790001244; c=relaxed/simple;
	bh=tetRSr8SNsky91gxjQ+TOKUr7Sf1nWiXbR9eyXu76dk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sT24664ELJthOU32ems+kR1hnkHZkJfEOCoDiGBK73zoQ2kFbqDfTKpp7LvK7uYw5BsXhvv5Mn8r7fQYuoW2+r4dLi9P8H7EavWVRqzQdQwtza7s7b33N8PMKYzZVgc6N9SfZoChs0svXVe3iEY9SGEy6F3IjYXpU7JXaB4yv1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFKGtrOk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFKGtrOk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 055851F000FF;
	Mon, 21 Sep 2026 14:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790001243;
	bh=9dpDQDLQkw+/NDyfHu/Vs1sdGLF9uus5VESzw0NcCzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DFKGtrOk9Cp8gW/RSjUmKiLUK3YSDD3nsvkSeD4koy5lx2Qq/E1Wf6iJdOVS02su3
	 zZwZtjgRnSTnoxXGBMFmOSIhFPRNDtx4nA1I/p21qTkSnCiYdSVzlPyIeYdzircSvn
	 gy9IcDPO9+N+MquIsuKjxSYWCXWYOrXNqieSDSD+zHQqUTQAw80HWDMke31Ne9n2oD
	 ecqbkwHXb919vFUr4QO2btgLMjNqUgo7E2e3US/4VYE9DQt9cteBHGc1QAtY28lldp
	 yANxw5WBeOJp0/DJ6e+13g5Tc1rzlSUAIt/mztRTrkUYOAVbA/BwxyQXqtuOl5y9ue
	 9hMMfq+3KfG9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 8/8] PCI: vmd: Workaround for hardwired BUS1 bus
 number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Szymon Durawa" <szymon.durawa@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260921164316.3860312-9-szymon.durawa@linux.intel.com>
References: <20260921164316.3860312-1-szymon.durawa@linux.intel.com>
 <20260921164316.3860312-9-szymon.durawa@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 14:34:02 +0000
Message-Id: <20260921143403.055851F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] pci: vmd: fake root bus number 0x80 causes resource conflict and b=
reaks hotplug
--

commit 96fa114ac906af61b74b8a37fc6def3f417dbf5b
Author: Szymon Durawa <szymon.durawa@linux.intel.com>

    PCI: vmd: Workaround for hardwired BUS1 bus number

This commit implements a workaround for the VMD BUS1 root bus number being
fixed to 0x80 in hardware. It overrides the root bus number in vmd_create_b=
us()
and attempts to handle the translation during config accesses and ACPI matc=
hing.

> diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
> index 51b8c2d9b7f0b..91c5b02bf91d1 100644
> --- a/drivers/pci/controller/vmd.c
> +++ b/drivers/pci/controller/vmd.c
> @@ -467,10 +467,23 @@ static unsigned int vmd_bus_to_ecam(struct vmd_dev =
*vmd, unsigned int busnr)
>  static void __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *b=
us,
>  				  unsigned int devfn, int reg, int len)
>  {
[ ... ]
> +	if (vmd->bus1_rootbus && bus->number =3D=3D VMD_PRIMARY_BUS1)
> +		bus_number =3D vmd->busn_start[VMD_BUS_1];
> +	else
> +		bus_number =3D bus->number;

[Severity: High]
Does this break configuration space accesses for dynamically assigned downs=
tream
bus numbers?

During dynamic bus assignment like hotplug or SR-IOV on root ports behind
VMD BUS1, the PCI core sees 0x80 as the parent bus number and assigns child
buses starting from 0x81 instead of the physical downstream window (e.g., 0=
xE1).

When accessing these dynamically assigned buses, this code falls through to=
 the
untranslated bus->number (e.g., 0x81). It then subtracts the physical ECAM
start (e.g., 0xE0) from 0x81, leading to a massive unsigned underflow
(0xFFFFFFA1).

This out-of-bounds offset will cause vmd_cfg_addr() to return NULL, silently
breaking all configuration accesses.

[ ... ]
> @@ -1188,6 +1223,7 @@ static int vmd_create_bus(struct vmd_dev *vmd, enum=
 vmd_rootbus bus_number,
>  			  struct pci_sysdata *sd, resource_size_t *offset,
>  			  bool vmd_in_guest, u8 primary)
>  {
[ ... ]
> +	/*
> +	 * Workaround: set VMD_BUS_1's bus number to VMD_PRIMARY_BUS1 so it
> +	 * matches vmd->bus[VMD_BUS_1]->primary and bypasses bus number
> +	 * reconfiguration.
> +	 */
> +	if (bus_number =3D=3D VMD_BUS_1 && vmd->bus1_rootbus)
> +		root_busnr =3D VMD_PRIMARY_BUS1;

[Severity: High]
Does overriding the root bus number to 0x80 here initiate a resource confli=
ct
that breaks the dynamic allocator's base range?

By overriding the BUS1 root bus number to 0x80 instead of its physical ECAM
base (e.g., 0xE1), pci_register_host_bridge() requests the bus resource ran=
ge
[0x80-0xFF]. This overlaps with BUS0's physical range (e.g., [0xE0-0xF0]).

pci_bus_insert_busn_res() detects this conflict and fails to attach the bus
resource of BUS1 to the domain, breaking hotplug and SR-IOV completely on
VMD BUS1.

> +	else
> +		root_busnr =3D vmd->busn_start[bus_number];
> +
> +	vmd_bus =3D pci_create_root_bus(&vmd->dev->dev, root_busnr, &vmd_ops, s=
d,
>  				      &resources);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921164316.3860=
312-1-szymon.durawa@linux.intel.com?part=3D8
