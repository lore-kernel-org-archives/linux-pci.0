Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135E53C37AC;
	Tue, 26 May 2026 06:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778613; cv=none; b=CizYzpmNVY9clANh1xDR/AXP0yvQfYyageXJal9OaYcrGS8zFgArfpX5kixUfA5/UD15ia0m0qwHxLYuc/tWeGnYstCUSUkcpBpHx7yIgAX0ngv6xBoSMdX4cmjG9+fbYrYwDfLPJOM2iFSBmLn0Yzxry2sw14etWwLk2oDThJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778613; c=relaxed/simple;
	bh=+K/chcO6pUeQLrwQKaofRX7QkoTVWrLfLjv8QEGt4mQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxNPXBZFCoNDM5R2+9YSXp6HnK0cbVeK6osvyvxy8XJZMUUeKhsg/o/3KYyo4I3foNXG/Bn7STbLmR+Gu2g6zA7tPLD8Jk+7xCKFtQOTg6P/SVdPegDGULH61aY0BhTtzmRY2/wRNs6KmFHPbpY/PSrC5abchAQYEkz4Owt05i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCH/tOTF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCH/tOTF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B13D1F000E9;
	Tue, 26 May 2026 06:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779778611;
	bh=daydDheNrnDPiRdJK/Nx8S7fHjZOfOICOVi+Nn5bm3o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LCH/tOTFnmO8CS9l839BxSNyadZO/ayY3InS1iAjoUiIN3aHjGV71aOrmeW1qftVZ
	 DgMJwl7kgcmlGKoZLk2U9DJAXZQQXfn3YBMxD/JVu931N937fvNvXsbRJ3tjUtHEgL
	 LdekHz44rm6daeBKpD1pgiR1WU1zlssMwGxXlWrJDftQQ1sF+fYpPT1s+focu7djGY
	 SGBk01pHAungdGkC/32Js5VVaet8IUn3vv3lu23OpLVvht5wcotwwEPkX703jIqKoC
	 wnzOh7f04kJ/J8NtmghwIgUlNFUiNG7ZlIlcYvCbFtCuB4TLCCsRzlQuJFAfUwJiel
	 ebOCTw/oS2/tA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 6/6] vfio/pci: Add PCIe TPH control register
 virtualization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260526040830.52854-7-fengchengwen@huawei.com>
References: <20260526040830.52854-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 26 May 2026 06:56:51 +0000
Message-Id: <20260526065651.9B13D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The TPH configuration write handler silently drops valid byte-leve=
l writes, blocks ST Table config-space writes, and bypasses virtual configu=
ration space updates.
- [High] TPH state is lost and becomes unrecoverable after a device reset d=
ue to missing state synchronization.
- [High] `vfio_pci_tph_config_write` performs MMIO accesses without holding=
 `vdev->memory_lock`, racing with concurrent device resets.
--

commit e0337d4fe2416ad1997b3bae043a087facf49ef3
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH control register virtualization

Implement virtualized handling for PCIe TPH capability control register
writes. Validate and mediate user write requests to accept only valid TPH
mode configurations. Synchronize shadow steering tag table to hardware when
TPH gets enabled successfully.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index a10ed733f0e3a..188845f81626d 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> @@ -313,6 +317,39 @@ static int vfio_virt_config_read(struct vfio_pci_cor=
e_device *vdev, int pos,
>  	return count;
>  }
> =20
> +static int vfio_pci_tph_config_write(struct vfio_pci_core_device *vdev, =
int pos,
> +				     int count, struct perm_bits *perm,
> +				     int offset, __le32 val)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	u32 data =3D le32_to_cpu(val);
> +	u8 mode, req_en;
> +	int i, ret;
> +
> +	if (!enable_unsafe_tph)
> +		return count;
> +
> +	if (offset !=3D PCI_TPH_CTRL || count < 2)
> +		return count;

[Severity: High]
Does this silently drop valid 1-byte writes to the control register, or
writes to the upper bytes of the register (e.g. offset 0x09)? This might
break guests that perform byte-wise accesses.

Also, could this drop guest writes to the ST Table if it resides in the
capability space (offset >=3D 0x0C)?

Additionally, since this function returns without ever updating
vdev->vconfig via vfio_default_config_write() or similar, does this bypass
virtual configuration space updates entirely?

> +
> +	guard(mutex)(&vdev->tph_lock);
> +
> +	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, data);
> +	req_en =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, data);
> +	if (req_en) {
> +		ret =3D pcie_enable_tph(pdev, mode);

[Severity: High]
If pcie_enable_tph() succeeds, it updates the hardware register and sets
pdev->tph_enabled =3D 1. However, since pci_save_state() is not called here,
if a device reset occurs (e.g. via VFIO_DEVICE_RESET), the PCI core
restores the stale saved state where TPH is disabled, clearing the hardware
register.

Since pdev->tph_enabled remains 1 in software, wouldn't subsequent attempts
by the guest to re-enable TPH cause pcie_enable_tph() to immediately return
-EBUSY, permanently blocking the guest from using TPH after a reset?

> +		if (ret =3D=3D 0 && vdev->tph_st_shadow) {
> +			for (i =3D 0; i < vdev->tph_st_entries; i++)
> +				pcie_tph_set_st_entry(pdev, i,
> +						      vdev->tph_st_shadow[i]);

[Severity: High]
If the hardware ST table resides in the MSI-X table, pcie_tph_set_st_entry()
may perform MMIO writes. Since this is executed holding only
vdev->tph_lock, could this race with a concurrent device reset (which
acquires down_write(&vdev->memory_lock) to block MMIO accesses and disables
memory decode)?

Without holding down_read(&vdev->memory_lock) here, could these MMIO writes
interleave with the physical reset or occur while memory decode is disabled,
causing Master Aborts?

> +		}
> +	} else {
> +		pcie_disable_tph(vdev->pdev);
> +	}
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526040830.5285=
4-1-fengchengwen@huawei.com?part=3D6
