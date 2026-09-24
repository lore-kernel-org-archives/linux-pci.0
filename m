Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E94A0F03;
	Thu, 24 Sep 2026 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264089; cv=none; b=emWsw1Y9jifSL5iXwYAYx00paL79brUgSnZ9rdlOyafh23qjNB6WxF7ehK5/kGIBtAuXpvGVJjftV7oHpURGGHeLvLesdS0nSVvIHVWyLvBVA9KBSpAAl0joWDjF3rci47qgvOk8AfqmaKNUDctdOyUnk1Pzzj2NcC7BsePwjXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264089; c=relaxed/simple;
	bh=uHwylYgB56cgoum85+3Ecr3mtQSwMScUwkFqCa7sH7E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YwRIkbzTLgzh0AMrFOzTQ/XolylT6fhA0PwZX/tqGE8LRVbflO06Yu1zNsElRddIcDklvEQ69jC86CKsv6c2CtoFD35iU0Q4xTnl3pDt5KZ6Uci+pWM/Dvqyfl/f+SM4ovi4FSG1YgpzrQP7ymY9xydpQYT2DJAmJP3ublhbPsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dAud4Vcr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dAud4Vcr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353B81F000FF;
	Thu, 24 Sep 2026 15:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264087;
	bh=h4Tf2vUdivgoMcY2ZUSCYrN3hrZSbKaJk08C4XCBqg0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dAud4VcrCdyio6E2yepaWeh1hkBiVFJzaEa6UEbrZvKtnVkWYGBakh9wAErQ8VgW3
	 DakbHbzYCmYXV4VkK0Aplmr5+2Gc+1fCKfknQCymA9n5vXStlZXCTyYYsrqA+V0NUI
	 KdWXBHhS2w2yJPHff2FBYicfDVF8Dj600bWwAppprrIx57MEdBzYv8m7PQUMECeIuL
	 x7KWRkOFrpA6wZEvPQvZerPA4J21UErDobnfGrY6Kc5PPRHMLC3/9Lw/hIQIFGROkL
	 fU9Y/Uu9uJLOZo3JSNY8YjwvuGvKYrIyCl3m2aCkdtG87+LzFIO/7ddlpuYRBiBaHU
	 pWdWzl+wa6bNg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] vfio/pci: Clean up BAR zap and revocation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Evans" <matt@ozlabs.org>
Cc: media-ci@linuxtv.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260924152159.49702-8-matt@ozlabs.org>
References: <20260924152159.49702-1-matt@ozlabs.org>
 <20260924152159.49702-8-matt@ozlabs.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:34:46 +0000
Message-Id: <20260924153447.353B81F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924152159.4970=
2-1-matt@ozlabs.org?part=3D7

