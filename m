Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEAC363C6F;
	Tue, 14 Jul 2026 10:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026231; cv=none; b=MHneFtAzzUCluSnzNO722U3TFEDeSoPO1SBg0zTcOjj6fh6RvQRCSFIuYqSRTYFOBGGcHNIjUm/xqjv7LnCWRAGwkmmguURc5+Pr+UN+zTUr8PgzJ8lVcwToxNeaRXpMkfqf/hmg4d4MWRK8tViw7ML8tdN2arj7ek0UF4A854g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026231; c=relaxed/simple;
	bh=M+karQ9eg8fQdrsUhkW5rTcYCTh8DX/A7OJXiFXHCqY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aiJL9mnfq0aVZWeaX+KLqVz9uYW+Y5zx+SjtCS+11Um+3veIEFJs4ZtZpJsq+H9E1fGgFwRBDvrop3hVWHYD+nf3CrIFFk+8P3D4DTCq/07kXExEssHtxI0lix+59s8c6rwAYtMaOQZCqBxp9VeQg7HJkRcVeEyZidLUs12+8vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnv3+aE+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnv3+aE+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472561F000E9;
	Tue, 14 Jul 2026 10:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026230;
	bh=M+karQ9eg8fQdrsUhkW5rTcYCTh8DX/A7OJXiFXHCqY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nnv3+aE+AVU2cVerIwgGaf8/A4+OmcZIGg/Rj+1KYpCdj/ybqCKSTnLRnl/ooB1ff
	 XUn7bNgNDXaqc+4WWitY+RLqYKplX13OPAdbvVAWUEXeE/Yl93fVe2claulae6mkBI
	 8gthD7AwhZPsCKgshNA8xusCB5VY6NXcSP5v+BzC0mHj03kL+wyLvnQSGjjTz9Ujx2
	 x2mJ2+cBNUBNIAeZxhwkSBaD5fKteGl1trZ9m8SyMkgGP6PlZjVzz8Vb+uDWUcD/w0
	 3qS6TVKbts/kzM5Av931VL0V5T8DrIWK+Me3PH99fMGILOWHGBUxZWeF8Wa0dyNcJL
	 FUMLl2cswLLDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 03/16] vfio/pci: implement get_pci_tph and
 DMA_BUF_TPH feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chengwen Feng" <fengchengwen@huawei.com>
Cc: linux-pci@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260714104325.54444-4-fengchengwen@huawei.com>
References: <20260714104325.54444-1-fengchengwen@huawei.com>
 <20260714104325.54444-4-fengchengwen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:50:29 +0000
Message-Id: <20260714105030.472561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Zhiping Zhang <zhipingz@meta.com>
>=20
> Implement dma-buf get_pci_tph for vfio-pci exported dma-bufs and add
> VFIO_DEVICE_FEATURE_DMA_BUF_TPH so userspace can publish TPH metadata
> for a VFIO-owned device.
>=20
> 8-bit ST and 16-bit Extended ST are distinct PCIe TPH namespaces; the
> uAPI carries both with explicit validity flags, and get_pci_tph()
> returns the value matching the importer's requested namespace or
> -EOPNOTSUPP.
>=20
> Publish and read the TPH descriptor under dmabuf->resv, matching the
> locking used for other importer-visible dma-buf state. The SET ioctl
> takes dma_resv_lock_interruptible(), while the callback runs under
> DMA-buf's asserted resv lock.
> [ ... ]
> PCI_EXP_DEVCAP2_TPH_COMP_EXT_TPH. Make PROBE follow the same hardware
> gate so the feature only probes as supported when the device can really
> consume it.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714104325.5444=
4-1-fengchengwen@huawei.com?part=3D3

