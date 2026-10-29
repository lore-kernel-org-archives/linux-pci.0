Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286203;
	b=SWzTpuVEey9C7zVPNLR6ykPohSVu/wP3tlz0tKxK0rq8HTkitTWegYbrFy6wOnqxsPJu
	 VypdeHAcmy4stvHsX00aTkTlDzZE+QO2jGGZVsRDgAsL6/nrV0lBaUl3sU3zA46b6cCLx
	 gFkze1QK3QWHv6xb3j2SgB6ZvFvwSckGeYJvvCwAWIygeSlC7CadQ4M85pXQ7d1NBnPKf
	 fd4PI148cW5uyVOmdyoNFEd5qmPbaYU9I91ASKapneRMBaffdp5bGxMtSw1r4yXM9mioh
	 QM23GAORYuu4hPGdvz7WBuZxsmcK4eK1HpqmenGyzaovtTClU3gkQDXYST5vS8Zv/wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286203;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=r3tqw4AxcOL5cPSNroNcIVb7gQpPwBJJoH9M+7X1rmQ=;
	b=zhv9/StYf42XgneYKSkOAgECrwfK0CuucAAo6hLqk+lS6suz5/u4C7kikd/s9smSzzfB
	 nKH7SDP2mMTbvo08+mFQM70l5e5g1DZdAnJkrfkoUXMGHtdXg9qwXGi62Z+k+VhbOxXoL
	 +5dVWQafDYy7FC/uKrGriuxg8cGw9M9Z89KfxRzBYBCrTq07y/8fADN9XHQTrpMg4uMk0
	 zM39nqeumTxkU7CRIniEQVp9Na/qzJdJ0CinU59OvEvuGYCrE7DKsYrCG7Fg0c+0+GCVe
	 HWnflI1cb1fvzs72t2xaM9pe4xfe+0WKBganilV5yqcH7w3N2tCb+8OZLv93uDMjLQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWSezIdQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E84606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oWSezIdQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC651F01825;
	Thu, 29 Oct 2026 15:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286202;
	bh=r3tqw4AxcOL5cPSNroNcIVb7gQpPwBJJoH9M+7X1rmQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oWSezIdQOR64ZqQ/S3d5nqNMa4Ft+TNdbKPPRkNVySwz+LT8JBRFjO3zIr/VmejCm
	 FA2AMh911NWumcopnDmzQxxCPOuuGr/QIvfGKwTbsefYrIcJktWUoEDy9h2P3i3j0M
	 2nHDVkAGx2/DFexpP1h1xARcGCa8CfJN+h4jhoO+Mp/BR5anVKgDK//b1rODkRHp26
	 PlR08NoUksrY0ODLfg/LZoI3Iv0TVrTjfK+FjS9O4wKilppmoqFKgDrGi8gwd+BQMl
	 wxGJX9VijUB/VWpGAnpz3TgLG8ALaQjBBf1Sg6pEQQBzpk304iycTDSG0NOrGddpPa
	 AV5R+QUQktImQ==
Message-ID: <sashiko-outbox-189569@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 05/18] cxl: Introduce endpoint HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-6-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:03:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Keep common decoder configuration in cxl_decoder_config and represent
> endpoint DPA skip in cxl_endpoint_decoder_settings. Share range
> programming, but keep endpoint skip and switch target-list writes in
> their respective commit paths.
>=20
> Separate commit initiation from completion waiting so reset restoration
> can reuse register programming without changing normal DPA-lock policy.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D5

