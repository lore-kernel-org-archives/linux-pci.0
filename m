Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503C83AB5DE;
	Thu,  4 Jun 2026 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581911; cv=none; b=ulvXfMK62n2ZYDDoc/sn3nHwzxTUN8gYBQ2iw+ZaM2E7g+SzWKjzDpFfaZeOnL1s6sRBskFutPjFQj4oSlrx0OEkLfsOobNpkGYq2M+sAGE+ThXwdgm/i3HdJh6jL+OLrew7Fcdmz9Nt9y75WmqzOaXE28omBs5HrWPQMk5xMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581911; c=relaxed/simple;
	bh=uA3QTIUbYRKd5dS/NLgKkZbJw1ug9x9DOslMSgeVzEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oB7r8xmSAgABE9tlYDcghnyyAoealgAaZR7Vwq9uQSsQmov7OpjDAL1EHstjBE0mXW3Junhop4x8rDTp16n//8sFGeLabOx2a77wXnS6qswCxfNomHplG+ya/k5dPYkUamLKeDyHUfAHbtfsj+ZNlNQvNj2PbaYxARyadCmjwok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy3myV5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy3myV5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1A41F00893;
	Thu,  4 Jun 2026 14:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581909;
	bh=eY9rAekhErGVAalBijf5j11yUwa1urlhbwaFyfTFwx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cy3myV5nHuJrpd5DzxJlsThDMchJJQkdJpF/vBxYjBhCtptfyCqE4I8R9DG3FLwX+
	 GA1z/jjuDxy+HVTk59xj3OwHiQ50Sr3CMegtvB2kFZw7ICm1i0E5c5LVuKM77TL6Lk
	 TVJZImjEjD9iwyRzQi/YkgxV2oaPlooTWvYe2NVvzC618+XPz5kBoNc1BjsLa4TUL8
	 NunP8PdcjCB4dqkpdbrJzm8F82CJNAIhTPZgDHMNG1B9wB+ImmkyOd9wMVG+k9tdSL
	 by2QW7NdUhBsZXv9v5ulW+K+1BZhA0TbsV/M+4JK3XGm2dFVVpKg+0C83JackmU//Z
	 DSOHiUIKXl0DQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 12/12] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604132804.28678-13-fengchengwen@huawei.com>
References: <20260604132804.28678-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 14:05:09 +0000
Message-Id: <20260604140509.BF1A41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Concurrent config writes cause Double-Free/Use-After-Free in p=
ower management saved state.
- [High] Missing virtual configuration rollback on power state transition f=
ailure.
- [High] Missing virtualization of TPH Capability Header leaks the physical=
 Next Capability Pointer to the guest.
- [High] Race condition (TOCTOU) allows concurrent config writes to corrupt=
 virtual state and silently lose write requests.
- [Medium] Silent failure when programming TPH shadow ST table entries into=
 hardware.

Pre-existing issues:
- [High] Out-of-bounds write in extended capability parsing loop due to mis=
sing boundary checks.
--

commit 32f3411184cca80f87b3f32db73925b8e64d5792
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

