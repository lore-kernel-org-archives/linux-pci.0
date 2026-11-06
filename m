Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965427;
	b=rzXfvaGd1UXxMUuSE8Ngr4g99o+Jc5DKDSBYLgUWiZqd0hctPBnLJiEj/q+8VXbfyxyO
	 gx7cxZKC5iZrKX5uEL7OI9ynbhLN3UeETeHRNb+NkH18Wt4LrX5DLEvqgY0v9+7mk9llj
	 BVKfA/JfiwrZ7OhFRQ0xfUHndasf9vU3CG8ljhuTuQIGlGD919fOLrqGq5ziJy3O43+Dj
	 vanslOjbrc5GZQ0Cu68TzmbKi6upHSj8hCDcTMQS6+Viae81Sd89fDHPvcIKW8O+n9M0k
	 9MqnCvy9OjY03nahKlJbxxHxnM2G7WxkzaOmhNcTCOXJhyofDNYh3YHQrq1cTnjC1mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965427;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IZJUBlohRv0eTa18plnGKmBUNgtOY9bwrng7AESz998=;
	b=dLersDVUyIfwX1wHc8DiJCs+dn+IUsGThtVzvug+h+iPPZGaC/9tvQG3Cn/AOmr1ARbs
	 O2qwi7NGlqKPB0LIGAPmqfdZqVJGDQumU8SyM8iyOVzY2uMcPOexJTNCtOGqxExhUBCsD
	 Tznncm2NilvZzZLkkkwydNklPjNk5WNeQ6nEn1BR6mU8A55UaLxj/x4ELXKGNJwfcHIm8
	 8iRVDk7zdNjVGdpk/I7H9Lju/ebQhvPohfWaYht4JNEG51NpJiY2Fczk4fguZF4vKu0kK
	 bWwfm4YUmtvxO7sM550zyLehkt2lNiTyN6CfMJ/1bqmue6ui+MQjdTxbkLtE1zbbiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSx07llC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D526083606;
	Fri,  6 Nov 2026 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OSx07llC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E771F008A6;
	Fri,  6 Nov 2026 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965427;
	bh=IZJUBlohRv0eTa18plnGKmBUNgtOY9bwrng7AESz998=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OSx07llCn32IaIy142FLEZAiwFGA9NQKWbfV5Gjf6/0ELx9/XLuShtKDTqdvmBTaT
	 MYqHWdRtrY+/Pv5X0qdBBSe2uVgWp+zfWNm5c4TxSLplqpxdvbdmZRf823WzUugraL
	 d7R1iDaEuhQgafkRlq94UReY8bM18GA/02Ztk8q9tsxZfa/UCIbDNG9U3joEB59U/t
	 fwWHB7HbvloQXRSNSLrtkwgDOU5G7wI7kZXOMFNGx/E70jd/nq9WI/LOTOsFa0hLuv
	 fnDfI/OU7hGDLt4a+Q4011YC5/X3t53OFEGu+0pp1aaJv5Rrx/QxkEdC+ze77TsRAM
	 4pTcc2xx/y4sw==
Message-ID: <sashiko-outbox-201346@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 13/17] driver core: Preserve trust commitment beyond
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-13-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-13-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:46 +0000
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
> IOMMU state can outlive a functional driver, including after failed setup
> and unbind. The active trust level becomes disabled in those states, so
> it cannot describe the authorization governing persistent translation
> state. Infrastructure needs the immutable commitment to avoid treating
> an unbound, previously authorized device as newly untrusted.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D13

