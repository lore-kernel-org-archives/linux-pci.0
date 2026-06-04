Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EF447ECDE;
	Thu,  4 Jun 2026 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780581325; cv=none; b=bWTTfhjZ9r5cHcP+dZ5aD4kbFkylCCjUwxhl78B+qee0KrvLgpqdJmf+d5pxWMVJydnR3D76e20of/X+M5dv/DXWovycTjMmRPNuUZNB64tEq0cDLk6s566HtOhFm1URrCSbx1+YdJ3x9+Lx65NOi8TJOZ4CQmK1P7+y86Ha1No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780581325; c=relaxed/simple;
	bh=wGIZfw6uJMx8AcxfhtKKV/uDPKacDLE5lgRNzfXdddI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lhNfnkdu2akLRH/6+v9/noHpzb5YeP3AMISB9kpksCdv5faj7jluU2avUIxU9Y6BD4NcHyfVSkYENC0kqQCQaZWZrjpIr/BM3OFRdkOuiVCimarx05PaY8vzqM9aa5PbKOWI7liPzvHnkmTEkhO7m1+foDaS4MH91c2NDUAFwds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/xBEPEL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/xBEPEL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A841F00893;
	Thu,  4 Jun 2026 13:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780581324;
	bh=6gSx0qrHpJdkaw5dYGTp89LNyK47PK4IiyNprMIwdlc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C/xBEPELx4BgEHz5RMg4knHbnuy5yaS0TT8/lNjx2JqiXtlEy6+yd2tCV3q7RbwgD
	 J4Z84glhsyBjGyMMFMbTh0OdpZf6jucvBI6nrdb7W/Wo4OSG9wO/Aw9mh8x224YHip
	 ucZalEQ7VXTOGhPXBtVjSmy/WmIzo3vMW89tufS99ietQT8e9eQbpgGYKKqDRxDtfR
	 dfMdxMEr6Gucyv/bXi1fwJfwQKaI+A8o42iQzUAOe+/b1rMuZFA6GhdoPEaoVUZlhP
	 QU+OoBMS2ex3PF97jdtnvPuMWIGf7sNSOK6geR7btptfczTIkJPB4DTUOoreUUAgaa
	 //EeQnGVnqEWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/12] vfio/pci: Add TPH_CPU_ST to query CPU's TPH
 steering tag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604132804.28678-11-fengchengwen@huawei.com>
References: <20260604132804.28678-11-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 13:55:23 +0000
Message-Id: <20260604135523.D6A841F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] VFIO feature probing is broken for `VFIO_DEVICE_FEATURE_TPH_CPU_=
ST` due to premature capability check.

Pre-existing issues:
- [High] Data race on bitfields in `struct vfio_pci_core_device` due to uns=
ynchronized updates to `tph_permit`.
--

commit 8e85ddd8531d274e066b704c2d380e850a4df8e5
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add TPH_CPU_ST to query CPU's TPH steering tag

This commit adds a new read-only VFIO device feature
VFIO_DEVICE_FEATURE_TPH_CPU_ST to allow userspace to query PCIe TPH
Steering Tags by CPU ID. It implements a batch query logic and is
double-gated by a module parameter and a per-device tph_permit flag.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index ae05343701f76..7c6e3e1213d3e 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1535,6 +1536,72 @@ static int vfio_pci_core_feature_tph_enable(struct=
 vfio_pci_core_device *vdev,
>  	return 0;
>  }
> =20
> +static int vfio_pci_core_feature_tph_cpu_st(struct vfio_pci_core_device =
*vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_cpu_st __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_cpu_st cpu_st;
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	enum tph_mem_type mtype;
> +	void __user *uptr;
> +	bool extended;
> +	int i, ret;
> +	u32 *cpus;
> +	u16 *sts;
> +	u16 st;
> +
> +	if (!vdev->tph_permit)

[Severity: High]
This is a pre-existing issue, but does the tph_permit flag suffer from a da=
ta
race due to being packed in a bitfield without locking?

The tph_permit flag is packed as a bitfield (bool tph_permit:1;) alongside
other volatile device state flags like bardirty and needs_reset in
struct vfio_pci_core_device.

The vfio_pci_core_feature_tph_enable() ioctl modifies vdev->tph_permit
without holding any device-level locks:

    if (!vdev->tph_permit)
        vdev->tph_permit =3D 1;

Since bitfield modifications are compiled into non-atomic read-modify-write
operations on the underlying word, executing the TPH enable ioctl
concurrently with other state changes (such as vdev->bardirty =3D true; in
vfio_pci_core_write(), which is executed under memory_lock read-side) could
cause a data race. Can this silently overwrite and drop state changes,
potentially causing the device to malfunction due to missed resets
or unflushed BARs?

> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_GET,
> +				 sizeof(cpu_st));

[Severity: Medium]
Will this early tph_permit check break VFIO feature probing for
VFIO_DEVICE_FEATURE_TPH_CPU_ST?

Because the dynamic permission check intercepts the call first, probing
TPH_CPU_ST will incorrectly fail with -EOPNOTSUPP unless the user has
already dynamically enabled TPH via VFIO_DEVICE_FEATURE_TPH_ENABLE.

vfio_check_feature() handles VFIO_DEVICE_FEATURE_PROBE operations, which
userspace uses to discover if the kernel understands a feature ioctl.
Moving the tph_permit check after vfio_check_feature() would resolve this,
as PROBE returns 0 immediately.

> +	if (ret <=3D 0)
> +		return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604132804.2867=
8-1-fengchengwen@huawei.com?part=3D10
