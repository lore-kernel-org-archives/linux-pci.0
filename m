Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002208;
	b=PGtFJnlKODU9Zdt0FOxc4j/MWGjGPYDdbi4wHTO3ecX0egIY7gJWBT6KLEnOhGSAhOAp
	 v4hIs/H8Ci+Jr5DHwp9WyyddvzRdZ+levMJ7xZa3f7rBGn8lUhitSJUlXb5jMOFCu97V0
	 Hp1P3T+y14NWFXfnpnv3QJjIRkeXnyK94CoxdVCUrOx+lYr9Z9nKfMTir4BrfUdu+Ql+U
	 wcYK8HbXzEU5niCu4IrFBoUkZ1WYQTe65+76Z0i+fsmWB0o+8vDE+uNCPdpwD5rr/kZ7O
	 PKzdnGE33v0WIyJ7VQ0YENF3Y3+dyXfIA/J1aq2ZrtfOaRW/tNUGiMcf2CwkAGnEPcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002208;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ndf003pWa8Q/MoWtoRtvYhzs4bAn/vyXxF8URZFKxeY=;
	b=sdRS5+njOJwlYISoZzfaD1O534bGm9QaIF01Xq5vwJxYoovOC9Nv4H/ZGAgHPBfuODMi
	 b2AO4dunpr5LtGsRsJReKwimKI+t7jYZng0376Hyck1yBCk13pt8NjXFM6suYgR25jlnq
	 GxTvKM9o9SJNVrB5YbQnFdZXe44YeWM6mJgCC5I/nlUbuHn2tO5t3w1s1fbtYKel/O/MY
	 G+bxebOEuCB3gw8Qh+TlaPBNJkDMZloG2j5tqXqqtChzmMNKFEGXEmeWAopxSLA8Xlosm
	 NL3/CyjmuAx7yFKP1tYX7xVRSP2LC+EEW12yeTri27WUzdp9nU126OAMdT9i+Ne2M+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="fQPQ/mvV";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73191606A338;
	Wed, 18 Nov 2026 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQPQ/mvV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A69D1F000CD;
	Wed, 18 Nov 2026 11:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795002207;
	bh=ndf003pWa8Q/MoWtoRtvYhzs4bAn/vyXxF8URZFKxeY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQPQ/mvV5jfqE75WGc/rcM/6NuIm3aeRhGdvMnEBDLDZee7OpKWG/1BMuLBWT27tM
	 MHYVpfur7K8kYpuClOQaq9PkBXMqACykeH7O5dksqiHondAOS2+DOKltIBDIKel4BL
	 8M9pUisggzK27CKLIGHatjaIbUXDiQZmGlovACBFIkRQ7zP9Q+p0fd4Yjpio7vtCd/
	 L0ty+YRIM1b9k34sAVAYc5TKm9BF7LM4rqTHLG0a5A/I+norbkRt85m2fpG7a+8+B/
	 2PkapfTxy3xFsFXeCuCeZN6yEvIQlGtsF9XJp8ewjAev50W6DFqynp23u8MtG33NFt
	 ULHXWvH882Jkg==
Message-ID: <sashiko-outbox-220836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 11/13] vfio/pci: Add DS-ST TPH policy and
 TPH_RESOLVE capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118091238.45992-12-fengchengwen@huawei.com>
References: <20261118091238.45992-1-fengchengwen@huawei.com>
 <20261118091238.45992-12-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 11:43:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] vfio/pci: vfio_pci_core_feature_tph_resolve() fails when
  !has_arch_st
- [Medium] vfio/pci: vfio_tph_config_write() drops ST mode and active
  req updates
- [Medium] vfio/pci: vfio_pci_tph_get_capability() skips
  pcie_tph_dsm_supported()
--

commit 5b864ef3e267f2d34a7496c96455a9bee2cc860b
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add DS-ST TPH policy and TPH_RESOLVE capability

This commit adds the DS-ST policy level to vfio-pci and introduces the
VFIO_DEVICE_FEATURE_TPH_RESOLVE ioctl feature for resolving CPU steering
tags on DS-ST capable devices.

> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_p=
ci_config.c
> index 398f8db8b8ff0..8e47f84216b0d 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -1218,7 +1218,7 @@ static int vfio_tph_config_write(struct vfio_pci_co=
re_device *vdev, int pos,
>  	cap =3D vdev->tph_vcap;
>  	mode =3D FIELD_GET(PCI_TPH_CTRL_MODE_SEL_MASK, new_ctrl);
>  	req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, new_ctrl);
> -	if (mode > PCI_TPH_ST_IV_MODE || !(cap & (1u << mode)) ||
> +	if (mode > PCI_TPH_ST_DS_MODE || !(cap & (1u << mode)) ||
>  		req =3D=3D 0x2 /* reserved */ ||
>  		(req =3D=3D PCI_TPH_REQ_EXT_TPH && !(cap & PCI_TPH_CAP_EXT_TPH)))
>  		goto out; /* Drop invalid or unsupported write value. */

[Severity: Medium]
Can vfio_tph_config_write() drop or overwrite ST Mode Select updates?

Right below this check, vfio_tph_config_write() still skips hardware
updates whenever req =3D=3D org_req:

drivers/vfio/pci/vfio_pci_config.c:vfio_tph_config_write() {
    ...
	vfio_user_config_read(pdev, start + PCI_TPH_CTRL, &ctrl_val, 4);
	vfio_default_config_write(vdev, start + PCI_TPH_CTRL, 4, perm,
				  PCI_TPH_CTRL, ctrl_val);
    ...
	org_req =3D FIELD_GET(PCI_TPH_CTRL_REQ_EN_MASK, org_ctrl);
	if (req =3D=3D org_req)
		goto out; /* Only care about requester enable. */

	if (req =3D=3D PCI_TPH_REQ_TPH_ONLY || req =3D=3D PCI_TPH_REQ_EXT_TPH)
		pcie_enable_tph_ext(pdev, mode, req);
	else if (req =3D=3D PCI_TPH_REQ_DISABLE)
		pcie_disable_tph(vdev->pdev);
    ...
}

If userspace writes PCI_TPH_ST_DS_MODE while the requester is disabled
(req =3D=3D org_req =3D=3D PCI_TPH_REQ_DISABLE) before enabling it in a sec=
ond
write, the first write is not committed to hardware and the second write
clobbers vconfig[start + PCI_TPH_CTRL] from hardware (where mode is still
0), enabling the device in NO-ST mode.

Similarly, changing mode while TPH is already enabled is ignored because
req =3D=3D org_req, disabling the requester via pcie_disable_tph() zeroes t=
he
entire hardware PCI_TPH_CTRL register including ST Mode Select, and
switching req between PCI_TPH_REQ_TPH_ONLY and PCI_TPH_REQ_EXT_TPH while
enabled fails in pcie_enable_tph_ext() with -EBUSY because pdev->tph_enabled
is already set.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 23ed8ea396575..049392831b35f 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -1710,12 +1710,17 @@ static void vfio_pci_tph_dev_deinit(struct vfio_p=
ci_core_device *vdev)
>  static u32 vfio_pci_tph_get_capability(struct vfio_pci_core_device *vdev)
>  {
>  	bool has_arch_st;
> +	u32 cap =3D 0;
> =20
>  	has_arch_st =3D vfio_pci_tph_has_architected_st(vdev);
> -	if (!has_arch_st)
> -		return 0;
> +	if (has_arch_st)
> +		cap |=3D VFIO_DEVICE_TPH_CAP_PROG_ST_NONE |
> +		       VFIO_DEVICE_TPH_CAP_PROG_ST_CPU;
> =20
> -	return VFIO_DEVICE_TPH_CAP_PROG_ST_NONE | VFIO_DEVICE_TPH_CAP_PROG_ST_C=
PU;
> +	if (vdev->tph_vcap & PCI_TPH_CAP_ST_DS)
> +		cap |=3D VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST;
> +
> +	return cap;
>  }

[Severity: Medium]
Should vfio_pci_tph_get_capability() check pcie_tph_dsm_supported(vdev->pde=
v)
before advertising VFIO_DEVICE_TPH_CAP_PROG_ST_CPU and
VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST?

Commit "PCI/TPH: Add pci_tph_dsm_supported() helper to detect device TPH
ST _DSM" earlier in this series added pcie_tph_dsm_supported() to check
whether the root port exposes the ACPI TPH _DSM method, but nothing calls
it.  On systems without CONFIG_ACPI or without that _DSM on the root port,
VFIO_DEVICE_FEATURE_TPH GET advertises CPU steering tag support that will
always fail when invoked.

> @@ -1901,6 +1906,50 @@ static int vfio_pci_core_feature_tph_program(struc=
t vfio_pci_core_device *vdev,
>  	return ret;
>  }
> =20
> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device=
 *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_resolve __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_resolve resolve;
> +	u32 user_flags, src_mask;
> +	bool extended;
> +	u16 tag =3D 0;
> +	int ret;
> +
> +	if (!vdev->tph_opt_in || !(vdev->tph_vcap & PCI_TPH_CAP_ST_DS))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(resolve));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	if (copy_from_user(&resolve, arg, sizeof(resolve)))
> +		return -EFAULT;
> +
> +	user_flags =3D resolve.flags;
> +	extended =3D !!(user_flags & VFIO_DEVICE_TPH_EXTENDED);
> +	if (extended && !pcie_ext_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;
> +	user_flags &=3D ~VFIO_DEVICE_TPH_EXTENDED;
> +
> +	src_mask =3D vfio_pci_tph_get_src_mask(vdev) & ~VFIO_DEVICE_TPH_SRC_NON=
E;
> +	if (user_flags & ~src_mask || !is_power_of_2(user_flags))
> +		return -EINVAL;

[Severity: High]
Does vfio_pci_core_feature_tph_resolve() always fail with -EINVAL on DS-ST
devices that do not also have an architected ST table?

vfio_pci_tph_get_src_mask() only checks VFIO_DEVICE_TPH_CAP_PROG_ST_CPU,
which is gated on vfio_pci_tph_has_architected_st(vdev), and ignores
VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST:

drivers/vfio/pci/vfio_pci_core.c:vfio_pci_tph_get_src_mask() {
	u32 flags =3D vfio_pci_tph_get_capability(vdev);
	u32 src_mask =3D 0;

	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_NONE)
		src_mask |=3D VFIO_DEVICE_TPH_SRC_NONE;
	if (flags & VFIO_DEVICE_TPH_CAP_PROG_ST_CPU)
		src_mask |=3D VFIO_DEVICE_TPH_SRC_CPU_VOLATILE |
			    VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT;

	return src_mask;
}

When a DS-ST device has PCI_TPH_LOC_NONE (storing steering tags in
device-specific MMIO or firmware rather than an architected ST table),
vfio_pci_tph_get_src_mask() returns 0, so src_mask is 0 and every
VFIO_DEVICE_FEATURE_TPH_RESOLVE call is rejected with -EINVAL.
Checking (flags & (VFIO_DEVICE_TPH_CAP_PROG_ST_CPU |
VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST)) in vfio_pci_tph_get_src_mask() would
allow CPU source resolution when only VFIO_DEVICE_TPH_CAP_RESOLVE_CPU_ST
is supported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118091238.4599=
2-1-fengchengwen@huawei.com?part=3D11
