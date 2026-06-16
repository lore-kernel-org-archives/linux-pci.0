Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC718357CEB;
	Tue, 16 Jun 2026 11:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607800; cv=none; b=bzQfI0HVt0u/uz+Zai4LPPvueYdZjmjxomKxfiOOJ3hfZXpPej4klpE37Ok2HV5DpaMftGJggMeg/F+x4LBY2fEfNLYB2vla0YvczEe9GSytL4gasosU0vQdRt51VXyaPBstkM5WE0lzkxgf7POLRqLktaHU4rEbxTZLwBJq6yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607800; c=relaxed/simple;
	bh=eSS8kA0RFxAOTZSfoY158TWQmE5dLERfhk13bixycPM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fWTj/XOb5zH9RfXHa3jA2Cb6dYTbWVo1E3511LGqcjZcYF4O77xaBF+01F9RDhVLvIpW2kdTJ4Tf4ibC4KF4bEhAjfgLQaIU1MLAZc4a6PvXk2VfDq9DKRHqG0uaDVHhLNuKD3SbqfQf7A+vltW/kQRqrUdpNvOC8f0jOaEL0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUnaHlM+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUnaHlM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE361F000E9;
	Tue, 16 Jun 2026 11:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781607799;
	bh=N0fq8vYpC1dwiPgtlYSIBRuKY8OuVIbMbNHQXQqaG+M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WUnaHlM+KOWG7cjr0PeTdn8Zi9w3GsCdhCeqzE66lHOS3RLHNzgq+b3wpKN7jvCdw
	 xlGlKhS/WSHGJPa2XnsXf62VK+pUsGJCN0oMIIfGd1qc5q2pOtYNGShjBhV5VW/VOX
	 X+/pA6Mvx25grpgviZ2p5dtPyoQSMmUErCOxatMaE9MsX/FwtjiocpYHSneQ2gALba
	 smqX9VgllYhmaI77FaLtlEvdVrbJMrNPDHBvnrmBN3gRgt4f0MaFUOxj7Wyl8dYS14
	 xmS/Yqe1qgZTri9NsYWt2pN6rSN0osKubtKwehiZh3dHxnKUqf/8h8nqKJjftJL3Kh
	 qeX0niyyuQ8VA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 12/12] vfio/pci: Virtualize PCIe TPH capability
 registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260616104621.41915-13-fengchengwen@huawei.com>
References: <20260616104621.41915-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 11:03:18 +0000
Message-Id: <20260616110319.2BE361F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Silent state desynchronization between hardware TPH and virtual co=
nfig due to missing error handling for ST entry updates.
--

commit 22993c676c19c404abf1528141d0dd0e78a51f99
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Virtualize PCIe TPH capability registers

This commit virtualizes TPH extended capability config space registers.
It blocks direct ST-table programming via config space, adds vconfig
masking to hide EXT_TPH, and syncs the shadow ST table to physical hardware
when the requester is enabled.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
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
> +		}

[Severity: High]
If pcie_tph_set_st_entry() fails (for instance, due to missing MSI-X
allocation), does it leave the hardware and virtual configuration out of
sync?

The loop ignores the return value from pcie_tph_set_st_entry(), meaning
ret will remain 0 even if the ST entry update fails. Since a failure here
can forcefully disable TPH in the physical hardware via pcie_disable_tph(),
the subsequent if (ret) config rollback will be skipped. This would leave
the guest OS believing TPH is enabled while the physical hardware is actual=
ly
disabled.

Additionally, in the VFIO_DEVICE_FEATURE_TPH_ST_CONFIG ioctl handler
(vfio_pci_core_feature_tph_st_config), the rollback loop tries to restore
entries using pcie_tph_set_st_entry(). If the initial failure unconditional=
ly
disabled TPH on the physical device, will these rollback calls fail
immediately, leaving the recovery broken?

> +		if (ret)
> +			vfio_default_config_write(vdev, pos, count, perm,
> +						  offset, org_val);
> +	} else if (req =3D=3D PCI_TPH_REQ_DISABLE) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616104621.4191=
5-1-fengchengwen@huawei.com?part=3D12
