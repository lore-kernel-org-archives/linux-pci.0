Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792490366;
	b=vAEnJ/RFb9AkpIFpS5bX+XaFk9l1TkBAySINUfFqiXqCKNj3t9OebLOdifTeMXluMvCR
	 K+HdAStFrM1SO+ipIG/sDaVkeTpm1jn/eU8tsfC43ZD5/EMsbyb61r6J+x8TSvS0y369i
	 dHNfA3XYrr+YeKsmxdsDhyvxOPZx7glYrjvrvrrb3QbMhOGoTOHZTHPN1+Zs4yJ2g5+m4
	 F50JeMJSfbItYODaX/5vjqy8D6ET+RE6HNKBoW7I2VGmLrvoI1Tu4HPJvQUq6UXCszU7y
	 XroNv0QJHjY3JgyCmPsKtz9N9vLD1L2SBGyVsJsXw8D/P8567u4YIsAcvR2bvozyWaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792490366;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WYHpD9yZcNdLbDqVpDwKmO8Dsh3wn1HDeeyT7KijEmo=;
	b=J2fm3HZpCgT88YFc0TJ1nMnMtoFYEd4LgYx1fCbJHL/aZfdwITEDqKw+BYDZI9FYT9/h
	 ptIVJmZSGJzT9HxQa+JW2uO+cpLGrC+vzqxu7KsPxIJW76Imk1ohU8p9/wfNMEBm84QSa
	 FNuNCVdPZK9f8DZjBJpNuEGeHNsPFi1srS1nBSQkx6NDu3Aajkk30YgJVQHiscEYy3g5K
	 JVLeZ5f7a5wWj6XWfQRL/Wd8hwRuNJ5KcpdTOv0x4FQQfl60DENnKeBx8yAOd9BeGZPKP
	 GPJ6No6bz806DbGT27PQTP0u8fE4eVDITEz+urPVlur8y9pI1Za2XduEVENbOmqyezw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYkIXTul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CD606A328
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 09:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oYkIXTul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B302A1F000CA;
	Tue, 20 Oct 2026 09:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792490365;
	bh=WYHpD9yZcNdLbDqVpDwKmO8Dsh3wn1HDeeyT7KijEmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oYkIXTuliAtPdZsIEG75IuSTwiU7VfxVhD2TY5vfTmhbE2OWKl6c/LRhaKzV4dLPS
	 bOPbEnihQZRAz/KTP8kYqF9GJ74RWIJGsY+24mcoIBDz9iHKtCOHLM/HwP/D0rss/g
	 58adWuWGIRvA1cgyZtFA60m8wB5xrh/yVq13octQGpXP3PIQeTgcvLiIwMbnJ91YRe
	 rLwm/cyq5mf8hPAVFM3XmGGl4gUuVufbKp9WB7XXbp9l/Se210EaBDH61CcK/xtK1u
	 edn/1P4qwbrrf1360ux6C5RnY2bz0UZzCtOpcFzQVcg37cznBQZbIkckTCSf81g+zN
	 8msWBn8wxo32w==
Message-ID: <sashiko-outbox-178783@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/17] arm64: dts: renesas: r8a779g0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020031049.969895-17-den@valinux.co.jp>
References: <20261020031049.969895-1-den@valinux.co.jp>
 <20261020031049.969895-17-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 09:59:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The PCIe controllers report Root Port AER notifications through SPI 454
> and SPI 461, respectively, separately from the integrated MSI receiver
> interrupts. Describe these interrupts with the "aer" name so the
> controller driver can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Suggested-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020031049.9698=
95-1-den@valinux.co.jp?part=3D16

