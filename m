Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7937DAD5
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486787; cv=none; b=W/hFi0QRcy4M7XXg4208v+FScNsA8VJN+PaUqDxSPapH77YaEohjAYj36baz+28eBGrQkHymTYNImAFX5zEx557HSdx53HVVf7SNf7uif+ETTnGZRKoC6omEZyII1C99GDZFcI8lTeXhGLU/NIU0MmYrhlREy5n+mNf/45C9sZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486787; c=relaxed/simple;
	bh=sQGYohwaXrdcKYwAkRRSUwUd4xrUIr9i2x73FCzJ/OQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Up+1KrYz8Tbl0roV510u9iAMLazt7gJKFBkP3J6oBBdttJkLYyW1iB2JWbK7BRGCl17IK7+/IOykpnBbXI5HWRuMJ9TPoOrDzdeojH1lMz+RtCfm4Ion2RCdVq1EebnKMPaPy4EktwHKgOgL5HdsbvW1u4NPi855WdHHHCOoaKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dldgESN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dldgESN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DE01F000E9;
	Fri, 26 Jun 2026 15:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486780;
	bh=sQGYohwaXrdcKYwAkRRSUwUd4xrUIr9i2x73FCzJ/OQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dldgESN94aS33ceGRH7WxyMIs2VJ3ls5hovZMRWfK/4e8e83M0flm7Fn38EWiJKRx
	 2I47hzM2JkQWKBG2zdxPcLBRtabsiOi312NDHFy44e5nXcayx64ihz5lGSN4QxQWm3
	 AAe3h0d0b6YbyGSfTPH0Ktw7jWKdWXdk1TUaBuVFM2lIyedlzCdY0esXMVTq8JRhjR
	 AnL6FKg6Yp2CEyEqD0RuQMw6TLfhriwrr6FPYeKBC6sM9VDZnUDVE08J2welkWFVkx
	 Km6WIP0Kqaq54MQj1uNaKtV5xxDbTRnsgJNz27CfVk2LiXP7H+93fSJAgwGQd8DccS
	 3wbcDmM6P6KoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 18/20] rust: dma: drop `dma_read!` and `dma_write!`
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-18-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:12:59 +0000
Message-Id: <20260626151300.08DE01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The primitive read/write use case is covered by the `io_read!` and
> `io_write!` macro. The non-primitive use case was finicky; they should
> either be achieved using `CoherentBox` or `as_ref()/as_mut()` to assert t=
he
> lack of concurrent access, or should be using memcpy-like APIs to express
> the non-atomic and tearable nature.
>=20
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D18

