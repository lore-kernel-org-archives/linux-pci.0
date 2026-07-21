Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A533246D2DE;
	Tue, 21 Jul 2026 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784651254; cv=none; b=ZJ8ti6W0EnYZdVMCX6V5FoUY6floeyshTrMBCT9uOHoTi3XdE25g6dLhw/6YzuDybitHIv/eOrI1thbIzAze+7z2GygnGLQ8FR90CRLPbpxG5HJySxDa718P24kS14pY64WT4SXQLxTAQpSEPQ3WgWV25z7aJPvye+7iFzpHHFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784651254; c=relaxed/simple;
	bh=CaHGlUBWyXIqz37bmhEhFYtlHieYIbCG3PY0iyTWcAQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gTRT80/QTldXLKroaOh1b0KLGalm2sGsw902KlRaA3FesZxOjCimnhWPjyEWotBVabbljG4n+G/PVyXqvh6IR8NARSdQdt5fI5YAj2QYIiu3axB9qyrhRO3PVJn+FmVZwZ7wjj7alHt+gASfbENmXX+2g2rQfJx1N4i6P1bbFpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+n/L2t3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+n/L2t3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488631F000E9;
	Tue, 21 Jul 2026 16:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784651253;
	bh=CaHGlUBWyXIqz37bmhEhFYtlHieYIbCG3PY0iyTWcAQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U+n/L2t3MugctFf8lZkihT06aaX6V9iWZYEEh4xt39CqT6rtGMz1CrrUiG/1mkuYO
	 ZqAK6jYitj+3ih3ZeRrlYu3Xtgiim46Ju8fY7+RAe1cnOEzT2l8eB8BT6LaM97VBRw
	 kQAdxLLrjoLoTALm6mn9xqRgGmflEps9LgigGAQ7qQ7RTd2xFcQZXhHPLgQvOvem2v
	 TJ/kZfOyotQd269UfB+wC1U36qwyJYjY7uuhXPQ9CTD9FI4ruYuEC2WxyxjKxtMVmh
	 GAyKkxn+ccsQXnQOTr8918DVc9dUmRlJyCAf/TMJtgfIi0AuTvnSARKa97WcHyuaHb
	 8mXxduFqwCdqA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] dmaengine: switchtec-dma: fix resource leak in
 alloc_chan_resources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Logan Gunthorpe" <logang@deltatee.com>
Cc: linux-pci@vger.kernel.org, vkoul@kernel.org, Frank.Li@kernel.org, dmaengine@vger.kernel.org
In-Reply-To: <20260721155739.62120-3-logang@deltatee.com>
References: <20260721155739.62120-1-logang@deltatee.com>
 <20260721155739.62120-3-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 16:27:32 +0000
Message-Id: <20260721162733.488631F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> switchtec_dma_alloc_chan_resources() returns directly on any later
> failure, without ever freeing the descriptor rings and coherent DMA
> memory it just allocated. The dmaengine core does not call
> device_free_chan_resources() when device_alloc_chan_resources() fails,
> so the driver has to unwind its own partial state.
>=20
> The device-removed check also runs after ring_active and
> comp_ring_active have already been set true, so a failure there left
> the channel marked active despite alloc_chan_resources() reporting
> failure.
>=20
> Add an error-unwind path that disables the channel and frees the
> descriptor rings on every failure after allocation. ring_active and
> comp_ring_active are cleared under the same locks
> switchtec_dma_free_chan_resources() already uses, since the completion
> tasklet checks comp_ring_active under complete_lock before touching
> the completion ring, and a stale IRQ can still be in flight when this
> unwind path runs.
>=20
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/dmaengine/20260707165555.350951F000E9@smtp.=
kernel.org
> Fixes: 30eba9df76ad ("dmaengine: switchtec-dma: Implement hardware initia=
lization and cleanup")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721155739.6212=
0-1-logang@deltatee.com?part=3D2

