Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296123;
	b=u7rIqvNiVT94iIOfz16TFy044RwN/r0lWWDMNi3F8bzp0R+vFN7dfWEz30/dWQ4sCU9D
	 z3WOjZEYCMruKHQObeyPR6k4fABCM6Se/RVmSFuC784GqG+r7gfny9mJ/+/ugz8FR+l+e
	 Cr1hIf6ev6rvNPWipwIfHm67EwUmnGKWoAsjyOIwoWbp0RQoofAIrVYcaK97Qlfxe8IG6
	 RNfPb4aQnORWgVyoEyI6yjqaZ2FjgOiRaT55CRZEoswux/60PvZAsM8k20x2xuQxdei+6
	 fuHEwK/BKRZxIi2y0s5k7XELcU0ESj7agyII7r4oQmxsudbWQeS+saCqaFwANzrl4TA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296123;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BmHyWnDVQh+dlHCaxoc/Dbr2VZRcXWgdENBlYYQhyZ4=;
	b=KoXkXEIykLDqIzl3a8SUM0lzEz6qMvuABiCOVf63XDMtsrdSZhYaxPlmCxbEIZr0wfen
	 hQp9pWJ1o0N1xBQ3NQurSb+SICNYFdrIAvGEWepn2WZn46qyKezF60ghz5V8eHdguauRA
	 T8Vqgp8RWCU5pvnh7e4m6w/GseP1GuFuJPGVpSyW1kTNNWQWG+yx0Z5xh36rylSn0BhHT
	 ei6ZwX1kUDzPCD4FjFN8g9Mx099r/yB1UJI4QdC0OQun1iuMNv19zGKzeiJO3i792ibqJ
	 XeKBUVbSWZY3ID7RKf9fmA6YblFt89r/kZRyPKzSJk3qydz7+68g9po6VbpTGwYiysA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iq4b5EKX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E0F60A2609;
	Tue, 10 Nov 2026 07:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iq4b5EKX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC391F00904;
	Tue, 10 Nov 2026 07:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296122;
	bh=BmHyWnDVQh+dlHCaxoc/Dbr2VZRcXWgdENBlYYQhyZ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Iq4b5EKXIJ8us49QT0g8UA3veimRhoBRa5CxkdaMIHISaQIKeNx3ZPAEE0S482QYt
	 +ylYAe3wbH3mb3qsIsadvdJ50NIDuaML3Q0fYGhn3D+PAaNwSng75CcUUg1q/9iQiZ
	 CJpVBQdikqfSRub8Wnzbytvo30zH08VVd9P/4rzq3RZBMV6dWuSR/NGMr9tTkTKdqd
	 jjLvYCxBrJn+nkVkmcZOFJnkynlJnw57RFpZboaCDIhcb5d4kpNZ1MTTJU/vMPZHPy
	 s9M+LRsKMhbf1I4fKGWnWgmRAPaBpVyTnFVY7Y49PVNhji1fxZhjlc3raz1vX+PGBm
	 D1GARrDqBnEVA==
Message-ID: <sashiko-outbox-206513@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/19] driver core: Accept device trust policy on the
 kernel command line
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-13-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-13-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:21 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> Built-in drivers can probe before initrd policy agents start. Fresh
> attestation therefore requires disabled policy before those attempts.
>=20
> Add device_trust=3D<bus>:<device>=3D<policy>[,...] to initialize requested
> policy before registration. Apply PCI overrides during discovery so IOMMU
> and ACS decisions use the same initial policy as binding. Retain rules for
> hotplug, preserve admission history when a device object is reused, and
> leave unlisted devices unchanged.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D13

