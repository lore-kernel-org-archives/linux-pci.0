Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3070B4A2A62;
	Thu, 24 Sep 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264063; cv=none; b=dqssQUAdUjve+hWj9Ee6C3pBSZQovRnbgJ66SggHIfotLtDBhi72WCBYQpIijyVV5Xgort+xZGhIHfxIh6EtWcEc/hOZwq0816H2MHPRRNPN3K3X+7Q6vZH0QDFV/Ke7mLL5PcA8T+hWfgKG5fhu1U8DMRjAW3Ox7DD4efC/3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264063; c=relaxed/simple;
	bh=Afqp5XnClEqiK2xol6lnQuzxFiRulHaTe99w+2C7Nbw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rqw6yKutGnP73STpa/JTgyeDg0XZ2APBiHWVMAOVfZHOTcgSpY8eJdOOP1hlth1LWuco6uV+iXPyOrXBo8xT0jmso/aBwQB5bJNNutNpHO2ruSkr2zESoRfGbnzCme/7RJLIoGVtHw28gnz6q07vVQGcNPcC05WwxClBjM+2RnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlGMvFMh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlGMvFMh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB11F000FF;
	Thu, 24 Sep 2026 15:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264061;
	bh=az7xxfOSK3d7joncT9mggFE1+UrHB7sT8pFuodahjII=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jlGMvFMhOQ/royNRBsJE1AzE6EFZnpSugaXsY9pSyNDNx+Opa1coatYKIZU+sVWi+
	 rjweNpyTtcLq8k32gJB9ukF7ALzlKMw+dJZk/0WHjmjnnxMlrtPCnteEEAkhMAgUBg
	 41MKL5u2DBDcUg9gBU55tfjDTyvq32illNz5qbh6MHSpMi2vhlA+SNqyOMwF9N95ZC
	 zAYreI66RZtAa3KvrRYbU503ni/Fkq8gAPBVXm9Ijx9MRN/NrNneGk8O25/SN0uKtv
	 04nx2G1zAj5gqxzT/JnCSi9JI3coWcG3TfdyC8IK6gaSVtgXFJUxED8x31h9vcnkMx
	 X8FuVKXTBdrKQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-7-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-7-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:34:20 +0000
Message-Id: <20260924153421.77CB11F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D6

