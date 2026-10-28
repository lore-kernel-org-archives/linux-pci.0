Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157307;
	b=MB6ODfKY2bUVboQpRdaH1i1guDDUI7tTS9eYoZcFrs7K7PpkzWbY0sL0PkfcMFLCqQoP
	 waEeKeKpSyk4txpFZrpuO42c83pzvr1ScS0r+jDYaMKmTrZx+/lAy+3qGxT/U1FQOpOfO
	 98pnT5KLW6mAxzEttyeJp6r1Cg+wvC9kZQmrLSgvg6SIlBMoayQg4ij8lynjxf2Ze3aRn
	 gN33L1C+oneGK98NjBVKN8sliWG2G/RID8Mi52D1LK8B7QPbQfZx5BZviqzrbgTVm49DF
	 TjsQ9SH9m+i//7cpGonX9K/Xb/ut/VQmusGawiplLdPm/p+vLF3SDpbqPmFlfZ3nEzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157307;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xF26fNJJkHMbWDucUJqFQxjKkSg7xRUna1VoZ7eGSFo=;
	b=ws6fEQ+bueDUI8xzxghXLubdxilvzCC79XnF1hXtnhqEurvaFABCcDtqjRpAlmO1bdgh
	 +1KsAjLiRdoz9yPzJ/0a9CZDM+bkljn0HPgZqUWOoqGl2+4tU2z0f2DVuGOrKKCiUc9SN
	 lQjduryuFYNFGfUnPCErOPfawXVHVLLPt86bY2QFEWtRv8i8r7RiAKEy2HKA0F9iVrAeM
	 vpphREeCrLvIJzE4qwTDj2ZKX5YomrRKGnzM7UucpWanI5/WQg7Vd1vyNKl4eVP2P7WLZ
	 ngMAh5RZyMf6WLyizYi4sCs4aQIueAUHLPBWBWsW+UHpigBmkzY0vNF486TSrixoDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cceaOlzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4E9606A31F
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cceaOlzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2171F01828;
	Wed, 28 Oct 2026 03:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157306;
	bh=xF26fNJJkHMbWDucUJqFQxjKkSg7xRUna1VoZ7eGSFo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cceaOlzM5dYU/3rKvD5gaOS+KibakIg/kmDR64iki04qrYmYopT36TuYEN7a9o/1m
	 zUjcseKIM/E/C3vgOrXLR5in4UgEjclEEWr3aUs0Y64w33Zr61scJ+mI3Ao92TlF0W
	 x5ttvqdev+3jT6KD2rVNnF3mlJp54uVBr9ffNdQe+lsmGpPJC9eoEFZOVwlDYWHqUp
	 1PGKaf4cvDKs+LPySSMDDp6qkBtrwygQVLusb+S8xg+2wM54yabLfdToGmok+8Z6r8
	 ms7AuwyT+ZRoBeWaRyQ2pAVLNgBPBOeb+cp0jKFTtBQr95z7ud8/mwdgZCdjjdel2m
	 1eJzfWykoUefA==
Message-ID: <sashiko-outbox-187400@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/16] PCI: dwc: fu740: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-9-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-9-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:15:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> fu740_pcie_start_link() is the .start_link callback. It runs after the
> controller has been powered up, so replace the capability search with
> dw_pcie_get_pcie_cap() to cache the offset.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D8

