Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245306;
	b=KlxlQwcBAcwoRaqkl0c88n99apc5n9JLd8UsCiQG18qKkA4GE8kkrCeg7DhUtkFens1i
	 QfNkGd2xIVhMp+sgyrwU279crYDKwLiLLMNVHecu+D0VDcBuCmH5G73cFcR5VIfEo43bc
	 IdvjH8xY9ux+oS10WzmtCzAsQWejm2kpMN2tYQzj77xmpWqQ5H0b4QxK38nSQzpk72Rk7
	 r+uLhibWSAIj4fMuZjih9e3+d9ASVoPuGXsj98KZePr4rpGE0+UE75m8ok1T1kUZBYjnD
	 6ES0tqPal6zh67zs5s0klECHI6h0uPanKf2H5EStEUvkRCtcxHUmoVyRgOpdvYF6+Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245306;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3Mr9u5XknRop6eLBpKbG3RBFiO3y+HKBlCK2+HH9hyc=;
	b=ncwVmh9VfL8ID0r+1N6yBLqHiRD62TK2Og5tRnU3MoZc19/2IkvcXKcAWdFdhmhxez74
	 eMnsgWKAaLA99xrR7BNdceGfZ6X54HeNZO9QC0fg11/aahm4HNxO6IAp+GpVv+xcaztWt
	 4IZhOHbIdNMlNUclu2V3Q3eVTBQuBy9tJcvuzmGu+hgiNAuDCVtiWo48fiI6tPu0rrRBb
	 dDZXbBOEF5HXkCZ7rOL7jk+zsLWJNzdJ95dZcxUmCxpdamxARWzYkwdK1eorA5MsL2aLy
	 0aY1pSgAY8BrgPJE8b+HgAuPNea0rQCeC5uW0rujKcc1cHbJCXL7AZQNWsOEntPB6XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Jbdyjj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120CB606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6Jbdyjj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B7C91F01825;
	Thu, 29 Oct 2026 03:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245305;
	bh=3Mr9u5XknRop6eLBpKbG3RBFiO3y+HKBlCK2+HH9hyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d6JbdyjjoYfRUKomu9iY46wNsgrrvQwyIvihgYFKmyRaEghnISb948AsckK/wyU19
	 DvcjUp4z4a2i8WpLIXk311HWpOyPPOfRDSXza9tyghrTaB5VJw8YUWwaDNe/xtmrWM
	 i4n8uK8ZdB0jwg9MgUctoQz9B1WEE95mzDadB77J0otiQvCH4KQugWYLoTTUG4ryPe
	 rvU5jyq1VVBGY2bfCwRXFBGo2ggwm+rSjmXLBpBGQJknpf+Ls7EGUl1WxDpVhsCJwN
	 rqwNlo045RVHeH/MP3lcb+V+q6vVSZota8sZm13TiH9Vw/c57DvwzKjz/DUOiEjq7t
	 AQp05OUXEMgpw==
Message-ID: <sashiko-outbox-188676@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/6] PCI/pwrctrl: Add the Tegra264 iGPU to the generic
 match table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-3-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-3-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:41:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Tegra264 exposes its integrated GB10B GPU as PCI device 10de:2b00.
> Its power domain must be enabled before enumeration.
>=20
> Match pci10de,2b00 to let the generic power-control driver bind to the
> GPU's platform device and enable its power domain before enumeration.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D3

