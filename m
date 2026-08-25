Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B753C0637
	for <linux-pci@vger.kernel.org>; Tue, 25 Aug 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787639382; cv=none; b=OuhcQS/goxiQeHwt1P+2ZkFVBTzt0HowY2PKkVEZFsXQbPeIPnGRK+u9BVH9sxSZnhl1FRdzDQyusV2JYe3V5RuD/AKE+5eIqiBdJzxBRPOoVwJ7YiKoFTtzInQhcNI65PRg+DmBRzR/bj/UV/A6PUqB/UvqQejynvHJmQGg0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787639382; c=relaxed/simple;
	bh=MW+kIda9mc2VpVFV9Y+rTGTjgmHQN2vbXA8UZx1K1sw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MkGhyVXea9vwSeOPKURbo3SX4f9iJ9f+IswbicP5QPN8dtBG7AHCcCNJZUR97g4y7ypVGC9uvAK/jrDbDRgV8xhZI6ZGznZoMDd5vzOnP+Ux6XRMn+KM411JkLlRnFH+mfJSjl//qF7SBfE5OOLCuCE8tonngIblF1j1Pt31s3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdotlt63; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdotlt63"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FC61F000E9;
	Tue, 25 Aug 2026 06:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787639381;
	bh=MW+kIda9mc2VpVFV9Y+rTGTjgmHQN2vbXA8UZx1K1sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wdotlt63Folg7dj0lbjDEL3hVs3NETUQwxnStXmLhizOYoUGcpCdEs2w5gHpjqU5d
	 j56Apju+0WwmEa7d2zdirPauoQp5DY1VkyhbjUwB7fbKjSqheYN0pyvEkD1InQ5G+G
	 nO37ZvMQQzuoyjjvkZhSmlseowNUlxx4y4zVkqmK43u1JDwEcKHTfjqN2URZyJAv+G
	 /RlAB2AcvxzQO0TCfIRRsk40eZN/UQ/nHhZ7PZiVqjyby1ja+IwuFnumETdtaUltq+
	 dwSU6g0TrkUXlU4mtZttj9NLVS8uw2dzK5C5ihGSjzMGRzgk+T8f0RfudA9hPZea4u
	 M14GUcpd3xvZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] PCI/P2PDMA: Update DMABUF lifecycle docs after
 move_notify() rename
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
References: <20260825-document-dma-buf-v1-0-5ecfb3e1371c@nvidia.com>
 <20260825-document-dma-buf-v1-1-5ecfb3e1371c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 06:29:40 +0000
Message-Id: <20260825062940.C7FC61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Commit 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to
> dma_buf_invalidate_mappings()") left the DMABUF section of the P2PDMA
> documentation pointing at move_notify(), a symbol that no longer
> exists. Readers grepping for it find nothing, and this is the only
> place in Documentation/ describing the revocation requirement.
>=20
> Name the current function and record that importers which cannot unmap
> within bounded time have to be rejected at attach time, which is what
> makes the synchronous unmap on remove() achievable.
>=20
> Fixes: 95308225e5ba ("dma-buf: Rename dma_buf_move_notify() to dma_buf_in=
validate_mappings()")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825-document-d=
ma-buf-v1-0-5ecfb3e1371c@nvidia.com?part=3D1

