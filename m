Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F28374E67;
	Tue,  6 Oct 2026 19:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316557; cv=none; b=bwYogpBtXH9JVbf78oa6BgLj8HZ6mJ+PYa73+L5H4N6xiHA5P1fu89pwmZKWsrrfBNmfdCD1raUrjj3oUqRZRCp1LwwmLgSEd0e5Cb0SXRyPrrP/dSp9lbruvnoh/ZwMrEZMPlPZ6HrdCaVBq0FcKj1ZlA2MIjUFIUHTdQ37DzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316557; c=relaxed/simple;
	bh=aYS18VeFMk3O2cvYj3osOcGXOQOPrte7eUeclVdyyjE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u3fxwSwvDd+5lw00GyufVeXVkrlDGgX5IbZyRmoQIzvXQMmKnRI0PflvihGJryZzaj00piwXNRk0/TeM8gjpxnqq63lgfWlxLW/bzCVKGkT/uiKoZjirjZWN7SGy2kK4LXudobzkTYum/62CF6in2ghz2EV/XUPt2Cwcg5iK4f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaZwKJQ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZwKJQ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBD81F0089B;
	Tue,  6 Oct 2026 19:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316555;
	bh=32tXOzelsXj6KNb13L9MtsbUTLzJ2HjQRseQdrpAnpo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BaZwKJQ3THMbgtlDOf6BSBOM2Gepc+B3NFmejwivVQOVfjaDN7V0DuQJP3Ad/iVf5
	 CJlCXBT4+BMWwx7b7UNAr4PPKaX+IzNGklYAc4ZZOjjkFYBb2K77d6uVDE3a0PMIGS
	 GPAj8ZqJDs5pSPoag5IyofM4vNxi3C9y3qmVz59CkoS9hsx5V1luUh2Xd0MIkuh91t
	 B6paMXq2crKv/WRHMYCoIIjDl3x5BHI8oTqquQxiubekTnGpTi1lMRFqaFJ7zmQT+y
	 n6FY4eMkUSPDbgTS4agBZkM1LTDT/RphUpcpWOUw6ZDgKx8fmjKw/gTWrcRHUmqik9
	 U+f1vO3Ky/27w==
Message-ID: <sashiko-outbox-162416@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-7-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-7-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:55:54 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Convert the VFIO device fd fops->mmap to create a DMABUF representing
> the BAR mapping, and make the VMA fault handler look up PFNs from the
> corresponding DMABUF.  This supports future code mmap()ing BAR
> DMABUFs, and iommufd work to support Type1 P2P.
>=20
> First, vfio_pci_core_mmap() uses the new
> vfio_pci_core_mmap_prep_dmabuf() helper to export a DMABUF
> representing a single BAR range.  Then, the vfio_pci_mmap_huge_fault()
> callback is updated to understand revoked buffers, and uses the new
> vfio_pci_dma_buf_find_pfn() helper to determine the PFN for a given
> fault address.
>=20
> Now that the VFIO DMABUFs can be mmap()ed, vfio_pci_dma_buf_move()
> zaps PTEs (used on the revocation and cleanup paths).
>=20
> CONFIG_VFIO_PCI_CORE now unconditionally selects
> CONFIG_DMA_SHARED_BUFFER.  The CONFIG_VFIO_PCI_DMABUF feature
> conditionally includes support for VFIO_DEVICE_FEATURE_DMA_BUF,
> depending on the availability of CONFIG_PCI_P2PDMA.
>=20
> When the DMABUF feature is not present, DMABUFs are used internally
> for the BAR mappings.  In this case, DMABUF attach is prohibited (and
> the requirement for a P2PDMA provider is relaxed).
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D6

