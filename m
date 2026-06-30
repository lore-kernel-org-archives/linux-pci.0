Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9122332610;
	Tue, 30 Jun 2026 23:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860923; cv=none; b=cbGN7vkRBZSpuPkhThamEflfLQzv/pS7pQLT0NrfST/jiN0dhFV/FXQKLsmm6ffQ1++wmGo8JDD+dUTe7slulQQH6M0uEgERq3Z3XOCmOwcrGhAztSngyWTlEk1ymHD+34oqz4Rg1bZA0NZeMUouhim0cumhhR25NXffRUrzONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860923; c=relaxed/simple;
	bh=IXjCB+J5alKxR7zrUb51/9sJO+axFt0zkGS8KIILwi8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RfMRDUOAZpxrWISLMEb7IEDg54gWKp2s9HNZkHJqawZWUfVGkyuYXKNKGt7gfW1z7AjX8tmBPmN/rGORd8k/dyPwUTWQEbnn7MKJnee/fylVadRg7skxee/FbbnhLv+WpQ2FYDYmWLpCp6H8Q2FObLVkXohZoSch9SIVbgAoffQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BasXIBhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BasXIBhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E4C51F000E9;
	Tue, 30 Jun 2026 23:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860921;
	bh=E9FuaoOJzCGZBbZKMbcQWsELlnnFjqrAYZ4zRijrd48=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BasXIBhIznEyleLufZSQKEe3/m/9U0UssRw/bMzftb/bLoO2RVnMARF5ley+dUonL
	 x2AtfdFjz/FWrjqAdxvS7jHByBguJDONIt+GuoDhB5GnAuDZPu/KznLxk5inBFUVFK
	 +k6A4kGan94PZpUDjthUOtUHjtCltbbG1SCZGdq2H2u3ZzV8GVsBdacWngsBLTsnOS
	 YlBXg0fRDp0VSbupSX4PP5/QnNfBK3xySF8rTTpRQfvTwZXbnVX0X8bqkYtLvSLQvd
	 JgRzVHRHnTWuKlFEoxXe3ud74f+7HmnnRCjid9lhWg6d8ZgUf0JhaBbKUoDMr49edZ
	 O7OF2yGZgrsxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/4] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260630224328.3218796-4-zhipingz@meta.com>
References: <20260630224328.3218796-1-zhipingz@meta.com>
 <20260630224328.3218796-4-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 23:08:41 +0000
Message-Id: <20260630230841.7E4C51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Lockless plain load of `priv->vdev` races with concurrent modificat=
ion in cleanup path.
- [Low] Missing `WRITE_ONCE()` for `priv->revoked` leads to data race with =
`READ_ONCE()`.
--

commit d524eab36e9482385fe1c1a6c6280e667bf56a9c
Author: Zhiping Zhang <zhipingz@meta.com>
Subject: vfio/pci: implement get_pci_tph and DMA_BUF_TPH feature

This commit implements dma-buf get_pci_tph for vfio-pci exported
dma-bufs and adds VFIO_DEVICE_FEATURE_DMA_BUF_TPH. This allows
userspace to publish TPH metadata for a VFIO-owned device.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..8de72f9e75024 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -30,7 +38,7 @@ static int vfio_pci_dma_buf_attach(struct dma_buf *dmab=
uf,
>  	if (!attachment->peer2peer)
>  		return -EOPNOTSUPP;
> =20
> -	if (priv->revoked)
> +	if (READ_ONCE(priv->revoked))

[Severity: Low]
Since this updates the read of priv->revoked to use READ_ONCE(), should the
corresponding writers in vfio_pci_dma_buf_move() also be updated to use
WRITE_ONCE()?

For example, when a concurrent state change like a device reset writes to
this field:

vfio_pci_dma_buf_move() {
        ...
        priv->revoked =3D true;
        ...
}

Will the lack of WRITE_ONCE() here trigger KCSAN data race warnings when
evaluated concurrently by the new READ_ONCE() check?

>  		return -ENODEV;
> =20
>  	if (!dma_buf_attach_revocable(attachment))

[ ... ]

> @@ -333,6 +362,72 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
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

> +	dmabuf =3D dma_buf_get(set_tph.dmabuf_fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	priv =3D dmabuf->priv;
> +	if (priv->vdev !=3D vdev) {

[Severity: Low]
Can this lockless read of priv->vdev race with concurrent modifications in
the cleanup path?

If userspace calls the VFIO_DEVICE_FEATURE_DMA_BUF_TPH ioctl on device A,
passing a dmabuf_fd belonging to device B, while device B is concurrently
being closed, could this race with vfio_pci_dma_buf_cleanup()?

vfio_pci_dma_buf_cleanup() {
        ...
        priv->vdev =3D NULL;
        ...
}

Will this concurrent plain store trigger KCSAN warnings during the pointer
equality check?

> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630224328.3218=
796-1-zhipingz@meta.com?part=3D3
