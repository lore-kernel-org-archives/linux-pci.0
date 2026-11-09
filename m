Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794259027;
	b=PiyPuEw3en6o3O9ADMKoLhMisFodENOhDRoRh++LR5MhQWz+2p866q5SBZ6FoFM6w9va
	 wx42DUJl54tTQkdHIHtVkHBS8MDgfTd4AweuG2x8TfvAawOyhilyUyURo0seoJEUKDaLV
	 ek8YDApIHmbkXKcReZMOW+r7Yo7WrISblagncHoAs8nNm2BUqs1PCwkkPOadJQpAvWUO9
	 1tif8manphISZrosqHDkIYW84L/XaeAnUn5CwM7f8xLta0u2qZFhUvGvT8ZQkS/byOgzS
	 hzHOuGWWMe+zOZ/+///xdQfQfZLNqARae2CXJmD/YrU2m7PQ7FKENTnO/iOgUQ6DUiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794259027;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7oyl/TJI2e5RsHSizuvPrFIQxEzv92ADYIqSjAjx2e8=;
	b=jOG+QMGwBA0cmBPjgcyqaLkkHBis/l4ymxL5WWD/ZcOJjRFHg0208xKwVhqITPOGqMJq
	 8mmwsIII08WLEkLH84FnAC3tKYMa787LVnzvnHdg39Y91nRCOqZ9ME9KzHoE71MKk4dKa
	 b0jnYT6nRQtt/t0uyS+EBkCP52Nqhrwnx4haBEEW4C58M6/eK5MHDLyJ+93/kFJ8xPZWK
	 9A4Rjk7+ip6sRXRBRTm5l+vyGcmvVx6bvvP/9wQ1EjQWG7jMOfZpQ6Kxg4x5p4J+wA88K
	 GOYyuAqLpLWwAiOgxug3K5R8Y2UsIabAwFTSrpe3hrybhHYzL6KnaXKBTJ+zKL31GuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgfbWDX3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E226606A31C
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KgfbWDX3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022711F008A2;
	Mon,  9 Nov 2026 21:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794259027;
	bh=7oyl/TJI2e5RsHSizuvPrFIQxEzv92ADYIqSjAjx2e8=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=KgfbWDX36dlP5g0Hfd79aYT5jsL+t+blZg71JlOuk2HmQBuGeFeDmKmA1bt84yG1Y
	 frHd27OVqOVNtJcEmpZxS6eRee8l+f5vTLmmWDNb4QaMyaJCClkoioUjBeRaLjKgf3
	 T34zjpF3MYbqzhQFA8F/JyPxaq6zn+lS8F9u4BoG+NznKHdgHwcXZMsT6tq5Cwp8Pn
	 uLQyGT914dB6LRDuOHqo8IwjgfykozTytiPQA7jPHpUwFMXXXZLdVV4YDFRDHmIIwr
	 eePwnv4mm+tCgskIQ3NpDvir7RmtcTCpOs3pAtrkAPZAvpEBwlH4Oia2uiQ75AsUI7
	 5q0IaQF5ZSaSQ==
Message-ID: <sashiko-outbox-205657@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 08/11] PCI: Move CardBus device setup to
 setup-cardbus.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-9-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-9-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:17:06 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> CardBus support can be disabled with CONFIG_CARDBUS, but
> pci_setup_device() still sets up CardBus bridges regardless of it. This
> inconsistency leads to a few corner cases in the resource sizing and
> assignment algorithm where CardBus bridges are treated like normal PCI
> devices.
>=20
> Move the CardBus-specific part of pci_setup_device() into
> pci_setup_cardbus_device() in setup-cardbus.c and ignore CardBus bridges
> when CARDBUS is not set.
>=20
> If a CardBus bridge that is Function 0 of a Multi-Function Device is
> ignored, pci_scan_slot() does not enumerate the other Functions either.
> Without CARDBUS, this makes the other Functions of CardBus combo chips
> unusable, e.g., the SD controller of the Ricoh RL5C476 (sdhci-pci), and
> the FireWire (firewire-ohci), Flash Media (tifm_7xx1), and SD
> (sdhci-pci) controllers of the TI PCIxx21. Making those drivers depend
> on CARDBUS would force CardBus also on users of chips without CardBus,
> e.g., the SD controller of the Ricoh R5C832 family, where Function 0 is
> a FireWire controller.
>=20
> CARDBUS defaults to y if CONFIG_PCCARD is enabled and the yenta_socket
> driver (CONFIG_YENTA) selects it, so CARDBUS=3Dn on hardware with a
> CardBus slot is most likely an intentional choice. It seems reasonable
> to require users with such an exceptional config to enable CARDBUS to
> keep using the drivers above with this legacy hardware.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D8

