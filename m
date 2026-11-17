Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925379;
	b=NXPgM7cQyrZX/K9FM19lpNrWghBXKqWR1QJjZy3VN2eQ1xywzFglxvYDo2noZrKSS9ON
	 FntEpoL98vT+TDMk5tQN0qmaABkkmw2PGYDy0XYNs7MfwRyqkeYwsp4yOEOhMv5TCed++
	 QmDxdMvOjbP/w3fqY4GuFpRfva2v8YVbJmrHmhSqgTNG9wMOHIhU9o+LSXkqXWEhfKZ9C
	 P4t4QFeC0vXFmigxQRcBNmNZulHv4svHrCLjWP5Z+fYo1MW2NoWP7aEN96KTka0bLDQok
	 rIVIhILgKNKHIMiIDS54bGYEW+PgyAdXiuY5l8pyKkD3OJLGDsvFS9Hd0FDIf3yFdHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925379;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ZHuc3nvYIZDL7FFoBjTKV6+jpBZrnqfNHIo2A0iolG0=;
	b=dFwBt0LTBsJzvrGk+r7P6ZG5OUVPrMkzySbj7nA0CCspV1vF1P98nCzGhLT5anihun/c
	 wM5Eb2IIqHfAkrnXqmZf4Wn52YcvINVOb/HEeFtr6vh2ZElftzN9HdNc6gTmJv95HfAJI
	 JeSFILWgNFInpoGXMVsuqZuXBm3aeP4A/NqbRzz7pc5YMWlug0m/Y7R9EAY8iZI1CrtE9
	 utmi4xfYa5wgFm0kJ3t/srXvMjAkVNWEjzqNu5HEAtjNcMgPofeGAE2uA72t1DFWPcXSL
	 x3Nbv2+mLbheOAOJYSJD66GyDF45vy3vo/+6YRIR/0+ybvUGkmks2M9+zXsBWNjdCjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4jjUolF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653D7606A31C;
	Tue, 17 Nov 2026 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y4jjUolF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE06A1F000C5;
	Tue, 17 Nov 2026 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925379;
	bh=ZHuc3nvYIZDL7FFoBjTKV6+jpBZrnqfNHIo2A0iolG0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y4jjUolF7kEfM2jJz8co/g3T3c8WemBMVgup/f//TvF8teSYdEpN7HKujutu5SNbn
	 rAjg1mUDn/CpFHQ82XKE4EUE+DpZUFyLBIjC5gUuDBh8nVNPN8JR+MFUHV0St8I9kK
	 vXeFcDg5hF6oemR3pdnQGnc+K584EP5LmqxNeHZp4D39Pch8D61AibdFKdCUeQQ8Iy
	 tguLok5Zw69nOJlk8wKwhlXytaY/1N52GQmefWTVqyGPp4zY9URl/FWoCtWZVDETag
	 0Ez+XoX7t2ofYLtsXaMbBe2obVu2SWyvGmomiI0wQG29QEchr3oTDeZkRv6cDoE7YM
	 lpo7vuS+Acg2g==
Message-ID: <sashiko-outbox-218953@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 1/5] rust: alloc: add `KBox::into_non_null`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261116-unique-ref-v22-1-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-1-12029383206d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:22:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-unique-ref=
-v22-0-12029383206d@kernel.org?part=3D1

