Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A4403B0F;
	Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781282793; cv=none; b=njBWtaZXUhEWOGyq4MrLwmNCyUW5mPJGdFvNfOmQ8dd0e30ugwhgnnSNF+ku/Rjn/ReJq9PYRNTE+22hvSgaQmR1oRnc2ELZrazib9zCDTO59x+MgkHtqdn9Tfr9qTUIoghlDb7JdhxuSNcU2y5PS7wYCv+NrK12KbU2TDcEO3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781282793; c=relaxed/simple;
	bh=xoXUCRUxyrCUYSNAH22Eg9PoIEFaucJb+XYKOp3+/8E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pMPC1/dqQx8akdJf3zKzsGoplXqGDcxEmXSMVX/QEa7HXYr4HmGdxpiaovRRoiTSNommuw1zOz+YgbLlN/9PsGdM2zwN5kz2Tl2dS2j9sHe77f6JmiKNLxF5ywDjE+4vcvIHMw7zHiY8P17whBBhVc9liGa8BZfp6ZeJRHxXo/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iq1fkRD5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iq1fkRD5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D9AD1F00A3D;
	Fri, 12 Jun 2026 16:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781282789;
	bh=mtAVy1u9/Zaxp8fZzeySoG/NXQhWeHkmxw4ZYwc18h0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iq1fkRD5fsi52Iu8j41RWp9eW1YhJbCuz6c9ZOGid4FaksVuvdm8Klp44Kx4U2X8o
	 k6gtTxiG+GRCwB9zo9fJ2PuuiNKeHl4Kx/tyv2RPm6DM2Nafhe17lejeweh4nfKJq4
	 0Ap6tWdIful6sA6Ayt4VAVl2mEN1vR4I/5QSv5f0oJwtVsEdk/Rdw0lzaJsWgCUIyz
	 EkbFxaS/U7emSSPdt+lfFpWgBHoFTjXGasL8ssm5GvAUWitrBml7hDdV1Xf4ITm9bO
	 XUF0OC7AqzxImcH8iDNGSEv71QuAk6lklbbFpj/mknMI3oZJfC2TaOD58uzuzwDrLt
	 yqXMiqyOHboWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/5] vfio/pci: implement get_tph and DMA_BUF_TPH
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260611161546.4075580-5-zhipingz@meta.com>
References: <20260611161546.4075580-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 16:46:28 +0000
Message-Id: <20260612164629.0D9AD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Unconditional validation of the flag-gated `ph` parameter outsid=
e its flag gate.
- [Medium] VFIO_DEVICE_FEATURE_PROBE incorrectly reports that the DMA_BUF_T=
PH feature is supported for devices that lack TPH completer capabilities.
--

commit cadaa92f5a8da2be3b081b506699064b7bf68059
Author: Zhiping Zhang <zhipingz@meta.com>

vfio/pci: implement get_tph and DMA_BUF_TPH feature

Implement dma-buf get_tph for vfio-pci exported dma-bufs and add
VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
for a VFIO-owned device.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index 1a177ce7de546..0a0705c8dbea6 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c

[ ... ]

> @@ -333,6 +360,71 @@ int vfio_pci_core_feature_dma_buf(struct vfio_pci_co=
re_device *vdev, u32 flags,
>  	return ret;
>  }
> =20
> +int vfio_pci_core_feature_dma_buf_tph(struct vfio_pci_core_device *vdev,
> +				      u32 flags,
> +				      struct vfio_device_feature_dma_buf_tph __user *arg,
> +				      size_t argsz)
> +{
> +	struct vfio_device_feature_dma_buf_tph set_tph;
> +	struct vfio_pci_dma_buf *priv;
> +	struct dma_buf *dmabuf;
> +	u8 comp;
> +	int ret;
> +
> +	ret =3D vfio_check_feature(flags, argsz, VFIO_DEVICE_FEATURE_SET,
> +				 sizeof(set_tph));
> +	if (ret !=3D 1)
> +		return ret;

[Severity: Medium]
Will VFIO_DEVICE_FEATURE_PROBE incorrectly report that the feature is
supported on all devices?

vfio_check_feature() returns 0 for probe requests, which means this code
will return 0 (success) before checking the hardware's TPH completer
capabilities below. Should the hardware capability check happen before
returning the probe result?

> +
> +	if (copy_from_user(&set_tph, arg, sizeof(set_tph)))
> +		return -EFAULT;
> +
> +	if (set_tph.flags & ~(VFIO_DMA_BUF_TPH_ST | VFIO_DMA_BUF_TPH_ST_EXT))
> +		return -EINVAL;
> +
> +	if (set_tph.ph & ~0x3)
> +		return -EINVAL;

[Severity: Medium]
Does this code reject valid clear requests if the unused ph field contains
uninitialized data?

When userspace sets flags =3D=3D 0 to clear the metadata, ph is effectively
unused and might contain garbage. Validating it unconditionally outside of
its flag gate could cause valid API usage to fail with -EINVAL. Should the
ph validation only happen if VFIO_DMA_BUF_TPH_ST or
VFIO_DMA_BUF_TPH_ST_EXT are set?

> +
> +	comp =3D pcie_tph_completer_type(vdev->pdev);
> +	if (comp =3D=3D PCI_EXP_DEVCAP2_TPH_COMP_NONE)
> +		return -EOPNOTSUPP;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611161546.4075=
580-1-zhipingz@meta.com?part=3D4
