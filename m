Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973155;
	b=SgJx/x4UI8M7u1xyI75U5E+f8RoKx4VpbHUWkpdlrLXssZ+1lHHjjcvg5VsFom002/Yh
	 ExXf4wWMgFeljeYD907nvAFzPVVIrGwNmI7i8TtsD4J31oNjVO6fsLaYHY/U83YOvwm0a
	 SsUiDU2aOQYRG82BZVDbvsX7fAMb3BGIxMyO0Vs2EJbCw8TOBHbd/9ZOJYr9ciVKSl8BK
	 0PK07EPbwZovigylImpaCr8I0qqMm6EnOhK7P5FLIvkwsOP7QB8eGkDKej/l2UFOiELwn
	 LnDGy2bnDJSsZa6NjullcAbJLS9lzfOr3Xn6b1ngFD94KU9C5jO9xGbO/xNaPvBd6Yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973155;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dsbuEkVnz3SjXATy5v3apG2kcpt5k5ogs72dTLmdjS0=;
	b=2r0snawLcnSZin5YFPwps8X48LVjV5cdmnheCD1Tsj70Jhq3o6P6qS7uWi+gvFXnhboz
	 0VfbNhg63GERs9j8DU6LiGaJOMwiB9xeERtw1tWqrBMTlH9oqGIBF6YdUV7wu0HL3GtQE
	 P5+IiVKVlAtrkpLB4bTeqH7UxQnMTQ/53y8tc1lRfeR0KKrCqCu1tqmUZk1lAv3AOvADm
	 I/qS2t3NjJTqgbJKCOoESgmdf17MYnVCjAn5h9mJhP/il/ReyU6I2LUwR8zcoWvxtfkg8
	 scb4v0sXIbsb06hIM7UCvKkR4yiu0RHvkSmJm+L6XbYfGiX0+u7Mv1oiD5k/w6kbpYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do7pe9rv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B97606A326
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=do7pe9rv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9E21F0089F;
	Fri,  6 Nov 2026 13:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793973154;
	bh=dsbuEkVnz3SjXATy5v3apG2kcpt5k5ogs72dTLmdjS0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=do7pe9rvSWfQU3gUBS5e2q0j5NE8R7AaWpolNbPGeowgNn2pWlmH2w7z6ppIJ7eWB
	 +Y7PMT51aTQql9llPWIoMPnHhxYmMXAIpsHvra6RkSAOd1Fk9ygDSi+ifYjhRePLGI
	 Ta8MPBQutymoxcEnT/n33AdAsNtTlKK2837W0iMEQYi7bDZEzhHM70VSxrhBDkyyLn
	 zv8h3GjkZ3SJr1cmWaZ/PQNFBTcqvd2OasRLwdyqflbFgokPM9hEt/2Wjaydq5JCDk
	 KzxpYd3alvC5Dx56dnN0U2WPxpgaIUz3+6jxekk1zKUNjq/xfjWzCeTyNciqrkXhlc
	 kFriBvyKoW/mA==
Message-ID: <sashiko-outbox-201509@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/14] resource: Mark free space assigned
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-2-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 13:52:34 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Free space ranges are (part of) assigned ranges. Since new resources
> have IORESOURCE_UNSET, the flag gets copied also to full_avail.flags,
> which hampers printing them with %pR.
>=20
> Clear IORESOURCE_UNSET for the free space indicator resource.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D1

