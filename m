Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795439046;
	b=RV0zCpYxcFlk6xF6NUNr3nu8MmuLlR7gPWshRxkNk4j/t1WyWXH7BGSkaQOft1qLIxjc
	 hYbnk1LyilwDTjjmpvWi5R1QPiaM+ZVPtCmaWk3GdLsLwPbuD5VzP1kZmS1uB7zA1EFS3
	 DBD3TEdv2ANMHUICuOUGGUqDNs5m68zg65AwYlByzENEz0BPlOoI11YtxWZAXwi3ZvfzL
	 cn3l0Qk5t2TLvQ8LAtH8CsR/W9mkgGCPbv5btUkxN995TO4Jzqa+pp+WdUx0ImebkdRpM
	 AG7flpN7jU9UYxGu9oKhM2A6MjUAADqeReg3wqe1ySXHXnpD52yONVt8ktEWaYrzMKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795439046;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qtPJ2XgDLbMQaCZBu7p4dzYO3MS2T1TJF7bo0B9GLdQ=;
	b=I3P7psO/iquLNIAC4Vu1kZfTm5eB0riWYCXjZMHz31gccsC2UrG+54aivAPwYxJULSTv
	 PTyg6hFWoH95AXpwjxqI5OKq+F7tqr5AIjQukGOqwyqAnHFB1pDybbhUbxaXpNo22mPwv
	 6yvt3xK0muCI0w41wTNKUmKEM2rA3jQBuQ4mGJtzMeYmNV68NC6Z9EUUhL1UDVdmZrD9d
	 RVyU1Rqhi+Hfo9H3PHxfTsuzgS+lpY0+IFO5KCjGrlSgrJTlA/vT4E3b3QSS5XwQeU/dH
	 kLqTTLcefPK13NBQ/ZBE02OIj6eIUvB2ZwsluS2v6GnBYUjYv6KtxQrR7oy2wZ4zFVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4pput9W;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950D5606A31F
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4pput9W
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E551F1F000CF;
	Mon, 23 Nov 2026 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795439046;
	bh=qtPJ2XgDLbMQaCZBu7p4dzYO3MS2T1TJF7bo0B9GLdQ=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=G4pput9Wg3kfHm1RYWbcsdk3KpNBQaDV+9GWwSf4wBYDBxfFQHOqOS3sApIF0Nlec
	 KJKndkEYzcjuZFkJ0ZRg5l5RA3+xH8ieTCmwsi8xLiqj0ViSryyBUVVRoAHoemSlvB
	 xZcNt5UV7oP2DsyRQkz6yi7lJnZVbszXIZHZ/M/CqkwRMkENVKL8xEsTO7+kAJRsvB
	 J+xBZZDzv5+w6V4dgU7df+rT2DqJ7gQsClirIzV7Mszoszml39MXsiDtA9q+fziYu8
	 GJsmvUgdKqqZ1zYKsFD4GTUh2o1rit9dE3u0Cr26nfxiQdrwUNXHNOSfdzUgUgwj5z
	 4fLsWDLbvESkg==
Message-ID: <sashiko-outbox-229281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Restore the device allowlist for lifting the
 2.5GT/s speed clamp
Reply-To: sashiko-reviews@lists.linux.dev
To: "Chen Haohui" <hhc436476@gmail.com>, linux-pci <linux-pci@vger.kernel.org>
In-Reply-To: <179543878283.1348.10115969159184460350@gmail.com>
References: <179543878283.1348.10115969159184460350@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 13:04:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed link
> retraining") removed the Vendor:Device allowlist and the link status check
> gating the removal of a 2.5GT/s speed restriction, so the restriction is =
now
> lifted on any downstream port that supports a faster link and whose Target
> Link Speed reads 2.5GT/s.  The commit message says this is done "in a hope
> it is safe to do so".
>=20
> On a Fujitsu XH320 V2 it is not.  Root port 00:1c.3 is a 5GT/s capable
> C600/X79 PCH port, and firmware brought its link up at 2.5GT/s with Target
> Link Speed clamped to match.  Behind it is an XGI Z11/Z11M VGA adapter
> (07:00.0) whose own Link Capabilities advertise 2.5GT/s only.  Lifting the
> restriction makes the port retrain at 5GT/s, which does not complete agai=
nst
> an endpoint that only advertises 2.5GT/s, and the endpoint is dropped:
>=20
>   pci 0000:00:1c.3: removing 2.5GT/s downstream link speed restriction
> [ ... ]
> Fixes: 72780f796468 ("PCI: Always lift 2.5GT/s restriction in PCIe failed=
 link retraining")
> Cc: stable@vger.kernel.org	# v6.5+
> Link: https://lore.kernel.org/all/179499032167.260.12060379483856337575@g=
mail.com/
> Reported-by: Chen Haohui <hhc436476@gmail.com>
> Signed-off-by: Chen Haohui <hhc436476@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179543878283.1348.1=
0115969159184460350@gmail.com?part=3D1
