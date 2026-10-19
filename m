Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792428941;
	b=wzWjPZxi8t05SulEcdMioC3m4gIh3yMEdREvFyG10cXguWbi6i9i/K8VFfrYIr020WAd
	 AbG+4+pCP9zaTFEiYCJH0sybXTyG/I+NolCrUuge4Mw1G84RxdT0yoI1TU3+F2XzCQZKs
	 oCKXIekBYztYaH7NKIQ1sdyQ0nKv25zuHSv0H83UHg4v0SGqyrlu2HR+H/rnI0x78+KW7
	 9ok3QX5XIUrnio0UpvN6mlITYNO5jkvaXlLe/y1Tx9IGSLbFAcKC9GQjN+62vImdl/GGv
	 npIg6pTCbWKwEBmUypcckn/O43PGQyUzweSZlLK/uzZBlUt+9zaZmqDAWxMfwxpIVbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792428941;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SoMaaQ9WbqLa9l1n+j/kjaZfyqYnqURMGN3U+usQEKQ=;
	b=Cfd2oeOWCp7eTO8rLw/QV3MfYY0nw5ShF4IvrgpCrSyeKaPWEmtFAEOCl/9HaGffdVF+
	 nC0XXtvb8ZABnjpUwT0AFykS3NoOv3aZn1Zjl/SDI906GLKWNvrNbDJBZYGRzU1hNvQnI
	 kBR27OwIhQ0wggNjr0ncUiPMLhQSgRrpogsI39iE6fCcNIS28jQ2DGSm4HN9rIFIoQNJI
	 PmNKQV6a85LAY4nQoCttzARJYcieaSDffcT/u3CXJUh3KlNEFDHg0KWiPuFHkftGkglOj
	 kKXTnOhF6tHicRZQOrtmbuS40nOSKfw2Wi8+SY8nfNJsIufYpDP+x2n/xnYCu70S8GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbBHHAZf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7C606A333
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 16:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kbBHHAZf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602AE1F000CA;
	Mon, 19 Oct 2026 16:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792428940;
	bh=SoMaaQ9WbqLa9l1n+j/kjaZfyqYnqURMGN3U+usQEKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kbBHHAZfcF8/pLUeTfe/WaGdA3SlcyPrgnJwE2MzRiAmiyeQ6vJoAhhjmRfvv/5Bq
	 duZ788yubK1T/kGaAX2uu1W+9bbZkHh55/fNq2qMnefVRccLafk2595tJ2d7PMv045
	 8IKJSQkPKvAsVVLB19za9VupVQLMrxr/3zQmudZEzQNmFQS0oVPYPIsJBKlQilhvCk
	 ZXNmCeue0D1u7jysFmVudu3YYdptvRVI3ISqnRtvD/YPnMZrbqdZZc14kKtT2v1+K2
	 fW0sW1j9rPDbdITIcjF69rg9hYDnWpaHZKPO1zgNEeiV91py+1zUk+NzXDXO0l45to
	 rjsxLe07Hi9FA==
Message-ID: <sashiko-outbox-177960@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Don't read config space of disconnected devices in
 ext cap search
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Pighin" <anthony.pighin@nokia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019165159.1268120-1-anthony.pighin@nokia.com>
References: <20261019165159.1268120-1-anthony.pighin@nokia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:55:39 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Commit 4d909bf1a53e ("PCI: Refactor extended capability search into
> PCI_FIND_NEXT_EXT_CAP()") moved the extended capability search from the
> device config accessor to the bus config accessor. The bus accessor
> skips the disconnected device check, so walking the extended capability
> list of a device already marked disconnected (surprise removal, AER/DPC
> recovery) now issues real config reads to it. A dead device returns all
> ones for the first extended capability header. That decodes as a next
> pointer to the last dword of config space, so the walk keeps re-reading
> that dword until its TTL expires, roughly 480 config reads per call.
>=20
> Restore the device accessor so the walk stops without touching hardware
> once the device is disconnected.
>=20
> Fixes: 4d909bf1a53e ("PCI: Refactor extended capability search into PCI_F=
IND_NEXT_EXT_CAP()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019165159.1268=
120-1-anthony.pighin@nokia.com?part=3D1

