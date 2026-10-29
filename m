Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286029;
	b=OkM7w+2tT8/CSF+V9CFConQ46+4t3cBmJ4iClX4b3CQDoW/mZY5vT6XfoidDFvx/PgVi
	 eVL25IygHxcfqbnBIqN44AlG22fXXfdd6wAT2NJw6SG164yoE94hISBr44e0TOJRyIeFI
	 NR0MJwYFa6QpwGryXSDw0gH+7LNVu+Zqf08MzflrsYm/Uwk6VnnV2ScsYBGw96o6J4LiJ
	 AehyvirKMj8w4B6o+Azl3iQtxB0Dx+EtRtJwjiHmykPFbLtgH+xjU+5yCN3U8zie3Zum/
	 axr3g/DSPFRk6hPbccB6yuO2/quTTsJxjF2rWg/1bLVoQNfEtlA5pIZQuuemrlXGNeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286029;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EJC0+kZyGla4iMMbu8F6/uCcjG7y+4iFZpN1eXOaEVA=;
	b=ljH3LvIIhb9v9MsHgX7pwXNaOEne2JTyL1M7pganG3d0UnnGuXbqAp/tXPw2nPjhRlyd
	 GqyW3O67ws9JvRhZFmtldDh3A/sUMIStgp6YLFnMoOXw90+l2QOsXJx0m/L9lDXch/TM8
	 xvAgONK3YsY+9ldF/YPP659qM0KK7Q0lGjjhvi95EmihvI1xjrtAdjt+nmgWbjjuqmy/I
	 fZHWUu4GZy5JK3GjG+XKTq0RF+FJU3CrySxLN3Ze1KtKHNPb30j6Cs7Y2RkUcvXLTdixs
	 YEtLlrDbxr/MFM9kDm0K2mYI8Qp7r71jyk+VdacqIXWKTlF6R0P3m/x3KOJ1JA60OzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nntloly/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC2B606A32F
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nntloly/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C7D1F01825;
	Thu, 29 Oct 2026 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286028;
	bh=EJC0+kZyGla4iMMbu8F6/uCcjG7y+4iFZpN1eXOaEVA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nntloly/TZx4CezZbnKZvuRQZV0tl1Ikdkt1mYz53b/SlHCVetiW1KoYuhUSevScf
	 1qzQ3J2FIWoVncpW7qD1Y2VXWiEpSpWuO/XJwfo/yPeb0Fd0G3yBgLUMjoVF2zGWxs
	 iVJuH7BJ5BwwDyYH58l1ezezxgN8E5/R1jdyeycp0wHosZqjTtJ7F3wYOP+2ZJYf6t
	 wY1Xe/dTmDcPRkamDq2ugXpakeJwKYwMNF9ip6IKlWj7MR+B03nuRSb20uP2CWMUs4
	 jO7qkdZJCSpB2WW3d2jwiH2Sy8QPxIjf64v4fNpEIbpnWEpZolXXr0MMpHqoDrLNyZ
	 bLuxIzpd6EnFw==
Message-ID: <sashiko-outbox-189565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 01/18] cxl: Clarify decoder interleave limit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-2-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:00:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CXL 2.0 added 16-way memory interleaving, making the comment that the
> specification supports only 8-way interleaving stale. Explain that 16 is
> the largest interleave a decoder can express, without changing the limit.
>=20
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Link: https://lore.kernel.org/linux-cxl/20260912003057.3db9335c@jic23-hla=
ptop/
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D1

