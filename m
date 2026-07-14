Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53148355F46;
	Tue, 14 Jul 2026 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027460; cv=none; b=pUU9wUp4QTLHde4aUXC+nHL0nd1aWzOtrkOXs6jooqPhCdvzSjC8GwHLcVDgzRfc9bnlIKLLCQsiLfDx9b13ZmcmD5EGocriJF0stdiH6t7RO9XoEARNxmSb/5tiCp4ah706jreit9aYapK8qn757dj0eFB3Q/IdrRbFSHPEm2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027460; c=relaxed/simple;
	bh=5wlfk22gxIpFL0iMkD/9mmlU/SV+dLh4uVz9Jyend5I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pRMdBmoMUdomX7I423v+Qm9JrHs/SFZyCyS38bFziDGGZEfLaEXAGYKF3sak++hvt2N2lbMIepUPKSOj11GFZM/9WQhKJLTD8kP0SvJta4APQUHcZudxLW9DcnDawy1pfHejgog2Xz23Bfk+vehgVzIa3MX0ZpPcPO9nEv9XQaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZea+Pgb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZea+Pgb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032C91F000E9;
	Tue, 14 Jul 2026 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027459;
	bh=OKaCynTvjXzL4ECA8pu+K4SC/r5UziDE3QODYu0WfLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BZea+Pgbpe2rUKuCKB9ODgZrtrPAI1y4vafMXXbOZ7N95UJyynoss1dKyhg2nCoeK
	 OiW/RQRfo+I433EEnDMlWxDnYDk/wr+qec5pkSXREajWgGdhny/5CLTkD6c4/vut+n
	 KJw/En2jkDCdLc5tfK8UtdQwUVXXE2nOcp/VCOLzK5xH6PaBFtC7uEbiPrpvZ1AGro
	 ArebUDU7PZhQup2czeJgDAPuCNGB1hzcDSNmxLlh7UZmORZGQHqFSPfHSAIx0ROjcA
	 WbczN5O/F6V6OnEhmldGkgA8c4CP7AhE4rLPjfgXxw7TEWqD66O2E6f5AJW2Z4QtgL
	 FAfcCYxZHPW9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 12/16] vfio/pci: Add basic NO-ST TPH VFIO device
 feature support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260714104325.54444-13-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:10:58 +0000
Message-Id: <20260714111059.032C91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unconditional release of the DMA reservation lock in `vfio_pci_get=
_dmabuf_tph()` when acquisition fails.
- [Medium] Missing validation for the reserved field `rsv` in `struct vfio_=
device_feature_tph_resolve`.
--

--- Patch [12]: [PATCH v20 12/16] vfio/pci: Add basic NO-ST TPH VFIO device=
 feature support ---
commit e2b4dfe99fe4b36b6dce86a257a0fa1605e500b6
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add basic NO-ST TPH VFIO device feature support

Implement basic PCIe TPH support in NO-ST mode, adding VFIO_DEVICE_FEATURE_=
TPH
and VFIO_DEVICE_FEATURE_TPH_RESOLVE to allow TPH operations after opt-in.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 4e5e34a77b76d..82582c8ef69da 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1607,6 +1611,123 @@ static int vfio_pci_core_feature_token(struct vfi=
o_pci_core_device *vdev,
[ ... ]
> +static int vfio_pci_get_dmabuf_tph(int fd, bool extended, u16 *st, u8 *p=
h)
> +{
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	dmabuf =3D dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
> +	if (ret =3D=3D 0)
> +		ret =3D dma_buf_get_pci_tph(dmabuf, extended, st, ph);
> +	dma_resv_unlock(dmabuf->resv);

[Severity: High]
Does this code unconditionally unlock the DMA reservation lock even if the
lock acquisition fails?=20

If a signal interrupts dma_resv_lock_interruptible(), it will return -EINTR,
skipping the read but still calling dma_resv_unlock(). Can this underflow t=
he
WW mutex state and lead to a panic?

> +
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}
> +
> +static int vfio_pci_core_feature_tph_resolve(struct vfio_pci_core_device=
 *vdev,
> +			u32 flags,
> +			struct vfio_device_feature_tph_resolve __user *arg,
> +			size_t argsz)
> +{
> +	struct vfio_device_feature_tph_resolve resolve;
> +	u32 user_flags, allow_src;
> +	bool extended;
> +	u16 tag =3D 0;
> +	u8 ph =3D 0;
> +	int ret;
> +
> +	if (!vdev->tph_opt_in)
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

[Severity: Medium]
Does this code need to validate that the reserved field resolve.rsv is zero?

Without checking it here, userspace could pass garbage data, which might
prevent safely extending this UAPI structure in the future without breaking
existing applications.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D12
