Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1822131E49
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778098943; cv=none; b=RvWFl4NDvwVxsfSDcxCc6cFio5hg6XOyG2ysZWqvSnGOKNRYquIoRSVF1WEIVmllQPuDHJRZpLtQKwia+ymQ/l7Dwyj3Q+jUe7QNXWUfpGrehdX7tnIvy254oMb5xBfae0YbUV5BCJRxi+WCCpo6I5o/kIbxB9Pl8JHjSri1SZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778098943; c=relaxed/simple;
	bh=Q4cOMIhkG1dO1XEn9ipd2Cy3hjV6SkdwDM3MYMNlx2A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VkklV+3HFjaLxNmkJRPC/R7J9RnUNTiKAELNDO4EoAC7dEy3+TPwUI2mNHA06aG6u7bYuQNWC/2AAcLHfYlm/0+y4gmDiseBmeiyJnp0NtdbbtOl+LXRCtDX71PvyMOI9E07Pt8bzNytI85KC5ajJGTM24JegYL3ixVp3Op4DMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8bqd4AB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8bqd4AB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D971C2BCB0;
	Wed,  6 May 2026 20:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778098943;
	bh=Q4cOMIhkG1dO1XEn9ipd2Cy3hjV6SkdwDM3MYMNlx2A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=M8bqd4ABTf+Nnb6l4XbQY8HhQ/iMfkMBubJGMOfEviB1m30gCo4ufVwABOzexi9kR
	 iRsTzG9wjAQdRrt+Zz0/YqoV237y7XEs9po7+ZBA0jpDgm9ZLdNUZduf+AjPghWBJ+
	 3o+pnLf9G5LHZrgHoSGivNKUat2OgFn5JKnhA5gavtqsMfI5P/Tk3xc/hPAwWOeNXR
	 +tkLBsdNvI1L0MXGcMDLiaS9Nn17Ilan2l0HBXVQih93W25nlP7o9fEN2K1ItrC2GF
	 gl9bZgeZu7L32d5N10bo8seiS/xlTNsARBBJDd8gi9XM6nSf0URALGWq+K7FkVAe9k
	 KsCf+byb1Qsaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 6/6] vfio/pci: Add PCIe TPH SET_ST interface
Reply-To: sashiko@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506094623.29327-7-fengchengwen@huawei.com>
References: <20260506094623.29327-7-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 20:22:22 +0000
Message-Id: <20260506202223.0D971C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Incorrect `argsz` size validation unconditionally rejects valid io=
ctl requests.
- [Medium] The unused `st` field in `struct vfio_pci_tph_entry` is not vali=
dated for being zero during SET_ST, breaking forward ABI compatibility.
--

commit cad3760ab856857766102c878427138245e1feb6
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add PCIe TPH SET_ST interface

This commit adds the VFIO_PCI_TPH_SET_ST operation to support batch
programming of steering tag entries. It also implements a rollback
mechanism to clear successfully programmed entries if any entry fails
to prevent inconsistent device state.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 45e641ab2a887..867d8694b56bd 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
[ ... ]
> @@ -1600,6 +1600,90 @@ static int vfio_pci_tph_get_st(struct vfio_pci_cor=
e_device *vdev,
>  	return err;
>  }
> =20
> +static int vfio_pci_tph_set_st(struct vfio_pci_core_device *vdev,
> +			       struct vfio_device_pci_tph_op *op,
> +			       void __user *uarg)
> +{
> +	struct pci_dev *pdev =3D vdev->pdev;
> +	struct vfio_pci_tph_entry *ents;
> +	struct vfio_pci_tph_st st;
[ ... ]
> +	size =3D st.count * sizeof(*ents);
> +	if (op->argsz < offsetofend(struct vfio_device_pci_tph_op, st) +
> +			sizeof(struct vfio_pci_tph_st) + size)
> +		return -EINVAL;

Does adding sizeof(struct vfio_pci_tph_st) artificially inflate the required
buffer size?

The offsetofend() macro already includes the size of the st member. If a
properly written userspace application computes its argsz exactly as
sizeof(struct vfio_device_pci_tph_op) + size, this check would fail and
reject the request with -EINVAL.

> +
> +	ents =3D kvmalloc(size, GFP_KERNEL);
> +	if (!ents)
> +		return -ENOMEM;
> +
> +	ents_off =3D offsetof(struct vfio_pci_tph_st, ents);
> +	if (copy_from_user(ents, uarg + ents_off, size)) {
> +		err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +	for (; i < st.count; i++) {
> +		/* Check reserved fields are zero */
> +		if (memchr_inv(&ents[i].reserved0, 0, sizeof(ents[i].reserved0)) ||
> +		    memchr_inv(&ents[i].reserved1, 0, sizeof(ents[i].reserved1))) {
> +			err =3D -EINVAL;
> +			goto out;
> +		}

During the SET_ST operation, the st field in struct vfio_pci_tph_entry
appears to be unused, as the steering tag is instead dynamically fetched
via pcie_tph_get_cpu_st() later in the loop.

Should the st field also be validated to be zero?

If userspace leaves this unused field uninitialized and passes garbage data,
it might break forward ABI compatibility. A future kernel update that attem=
pts
to read explicit steering tags directly from this field wouldn't be able to
distinguish between old programs sending uninitialized garbage and new
programs sending valid data.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506094623.2932=
7-1-fengchengwen@huawei.com?part=3D6
