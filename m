Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793382810;
	b=BsbqVFBQkMLItdTaFyUaGqGaUwYHZapXSQyJVtslKDKwklTBvJhK7bXyCeOfiCyJtZpE
	 0j7SWwu3LxvXor+WwiBHzS00MDUNbf7uble+h+L7D1kNO8pivrl27bj29ynH5DHiC4xMe
	 PGmxdrE7R4U5aVwVn4W4AdHyFfhkwTBvLqSBbMMPFou2PUFBC0yw8kjXxDqUwn3TFGcDa
	 SVxP3Jn32X9NT+tk76fJgkudNKeWuQu4nwDwNqF0h4SmBoEla9M9edzAS8J66rL0hhnoJ
	 YEPIILLCCZ0S/+I/BBfcLsKotk9iFD+vZIluNIAb5MaHvwWB85s5yjWdYDbxpzo9ZEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793382810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YE2++E4hbpYmHSRRgfKWEVm/29HpNHmK3SevGyf6Zjo=;
	b=vkg0b+QTIdI0ECYNCCtoJimil0LJwE9ud4EEroodK0FzRK8fTrD0++rAX20I63uz8/F5
	 zo5qb4FeZae558mYY1Z/Rp7CPZE8JQ990+pw6qGO4T/MHnhTU3BBVhkXsrFHxuPcLnOXC
	 2nhJH78TPhgvQ5P1ZVvlPTtwxgkQKlyJlXa1AzwXOO2D2xEMslsmpd1rTQMETeDXzEujb
	 Rsi/na3Ygb0Phohkx0dJNwBOoq8wDf5S1ndyaLXW946inOKSm9RdObppYqRtz4tgcaC+n
	 cIuPBfTWOdUBgD7T9KyCQGoPNNJhHC7jNgryA5I46rURddBYetI9MkQWhqNdT0CruAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ohsf9Gc/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AB9606A31E
	for <linux-pci@vger.kernel.org>; Fri, 30 Oct 2026 17:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ohsf9Gc/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DFB1F0093A;
	Fri, 30 Oct 2026 17:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793382810;
	bh=YE2++E4hbpYmHSRRgfKWEVm/29HpNHmK3SevGyf6Zjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ohsf9Gc/Tsx7QbEHEGinl6RU3p2NejrTOpfoexhIbNwrDu6dBn4eyMb2V6g12rDsX
	 pQNeeq6CCQcvMq52PE1vn70Uz8vbhQe8eYcxPG5HI5wa8bGo7OzDi2fN2O0qmiW7jF
	 qF4zHpnQatPpo+U1CB728QTGZDY7uGUXXvqKHoZZ+P/iLLWdVTLB87UtrO6qvhD+VS
	 kofTstFwT3jjX1Sst2NZlQcQjpkTTPx7o97AuaZnYR1Y5GtaCDXhBKQh6aJUBumtw9
	 Cx3NCUML3udlw1zghi2ZhjpOnPFXuWN6iwNKDSGS9YbMNAKdO55FkAm4f+mgu/CjgG
	 5bHwC3GnsC9NA==
Message-ID: <sashiko-outbox-191368@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/pwrctrl: generic: Fix leak on clock error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Felix Gu" <ustc.gu@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
References: <20261031-pwrctrl-v1-1-405af11c5662@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 17:53:29 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The devm release action for the slot supplies is registered after
> devm_clk_get_optional().  If clock acquisition fails, probe returns
> immediately, so the resources eallocated by of_regulator_bulk_get_all()
> is never freed.
>=20
> Register the devm action right after of_regulator_bulk_get_all()
> succeeds, so the resources are released on any subsequent probe failure.
>=20
> Fixes: 9cb64f61ec7a9 ("PCI/pwrctrl: Add PCIe M.2 connector support")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031-pwrctrl-v1=
-1-405af11c5662@gmail.com?part=3D1

