Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012539902D;
	Tue,  6 Oct 2026 19:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316399; cv=none; b=iDn/oWrSMZTJm17vdXZInRJHTuj6xiGHXhKyysUOvFw96uhHJC3E4L3g+I3I7Gljb8G72wDYYvw9PWvPytyFhyHJgMRCr9WsF3xPAtftMH2RpU+vRtlKt+Q8ksnm72OuF1AfJQQKwu51fU4JwJM/9Meg2IDgFfFbPV/7Q4omzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316399; c=relaxed/simple;
	bh=zaMRKBe6V04HOzMvP1qBXVjFa4PRlv25u5eIcKWROIQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R1/U7wUoCH5SMPQ3T6CFZgcla/BGEiYnHqRq+O/11gaNQJBTcrmhmEj5z4MspNHvf/11mYX1ZmlrhXKsww4wLcrOglCoz6VSYeTKaMISvEdcV5dQZ/VPfR+AharRT4Yb0EyFayvobZahE9SihP2ABJ/OZ/cnb3D5m4IA+u2nCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NlfE12ko; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NlfE12ko"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB2F1F0089B;
	Tue,  6 Oct 2026 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316398;
	bh=0hmkFwt9p2NisZAv7OaJv3bc/TXSWBRTiUQhA7DyGsk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlfE12kovdalabd3rXaub0z1DL7mYW+xBlsTCsUdCN+jWEo92UR89X2NJGxys3Ayq
	 JOQyQMkrBnZS4nwFEWsFcXOMPddTPTbOo6X2zcDgndIr0X1RBmbAxwfwt0VxPY+wXH
	 gTmt5ceH0bnmzS0JeJ7GCdSLsia5AQHlYYUIjCoMN+/bzAg6LgnNdgSliy2M7JWQm9
	 AyyQNC4cYP57sngQnIyu4zbwJCwtMFhmZVfrrsIjIPzBPmTq1M3VJW6oSPG3zwcxga
	 pA9fvOU9XUtzHo87QOO5mTlWW0hSfrZ2nvcx5eo2TPrRfB/gpgflGEebzt2qs8bjP/
	 JVO08kMzfHGKg==
Message-ID: <sashiko-outbox-162413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 5/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, media-ci@linuxtv.org, kvm@vger.kernel.org
In-Reply-To: <20261006193643.76330-6-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-6-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:53:17 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D5

