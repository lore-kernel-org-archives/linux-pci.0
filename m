Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C40D374E67;
	Tue,  6 Oct 2026 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791316456; cv=none; b=QDKIeQfbC8w4sztN/8VDEyyxoeZO2iJ9ul6ef2B77vdGzbM3NfjhdIBoZSuDcYMhdUMZo/0190shdZ5U+r0OpQKI/VbOFLm9bd04uqVePgZiKskOoUDF0Oxyu3hxEBot2Xxv5g7HskONAFnx01U5Re+0G2bI5nJy3jsVp4VomKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791316456; c=relaxed/simple;
	bh=roRs0JJHwdLqyg0+aeS3sau1hFZW9/9hhC7lyswoj2s=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ARz+N1w91EzuxBlF9eihTJF2dHKQh93hwoSCQfG7dwQ6EZdxBZB8sgCQKGqn9LHKrb1FfMtgBcBMZA1vz68xsONfEU93ElDACu2xbRujwnZrehiAsYMifDfEKlctuLrBlI62Y92LbqUqVEpwsIigs9zXB8DuYTH5gKD0drcsYfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu5VPByq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu5VPByq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EA11F0089B;
	Tue,  6 Oct 2026 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791316454;
	bh=LM9oiKFJgjIDJzKgs29cUjsil50ET+x9NLx26CRTP0s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lu5VPByqH5Ud6ZLp9nNtKioWJAdmxTjIQbyZ9vXTST0PiBtZ6+LGc+S6k6iRv6Ql9
	 eXujMLAQbPJnoHvieXaV9T07Tn5WbtIy3MEsICBLEyJvo2L7nmhxhHAWiE6vqBvzPt
	 PppbFUN66iHX1fnKibhkPoCo2l+0yG/XN/iZ/vp/GkxazRRS0DZNkYGWKMwZC9rJ3a
	 /CUtazRSr9sPYyeaijgGP1KYKGHPTVAZ3QEgryLX7uf6KZZO65towU/uRS7caZauIs
	 BQcHcoygvxybz0L+g0zqoUQqHtIC9VPQ6vMkKMZiT4h9sNgT1OiC10PV0idOLTwHoI
	 s0datMzPc/psA==
Message-ID: <sashiko-outbox-162415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 7/9] vfio/pci: Clean up BAR zap and revocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: kvm@vger.kernel.org, dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, linux-pci@vger.kernel.org
In-Reply-To: <20261006193643.76330-8-matt@ozlabs.org>
References: <20261006193643.76330-1-matt@ozlabs.org>
 <20261006193643.76330-8-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 19:54:14 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006193643.7633=
0-1-matt@ozlabs.org?part=3D7

