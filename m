Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16B48B378;
	Thu,  2 Jul 2026 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996985; cv=none; b=VLKXbwel/YcHhSmveVqSSxfPZUQ9B1T8Yl/blrH9EGARE+yOSGkz7cLFvH8z4XQFesMIHy6A3mkrQ4KIW4NzlWrMI7jOxIEfHrnx2JSpiI/GX0mSyAqyUVdae7BsXqgrBhiWA/F6wSmbGQOWsHaIEH4AhZq5iWRPcJMMnBBLB6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996985; c=relaxed/simple;
	bh=rjFJfc2Kai7/NHqo9hojqkigDUPg8YRKUdeTBmieO3I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LjbtVU8b8mUtvKXYMmH8BQqEsOfOKQZEAHkRZPL/fBOQKjJJP1BD4T1eR5kAEd/fdMvrvvZnuvSIT48K/RDO/0d5HwFJAfMpF5yQZPveICCUzA/9I5bqr8wSZ4y9vQ2RmWa+q4HL0Wa0xP8OGHOw3DZxDD5oFM7F8LBou1kOpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P3KiiVHa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P3KiiVHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB531F000E9;
	Thu,  2 Jul 2026 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996984;
	bh=DZMWL21PYMzjDz025ycT1cTmJizrgW1fmZt35r0hZuQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P3KiiVHazqqvSqNvEoDzkwKxZABtaounU59UYQCsNVJIKSNtPZqSE4h2m3RRWuEU5
	 ux5eZ05Tnh83vZ4hC+4fTS89xCpoC2wlQXIhHYB+4uEQ7mu6s7gt4Xh5QDt4F/UVmd
	 xKuadDv7bzxdRhcJjglREE5BZtpZMtBizVGoxMG9zd1mA4CnJSXoNmLlX2+1DssrT5
	 TICPKNX++Frir/OEoCwbK83hZaEtGz3fqcOeRpDoLU4KpYv4cQZQuoxxfPNeGVFohV
	 CwKllAyNBMvtJIi7fakQmcB0KYNhbokBcvhRLmu+D3Ul+jHJCu/blWMj5L4hXeoGiL
	 cXjwVZ1xfy45A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 12/18] vfio/pci: Add dmabuf TPH metadata storage and
 fd query helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702124224.57168-13-fengchengwen@huawei.com>
References: <20260702124224.57168-1-fengchengwen@huawei.com>
 <20260702124224.57168-13-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 12:56:23 +0000
Message-Id: <20260702125624.1AB531F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vfio_pci_dma_buf_get_tph_by_fd() fails to acquire the dma_resv loc=
k before calling vfio_pci_dma_buf_get_pci_tph(), leading to a guaranteed lo=
ckdep splat and a potential data race.
--

commit cb20e399309e26c4cb897d3a87f672443b48caa4
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add dmabuf TPH metadata storage and fd query helper

This commit adds TPH metadata fields to vfio_pci_dma_buf to store
PH and ST information along with their validity flags. It also implements
helpers to fetch this metadata from a dmabuf, providing the foundation
for upcoming TPH resolution features.

> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_p=
ci_dmabuf.c
> index c16f460c01d68..d9c5e434e586f 100644
> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
[ ... ]
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

[Severity: High]
Is it necessary to acquire the dmabuf->resv lock before making this call?

Since vfio_pci_dma_buf_get_pci_tph() asserts the lock is held, it seems
invoking it directly from here will guarantee a lockdep splat.

It also appears this could leave the read of the TPH metadata bitfields
unprotected against concurrent updates, resulting in a data race.

> +out:
> +	dma_buf_put(dmabuf);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702124224.5716=
8-1-fengchengwen@huawei.com?part=3D12
