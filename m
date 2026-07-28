Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271FE3BA222;
	Tue, 28 Jul 2026 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785259734; cv=none; b=ALZYmOmBs3EBPWO0y1MEWRUYgR4D0Bzg4Y9yddVzqkKCy76VH9wgHE7Q6vOwtdOBDKu0e5WZXDdrkI4tD3C9h2t296s3sNrmhZE9G2ichnw7mXZwfEg+JJMLw5sEFy6ceZRp9vXY75sIlruojNXy4f+Xv/+kapyDX2bN5A7SaOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785259734; c=relaxed/simple;
	bh=sUNxknAOcGuh0ZZp3nSqbKKwtca/s9rL6WsxWYX1g8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uUnyyK4t035DP3JBOSXc4dUrfYpgZc1htCNWCCT4voatTgabR0fxg8DH0gOh0SAbJAgrDyPtmDhAwdLgEW30C9JYN+kCTAD0Hflm4uJCVEVufSjIms7m4yqX1pfnsaRreuyRmV5g3vHyzPRadiWbgTdxoL8Pn/nPR6iDA6Azs4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/LWQEqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/LWQEqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6861F00A3A;
	Tue, 28 Jul 2026 17:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785259732;
	bh=sUNxknAOcGuh0ZZp3nSqbKKwtca/s9rL6WsxWYX1g8w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I/LWQEqt3Mk1w3eWDIOUuMHz3361gSq7OOuLwgA1cI+/KJLwYGMR44PT8IBtc5lZZ
	 5vKOnWuNCbh6kUs3uip5csrVjK1hadTEXhALk+lBzUXCCRpG9c9Z4r64vPnsFztvmd
	 hVrMxzsvHXrYnbRGgpb4nk+dVT7E+stNkYTT13EHoEaAnEZ9vkGKGBlvlPVt6xe+2g
	 rQ+fb1SbKrvn4LSw5AmjW0sjRT5VH6UmyG7wOF2XQ0F1UYlSS6RQi7I1vcO0tH1MTP
	 YFNvJnptozhIFY2g+5ipyVcc7h+0wiHxooOVzBswD2RrEWVNwi5dWU3oSqmCBmA4Gf
	 2hGmzSmk8srow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] PCI: endpoint: pci-ep-msi: Make embedded doorbell
 IRQ exclusive
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, ntb@lists.linux.dev
In-Reply-To: <20260728172306.2751813-3-den@valinux.co.jp>
References: <20260728172306.2751813-1-den@valinux.co.jp>
 <20260728172306.2751813-3-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 17:28:52 +0000
Message-Id: <20260728172852.8B6861F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Embedded doorbells may use the same virq for several messages. This does
> not mean the IRQ itself should be shared. Consumers only need to request
> each distinct virq once, as vNTB and pci-epf-test already do.
>=20
> IRQF_SHARED would let different EPFs register handlers for the same IRQ.
> The embedded doorbell interface cannot tell which EPF a write targets,
> so every handler would handle it.
>=20
> Only the first EPF can allocate doorbells today, so this cannot happen
> yet. Drop IRQF_SHARED before extending the embedded backend to non-first
> EPFs. A second request for the same IRQ will then fail with -EBUSY
> instead of attaching another handler.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728172306.2751=
813-1-den@valinux.co.jp?part=3D2

