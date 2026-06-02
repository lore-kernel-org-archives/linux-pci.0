Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2B83E075C;
	Tue,  2 Jun 2026 15:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412759; cv=none; b=KT6tu9S0PenCtCfuIyMbZs9L26ihle7kW9dsSvCBEwyc26p5LuQkSHM9d0U07WsW3az1nm1n457A3FObE/ua0q0SsPGHWRlA8Ivlq725Bl9vvnGnDfroyLk+m5JXgIo+2bOA+QDs5lVT6EEemW09oxEabQZNAjnQqSGIiu7KbAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412759; c=relaxed/simple;
	bh=3XexjlArPdg2pxr8Uoa9i85f4sbtywDra//oBXRXwiM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fEfCO0mdP2wiRMQZ2yGZ/x8RPiOS+dOEPGhjeIJugRKdYxCw41bwtiHx1wyHDeh6kQJhxGIfbdI8mZe3AF7IhVgVX0h54nH5GZ1UxSYlLR4++m8cc4bunwejLpPOuc4a6ieygydpiXbfWt2MPyf6cPkbpulEBpUywRVZSY6qOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjHTzUeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjHTzUeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F21B1F00893;
	Tue,  2 Jun 2026 15:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412756;
	bh=mzcjlG4EE45Z41dE0Z39X0U0oVGWPPNB6DrZ1+yxcg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UjHTzUeC1WHiVVzXhGCMb21qbWxhpfme8iF5am9yDotsQABQ3ZmUWH6qdAM8JiBSe
	 fMzXpxnwrrV7vhH9hzWA1/pODOPXfDmBD9ijnkgFQD/E+SNH1+1Fd4agxnVuEOTsI9
	 YKQA/XChVvJui4hc7evEh7Io9hyHa0kQEOvsCmKVPK+9xv254Lp/ZH9wg33i+zlF8J
	 Wq1tgOkj8A43OCBA/eBgUMhrwumhniMraE51czmH0F2OGMk8485sr+/9TWgOyjY7TC
	 s+eZo0K/6iDUmZy6bsNZ9TqQqyKp00mfLfve4bj4jx95g3FpbbxOUSKa1WRo+wYjQb
	 gWP+uG5hLOEqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/10] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260602144023.25254-11-fengchengwen@huawei.com>
References: <20260602144023.25254-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jun 2026 15:05:55 +0000
Message-Id: <20260602150556.0F21B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] Heap buffer overflows and Out-Of-Bounds (OOB) accesses due to =
unbounded TPH capability length calculation.
- [High] Missing synchronization of guest Steering Tag (ST) table writes ca=
uses hardware to be programmed with zeroes.
- [High] Partial (1-byte) writes to the TPH control register are silently d=
ropped, preventing TPH enablement.
- [High] PCIe protocol violation: Steering Tag (ST) table is modified while=
 TPH is actively enabled.
- [Medium] Error returns from physical TPH enablement functions are silentl=
y ignored.
- [Low] Global variable declared as `extern` in a C file instead of a share=
d header.
--

commit 108833646583e89dbe04c9e7d07acc6d639f0bf4
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

Implement TPH ext cap register virtualization:
1. Read: Mask EXT_TPH bit in vconfig if unsupported; mark CAP read-only
   virtual.
2. Write: Apply update to vconfig first then sync hardware via core TPH
   APIs. Sync shadow ST to HW after TPH enable with device power/memory
   check.

Disable stale TPH before save_state on open, disable active TPH before
restore on close to avoid cross-session leakage. Hide TPH cap entirely
unless enable_unsafe_tph is set.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..24614a4a52646 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -35,6 +37,8 @@
>  	((offset >=3D PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) ||=
 \
>  	 (offset >=3D PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
> =20
> +extern bool enable_unsafe_tph;
> +

[Severity: Low]
Does this violate the kernel coding style?=20

Global variables should generally be declared in a shared header file rather
than using an extern declaration directly in a C file to ensure type safety
across translation units.

[ ... ]

> @@ -1085,6 +1089,100 @@ static int __init init_pci_ext_cap_pwr_perm(struc=
t perm_bits *perm)
>  	return 0;
>  }
> =20
> +/* Permissions for TPH extended capability */
> +static int __init init_pci_ext_cap_tph_perm(struct perm_bits *perm)
> +{
> +	int i;
> +
> +	if (alloc_perm_bits(perm, pci_ext_cap_length[PCI_EXT_CAP_ID_TPH]))

[Severity: Critical]
Can this cause out-of-bounds accesses?=20

The permission arrays are allocated to a fixed size of 256 bytes here=20
(pci_ext_cap_length[PCI_EXT_CAP_ID_TPH] is 0xFF). However, the capability=20
length calculated dynamically in vfio_ext_cap_len() can be much larger if a=
=20
device advertises a large ST Table Size. Accesses beyond 256 bytes will=20
overflow the perm->virt and perm->write arrays.

> +		return -ENOMEM;
> +
> +	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);

[ ... ]

> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int =
pos,
> +				 int count, struct perm_bits *perm,
> +				 int offset, __le32 val)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	bool extended;
> +	u8 mode, req;
> +	int i, ret;
> +	u32 data;
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	ret =3D vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	if (ret !=3D count)
> +		return ret;
> +
> +	/*
> +	 * TPH_CTRL (offset 8) register layout:
> +	 *   Byte 0 (offset 8): Bits [2:0] - ST Mode selection
> +	 *   Byte 1 (offset 9): Bits [1:0] - TPH Requester enable
> +	 *
> +	 * Only intercept writes with count >=3D 2 which cover both control
> +	 * fields. Single-byte partial writes do not affect combined
> +	 * configuration.
> +	 */
> +	if (offset !=3D PCI_TPH_CTRL || count < 2)
> +		return count;

