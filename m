Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B940D596;
	Tue, 23 Jun 2026 09:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205985; cv=none; b=Wj+5SN7CFYBWtWemi7o0aG7v0PlkwWJv7+H+CY7OkJ9pGceefKgwUDyV27yfzl4n2Lp0OcfZ4cEgIgdGhF+yI2dCC3UAblKYpIQsxz+tw5GLcTt700A0DU8k6K5AcoldXEk8MNaS1/ZANsgL+KmlqSn1yjPCIsWjcH1mljU3sVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205985; c=relaxed/simple;
	bh=Ofqcxxm1ej38nmG+LBaSt7lj67gWAkaPgKLpcYrWrow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LRK6IytJmXpJMc0PqVDi4jhBxCb46kr3Yas7ujNkVFRJeJxvL+avqHnMtVp+atDQ4ZXchL6eXZ/vZ5zJQ1qw1QFHNY1wbId6joE8A2+NXak1A2KZPwvvsW8CHoeookjCwCSat6L6uAF7vwQiBO+VwerlF55THwmEhwMaBymDZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBFmF+rv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBFmF+rv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4471F00A3A;
	Tue, 23 Jun 2026 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782205984;
	bh=O6joF6ACs28Jn9QPTQutw3nRysiqFFNqHQTpGsZ48BE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oBFmF+rvtSS3I7RwzCTM15adeN5v8xbO5w3D2kw13Jm1cjFoCELAT0ng1b8yUbpVV
	 I2F0za2mnFbzNISgN9GRXDhEoWv2L079Cti5vKLTPnQFCWmw2o6ttpnWFvL/GHzEn6
	 wucA3t+B9gOVz42SYzU2kQXfFIR4DSKmXaaitVRKjwciH5dOjU07Iph48nf49NkGyt
	 /oToKksxoZfUR+6VV0TIrHPGVkm63xKHSjiz0FCKQZkSMZCI1xWHW7NMDH3KsbbUax
	 /5FDa6jCcvq7Sbp1DtIyxJKz2M9MpD3KOY2r/d+PJUQGZBcrKgd143uI2Fq5xA4qsa
	 9qtE9RcjGBsTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND v18 12/12] vfio/pci: Virtualize PCIe TPH
 capability registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260623085048.51139-13-fengchengwen@huawei.com>
References: <20260623085048.51139-1-fengchengwen@huawei.com>
 <20260623085048.51139-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 09:13:03 +0000
Message-Id: <20260623091304.5B4471F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unchecked return value from `pcie_tph_set_st_entry()` causes sta=
te desynchronization between the virtual config space and physical hardware.
--

commit 94cd790796325d732c4348b7bef18a12078f330c
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

This commit virtualizes the TPH extended capability config space registers.
It splits permissions, blocks direct ST-table programming via config space,
and syncs the cached shadow ST table to physical hardware when the TPH
requester is enabled.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 5c6ab172df6c0..10f4e9fabea7c 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c

[ ... ]

> +static int vfio_tph_config_write(struct vfio_pci_core_device *vdev, int =
pos,
> +				 int count, struct perm_bits *perm,
> +				 int offset, __le32 val)
> +{

[ ... ]

> +	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH) {
> +		extended =3D !!(req =3D=3D PCI_TPH_REQ_EXT_TPH);
> +		ret =3D pcie_enable_tph_explicit(pdev, mode, extended);
> +		if (!ret && vdev->tph_st_shadow) {
> +			for (i =3D 0; i < vdev->tph_st_entries; i++)
> +				pcie_tph_set_st_entry(pdev, i,
> +						      vdev->tph_st_shadow[i]);

[Severity: Medium]
Should this loop check the return value of pcie_tph_set_st_entry()?

If syncing the Steering Tag (ST) table fails (for example, due to MSI-X
table access errors), pcie_tph_set_st_entry() disables TPH on the physical
hardware and returns an error code.=20

Because the return value is ignored here, it skips the rollback of the
virtual config space that would happen if ret was updated.

Could this result in the guest OS incorrectly believing TPH is enabled,
leading to an inconsistent state between the physical hardware and the
virtual config space?

> +		}
> +		if (ret)
> +			vfio_default_config_write(vdev, pos, count, perm,
> +						  offset, org_val);
> +	} else if (req =3D=3D PCI_TPH_REQ_DISABLE) {
> +		pcie_disable_tph(vdev->pdev);
> +	} else {
> +		vfio_default_config_write(vdev, pos, count, perm, offset,
> +					  org_val);
> +	}
> +
> +	up_write(&vdev->memory_lock);
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623085048.5113=
9-1-fengchengwen@huawei.com?part=3D12