This commit virtualizes TPH extended capability registers, splitting
permissions so the header is read-only and the control register is writable.
It restricts ST-table programming to a specific feature and syncs the
cached shadow table to hardware upon enablement.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 5c6ab172df6c0..23c32aa5842fa 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1086,6 +1086,109 @@ static int __init init_pci_ext_cap_pwr_perm(struc=
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
> +		return -ENOMEM;
> +
> +	p_setd(perm, PCI_TPH_CAP, ALL_VIRT, NO_WRITE);

[Severity: High]
Does this miss virtualizing the TPH Capability Header at offset 0?

Other capabilities use p_setd(perm, 0, ALL_VIRT, NO_WRITE) to ensure the
guest reads the virtualized header instead of the physical one. Without thi=
s,
could guest reads to the TPH capability header fall through to physical
hardware, leaking the physical Next Capability Pointer and breaking VFIO's
ability to hide capabilities?

[ ... ]

> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int =
pos,
> +				 int count, struct perm_bits *perm,
> +				 int offset, __le32 val)
> +{
> +	int req_en_byte =3D PCI_TPH_CTRL + 1;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	__le32 org_val =3D 0;
> +	bool extended;
> +	u8 mode, req;
> +	int i, ret;
> +	u16 start;
> +	u32 data;
> +
> +	if (!vdev->tph_permit)
> +		return count;
> +
> +	/* Back up the original values in order rollback when fail */
> +	if (offset <=3D req_en_byte && offset + count > req_en_byte)
> +		vfio_default_config_read(vdev, pos, count, perm, offset,
> +					 &org_val);
> +
> +	ret =3D vfio_default_config_write(vdev, pos, count, perm, offset, val);
> +	if (ret !=3D count)
> +		return ret;

[Severity: High]
Can this create a race condition where concurrent writes corrupt the virtual
state?

Modifying vconfig via vfio_default_config_write() happens before acquiring
vdev->tph_lock. If two threads concurrently write to the control register,
both modify vconfig unprotected. If the first thread acquires the lock but
fails to program hardware, its rollback would blindly overwrite the second
thread's new state in vconfig.

When the second thread subsequently acquires the lock, wouldn't it read the
reverted vconfig value (the first thread's old state) and write it to
hardware, effectively discarding the second thread's write while returning
success?

> +
> +	/* Skip if write range does not cover Requester Enable byte */
> +	if (offset > req_en_byte || offset + count <=3D req_en_byte)
> +		return count;
> +
> +	ret =3D vfio_pci_set_power_state(vdev, PCI_D0);

[Severity: Critical]
Does calling vfio_pci_set_power_state() without a serializing lock expose a
double-free vulnerability?

If a guest VM concurrently writes to the TPH control register while the
physical device is in D3hot, both threads can evaluate needs_restore =3D tr=
ue.
After the first thread transitions the device to D0, both threads will
concurrently execute pci_load_and_free_saved_state(pdev, &vdev->pm_save).

Since pci_load_and_free_saved_state() has no internal locking and directly
frees the shared pointer, could this concurrent execution cause a double-fr=
ee
in the host kernel?

> +	if (ret)
> +		return count;

[Severity: High]
Is a rollback of the virtual configuration missing in this error path?

If the power state transition fails, the function returns count (indicating
success to userspace) but fails to roll back vconfig using the org_val back=
ed
up earlier. Doesn't this leave vconfig falsely indicating that the TPH
Requester is configured while the physical hardware remains unprogrammed?

> +
> +	mutex_lock(&vdev->tph_lock);
> +
> +	start =3D vfio_find_cap_start(vdev, pos);
> +	data =3D le32_to_cpu(*(__le32 *)&vdev->vconfig[start + PCI_TPH_CTRL]);
> +	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
> +	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
> +
> +	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH) {
> +		extended =3D !!(req =3D=3D PCI_TPH_REQ_EXT_TPH);
> +		ret =3D pcie_enable_tph_explicit(pdev, mode, extended);
> +		if (!ret && vdev->tph_st_shadow) {
> +			for (i =3D 0; i < vdev->tph_st_entries; i++)
> +				pcie_tph_set_st_entry(pdev, i,
> +						      vdev->tph_st_shadow[i]);

[Severity: Medium]
Should the return value of pcie_tph_set_st_entry() be checked here?

If programming any ST entry fails, such as from hardware rejection or
inaccessible registers, the failure appears to be silently ignored. Could
this leave the hardware partially programmed while userspace is told the
operation succeeded?

> +		}

[ ... ]

> @@ -1704,6 +1810,8 @@ static int vfio_ecap_init(struct vfio_pci_core_devi=
ce *vdev)
>  		ret =3D vfio_fill_vconfig_bytes(vdev, epos, len);

[Severity: High]
This is a pre-existing issue, but could this capability parsing loop allow
out-of-bounds heap corruption?

If a malicious hardware device or hotplugged peripheral provides a malformed
capability list with a large length near the end of the PCIe config space,
epos + len can exceed pdev->cfg_size. This would cause a buffer overflow in
memset() and vfio_fill_vconfig_bytes(), corrupting the heap-allocated
vdev->pci_config_map and vdev->vconfig buffers.

>  		if (ret)
>  			return ret;
> +		if (ecap =3D=3D PCI_EXT_CAP_ID_TPH && !hidden)
> +			vfio_tph_mask_ext_tph_bit(vdev, epos);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132804.2867=
8-1-fengchengwen@huawei.com?part=3D12
