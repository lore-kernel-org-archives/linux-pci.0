Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286565;
	b=IRzHR4zcT5cu7I8kwJ6nAVyhFy9RRjff2crm8q8C+cFr6H6dEWYydukIsmfiihorgIOv
	 nWyynTj1eIz2gthLy2mtVnI6SmUBs9CXgvyvW6s+bHfDzwYQd08TGODXjB8tzjuayXPxw
	 79s3xLdpBP7vf6v8b8VeAB4UsNR462aHIGUgY8RvrBPwq2K3bBfj0/Iv5CzrJbCf5+rA1
	 +EbNUIAB4WkU0Uktc1PSqQvmIqc01z3DOWQdZFay1EOeiHdcGTNipKNNi0o0L/uZu/aUY
	 uEWV8bos+CuMj7aOgAC/e2PZX/GwXzRnCxIU68W6U1tUXXMMoTKtgmn3yoqLYVi6ykA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MlvxLUxYi8Cl2jghC7f24irUC+X3MzQ1czC1Iozl+Ac=;
	b=hV8mhqRTI+YEfg+B8bFOe7jC8zClxASxKH/3S3HT5N4Wjuv7DQXhoPDMw1rbvfkAuBs3
	 wGCIY2o/M340lYGxKINNn5q8wD6k85VmhaVoAHbBtonNREDu9gqlg7idJht+Ghpc1vZD+
	 Qe4Pte5MGpSoqIdnTEXZRBuGh00fb4x2J9g8wRlCfpFLeznkdDcXmFD36GX3RqyaE2OM0
	 ILDwtT58d8f4lRAZn/Q7DKoRXnOxMri7awnbMKQWD0tKXY/ttnDDuPFuIolugG8gEsHi3
	 utxfaXpVfnow4RuTTSA0oh/iS1M1wL7XTAjrIj67FYaONjqH1uYUmQw/pXuzBn9hP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFBDDUO8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6570606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aFBDDUO8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B49C1F01825;
	Thu, 29 Oct 2026 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286564;
	bh=MlvxLUxYi8Cl2jghC7f24irUC+X3MzQ1czC1Iozl+Ac=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aFBDDUO8aQaztGrTnnCqCUD/AucFZeuQgctelKzWofdXx57mcxj4OfsvO59yFhTSQ
	 RBjMPKbBkLuzSljA3SZQiQur3qW5ir29GUCxrrlaWy0qK9D8fEIhHaMmerJCmvUAIH
	 0biA0S1nxByJkbhzFedQ+UAz97yqlor6k4QWD5s6ddjQyZUcTwIJBu4dAn5uT+7fht
	 8LjgSPhksgc/2/LfqHcfiN79VYRnZQCl2fuN0vVJwwtWVW1KBPZgYTbH40B9uTYjca
	 A86VKNBfzlmjAkIPcnbkk6AYjYL3RYZZK/X4fxN7zMpo4/VQ9hRuO4CPdJfrIjONji
	 YB5WnNMpGvBbg==
Message-ID: <sashiko-outbox-189582@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 18/18] cxl: Add KUnit checks for HDM decoder
 unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-19-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-19-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:09:24 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Test cxl_hdm_unpack_decoder() without a PCI device or HDM MMIO. Cover
> range boundaries and overflow, an all-ones base, zero-size and uncommitted
> decoders, and a locked host-only decoder with 12-way interleave.
>=20
> Run the checks as a KUnit suite rather than during cxl_test module loadin=
g,
> so a failure does not prevent unrelated CXL mock tests from running. An
> uncommitted decoder has no meaningful target type, so do not check it.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D18

