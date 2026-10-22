Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792692204;
	b=eIBIZkK15s7xm/tByM5Xp0EMFckeMx9mkaz2nZMK7vQwYSkKextAR1Jqgt6WBeY9s80l
	 MXwJkxPeFOSIaFOwtOk0LJ/Bqclt5vWvCka7NRyCURF952ZZcYVwPKAnNQnK4m7yr7Rho
	 mFq4kiciliMDjZapdvG4SOk9CKTC5lY0YijCOxifijPEigDpFNSagJeW0zGQwu1MQsbXb
	 e74mq3S5W8EXtnB2nz6M1RnHHtGxHF+OkfHLPXRlr2AMM+4iVJjkGfpTkDB4C4VU7f0s+
	 0L345a0XbnrVatWeh59NOw1VCnGbJUJ2iN4Q0FYEEVQafOeEwEgWha5h5TDuPMizxPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792692204;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PIG0YWkRKIwZfZUQq0ylwHMlyOagabZevM5dkbenq10=;
	b=1MgP7DtkD5vV8WAw51Hj5+icZcEupgCl5/yk3sVJ6KJfPwn1SQ8OZoUgUKV6qVf+/LRU
	 6cL9UavzRT5K4rvdDDI3IkXKwDUaaYsWZqi0n0V4kA+0Y18R9u+0pWYpHU/StQZb5Vmol
	 KmiUSLGqnlbtDxgPla5OWnH93mn/9TN+ygLxvVIcb8C/o3OYYy76UvjXC8sRDXYkrynAR
	 JMJ6l66puXecNt2lWDeKyQ3GzntZ1ZSgCXOoXG61PcHRE4E9K6PzkHIcxxYVrumUvR4v5
	 /WWA9HJiOGI1iqgXlr7Vn59KbNCziEEyQCBq/Y2iLaOxe8ho+KWUTYkiL8ORBGf1FJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc7pfK3Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FAA606A31A
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 18:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nc7pfK3Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A861F01825;
	Thu, 22 Oct 2026 18:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792692203;
	bh=PIG0YWkRKIwZfZUQq0ylwHMlyOagabZevM5dkbenq10=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nc7pfK3Q2T079wA2qirZqgitNTwYvCcYTTL3uf1PofA86v0BsQI4AUzvHilajXDW1
	 6risS9rZ/bjVNYgpBiyFh9b3CWSsxVKYibCn8Hs4HeMi7nrO6RC0JPQBh+qBQa5zL1
	 FEx107CT09UsEcgfELhk9B0yvqkAP/mTaSzlDW+mplQ+FwKTkcCkujTmDTzo3NnhSg
	 w+MgJ8tGTCovuEn3/EpP4+yyCtG9hVsaSh05MF2776qkMsnko86VA5L8PaIvWJ3uSj
	 6MsGn/LEH/5V6X+rd7qKoWNybaDWyib6aVr3p4lroRRqXwq6iJsiG5cQ+knaCrz81a
	 9QS8Pd0YjFs8Q==
Message-ID: <sashiko-outbox-181899@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] selftests: pci_endpoint: Do not link with pthread
Reply-To: sashiko-reviews@lists.linux.dev
To: "Florian Fainelli" <florian.fainelli@broadcom.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBFTkRQT0lOVCBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>
In-Reply-To: <20261022180022.1282641-1-florian.fainelli@broadcom.com>
References: <20261022180022.1282641-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 18:03:22 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> This tool does not make use of POSIX threads there is no need to link
> with libpthread as a result.
>=20
> Fixes: 392188bb0f6e ("selftests: pci_endpoint: Migrate to Kselftest frame=
work")
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022180022.1282=
641-1-florian.fainelli@broadcom.com?part=3D1

