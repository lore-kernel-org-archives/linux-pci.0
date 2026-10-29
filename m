Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286219;
	b=cuCSBb0vlh4DPNdMenBPlfVSIQcuNE0Kz9O+Ch3kaKNGFw+0eR8fZ4eeOhfCqq5Fa+zU
	 foWST81L8fuKXKtiY1YVgAUVHXCb65xVRH/GP+aOQEpExvI0OVne4FPSwVvFb9YNnfJT7
	 YgOXTC6qG4t6H54ILSi4lnOU3eTr01RgjhGM5nv9BQ6W8icv7q6mpR2yVS4g0VFkgME3V
	 BtFph5W9pjPYPmDexlCxtVyzzDfM7zKoMAiIawvtMfLDWCvKqANqMvr/TH/FjfnUdsAK6
	 iNdyP4xcYgXgp8W4o+DJti8MQc7EqffSmPwhZXEzVLgkjJhs9xHOBJN7C8x6KNWQg6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286219;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=btzRf6kzimNYYX6fx65Zr3MuDO8tahF5K5rPHMECYnA=;
	b=Oi/knOnRS3e3QApFBF3IjfjoxusmcI6ipexckP96gtU1FHsf59sJJ3EJavlQCDqv5mlm
	 YgCpyRb8mPNP6yDNQU32AAo7v90EBPbMaHuHglLddskOcBYUJwQXaX88/ffz/uAnKCU/m
	 aO3Jxp/yoyUat7WTC3CmW0GYJ3I/tZZAiGXiBAApW9yKR6KxpRUeOzA42TEeUCwk828+T
	 ukqTE2U0sSl5sdcsW+rKfD8hIu+b+lmUcTUv2ljy/OWrL2zRwperOXQQ72jcP/jct+BCr
	 gJK1GOKTmH8xwmaiAZ+dX5tIKs1BKPVWKJmIwbYQ08yI3Z0xy6KEY8pzH7yWwOOe9AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZICEnSKK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64394606A31C
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZICEnSKK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18C21F01828;
	Thu, 29 Oct 2026 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286219;
	bh=btzRf6kzimNYYX6fx65Zr3MuDO8tahF5K5rPHMECYnA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=ZICEnSKKnrXd6dvAPLYAeNznHLND/fE2c2LcJHhIO16hpifUBHArHiRprrdeDIZW4
	 c1VP9hfJCaNjGMtX/Kf2+bkUKdw/msQaPaF7FntOJfSUfgj8c/Zis/iVcw25YChmYw
	 t6LDxrrEvCeDIrm4XJFQ2/cjrPos3y0lOO2fqXEZzeDHqMMZx8yPsvKZeNiFrKJY/F
	 yPoXsjdN5kX0a4utZVYxgWxeqcjwIJ67lYCVNhkueIv3ixY5HeVYGJKglpO/gx963O
	 iAFZF7CkolsnoWL+ezw6fFzL0VPyrw0GU44ZIxeb9MjZ+wOQ6LxsNIedQg9qwdc6b1
	 JhJWDpwepRSNA==
Message-ID: <sashiko-outbox-189572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 04/18] cxl: Embed decoder configuration in a
 standalone structure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-5-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:03:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Define cxl_decoder_config independently and embed it in cxl_decoder. Upda=
te
> decoder field accesses without changing behavior, so reset snapshots can
> reuse the configuration type without struct_group_tagged().
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D4

