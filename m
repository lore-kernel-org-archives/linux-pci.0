Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20520EEBB
	for <linux-pci@vger.kernel.org>; Thu, 14 May 2026 00:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778717142; cv=none; b=ZuK10qBAmlVkLv4a9ljv40vZ1zyDbziLq8jyO1SjQytFT6zbrsjAKf9lCU88s9mfuwOHz+jLIs49MItHzaWGs/dOTACu3wqjGsA/rKIiXuJ3TG+D2FCHN5XG+2iL1QfjGtb9HUuhC3TNss7CN+Q3bFW7ej3H6HkU2TKvNuKEltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778717142; c=relaxed/simple;
	bh=X0ZmzKRx5e1e6rh09REGcEihlZ8+BqssT8pL+LIwAo8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UfKSwOq1CNjiFckHx/1VyguGgOwzs0REOi3H8u+OEfYj3Q6WUnWAXugj0R4SkYRJE20IVil4u8szkxqxLUkTrkYif7jekMESs5JNH13DIA4u4Q5Qp/74da7v+M12JW4tsG4QzYjKF8klCTTnYGfCOPdWLw8ANqzqfsbYsjS8dCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpMMPcmS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpMMPcmS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB75C19425;
	Thu, 14 May 2026 00:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778717142;
	bh=X0ZmzKRx5e1e6rh09REGcEihlZ8+BqssT8pL+LIwAo8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PpMMPcmSgf7+tdexFWhAcLUMO9sHLqkR+fiyuRiiHaZAtBnDushE1YvvVotDy9ipy
	 XVlResAA2DzjwjS2c7Snt9hVq2eoGlYi9HB61Ly5z4c99/+oHrborEoyyXbzvabXat
	 BAT+VaMh7TNsCr4E8itog3UHlh2RMQ3r9PuZAlyu6i+K0Q+LT+O+DyPQBjXyqeF1k7
	 AXErzpBBod9Esd6SyFYnSgRW8mS/kxpsZNUg6R8otTU3+Q71z0jJCxCxoeIyA0FWWK
	 BE7Zvtynwe6RKoYj/ZcfHuMAkDnWMiACtJVLEKCnkwdRFGaSpCSzSWJKZs2eD6K4gY
	 LAtNUGqeYXUNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] vfio: add dma-buf get_tph callback and
 DMA_BUF_TPH feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260512184755.4137227-2-zhipingz@meta.com>
References: <20260512184755.4137227-2-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 00:05:41 +0000
Message-Id: <20260514000541.CDB75C19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Data Race / Lockless Concurrency Bug in TPH metadata updates
- [Medium] Data race on `priv->vdev` ownership check during cross-device io=
ctl invocation
--

commit d00a3ff646f832b56279c8a55984e20630463a25
Author: Zhiping Zhang <zhipingz@meta.com>

vfio: add dma-buf get_tph callback and DMA_BUF_TPH feature

Add a dma-buf callback that returns raw TPH metadata from the exporter
and a new VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl to set it.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index f87fd32e4a017..28247602e3599 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -331,6 +377,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{

[ ... ]

> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv =3D dmabuf->priv;
> +	down_write(&vdev->memory_lock);
> +	if (priv->vdev !=3D vdev) {

Can this race with a concurrent cleanup of another device?

If userspace passes a dmabuf from device A to the ioctl for device B,
device B's memory_lock is held here. If device A is concurrently closed,
vfio_pci_dma_buf_cleanup() could be setting priv->vdev =3D NULL while holdi=
ng
device A's memory_lock, leading to a data race on priv->vdev.

Could we use READ_ONCE()/WRITE_ONCE() for priv->vdev, or acquire
dma_resv_lock() before the check?

> +		ret =3D -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	priv->steering_tag =3D set_tph.steering_tag;
> +	priv->steering_tag_ext =3D set_tph.steering_tag_ext;
> +	priv->ph =3D set_tph.ph;
> +	/*
> +	 * Publish the TPH values before the gate flag, so that lockless
> +	 * readers in vfio_pci_dma_buf_get_tph() see fully-initialized
> +	 * fields once they observe a non-zero tph_flags.
> +	 */
> +	smp_store_release(&priv->tph_flags, set_tph.flags);

What happens if this ioctl is called multiple times on the same dmabuf?

If priv->tph_flags is already non-zero from a previous call, a concurrent
lockless reader in vfio_pci_dma_buf_get_tph() could pass the
smp_load_acquire() check and read the metadata fields while they are being
updated here.

Does this cause a data race or torn reads?

Also, if the second call drops a previously set flag, could the reader
consume uninitialized data from set_tph?

Should we reject updates if priv->tph_flags is already set, or use a
seqlock_t to serialize lockless readers?

> +	ret =3D 0;
> +
> +out_unlock:
> +	up_write(&vdev->memory_lock);
> +out_put:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512184755.4137=
227-1-zhipingz@meta.com?part=3D1
