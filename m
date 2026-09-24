Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C027D283142;
	Thu, 24 Sep 2026 15:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264335; cv=none; b=ePfOomP4ebiWg+j4hSiY1ylXJOGCr515NquM56iOaoKv345sfMX0RTEPhxwDiM5ie1JO7hzfWEaYZ8I+PANfuRll7P7js5ftqVWcx5veA2LnCe/OSmuTCoWenrzeRWT/Nv+VxV6MpED8WHSWMsBoJPeHI0rI3ytCal8XkZqfd+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264335; c=relaxed/simple;
	bh=mWIxE53dNbsNhT47c3nH58jBRfaByTW7aWRghCyGy1k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Sqwi4j7OzajNYwmiRM5Db6Gjh1MtUUgKlVhQvdf6NFiiqZxx9XlRlhUX4YyVXYirSttLZYoyc0ScmacVNQbEhmYyK8vRaKHBQCF7SSrt7ig6PSpYxHs1+NVN2mMRgBLKJ/cKJ8tNZRoWgWrCOiZyEvSYDi4FuSlVPzhf5kX2r38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTBPhELI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTBPhELI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F7021F000FF;
	Thu, 24 Sep 2026 15:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264334;
	bh=akutNHbzTxDEF9m34BiAHrNOwltYDiuyMm35he8BXEo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bTBPhELIRN3O0FFn8rpkmZEmYBQLN/8ZJX9fWuZ2YU+nsYszze+8Po6E2Jpkx1/U2
	 csSAmCdllvo6txJLC5zGIYOQEIRXycEUR2jXLQiZCsxHIWtiRgVdUo8BIveljHW2nQ
	 UbCjydyZNZc1l/gbAwQpobRjn0br/M5EesAtxQ67z9UrKC8jsDW8Wx2ZQne4Y4AGls
	 INJ91jqLgCH/y0bJchnHu7Ii1zPf9g9rdXPPFTLIz0IMAmVDkydnbNJGdFCibyKJqZ
	 RR5RoUM9ekOIuy56k9wImJFfBzeSmO59rpxTjSeQikGWDqnHT0bD5Y7TlHBal8T0IU
	 Chd99eqtvZhOw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-6-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-6-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:38:53 +0000
Message-Id: <20260924153854.2F7021F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> This helper, vfio_pci_core_mmap_prep_dmabuf(), creates a single-range
> DMABUF for the purpose of mapping a PCI BAR.  This is used in a future
> commit by VFIO's ordinary mmap() path.
>=20
> This function transfers ownership of the VFIO device fd to the
> DMABUF, which fput()s when it's released.
>=20
> Refactor the existing vfio_pci_core_feature_dma_buf() to split out
> export code common to the two paths, VFIO_DEVICE_FEATURE_DMA_BUF and
> this new VFIO_BAR mmap().
>=20
> By exchanging the VMA file, we lose the original device path in
> /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented synthetic
> 'filename' for BAR mappings based on the BDF, plus resource index.
> (This does not apply to explicitly-exported DMABUFs which are named by
> DMA_BUF_SET_NAME.)
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D5

