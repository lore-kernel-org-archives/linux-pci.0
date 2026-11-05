Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905765;
	b=KPp6jsmgRTT6kSzLIs1eIoEBVtr2MKDP2RIoV1IlRNWQWRfh+CKD4CsLODRjpTu4eIOr
	 cMqm0Kdk/V+j8pOzasu/+Uhl5wZtAdKDPJKQpc5wsvByWxuC5CPDpC78g+AAaQnnwO2uZ
	 HvsqKoKvqU+pPZdNCuSxP0JjjFRVNq4ILNGkLjkx5zsPihKkTutSsd2nmvL/c449FUfS4
	 uIlIya8nKOsgqU7p9SWn9cnqHFNJr4drU/zmPPIXneHsPtDgpCAeZcRgtUQgOzmE7M52L
	 JeMK2nKxZmapTayhPOMRP0VmoPNnXghkRaMS9PRmDSqoxmxZxEXP+CtuYz8eb9gsIiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pLD8sROmPtb5EDBbOI5hjf8TJAmW8V1rCXLW8F/Igdc=;
	b=mcSmLu7EnjUhv2KdOnnjRekopMXhJhWg9/5QNw4InrM+IB+6LExSwqOu+yXpM/Yoewxp
	 KDVcgOuYLK0+2I0/jI21h3+7D56+cSI99ndK5FawKlLPtfMuQui4LiGYbH7a0fb3hiaMl
	 B6nggGLV/LUVaayqtGe1PgOYF+JYxPIW92W6poP7AGHJ+b1M6wHDSWfiXFPLil4BgIG7R
	 nRC9q+z2TwshlU4TW585BUfIastSQBvhKdsWI7d8RBASzNXbWZkXJbea31u/QrsA+VqnM
	 bBQk/11t05FNLHeUecK2DWXGahGu27BAu0qnJx8g5Upx4KhdaHsUbfQCdPck0o090Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C90Y2l0D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3878606A32C
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C90Y2l0D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 777231F00919;
	Thu,  5 Nov 2026 19:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905764;
	bh=pLD8sROmPtb5EDBbOI5hjf8TJAmW8V1rCXLW8F/Igdc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=C90Y2l0Ds7J5vFGmGTSb5dXPm99G3oYGCeFra5hIMKVSCcIt7Q+BBxK0v4MY7/JFa
	 5EdR1Mq6XqdHJP++u94/r1P5ur/N0TiNy2RxmTCWzsAcJg6hWvPZMq2NxFK+w/CFd1
	 QPyHwNh9y1+QUubds8VIZ9pj0htWTyA1c88EX+Q4cVe+Ah34ub2BpxXus46aCtITuY
	 USf5WJZ76LQP3sdkLGF6Segmpms5FNL4EPtbuW3BnqXXsNw/U+iwebGpXwqQQvwQD9
	 hv0UchE792VjRNMXptZ8vQwPS6TWizb2XENXZqFbXhppP6nbjpgumlyR5SIuN09xvv
	 6nm3s21cN6ZwQ==
Message-ID: <sashiko-outbox-199814@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/19] cxl: Introduce endpoint HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-6-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-6-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:09:24 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D5

