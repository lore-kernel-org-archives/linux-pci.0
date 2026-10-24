Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792863120;
	b=Qk0Sl1+l6YOYuThovWI4NV2PI2tPreSQVZoBiCpoBlqyvamv3ThdbxUlwyMW8ZOwFieL
	 alyJxPKYB90bdeVQhUd2+RGej8bzaDMsNNV6/uE8I70FJKKg2G4aGa+6b1G4aD75RdCvA
	 qh1GSrSVP7ljcpKZKxrgiNxgJGmHGW1ztb3SN0HEN+CqMRicdfvr2xZj1fBwoXp23BrVl
	 KbOQIHWhwRT6ZrDyliJGSkzJyVAM+3Xi70a8KxvsClGemhwh9tBbMV6EQdydU9/6TjiBa
	 EPXkART3IQc50QxO2it4qsAfuyEls1H6WqCsSHvTlvjWbiPTytDZOXIEvR0hzlXlXIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792863120;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BTt1R5XtHl9ef+scR96NtnKA+VOYQAlkXo7DyXTbXKY=;
	b=MWLwl/hoRgf9ySDZFkiKVWgrD4+GqclmaJDsL4KsqCptdks1jhwjQaiyaF4cKduGc0Vv
	 7ZCsPBhwIFiNCm9zw14fQhfuyKnekZJVQR8y7oAFjsTO7dhG5NJMv/SkdBsNKWsQaLJhQ
	 1VmwMAiH1eFZ/GgtO0RdeKgock+OBfFCn63gkRhhQoNiazTdxB7neBTKEZPlMmHC1Jsp0
	 NfoRa/VHgSDTPkba7fXK90NtjDw2aJtha60X3bGrcNv018dLTADgMM40VorQznY8XEwg/
	 f4mtWyyNg4i1G1u/m4X8kmTnVcMrnXSu31GE2uYlw5GBt19m3mykiAQNpy92NECTDlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCfwnXub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F08606A31A
	for <linux-pci@vger.kernel.org>; Sat, 24 Oct 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCfwnXub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC9A11F01825;
	Sat, 24 Oct 2026 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792863119;
	bh=BTt1R5XtHl9ef+scR96NtnKA+VOYQAlkXo7DyXTbXKY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CCfwnXubPYPZyeaGzTNe4CSSNFlVk722f7fXsU+2Lwa13lYDFvYABqACmGIvS73ok
	 miyEJBj8iv5C3bS+KsCDWs7oBqBPHd31E7b40meljaZ+c9ve24YvzycYmwTkJr2g98
	 Ov34w49M/lA+a0JbOmUVDr4zaHja2WX5IHWkGlun39MZcvY9rbMsNBNYts1xZp4TkF
	 F8NAI4EzwTRtp5v32BgCUCM8PNDyjLsXLEYtSGBOwkH/4jHWG5DJMtK6ZSH8jvh6vP
	 kF60SB5nyGDp9dLsEY33zSVS0cZHtJgTqiJmbMy0B/OTffLvtQg4cqMHCEaEQ83h+E
	 VXcCuXtN4jZmg==
Message-ID: <sashiko-outbox-183827@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: quirks: Skip nv_msi_ht_cap_quirk when host bridge
 00:00.0 is absent
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261024172426.85842-1-kmehltretter@gmail.com>
References: <20261024172426.85842-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 17:31:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> __nv_msi_ht_cap_quirk() runs on all PCI_VENDOR_ID_NVIDIA devices to
> enable or disable HyperTransport MSI mapping relative to a host bridge
> at bus 0, slot 0, function 0.
>=20
> On NVIDIA Tegra SoCs (such as Tegra210 on Jetson Nano), the PCIe
> controller exposes root ports at 00:01.0 and 00:02.0 with no device at
> 00:00.0, and the root port's HT MSI mapping capability is already
> disabled (found =3D=3D 1). Looking up 00:00.0 returns NULL and logs a
> false-positive warning on every boot:
>=20
>   pci 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
>=20
> Return silently when no 00:00.0 device exists on the domain, matching
> nv_ht_enable_msi_mapping().
>=20
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024172426.8584=
2-1-kmehltretter@gmail.com?part=3D1

