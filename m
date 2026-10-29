Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286529;
	b=uHP70jHIqnfR4SL3ZDmUxuAh30cvex0nVE19V1zemQnfFFrKVGbh1ZPD5Ts+d+AslpcO
	 8K5XRoaLCMEC/fehz6um0VtdyjT12D5M1T2VxIyuIgKonXvsNz79zKYPCJ9CHq8xvIILV
	 8QAl1qz2kMuzUFFKvA5PFRIhoC6N7/TLS1s9hfc1Dntp/hHttbY8NM01PH6DYW83o8mVK
	 SnjtXi+8jB5SeUKI4ds0JkF/XNwWtj4XhUDO40URXGlLODcNVsQLVmbciU9YY706WhNoB
	 aBLFIIsYipWwPoGpCOIc0XQy004Nu7oMg6KwUDHKDrXT/l52tZybg0MZjH5GP92r05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286529;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fT039p2PTvp+D2ZvY7MSmvf3JvUBJ5IUe1oKaz0OrbY=;
	b=VK+PfkJ6md2U+Q+ePvNAiF2wy1b0aAs+eQdCBsqVSQwnWB39cjvYZ9bgKwM0DKrMG1QF
	 6IKl8lj1ZA4i00ju0NgepluLIs5S1kM8dz6dFVME5shjuK9tX4lU3Cx12A8iZsBaYb7uz
	 SF9EYqxIZCT+iuGsER8ARySCZbyZyV2Jsoym1QYFFhZZSOVkpkfIBSDOxVAqsHcy0CLK/
	 avkgzyVXowFNIO15MLzMoWdELwQqS8NpQtwfGnqYgDsyhHtW6xC12qHRxalUwJKOxys2U
	 XdCHw+i1Y6EFvbzS/x7Inwpjs5s8hTMcuLFJacyXMUuECMAvEjmniZCbuleLL4ivvcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFZdDAH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74655606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZFZdDAH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3E81F01825;
	Thu, 29 Oct 2026 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286529;
	bh=fT039p2PTvp+D2ZvY7MSmvf3JvUBJ5IUe1oKaz0OrbY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZFZdDAH3ajgRZtxwFpfuxi55Urr0iotZPkwENuzlA/RKVRtmoiSp/tDSmrJga6+Te
	 uLiskUU517tSGiqboyDdfIoVmXEdCtnSr+KZy1b/xBssOwjiepaIpa37Mmy3qfkO0X
	 vH6a12B7j62koQt5KTScyYrlAMKmy3eTVIK6afozUkUUGINZi3kl3seBBybPqrXq+h
	 EhKHbcxa0ar+m57mQnGLJqS1Z25gPU9aC16k4AbxRiYEvZOz19U6LHl2xiKNso8cEk
	 nIecyMQslc82CCvEFgQ4qM2eWm0ilotupbFfuBZ1t8gYtyc4ZF4CtCAgTXSQmi274O
	 Kn3T9SOGlVnMQ==
Message-ID: <sashiko-outbox-189581@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 09/18] cxl: Refresh cached PCI HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-10-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:08:48 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Early PCI discovery creates the HDM cache, while later CXL enumeration and
> decoder operations provide updated programming state.
>=20
> Refresh the PCI snapshot when decoders are enumerated, committed, or reset
> so reset recovery need not walk the CXL topology. Keep cache access and
> locking in the built-in HDM state helpers. Ignore updates when no cache
> exists and reject decoder-count mismatches.
>=20
> Use CXL_RESET for the PCI HDM cache. Shared HDM register helpers do not
> require it.
>=20
> Skip cache checks and updates for DVSEC-emulated decoders, which do not
> use HDM registers. Keep cached global control when MMIO reads return all
> ones.
>=20
> Non-PCI mock ports have no upstream PCI device, so the cache helpers
> ignore them. This avoids test wrappers and a circular dependency between
> cxl_core and cxl_mock.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D9

