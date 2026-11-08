Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794148112;
	b=YSU59vcR0p2qusKAKNWHKihoKp8CzAzBX6SHuLuGND+0evWuHn8h1aR61B//1bj7CwrK
	 ER3ZQc+KAVP6k6OKBORQiF97Th+xhcGRAKeclDV/KEXNMubUgpd71OwXyzz5YEeZQWbVF
	 ndDDI1juHwvIvK3gMoqsM48YUnSp9J7IhQCZLRabmc2Q4Qb5HdatmR9s71kQwjuRMr3a/
	 6fhtvFhKin5LIHJfpFflO70GNjg9pUM2Wc/zxUEH75Nd081TbqHkv9LZNNO0rZJ1PAYKL
	 K/BWGU/QjJtpOWbsDI6REXMDkhN7i+yaoMrysIOPzRAIo8lwfZzkOFBdp4+VRGQv5lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794148112;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mgPt8iZ4lhRucC8uTVyT45A/ycBpYjFQ903dh98+oS4=;
	b=vhN24QGifBsYNuyzy793CK9OtgeMcCwozPKkxbMXZ7zwF3qaksRMPHHA2lHRtZWu4CKr
	 pXQVRJpR968mXOhZSIbdhmyAe4yhuf1YYAddBLAxSbrszLx2BgNdPyk+c9mwojC5HgH2T
	 ArPTX+HLFyOXHxXrnIRrcTbn4JbT0/AytwSwxjceEq9x0JWvF3NrsR1WJGbES2vWd26nR
	 plSR5+4hMKnu4JPXhUUm2bbVjwr1INtrxmPbfRFIKf3L+jZjq9ahJztVSM2AtkNGFTbn6
	 VdbGYRJfdQoichYFtp6YrM72HwH/de5LSIDnPM3dCupt9Ll6KOxxqDx0hWIyV5TLKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lB8Yvur/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A07E606A321
	for <linux-pci@vger.kernel.org>; Sun,  8 Nov 2026 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lB8Yvur/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63F11F0089F;
	Sun,  8 Nov 2026 14:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794148112;
	bh=mgPt8iZ4lhRucC8uTVyT45A/ycBpYjFQ903dh98+oS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lB8Yvur/Jx/+EqyDev7UVQ8NLt7fsUdC6stEK7ymCH8Q9/woSTYaE5gyK8HxR8rF/
	 cy/apb9GlRA/ToSEksOd5hw8xeEx2PRbh6P1/epb7cTAUj8/hG6jSEFpq89vtdVFXK
	 Tke49avOj3LY39sn19LFLFIm1FI7ASM2qJzXEoyC7MzhJt4btnlKEpuPtKB4tSOJRH
	 e2K57dd4U43cSVnYMqXaGTZO3lq3oD9Lvg4TXVOh7NNCefHhChL03TLGkqiBGGtSoW
	 OgVP+cO2FeEQ3Gf9JsZQr0Ckv/bbd3XZMaHZ8mkzJ6ARzioR1NH6e+WPwuoDTAwkay
	 ZTmZ0zedS5mlw==
Message-ID: <sashiko-outbox-203800@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/7] arm64: dts: apple: t8122: Keep ps_apcie_phy_sw
 always-on
Reply-To: sashiko-reviews@lists.linux.dev
To: "Janne Grunau" <j@jannau.net>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261108-apple-m3-pcie-v2-1-0e5ffec71da4@jannau.net>
References: <20261108-apple-m3-pcie-v2-0-0e5ffec71da4@jannau.net>
 <20261108-apple-m3-pcie-v2-1-0e5ffec71da4@jannau.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 14:28:31 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-apple-m3-p=
cie-v2-0-0e5ffec71da4@jannau.net?part=3D1

