Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB844A205F;
	Thu, 24 Sep 2026 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264259; cv=none; b=qE0CnmxvrEruyySwO35FluYLbWdp6UdVxIn1mwwN2KhRZW2yrjCbYkBKUkjI/Z4BPcNUAehoPD2VRKhYz/9DTRQ+DbDUu5s0md0JV38N2jiUL6p3pAWopBEys/spwwh4JS6hTUyhW8E6K33ryh+sUSc7qtlYynw464M5RY2OyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264259; c=relaxed/simple;
	bh=42V5Tj/XVqcbr6k22PeL7jUd6/1BJK7TwU0Dxk0FvZ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=svj6uPXXqmHjQ9ZMhvKtTT/ZBgP4SFGalwlFK9srz7R5qCfQ0hdWhVjEP7oMXnFTVZqQE5QRjKzPJyLeX9HyfoBz3GTsMiPQCARmyLvPO/yKoONggm0jCwz0lkn72buS9B7NGaCYuiLkg3EattYzi4YlvC6cUPOrKkWDCPBNWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGprt86M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGprt86M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951E71F000FF;
	Thu, 24 Sep 2026 15:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264257;
	bh=A+GcTAm5IysdIIKjkNpvBgfiFzzyjTnORMip90phKbI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kGprt86MX9yRMME/RrJ0o5A7rfx7gMZ9I2yrban1/rVH4IakHe0UYyFpAJWLDQ0WO
	 /fIV8FX7Rba9aLKKxqLg019L3VQX8bUmoyt7GOXrN8sUdV+9AR5L3qsqFr96GR0fjk
	 bmDALgeVDAQD+oNmNVOPLJu8svERKBVa37rBCgHxbeCq6wpLhwPW+0KtZh3iw5ooq+
	 mNDTpYeiSDh8sPwjHPni87+w36SX3POb/3PIvYCcK0iPYphQQPAdCi1zruCHkSvoq2
	 yAyTmc9KzDkgaDXA8Us+AFcP4OTg01eCrBuaEJbHSIJkl8DoYxZIHmfa46txkSLfHl
	 YmPCvZAhudHLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] vfio/pci: Remove DMABUF export dependency on
 vdev->memory_lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260924152159.49702-2-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-2-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:37:37 +0000
Message-Id: <20260924153737.951E71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio: incorrect initial DMABUF revoked state allows DMA to disable=
d BARs
--

commit fb51fe9e3cab37471d1c4237de83fcf89aad79f5
Author: Matt Evans <matt@ozlabs.org>

vfio/pci: Remove DMABUF export dependency on vdev->memory_lock

This commit introduces a new dmabuf_lock to protect the list of exported
DMABUFs and a new bars_revoked flag for tracking BAR revocation state. This
removes the dependency on vdev->memory_lock during DMABUF export in
preparation for future mmap refactoring.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 6757054e9d875..1f60661078313 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c
> @@ -663,6 +663,7 @@ int vfio_pci_core_enable(struct vfio_pci_core_device =
*vdev)
>  		vdev->has_vga =3D true;
> =20
>  	vfio_pci_core_map_bars(vdev);
> +	vdev->bars_revoked =3D false;

[Severity: High]
Is this hardcoded initialization safe?

Earlier in vfio_pci_core_enable(), pci_try_reset_function() is called,
which performs a fundamental reset that clears the device's
PCI_COMMAND_MEMORY bit in the physical hardware.

Then vfio_config_init() populates the virtual config space by reading from
the hardware, capturing PCI_COMMAND_MEMORY =3D=3D 0. Does initializing
bars_revoked to false here fail to match that initial virtual config state?

> =20
>  	return 0;
> =20

[ ... ]

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..847ee5cc78e7f 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -305,12 +305,27 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
> =20
>  	/* dma_buf_put() now frees priv */
>  	INIT_LIST_HEAD(&priv->dmabufs_elm);
> -	down_write(&vdev->memory_lock);
> +
> +	/*
> +	 * dmabuf_lock synchronises access (R) or updates (W) to the
> +	 * vdev->dmabufs list and to bars_revoked (see below).  The
> +	 * revocation state of DMABUF elements in the list is written
> +	 * holding both dmabuf_lock(W) and resv, and tested with
> +	 * either.
> +	 *
> +	 * dmabuf_lock -> resv
> +	 *
> +	 * vdev->bars_revoked tracks the BAR revocation status updated
> +	 * via vfio_pci_dma_buf_move(), so the initial DMABUF state
> +	 * follows the same criteria that later update the DMABUF
> +	 * state (BAR zap, etc.).
> +	 */
> +	down_write(&vdev->dmabuf_lock);
>  	dma_resv_lock(priv->dmabuf->resv, NULL);
> -	priv->revoked =3D !__vfio_pci_memory_enabled(vdev);
> +	priv->revoked =3D vdev->bars_revoked;

[Severity: High]
Can this incorrect initial state allow P2P DMA to disabled BARs?

If userspace exports a DMABUF at this point, the DMABUF inherits the
un-revoked state from vdev->bars_revoked (false), bypassing the correct
state evaluation.

Could this permit P2P DMA to this DMABUF to be allowed by the kernel but
dropped by the endpoint since memory decoding is disabled? This would trigg=
er
PCIe Unsupported Request (UR) errors, which could potentially be weaponized
by unprivileged users controlling the VFIO device to trigger AER and crash
the host.

>  	list_add_tail(&priv->dmabufs_elm, &vdev->dmabufs);
>  	dma_resv_unlock(priv->dmabuf->resv);
> -	up_write(&vdev->memory_lock);
> +	up_write(&vdev->dmabuf_lock);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D1
