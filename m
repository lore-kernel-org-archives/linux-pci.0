Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762013812F1;
	Tue, 14 Jul 2026 11:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784027687; cv=none; b=HtKUCPHS6p2QEE1jYVTSTNf6ydoLnm32Efo8VEsc9YSqnNpD7aGLnBobLU49sZomzvCnsWnvhQKtSRQyPg7sz9OaQMAopCpVL6lHE44y3oeX6PXCsAacDFv2uxmz/vD3pW7MBSPcF+RrUkRe7sP47nj0KMyFxgsnvLKBoIScM0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784027687; c=relaxed/simple;
	bh=1uxJU68NWG3yfI2+FnaMWxfdrihNVqxjLTMRvW9x7Fk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQ4pme3oGtqtlKSOQYvuBYsnaooTKpjIIda/VOnODWCBiZ8mJrMJzg/MeIkzJfZ/kyPgoXAtfLk1pU0UfC1nLDMmYxZpa3s1fJhnT9XGcDYZK9hhmXZE4DUWwfvRrz5RziDzAVO8sIihaJnfp520c0/QL382V6bnx0B++HxQbDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh08sqih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh08sqih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06F31F000E9;
	Tue, 14 Jul 2026 11:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784027686;
	bh=f23+OPq/pAmB2sVf60LlrAq6TNTWaBKLv1/lotO0nFY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Rh08sqihTXESjI5Vi7Bk7E+OTjBn1Ki/bO8poTgmIrlLqnIkR8kfghWUKxo9yy9v4
	 4ig4/tVVPlE7cY23K34kJo7tGoIwFP3heP7RP+IWAZox7o+DFsOMR3hG8ZHDfJhIxT
	 rSX0h3mGQ1oHVMRxiTTj4ofC6LYkK8vy8FPbedZ1lFbYCyEcHM3Kv3obcZezpT2tXt
	 1w2GOfOw6D2ycr0IbuRvCR7SlqE9aJSKmveQstJfcktth2fgbT5iWJ+w9pMv47ktt+
	 at6V7RHkU2c01zz0H7I353iEhCMgESthJT/Iydl5SeaXO+js432HsMPSQVh4gJIXtY
	 SOOtDFaJUloOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 13/16] vfio/pci: Add IV-ST TPH policy and VFIO
 TPH_ST batch programming support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-14-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-14-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 11:14:44 +0000
Message-Id: <20260714111445.E06F31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unconditional call to `dma_resv_unlock` even when `dma_resv_lock_i=
nterruptible` fails, leading to unbalanced unlock.
--

--- Patch [13]: [PATCH v20 13/16] vfio/pci: Add IV-ST TPH policy and VFIO T=
PH_ST batch programming support ---
commit d4cf54f638f6e3b2fed97fa978cb257c72da35af
Author: Chengwen Feng <fengchengwen@huawei.com>

vfio/pci: Add IV-ST TPH policy and VFIO TPH_ST batch programming support
   =20
This commit extends VFIO TPH implementation to support IV-ST mode based on
the existing NO-ST baseline. It adds the VFIO_DEVICE_FEATURE_TPH_ST feature
to enable batch ST table programming for NONE, DMABUF, and CPU sources.

> diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci=
_core.c
> index 82582c8ef69da..df31f4e8766fa 100644
> --- a/drivers/vfio/pci/vfio_pci_core.c
> +++ b/drivers/vfio/pci/vfio_pci_core.c

[ ... ]

> @@ -1680,6 +1690,32 @@ static int vfio_pci_get_dmabuf_tph(int fd, bool ex=
tended, u16 *st, u8 *ph)
>  	return ret;
>  }
> =20
> +static int vfio_pci_get_tph_st_tag(struct pci_dev *pdev, u32 src_bits,
> +				   u32 src_hndl, bool extended, u16 *st)
> +{
> +	u8 req_type =3D extended ? PCI_TPH_REQ_EXT_TPH : PCI_TPH_REQ_TPH_ONLY;
> +	int ret =3D 0;
> +	u8 ph;
> +
> +	if (src_bits & VFIO_DEVICE_TPH_SRC_DMABUF)
> +		ret =3D vfio_pci_get_dmabuf_tph(src_hndl, extended, st, &ph);

[Severity: High]
This isn't a bug introduced by this patch, but looking at the implementation
of vfio_pci_get_dmabuf_tph() which is called here, is there an unbalanced
unlock if the lock acquisition is interrupted?

In drivers/vfio/pci/vfio_pci_core.c:vfio_pci_get_dmabuf_tph():

	ret =3D dma_resv_lock_interruptible(dmabuf->resv, NULL);
	if (ret =3D=3D 0)
		ret =3D dma_buf_get_pci_tph(dmabuf, extended, st, ph);
	dma_resv_unlock(dmabuf->resv);

If a signal is delivered to the thread while it is attempting to acquire the
lock, dma_resv_lock_interruptible() will return a non-zero error. The
if (ret =3D=3D 0) check correctly skips the inner function, but does this c=
ode
still unconditionally execute dma_resv_unlock() and corrupt the lock state?

> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_VOLATILE)
> +		ret =3D pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_VM,
> +					      req_type, src_hndl, st);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_CPU_PERSISTENT)
> +		ret =3D pcie_tph_get_cpu_st_ext(pdev, TPH_MEM_TYPE_PM,
> +					      req_type, src_hndl, st);
> +	else if (src_bits & VFIO_DEVICE_TPH_SRC_NONE)
> +		*st =3D 0;
> +	else
> +		ret =3D -EINVAL;
> +
> +	if (ret !=3D 0)
> +		*st =3D 0;
> +
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D13
