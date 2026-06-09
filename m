Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E11346E7A;
	Tue,  9 Jun 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781033920; cv=none; b=HK+oOQZbe+l7WqeBdp5MfPsRyal303eamJFc+NhLJ1lataNNuWkqsFa4F2Zm3SgFnzdZd5MVh4crsDHAD0+mRn9Bk+RyW12vMGZsnkov21hheuo8krXLJVh7zQ4R2IrxB8d47gToMX1XddWeI5O3ZIP5CUQPYJIlNGfH4XwbXVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781033920; c=relaxed/simple;
	bh=KEmtf101ZMIJ0jpmSMTIacoCWDu2qiGGkHnUjRVZkz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rEx2PBTWQazzJPLRvVdVJ0r1aFjb8FHGJn9bKhH0/nRYECWreWu2Yf5F9fDqlj52oubMHlYT7Atm8Lzbo/gL7jwZ5sAVDbHwDnQSTjeTfsWhrcCzdmwfjKn5JQXVOG3/3U2PYFZN3szRwfiaeRcri0wkIcIFN4T9jGpN2fbMUrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ny7mzlMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ny7mzlMr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D337F1F00893;
	Tue,  9 Jun 2026 19:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781033919;
	bh=XPHGM0EGRSSY/Vy8eoWWttPOeuJ+XBDhfAa5o4+g8Sg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ny7mzlMrbHxebg5xp2gHjvAYhkJI01uzJ+ouzby6qT7y1pViGH+4HhN3VO90rOnqN
	 OLvd16IRq2uR9vJ0LJoGlfBslukL1uZAv434N4XtLfrfEW1jD+C8d3HprQRzo+Ji4D
	 whC71dm75hgy+Ed5uAXqstfnMuA1IJMCcrgcZLEiQHSYxtxksZc2X61v8qMlX1CYeg
	 q72g+JIrElHNwaSUYv56fxBATu9jFOhSbISPXK0JnAIAIFxDo9CIrCjzmVvSf6RnjB
	 hU5sl/5T/jnaDA4Pd9ZSmX6j2ZU/UzwYKXAkNiJFetjyL9fQG6kngC6foFbKZUd9Qp
	 tq+sH9lZ+B7pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608185646.4085127-5-zhipingz@meta.com>
References: <20260608185646.4085127-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 19:38:38 +0000
Message-Id: <20260609193838.D337F1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Unconditional validation of the flag-gated `ph` parameter causes=
 valid requests clearing metadata to be rejected.
- [Low] Mixing `goto`-based error handling with scope-based cleanup helpers=
 (`scoped_guard`) in the same function.
- [Low] Unprotected read of `priv->vdev` races with concurrent write to `NU=
LL`.
--

commit f7be31969e4c92a551932ef245b8d9697e571272
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_tph and DMA_BUF_TPH feature

This commit implements the dma-buf get_tph callback for vfio-pci-exported
dma-bufs. It also adds the VFIO_DEVICE_FEATURE_DMA_BUF_TPH feature to allow
userspace to attach TPH metadata to a dma-buf.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 1a177ce7de546..f1bc3733d3db5 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
[ ... ]
> @@ -327,12 +358,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_c=
ore_device *vdev, u32 flags,
[ ... ]
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	int ret;
> +
> +	if (!pcie_tph_supported(vdev->pdev))
> +		return -EOPNOTSUPP;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret !=3D 1)
> +		return ret;
> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	/* PCIe TLP Processing Hint is a 2-bit field. */
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

[Severity: Medium]
Will this unconditionally reject requests clearing the metadata?

The documentation mentions that setting flags to 0 clears previously publis=
hed
metadata. However, because this check is evaluated unconditionally, userspa=
ce
leaving the ph field uninitialized (containing stack garbage) when passing
flags =3D 0 will cause the kernel to erroneously reject a valid clear reque=
st
with -EINVAL.

Should this validation only occur if the relevant flags are set?

> +
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
Does this unprotected read of priv->vdev race with concurrent unbound opera=
tions?

In vfio_pci_dma_buf_cleanup(), there is a concurrent write setting=20
priv->vdev =3D NULL under the vdev->memory_lock semaphore.

Since this read occurs without locks, can it race with the concurrent write
and cause KCSAN warnings or load tearing? Would using READ_ONCE() here and
WRITE_ONCE() in vfio_pci_dma_buf_cleanup() help prevent this?

> +		ret =3D -EINVAL;
> +		goto out_put;
> +	}
> +
> +	scoped_guard(mutex, &priv->tph_lock) {
> +		priv->tph_st =3D set_tph.steering_tag;
> +		priv->tph_st_ext =3D set_tph.steering_tag_ext;
> +		priv->tph_ph =3D set_tph.ph;
> +		priv->tph_st_valid =3D !!(set_tph.flags & VFIO_DMA_BUF_TPH_ST);
> +		priv->tph_st_ext_valid =3D
> +			!!(set_tph.flags & VFIO_DMA_BUF_TPH_ST_EXT);
> +	}
> +	ret =3D 0;
> +
> +out_put:

[Severity: Low]
Is it okay to mix goto-based error handling and scope-based cleanup helpers=
 in
this function?

The kernel cleanup guidelines discourage mixing goto labels for cleanup (li=
ke
goto out_put here) and scoped_guard() in the same function to avoid confusi=
ng
ownership semantics.

Would it be better to either use a __free() wrapper for the dmabuf or stick=
 to
traditional mutex_lock()/mutex_unlock() here?

> +	dma_buf_put(dmabuf);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608185646.4085=
127-1-zhipingz@meta.com?part=3D4
