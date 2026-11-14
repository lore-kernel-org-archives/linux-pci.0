Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618062;
	b=ODOiLKgzEEj9z4ZdLVrEbckR4F4Zm4p90dmVdk9R6NgtB0JqU1c1mRA/150cr1LDa0JP
	 wWaeDsJDbRG4C55x96Y9cRPLr6gvZ+XAdbi6POqvwf34Am7El5qDA89qWX4xQZHrWA3E+
	 Z3Bn2Z5CitGVdKntKKjQrITvXccjc0NgDa3bDsHhvOlIPbVzmXkSORYCjAGFiBiWZnFLQ
	 XiXqJ093X+e/50eZDcoCqiRx+kAz9nR8mK/LsHp/QVFJ30s40MTJbx7m/b0CO6H5fTiVM
	 5BPV/bSXGLSf1YJQnS5UXefPB8RFM1bBlTRWm6q17tFnw7zG/xxhH5YCIo2UDWQX80w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618062;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JrMANqhgmcq1xD/hCNfaObuBPo04ooCcly1RfV1yR7Q=;
	b=Y+aMw560wRZ+E2GEt7Ht7zD6tn2beGp+nPxn3qC4aDlRyAvTHg9aLfeUJqTrfC95XUfj
	 ECTggeiO/VvWM1CRH6ZJ3KJ1mIbVAFuLY6M+Aq+CeZgkDJXTuS33b8SVJ8R5x30u8EPqC
	 ToK3MdJlt5bHuRiJY5c9IjzpHUn/SwUBE+jJbaEEdy4foEkJ824o8fqmwSTkGkM2tCbJP
	 U+ozdjLX36eP3aJqdgBrno6JcaRTcW/KadmfxFWPV0OSHJIlTf/6exCDIBjWKFzJamCzu
	 cSwyGOfiX+0Sd2F6FZyOBkYfDPW1BYwLVwgI4kgILhn3c1Ksuu/XqnRxTvrmRNuoQYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwQwrrfB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D5C606A333
	for <linux-pci@vger.kernel.org>; Sat, 14 Nov 2026 01:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwQwrrfB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C57A1F000C4;
	Sat, 14 Nov 2026 01:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794618062;
	bh=JrMANqhgmcq1xD/hCNfaObuBPo04ooCcly1RfV1yR7Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwQwrrfBlYWayJe1Yhg309Qdw7h4R9f/zVh0fF6cHOSvs1mpBvatcbql3mqfpmEO3
	 UIoKweaQN/drm9/To5mNBm/lgdarL0UND8CWKJO8wRjRI96CU8FMlAE7/hulAp1IKH
	 ms0oB+XlRhC5RpUmV5so2nl8kGcPXscgc0x19iBiZq08K+9/KgB0xhNizNDMyvXy7l
	 VI/zQcOROxoW4b40kOLRoNh9FsBAtESpaAoyo8HtHXGeuOUzg41DBL9W1lqkJ5vRGP
	 UWdYTZ5aZMWMdd+EUMu9Z8uGT/0fo8mY/j3tMng8LUfKQ9Tpea0omDh2PpytwqAk9w
	 QIif2ADdyeTfw==
Message-ID: <sashiko-outbox-213973@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 3/3] PCI: rockchip-host: Recover downstream
 configuration access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Matt Thompson" <matt@boondocker.io>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261113-rfc-b4-v2-3-d6b14f95c1d6@boondocker.io>
References: <20261113-rfc-b4-v2-0-d6b14f95c1d6@boondocker.io>
 <20261113-rfc-b4-v2-3-d6b14f95c1d6@boondocker.io>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 01:01:01 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Matt Thompson <matt@boondocker.io>
>=20
> The link status can change between the readiness check and a downstream
> PCI configuration read. A link that reports up can also fail to return
> a usable completion.
>=20
> On arm64, annotate downstream loads for all three access widths so a
> synchronous external abort returns PCIBIOS_DEVICE_NOT_FOUND with all-ones
> data. Keep little-endian conversion and I/O read ordering on success.
>=20
> After retraining, the controller can continue to block configuration
> traffic until its AXI link-down latch is cleared. Clear the latch before
> downstream config reads and writes once the link readiness checks pass.
>=20
> Link: https://lore.kernel.org/linux-pci/20261024-rockchip-pcie-resume-v1-=
2-58e54a5cf5f1@iav.lv/
>=20
> Signed-off-by: Matt Thompson <matt@boondocker.io>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-rfc-b4-v2-=
0-d6b14f95c1d6@boondocker.io?part=3D3

