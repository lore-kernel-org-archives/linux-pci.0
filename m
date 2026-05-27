Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB126CE11;
	Wed, 27 May 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890445; cv=none; b=CFPiF8A6gBpbOUazNQaGAhRaS1Ea9g1AONFkMaBsrvMV+WxCsCM1uqsoO50iIGXpV32DBkWr0XQpRTJ+MPY7BTgFbbHjpMWATGIWPFwkwqCCwJP9QmnE25+WDzohzdwrDvrhxdpZ5UByM1+YgVH4L7wBRZjy6PbS/7dP/F7ZaLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890445; c=relaxed/simple;
	bh=RgYLm0neXHaOUmS8HjXVx4g4nVnS8LbFqtbXrEMNpvU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bs5KsTxIh41I7TZ2TXNkgCNS5Z7tH9tH5Rbc7FJ+3/Zp6tWM9G7fGXVoZA79zsT7gaFzpMdTr+7O9M+pX+ONBibqiqN2UKOqHTajIgXE1zrnIibyzk2aZC8g6IfTjdLTXPmf+GTd3rrtdmuKKBNoXE0rQFUu4KUuHr1IjNot5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diRZGXiJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diRZGXiJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144C21F000E9;
	Wed, 27 May 2026 14:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890443;
	bh=nnV4YXKJfYHyAfxRAhVW3bNbXbpn5GT0V7zzObAG/mE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=diRZGXiJ5GihVQS9GokK+5+3VnNcn8P+rV9aDMo78yM+p69WoMrMDfrV8D7xogQ5o
	 llqgzvJe2i8nFj5IDGx/oMC8ge14YpfO3ZfUKq6s2APNQkkAvy/wn6OLidWpXjthZQ
	 w84M66ym7ChgacwVl6crL7olCsCXhTmyxe6eGl6De6F+Tef699HI7bczEsAZSTnmpJ
	 ftDRRgV4bZMSEtKRvnX7eM738Nh3f4w4HvbHdXccaxnuaOy6lwm92b7dkZSQY/BZDM
	 +E6/jSQoPoLCA04JlvLTJgDuLm+0uyjFFO8tJY8orrkZ9VcpC0r+9Hp6B8gXFNmHVH
	 fA9VjOKrBSY/g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 8/8] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260527094719.43886-9-fengchengwen@huawei.com>
References: <20260527094719.43886-9-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 14:00:42 +0000
Message-Id: <20260527140043.144C21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Failure to clear software shadow state (`vdev->tph_st_shadow`) on =
device release allows cross-VM state leakage.
- [Medium] `vfio_pci_tph_config_write` incorrectly drops valid partial writ=
es to the TPH Control Register.
- [Low] Incorrect bounds check (`offset + count < target_byte`) in `vfio_pc=
i_tph_config_read` causes out-of-bounds byte masking.
- [Low] The global variable `enable_unsafe_tph` is declared using `extern` =
directly in a .c file.
--

commit 1386cbe8efd9ebb31a3a570e82dded7da344b1be
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers
   =20
Implement read/write virtualization for PCIe TPH Extended Capability by
masking out extended requester bits when unsupported and validating TPH mode
configuration. Automatically disable TPH during device ownership handover
and introduce an enable_unsafe_tph module parameter.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..518a6afa7ada1 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -35,6 +37,8 @@
>  	((offset >=3D PCI_BASE_ADDRESS_0 && offset < PCI_BASE_ADDRESS_5 + 4) ||=
 \
>  	 (offset >=3D PCI_ROM_ADDRESS && offset < PCI_ROM_ADDRESS + 4))
> =20
> +extern bool enable_unsafe_tph;
> +

[Severity: Low]
Is it intended to declare this module parameter using extern directly in the
C file? Usually, these are placed in a shared header file to ensure type
safety and consistency across the module.

>  /*
>   * Lengths of PCI Config Capabilities
>   *   0: Removed from the user visible capability list

[ ... ]

> @@ -313,6 +317,68 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
e_device *vdev, int pos,
>  	return count;
>  }
> =20
> +static int vfio_pci_tph_config_read(struct vfio_pci_core_device *vdev, i=
nt pos,
> +				    int count, struct perm_bits *perm,
> +				    int offset, __le32 *val)
> +{
> +	const int target_byte =3D PCI_TPH_CAP + 1;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	const u8 ext_bit =3D BIT(0);
> +	int byte_off;
> +	u8 *data;
> +	int ret;
> +
> +	if (pdev->tph_ext_requester || offset > target_byte ||
> +		offset + count < target_byte)

[Severity: Low]
Does this bounds check properly exclude reads that end exactly before the
target byte?

If a read happens with offset =3D 4 and count =3D 1, and target_byte =3D 5,=
 then
offset + count < target_byte evaluates to 5 < 5, which is false. This causes
the code to proceed and modify data[byte_off] outside the requested read
window.

Should this be offset + count <=3D target_byte instead?

> +		return vfio_direct_config_read(vdev, pos, count, perm,
> +					       offset, val);
> +
> +	ret =3D vfio_direct_config_read(vdev, pos, count, perm, offset, val);
> +
> +	/* Mask out TPH requester capability */
> +	byte_off =3D target_byte - offset;
> +	data =3D (u8 *)val;
> +	data[byte_off] &=3D ~ext_bit;
> +
> +	return ret;
> +}
> +
> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, =
int pos,
> +				     int count, struct perm_bits *perm,
> +				     int offset, __le32 val)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 data =3D le32_to_cpu(val);
> +	enum tph_req_policy policy;
> +	u8 mode, req;
> +	int i, ret;
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	if (offset !=3D PCI_TPH_CTRL || count < 2)

[Severity: Medium]
Does this check unintentionally drop valid partial writes to the TPH Control
Register?

The PCIe specification allows configuration space accesses in 1, 2, or 4-by=
te
sizes. If a guest OS writes 1 byte to the PCI_TPH_CTRL register, count < 2
is true, and the function returns without updating the hardware or virtual
state.

> +		return count;
> +
> +	guard(mutex)(&vdev->tph_lock);

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 01c8396b9ffed..47d20f17ff656 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -656,6 +659,9 @@ void vfio_pci_core_disable(struct vfio_pci_core_devic=
e *vdev)
>  	 */
>  	vfio_pci_set_power_state(vdev, PCI_D0);
> =20
> +	/* Clear TPH status when releasing ownership */
> +	pcie_disable_tph(pdev);
> +

[Severity: High]
Should vdev->tph_st_shadow also be cleared here during device release?

While pcie_disable_tph() disables TPH in the hardware, the shadow state in
vdev->tph_st_shadow appears to persist. If the device is reassigned to a
new VM and that VM enables TPH, vfio_pci_tph_config_write() will program
the hardware using the previous VM's steering tags stored in the uncleared
shadow state.

Could this lead to cross-VM state leakage where the new VM implicitly uses
the previous VM's steering tags?

>  	/* Stop the device from further DMA */
>  	pci_clear_master(pdev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527094719.4388=
6-1-fengchengwen@huawei.com?part=3D8
