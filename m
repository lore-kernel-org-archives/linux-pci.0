Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157392;
	b=PoGD4BNXzBtpyEG+LDrdPQRmgi0SpLF9jKZCJPKTRESuAwYFQXyfq4Icas3z9N9+jSZV
	 +VQm+hF/tBtoaBCcF+mXeY70ZJneAfBT1tAGGzGdEpIW018kx6SBdvC4t/YZlK/HqLNEd
	 VswZuToat574GJrSffwQ++o832k0LAMkJDffmv71fBuFKOkriUdz0TW9nIksdQrzmlGf+
	 oEkPUynUcshXUjSFNa2Ur2pCFLY8dzXr0F8E9PJHkWy6XFXebnvK+b78w2D4ryprgzUP+
	 nxj7RBR4JoOGg5lAEHfA4slknEEvf77Ufpi18uiA3jx4qyK5tmxgdwbZngVg7TiOmGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157392;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D5dRVhUtlRXKjE87RlBm84y96yPI9GzNYM7DJ3RMX98=;
	b=t6aKDPYopPWIYZUXg/eJDxwZE678tuymhFo3oHrrniLI8B2+Z+Kt2xPzKrr2qF1KwS+T
	 1V52kzS4epi/5h3AfGwcUEOdshSYrMwVeaWhbNpYhGzdukrCXmPP5UKdpYnPYjz4FeVpw
	 wiaN/V1xQOjuBDXk7J37r2MBPx+QvTjM45p9vV8WRbtEaP2F7tcSjRZaROpknLw/dycGc
	 z83I4DevYR1JJj04YZVJ8ZC9SC9uS3/vfR46tl36UUVISiYpFO3FYdNIq6WFMfQTrZfp6
	 pw8ma0UevGUz9Ij4t3LavzQCze7ZvrNuzHsd0fLwmkzbhLJ78B31IGXupN0n1yIzDZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1g7gs4E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD4F606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a1g7gs4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D3D1F01828;
	Wed, 28 Oct 2026 03:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157391;
	bh=D5dRVhUtlRXKjE87RlBm84y96yPI9GzNYM7DJ3RMX98=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a1g7gs4EsS5X4uL7fZieuekd1P9KZlW0d56DOgZHlP2JeVoGUFPuDRTY5G/BDNSL/
	 rtaXfggB9LYGN3dxwbfgtFfLm97Fu7lkSKD3Nu+7ZkwJ88jQYs5dO4EifluDNKvzhL
	 Pt3h6vY/JBYBye0/Mhf0BZygpI/+QCGB/PuVHPLKhXVCpowa1DsSu/+DMmpd4r/7V8
	 W2qQWF82VK5E5nSRfSWWai2u7F+Sj+H7KUrBb8X2iamOtsU36JFxTxniKfAhHex/pF
	 Lqg/RAaUs61At1VMPdbfM6kJpCne7INDD3+11lB0yo60OVB80ZvfZl2QbzOXNR4Z9+
	 eXSggz77TcEMA==
Message-ID: <sashiko-outbox-187408@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 12/16] PCI: dwc: sophgo: Use cached PCIe capability
 offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-13-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-13-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:16:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> sophgo_pcie_disable_l0s_l1() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap() and store the offset in a u8.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D12

