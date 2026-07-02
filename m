Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458CB35DA56;
	Thu,  2 Jul 2026 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997274; cv=none; b=cxeREyAMcthfx0Dk0g1GNPsFM/GyXvfoDLMYrD1UsZ652G28c6AHHdE7ZLeJEUj+4AderblnT9EHmOm/JT7ihwWJtQiMoDKErShaO1xiMP+7WkUN0+v8eAkBhsYgHEVWHK4Dc5I2y4R2fdszg6QiVJP3vAWbqL0ajxfCODL5QZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997274; c=relaxed/simple;
	bh=9LPJGXyNMZVlWU5xi93yd6jDl5jHLT/UW1Hw3Im2k40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IViA707o1hDNmjN2jhsHlHHs+hx55KxiE9On2FDbiGtH7sr8jvqr5diZnN5BuZ4NUqlR40RdUWLpodL8mVUnq1imoAwGnA6mJfKlOzzArwD20dOWtBrynls5WCrKeUSVUgO3FpQuw3KeRTNhUCUXu85GGgITgRb8ysxshbXKwfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icR9xknb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icR9xknb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53211F000E9;
	Thu,  2 Jul 2026 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782997273;
	bh=oEp+/vGoImFliTwzEu1dW5vHYfkf55jjEfFR7L2vui0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=icR9xknbNacH8A0jCl/NZBp2kmjn5HKIGxpaXCh8XXZIqoWdfOiNGLClJtOqLgRbb
	 qqiuFJUn3lvxtt1P8ZU7uJWrP9mG1dSU5EgvF/9AcaLPvBxGhvAogqmFBJtPrZcZzV
	 n2jv8GZPT1G+xQvDPczumvRpl7DsOHDtSZVQvIHbrFhMF7vh+Y658eHYzb/J8mCmHr
	 cBTAavXc14htX1zipXIwAkjA69LeN+yuRPmxhUATKBFK9CsAz7C2hbY0JvpuTuW8If
	 VPlIQoRIFVmvA04BiFYY6BSgikC/F9LZuNMhR79bYlwTSMIRwRUf6YuOsALgAUJrba
	 1R4UTOE5XBl6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 13/18] vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH
 family uapi for PCI TPH control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260702124224.57168-14-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-14-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 13:01:12 +0000
Message-Id: <20260702130112.D53211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Missing dma_resv lock around `vfio_pci_dma_buf_get_pci_tph` in `vf=
io_pci_dma_buf_get_tph_by_fd`.
--

commit dbd8da4bdde63982d3f30b59ace151720f7b743f
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Introduce VFIO_DEVICE_FEATURE_TPH family uapi for PCI TPH control

Add user API definitions for PCI TPH device feature set, including three
feature IDs for global enable, resolving PH/ST, and batch programming.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..d9c5e434e586f 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
> @@ -81,6 +88,26 @@ static void vfio_pci_dma_buf_unmap(struct dma_buf_atta=
chment *attachment,
>  	kref_put(&priv->kref, vfio_pci_dma_buf_done);
>  }
> =20
> +static int vfio_pci_dma_buf_get_pci_tph(struct dma_buf *dmabuf, bool ext=
ended,
> +					u16 *tag, u8 *ph)
> +{
> +	struct vfio_pci_dma_buf *priv =3D dmabuf->priv;
> +
> +	dma_resv_assert_held(priv->dmabuf->resv);
> +
> +	if (extended) {

[ ... ]

> @@ -106,6 +133,26 @@ static const struct dma_buf_ops vfio_pci_dmabuf_ops =
=3D {
>  	.release =3D vfio_pci_dma_buf_release,
>  };
> =20
> +int vfio_pci_dma_buf_get_tph_by_fd(int fd, bool extended, u16 *tag, u8 *=
ph)
> +{
> +	struct dma_buf *dmabuf;
> +	int ret =3D 0;
> +
> +	dmabuf =3D dma_buf_get(fd);
> +	if (IS_ERR(dmabuf))
> +		return PTR_ERR(dmabuf);
> +
> +	if (dmabuf->ops !=3D &vfio_pci_dmabuf_ops) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	ret =3D vfio_pci_dma_buf_get_pci_tph(dmabuf, extended, tag, ph);
              ^^^^

[Severity: High]
Is it necessary to acquire the dmabuf->resv lock before calling
vfio_pci_dma_buf_get_pci_tph()?

Since vfio_pci_dma_buf_get_pci_tph() has an explicit dma_resv_assert_held(),
calling it here without the lock could trigger a lockdep assertion failure
and cause data races when reading the priv fields.

Should this code take the dma_resv_lock(dmabuf->resv, NULL) before calling
the inner getter to satisfy the assertion and prevent races?

> +out:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D13
