Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906215;
	b=xcrRanpKw+sSujuYdwRz8B2+TugnT1AdtWjVv6ePrdgp1C5hc2HRxDe1/vfILwQGaVer
	 FmKvKQA+kncliSBGnMs6+iFPV6RHuogPyS5GnmAGPv8Vd20WBUZIFXb3EQ9yNaXd80+uO
	 tSV2MTUXKeo+hpMKcuBaYU1Oopi4yq6UKuHugkkCK77bZbGE4EsfG4xdr5hZpoLt7Ps0A
	 n/euGg/fdSXX2csMxjFKN15KbVGkTk3LDvuzf4hqBrbHlW6+mIZ3xYT9W3bW+2XoyHQOy
	 rZp/mibJ15XLyf9CVdwuZGUG3FGeYVaYFkujEizUZD4DhuGarm2jVSYDeftENkXZ6mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906215;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sw/WpvDzh7LjgPVyXHNXIV/jDl0nr4fug6RfjDyNna4=;
	b=TD1zawipK1yjO58aeFG0+UVkdd0X22XvqIq1nijHp46ywT41XZHxyp4qbsBaEiQEP4gk
	 o9i9JEhYoG6U0GzKz0xzgqd2MyS09PWMR9KMySqn12h8qsp6A5FSKSCrTXw/hhokAjXGA
	 VJ5yzEdrlvezeMjIUoPPKEbU4USM0duXVAdrYNJORt7d9skCW9daF5b3xxb4ZvIMrZAuQ
	 O827D9zBYAPxO4qzE7u8ft2E534pn3n0W1RR9am8G97L5U8Xa00k9FIs03yazFSk2/uDF
	 E/feA8Ok4Govbt03oBFY8nZH7N7Y131tVYNKUbp/p47ID1OJNJoyWpVGZmVPDFhPClA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgOAgzyU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82E2606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgOAgzyU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B361F0093A;
	Thu,  5 Nov 2026 19:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906214;
	bh=sw/WpvDzh7LjgPVyXHNXIV/jDl0nr4fug6RfjDyNna4=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dgOAgzyU4tai0xcwSvJ2jZBTtK0omk0rbb6PzgJGnWFglrYttH6pQev+bSFAyLC6I
	 fy1pAxuiXn4V+sqvEs/R1Qts1W5ZMFALM+5gODLmOOEokO4L/bqvNmUV/jWmYNAO07
	 /QewzK0XdpoxSx0BZrOamkqE1emgzB8cMgFVsvZQ+nmHZyT/TqodeZc9+Xn2kwCa5D
	 QKfsp2JinuYZYCiWcwdD8ezhA4OUFFhwqVFmF7+NfXWRtEDY2psidDxJm43K8HbxxL
	 yv6C6UVRmZM7th4vYiW5JX2cukvWofwwD4hLIg7Xdo9DIabjZJD0HZW2arl4pGhJzR
	 v2uUyUTH68wpw==
Message-ID: <sashiko-outbox-199834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/19] cxl: Share HDM decoder register unpacking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-8-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-8-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:16:53 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Factor common HDM register parsing into cxl_hdm_unpack_decoder().
> Validate range and interleave parameters in locals before publishing the
> decoder configuration, including enable and lock flags. Reject nonzero
> ranges whose end overflows the address space while preserving the
> zero-size range representation.
>=20
> Read decoder base and size registers low then high through a shared
> helper used by enumeration and the reset snapshot.
>=20
> Read switch target lists and endpoint DPA skip in their respective
> branches of init_hdm_decoder().
>=20
> Preserve the decoder ID allocated by cxl_decoder_init() when publishing
> the parsed configuration.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D7

