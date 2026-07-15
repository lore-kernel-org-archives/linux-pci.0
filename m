Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD84A3C3F45;
	Wed, 15 Jul 2026 18:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784138453; cv=none; b=VUSQT8RkoeaPy3wbfCYC383yQjIkmX5zoV2j1ggXmD8t0a/rsN1SaoO+I2BIZ7cbFeUZGGSDdtC9RB0/LOZfxQ4wdPmpRN9+yyi+aBAGbSL4bxY78eFnaDQX7hT1PAfNaupX23G0Gs1qWUaheQ3wvAfxzvMLZgPxtW8RvGvd+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784138453; c=relaxed/simple;
	bh=HD5Xr3yfr9xBxnX7U/CP9jh8HNr5rPvfcU9Nkg9gwQY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XptdtrrkkcHZKfKKf6YNlW4AAQ0/4iv+D4jirvnsHt9TJ018mFYEbrJPNizPw4/eVJB3M3Xvzn7/N2HKQ2GhcJIc43NjNNSmBbemSG1Iqv0kSGOTPGTXWnOidtdrcoWAEMmBUCO7hXUzsZzeWSyTeA7/vb6YLVU1dl38ReKVHac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iy++/YYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iy++/YYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461811F000E9;
	Wed, 15 Jul 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784138446;
	bh=mt/qyZsjAXmu+EfSDpNx+Y+StIHSiAcH3j4YcjkH7Hg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iy++/YYaF3cXdzJyt4kddA0w69eF1nL5DbVdlXExYU0VAih2ODGzrrpE/3yP7MWrE
	 oSEZmbIFClt5THVbqjaJmzMcM3f/wzymieIOi0Do2CYGpVSsQzVo3ur+OF+hcYQoSF
	 ZhGkGSt5DcHZDFxrBIHdRPXPF8ehjDFS/2/Q+Jjk9cV93880fOPUiDFmRTh7/u8qly
	 7hs9UD9J6uL6kmY0xe5UwBhMuXF7IYOty9UsNYmkdOB4s2ZXSpncSYFXJouXOiJr0f
	 SvA2Kc7sD14CFfAUWYrYSq11UXS9MxgGGPoK7vtvkGmUcI+mv5A67OllrF+4AhC3H4
	 SGntUnodngy+w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 7/9] vfio/pci: Clean up BAR zap and revocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: dri-devel@lists.freedesktop.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260715174737.15287-8-matt@ozlabs.org>
References: <20260715174737.15287-1-matt@ozlabs.org>
 <20260715174737.15287-8-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 18:00:45 +0000
Message-Id: <20260715180046.461811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Previously, vfio_pci_zap_bars() (and the wrapper
> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
> calls to vfio_pci_dma_buf_move().
>=20
> This commit replaces them with a unified new function,
> vfio_pci_revoke_bars() containing both the vfio_pci_dma_buf_move() and
> the unmap_mapping_range(), making it harder for callers to omit one.
> It adds a wrapper, vfio_pci_lock_revoke_bars(), which takes the write
> memory_lock before zapping, and adds a new vfio_pci_unrevoke_bars()
> for the re-enable path.
>=20
> As of "vfio/pci: Convert BAR mmap() to use a DMABUF", the zap via
> unmap_mapping_range() is no longer performed for vfio-pci since the
> DMABUFs used for BAR mappings already zap PTEs when the
> vfio_pci_dma_buf_move() occurs.
>=20
> However, it must be assumed that VFIO drivers which override the .mmap
> op could create mappings _not_ backed by DMABUFs.  So, the zap is
> still performed on revoke if .mmap is overridden, using a new
> zap_bars_on_revoke flag.  A driver can explicitly opt out; the flag is
> cleared by the hisi_acc_vfio_pci driver, since its .mmap just wraps
> vfio_pci_core_mmap() and so still uses DMABUFs.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715174737.1528=
7-1-matt@ozlabs.org?part=3D7

