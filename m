Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2BD393DF5
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341633; cv=none; b=HlFDH7yp+OLn5TB7tpmPkebgbFwLhanc1sMkQ8US4UAaz1wETUthk88/IBUhaMsnDafnEJqrx3Y06wHEXBcCp7I3uZqRyi41eKBpO+0EFCj21Hb/p0UoDi+42dXe/gX8FyfFgPK8ozjpvGWgmVHq5DNSRNi4N3NUdHREMI56LaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341633; c=relaxed/simple;
	bh=thxPZNXOYK9rHsdoZZ47xK76AS2jALeEQOpSLQ4J3c4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qp4K880loMCMtlyYrI7ZE6536rP4j6XVpUS12Nc89pEgnqSLg62sxhVFvdNUyXpm1N1XL6Ffd4Kl3/HAW3H1ZauCL5CcHewYx3K+k80S7J16GIx4nPhRAQcTrcWpDDauFpOIPIDAH4ag1ffLVnm/r1v71zr9cZSeMoQW4tgBn30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CB38HZse; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CB38HZse"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054CB1F000E9;
	Fri, 21 Aug 2026 19:47:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341632;
	bh=thxPZNXOYK9rHsdoZZ47xK76AS2jALeEQOpSLQ4J3c4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CB38HZseeGTHS/kP3b2iU1Vdevpevf6/wmYPtsLrOIMZP3c7mNc5Nxryta0sIM8ct
	 /5B9wcrlxP/Npj5bF5wXuRoL4EjUimCaN/mKawQINoOJL+ImdFQICiYe9ZIa8ByJdm
	 SHteGwz2Hwl/2ukwaXzZnscrI+F7QkAPUkVag8iEr+UXyCFqSOoSwahv6r/xtyEvS4
	 +RDTPegckKyZUarZ1Ouq1MJrZL6S7hyQcbHU4rXMHEFaoNL0cEmPTJfjxNwumLd7L5
	 71CuP+iZM9EoEIv5x9KE7WBKay3W4QyIk0n46ML8zIgSQPy4YZ75/WTJ8ndzqI1nRK
	 1sjC/AvzOmAZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 04/18] PCI/P2PDMA: Safely terminate ACS redirect
 lists
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-4-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-4-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:47:11 +0000
Message-Id: <20260821194712.054CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> seq_buf marks an overflow by setting len to size + 1. The ACS diagnostic
> path unconditionally writes a terminator to buffer[len - 1], so a path
> with enough ACS ports to fill the 128-byte buffer writes one byte beyond
> the buffer when verbose diagnostics are requested.
>=20
> Use seq_buf_str() to terminate truncated output safely and remove the fin=
al
> semicolon only when the buffer did not overflow.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: 52916982af48 ("PCI/P2PDMA: Support peer-to-peer memory")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D4

