Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4195535203A;
	Fri, 31 Jul 2026 21:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785533906; cv=none; b=s07xean5imcjQHxe9hULVShwmXHBpcSvNcG8Ka3y8bI01OrvOiH/P38RjRdRyhNV4ngL5it/G95hKlGi0K+HX62zzEJETH+wBDj2/Hn4Y2382yFOtOQKVQrjAD5iGGOf8FBN+JBPzJlgv/erFAg6XKxfFx8DUw/I5lz53mrNqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785533906; c=relaxed/simple;
	bh=o7kaIlIb15EcE0hMc1jTcbz3QH3sjCuPYtJCxBOZ8pA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TBXcn9fz2Sjnnld+OIlOoM6DZikaHEI2EZ3dn4+H4QlqyUY7uDaimfFkrwZWzoSBKf7wDRmPb9b+6BXnN5kmXxe1JLiNNnGcuYsEFGcq7uz0iEjwBvaXzt2vtjQPaKmWtx83AUu6f+0HNeIYBenGOYWAk5nLIP8gyKVBVSFypzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6/ghXRw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6/ghXRw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37C41F00AC4;
	Fri, 31 Jul 2026 21:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785533905;
	bh=o7kaIlIb15EcE0hMc1jTcbz3QH3sjCuPYtJCxBOZ8pA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l6/ghXRwYNMzGq2nwoR2G9qwn1A5TNF0SxPKs+bD0Lw+j9PRg7A6PxKXf8w44cmIi
	 hXWjLAepyoa2s1OtsyK2mbEM3tEFSFRA2Ao4Pfr2t4PowqcA/ph7zFJa9fotObc7Mg
	 tLgK6N8puw9qTtCdXI0Wznpv23Jr4OIKLaEQBBV8LMaszNVeckyhg+RavEgt17lJX+
	 j7JMiIc4soUUKv44kHhvTYWYga+c2gfFdzeG/W099O7cuMkQOmA5sM9/4/jnpGWjax
	 xu7Hd1n9hVcyjI4L7KoqhIpRapkae/yWSHqvQMJQXPkAeUAdEoUsk1OeEiTxObSPyL
	 D0t415YWcBnPg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/5] vfio/pci: implement get_pci_tph and DMA_BUF_TPH
 feature
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhiping Zhang" <zhipingz@meta.com>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731211601.3033906-5-zhipingz@meta.com>
References: <20260731211601.3033906-1-zhipingz@meta.com>
 <20260731211601.3033906-5-zhipingz@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 21:38:24 +0000
Message-Id: <20260731213824.E37C41F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

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
>=20
> Hold memory_lock in the SET path while checking that the dma-buf still
> [ ... ]
> supported on a device that advertises TPH Completer support but cannot
> export a vfio dma-buf at all, so no dma-buf can ever exist to carry the
> metadata and every SET would fail later at the ownership check.
>=20
> Signed-off-by: Zhiping Zhang <zhipingz@meta.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731211601.3033=
906-1-zhipingz@meta.com?part=3D4

