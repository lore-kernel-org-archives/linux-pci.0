Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793878824;
	b=i4BSW75Qzf1uEXO8Qz40KhgrkdJo3pLxOCQfcJvhXcciS1YzWrnxcApODkHFuAYKB8bT
	 3LFGqQt+xobHg8UdILVlcETUVmxWp8cbQ/FwIrYygFCDMVhiZGWVdIOg8F5IDd87ASRQs
	 H8HkF0NhJlQBweoxttqDfCzrEosC7HkfTXYVxxNv/MKKj3XVephgZU0wxaJPIFKiFUhdS
	 WCUNHtZwjU2KV0w8el02g29Ze/Q2pLQcYx9BUnf4XlYLzjf4iZOnN+3g9fR+oglDZFY7W
	 6+9I0rO9rTosJ84sH2cGjcD0FmZPIdoc27oUXhNvhUFW7SCDyakg6LeLFmgOdE23Fsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878824;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=J5Eo39xafKtQmY/imVUr4yAZXzV3UlRJeZ/raPao2I8=;
	b=KVBUodkNP8rOu6ujQX3+Qwf9W2Q1y7/ZvfW5e/UDhRgjC9BwVZSj86qjFAnh51PRGlx8
	 06kkv8g0kM//cLucnThHuQWWqYdTakw8Nba7rVuqU0PptxNkuXMbn/MpSHG6fl03jd2/K
	 T8lCFis4QtdHAY7tDrhVy1FkHx2NsSK/4+DWv70ztDWg8XLEDVLRXzDgjWJuIreVIkujD
	 sL0dGY6G2es/l4qYeabHAhQXRd1Fq4j+jBkhlC5NeswU8NKc3XfVunD6AyPL4VOgbaL18
	 2230me2YBWmkIB5J/va1g/iNWuPMI/CjOoVKZmw22/A9dFckbvpIW1IhUrpa+pMhcHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlDr7gDs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424B8606A332
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NlDr7gDs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB111F000C1;
	Thu,  5 Nov 2026 11:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793878824;
	bh=J5Eo39xafKtQmY/imVUr4yAZXzV3UlRJeZ/raPao2I8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NlDr7gDs8PWfVnIe1c1RTt1vQ4yfS/jc4wgRwEJLOBofLi53fb1eAo+jOXR3IWzRB
	 8KKyb6XMGLtGOYXQUxYhKcanxuueoKNDorwqOs8pU3gnM3+cXGDhZGR5rtdHPmNEIC
	 SEaJGdMG+7jkbPtUSHfL1SuC6qjuQaS6x6CteWKbyQhrQqdXL7Q5np5nCjEOVh0UfU
	 4A3YK1u5cmYebRDoZ1/KFeb3LrxEUpD6ivcGA2I4mUGtMWV01NLkyX9ttCXRTOY04M
	 ENfbbYl5xY1sIf7Zt4kd7ovt6HztEPF1ZBCIaNQwQ35MQy2JaXipn3cpkiMuRsHUJt
	 JVxRfdnbVqmSg==
Message-ID: <sashiko-outbox-198966@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] arm64: dts: apple: t8122: Keep ps_apcie_phy_sw
 always-on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-apple-m3-pcie-v1-1-e00a72a604f8@jannau.net>
References: <20261105-apple-m3-pcie-v1-0-e00a72a604f8@jannau.net>
 <20261105-apple-m3-pcie-v1-1-e00a72a604f8@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 11:40:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The APCIE_PHY_SW power state is in Apple's device tree a child of the
> virtual storage and general purpose PCIe power-states. MacOS however
> keeps it always powered on. Mirror this behaviour like the M2 Pro/Max
> device trees already do in t602x-pgmr.dtsi.
>=20
> Fixes: c65ab4905e58 ("arm64: dts: apple: Initial t8122 (M3) device trees")
> Signed-off-by: Janne Grunau <j@jannau.net>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-apple-m3-p=
cie-v1-0-e00a72a604f8@jannau.net?part=3D1