[Severity: High]
Does this logic inadvertently drop valid guest writes to the ST table and
Requester Enable fields?

By returning early if offset !=3D PCI_TPH_CTRL || count < 2, ST table write=
s=20
(offset >=3D 12) are completely bypassed from hardware synchronization.=20

Additionally, if a guest issues a valid 1-byte write to offset 9 to enable=
=20
TPH (the Requester Enable field), the count < 2 condition evaluates to true=
,=20
causing the hardware to remain disabled despite the virtual config space=20
indicating otherwise.

> +
> +	ret =3D vfio_pci_set_power_state(vdev, PCI_D0);
> +	if (ret)
> +		return count;
> +
> +	mutex_lock(&vdev->tph_lock);
> +
> +	data =3D le32_to_cpu(val);
> +	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
> +	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
> +
> +	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH) {
> +		extended =3D !!(req =3D=3D PCI_TPH_REQ_EXT_TPH);
> +		ret =3D pcie_enable_tph_explicit(pdev, mode, extended);

[Severity: Medium]
What happens if the physical hardware rejects the TPH configuration?=20

The return value in ret is captured but the function ultimately returns=20
count unconditionally at the end. Since the virtual config space is already=
=20
updated by vfio_default_config_write(), this leaves the guest OS falsely=20
believing TPH is enabled, causing a desynchronization with the hardware.

[Severity: High]
Is it safe to program the Steering Tag (ST) table after enabling TPH?

According to the PCIe Base Specification, software must not modify an ST=20
Table entry while the TPH Requester Enable field is set. However,=20
pcie_enable_tph_explicit() enables TPH before the loop below programs the S=
T=20
table entries via pcie_tph_set_st_entry(). This incorrect ordering violates=
=20
hardware programming rules and might lead to faults.

> +		if (!ret && vdev->tph_st_shadow) {
> +			for (i =3D 0; i < vdev->tph_st_entries; i++)
> +				pcie_tph_set_st_entry(pdev, i,
> +						      vdev->tph_st_shadow[i]);

[Severity: High]
Does this program the hardware with empty ST table entries?=20

Since guest ST table writes were bypassed earlier, vdev->tph_st_shadow is=20
never populated with the guest's writes. When the guest enables TPH, the=20
hardware is programmed using the zeroed shadow array rather than the actual=
=20
guest configuration.

> +		}
> +	} else if (req =3D=3D PCI_TPH_REQ_DISABLE) {
> +		pcie_disable_tph(vdev->pdev);
> +	}
> +
> +	mutex_unlock(&vdev->tph_lock);
> +
> +	return count;
> +}

[ ... ]

> @@ -1450,6 +1551,9 @@ static int vfio_ext_cap_len(struct vfio_pci_core_de=
vice *vdev, u16 ecap, u16 epo
>  		byte &=3D PCI_DPA_CAP_SUBSTATE_MASK;
>  		return PCI_DPA_BASE_SIZEOF + byte + 1;
>  	case PCI_EXT_CAP_ID_TPH:
> +		if (!enable_unsafe_tph || !pcie_tph_supported(pdev))
> +			return 0;
> +
>  		ret =3D pci_read_config_dword(pdev, epos + PCI_TPH_CAP, &dword);

[Severity: Critical]
Could this length calculation introduce a regression without bounds checkin=
g?=20

Further down in this function, the capability length is dynamically=20
calculated based on the hardware-provided ST Table Size field:

    sts =3D dword & PCI_TPH_CAP_ST_MASK;
    sts >>=3D PCI_TPH_CAP_ST_SHIFT;
    return PCI_TPH_BASE_SIZEOF + (sts * 2) + 2;

If a malicious or buggy physical device advertises a large size, the=20
calculated length can reach up to 4108 bytes. In vfio_ecap_init(), this=20
unbounded length can overflow the 4096-byte map and vconfig heap allocation=
s.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260602144023.2525=
4-1-fengchengwen@huawei.com?part=3D10
