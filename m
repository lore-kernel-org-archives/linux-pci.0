Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794568834;
	b=Rmpdl6Oy/P891BfAg06brZ4c+pstz982UPzFQP4sS+Sqjd7sMnKVC6bsoo3zRkorLA8P
	 KVFo2d9clkRhqSHFanREcgv1sI16WphkkvR/yxnen7c5sznNbpkhqMCauBg+Rb2Jud1qT
	 0q3soTgrL0fCX32RhSARC8scIYrkc2QNm5KzoK+zz1B1wRDprDD4KKmSE99JCOsFCZsQv
	 ml1nmSbU4dnjkxUal1FsWqPDloChuq4ytx46YPE9a2GOD/r6vyJyS3MRvXJDggRHJuOhx
	 5OyNCxRnaqqzq94yVRiNzrWPqruZWwOENkpRmTN2PRvQioaNzGpRphDnduaQuKZv1Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794568834;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sg97A9LWSkI8A2Arj8tZ9DgML1Yr1eXkZZumNX+nxkY=;
	b=R1XQzZEaSOoivoMmhxCVGnQG40uQXszMXR/aPGLbNZdUUBByyYq1kh7o+5a99WaxyUAs
	 FCeARhDEUftU94vnu6BgOLpdkPjscDsHe//VEaouTb0OghyGpTTKxXEETAxy5wwkM8kjq
	 QgiWoA6vZEHa00hJ6vUKarX2r2GTaNU9b2pJ8ClKHwAoqVuqOb5Vh/C4fWf7HylCcwgfw
	 MiD1twr+Lu5WiKJ08fGKob9W5Doc51X1rD7u8wF8c9E5MXhDgCq8dj6AXhz0OPzGVsrDe
	 gQlywyjxMReH+ZcEg37pe81MH1cBTLFaS2G+ejO84NkpZ1F5Ppc522y4pgPta2p9RVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJB4h8ST;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B674606A8B0
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJB4h8ST
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A961F000C4;
	Fri, 13 Nov 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794568834;
	bh=Sg97A9LWSkI8A2Arj8tZ9DgML1Yr1eXkZZumNX+nxkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BJB4h8STsBYmmMFcUTtLDMbD0CFvAVizBQh4bMMjOkQ7nNvHhymRQVHxRyCEKBdsO
	 tKakBmd8H3gIfCG9h2awLWlZDm0/kdn7qqETkJEiKKsD1kPPASxneNm0TzViDOGb6v
	 nRafE+/3s2T054OLPm4Ud6buBPiK+6++G5EmSKDGINGRGIdD7DSFxMIXxJfkSgDjwR
	 XYrz1zpikDd6OI8G2aNIcmXU7fPaC1WMxG3kzX754Vp9NcxmSXRHsPy4NdfcZLhuT6
	 axOnSunYWvD3ZmvKJ8fUUK+RllHG5fXstg0nHUyfgXxsDq//YGcN0jfyhUVFrvC0rV
	 6eTUqopyjXaqg==
Message-ID: <sashiko-outbox-212710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] ACPI: Unify *_device_id list terminators
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VXdlIEtsZWluZS1Lw7ZuaWcgKFRoZSBDYXBhYmxlIEh1Yik=?= <u.kleine-koenig@baylibre.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <68abd7c74b17f3ff08bd825b08b99d7b77ca76ac.1794567577.git.ukleinek@kernel.org>
References: <cover.1794567577.git.ukleinek@kernel.org>
 <68abd7c74b17f3ff08bd825b08b99d7b77ca76ac.1794567577.git.ukleinek@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 11:20:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Consistenly use a single space and no trailing , for the list
> terminator. This doesn't introduce any changes to the compiled result of
> the modified drivers and just aligns these to the common style of the
> other device_id arrays.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794567577.gi=
t.ukleinek@kernel.org?part=3D4

