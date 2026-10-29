Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793245290;
	b=Wh8QYBJiPGSNS8BZ0sRjznD2N63J+WMO7eB+nsIu0HRNW0/QmB8o14wMvuxPEwobUP83
	 KX12HxF/TJ6ot8rqo1MNUcFw+ksyRCK0TgqclEI2gpHruM1yRzGsoQ0q/olZVDczjrDwK
	 y5/CCUGprwzk4ZwcgsiN9maQPM9C1C32eljE2o0RsYwo98GiwGNmF/dK3nWyFE0ZktvnN
	 9Lj2NAIfThHwXvvhkVqdfev7hf9VHpZpkEFEBZoXmQH5xBWp3izKqfiLCeNVlB4bwEfjt
	 0YA6iR4yCtvjYwDrsElSkVJh4JS/qrNmem/b8W8/N1ScuVsjxOaK1rY101tPn/UBrGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793245290;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mrtL8XqUGqE1N4DFlL2acGMVTdfHOFSmCAt9VWogr8g=;
	b=iFef1fHrGJx2GCIIKdH+nCZVpI4x2xm5coKeA+QEoVCFcU/Tg12jlYwZk8QshGMBg4wL
	 EH0Prv6egx5YN56HbqtmQ0O/emDg/BgsWCQ1ybG2X+lot+Ch6iIpmyjQNto4Ngvzg75Sm
	 RXecIV7E6P1pX0BP50ajRXQos9jCUEDkxtAOliBk3PADr8w+f4dmO3XIMl9if40CCKtdF
	 MgIkLa55N45lySGD7K4hdNrlxJWzyowYe5GdN/gtJnaduV2Lm4T7prglOJ4kZC2A/Y0We
	 m4D7Bt1nKOB7eoDDopXrICeUlCUy6hYobBmsCQcKi8aib7AT2Hh3m0xLtiFgriqaF/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="o06ggW/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DD606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o06ggW/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACC0B1F01825;
	Thu, 29 Oct 2026 03:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793245289;
	bh=mrtL8XqUGqE1N4DFlL2acGMVTdfHOFSmCAt9VWogr8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o06ggW/X6TaJUBDtcEEO7OAvhJaLLPiKwNSefmxaAM7LUkbEqmAm+EjAcQrkeW8rx
	 +Annuw9XkaJ+87RBjRmS5daPo570H190eWwYNeGnnTLmDLRlYv0BbA5uVd+Eg/Gmi+
	 CDfxDtP2Jiy1amIKHBldx+C1txLuQCeJlWz3gb+MEnz0UaqWec+AFFUIGv+XoQfj3Y
	 v2i31dsyhsr+yJZVwy5rAtiSRF343WcdqQtvv8JIskOilQpWRl8GucXV5W9FlOgj7A
	 mA/wtQILshY7CkLnushMNPbnXLs/lMYmw8u6q7bpsuDpAWwzkoD9Ot8fWovzaVuyek
	 yZ5vMRUG+Pr1Q==
Message-ID: <sashiko-outbox-188675@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] arm64: tegra: Add node for the GB10B GPU on
 Tegra264
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikko Perttunen" <mperttunen@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
References: <20261029-b4-t264-igpu-pci-v1-0-4d843dda0b02@nvidia.com>
 <20261029-b4-t264-igpu-pci-v1-5-4d843dda0b02@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 03:41:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> While the integrated GB10B GPU on Tegra264 is on the PCI bus, it
> requires a BPMP power domain to be enabled or it won't enumerate on the
> bus. Therefore, describe it and the power domain in the device tree to
> allow the power domain to be enabled prior to enumeration.
>=20
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-t264-ig=
pu-pci-v1-0-4d843dda0b02@nvidia.com?part=3D5

