Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761555;
	b=EM51AhX3uvYjyeeFqQ71o+TwtyqpktOMd0Agq/LWH43Dsy3A0uJubKljlbdRLxQPqHGf
	 ZeOjTCkMBFsFcKdbPP8uj7ueYKQ5c3oDDUAaKbCsA/HHA1/5aeuSKuqfuCFg2E9zKD6PI
	 dppjqnM6KUiYknJ2OkLT4a9VqkdbbaHy6aL3i0LoGfkKeromg6UNz08Ikf7Gm3G9+lXrk
	 UbPiwQfR0yqN1teLJ1UIqTQEZMD/Yc24J6fKpjY34qCoyR4gbJb/aznlEKtehkNVwWNMD
	 WON3DktikgIjmPVdETSMdj61ncuDC3rh0R+ACfMt0e39k7dxB2fgW7JGmzmg1Wvwd2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761555;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=f5ra9FOT3k+2AxochmueF1lPo26JNTrHTkFPJ2nWeyc=;
	b=zf5J37PUblbHbS8aAYmSFQmjsatmM6scHxQPsKLh6PAb3v5dJevmR1RBbxKtGX+ZqEDl
	 dFGwpus+bKLsmdgSUBgfD75ZfsrD2gY7eL9Y++MhpSsq1U9u7oHQJhDXyyM6XpUfA0Skq
	 mnGxSzI/ceVbxYv7hNfpL3TTa0s986ArdrggJNyFfI1pp55OA0I5+aAG/7n0R9ALd/Qma
	 fcb0fvmqhAOyXDrefkX2SHTFzJkWckYohi6dTq/WFUCi7XPoQTYdDlDHYD9v9vz/rCJsi
	 etXR90XVlaGq6c2N5Q72j50FyoD08QnP0m4Dht/WIKel4xsYLkIvxNf+10ylnywkbdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp+Qfb7b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5A606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yp+Qfb7b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 905B61F000C1;
	Wed,  4 Nov 2026 03:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761554;
	bh=f5ra9FOT3k+2AxochmueF1lPo26JNTrHTkFPJ2nWeyc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yp+Qfb7b6G/JMI4uY4XBwDdgcgzPD5fBwBiL17VXE5PMG4vfGRs6x9JNpWLQeqOgI
	 Ky/kAY983a/kLA34iKKhEYu7EGNE11tbUtIPkgAq0IieUjon592Q/MZkpzdKZY2Jwg
	 hQBqDRPrmBll5HlEGW7w7Pm1GzE43WiE/0T8EzyDURLSU4bqgKYVXC+vp9BAvd+Kki
	 eGF92/E6koUXKxwnRR/IIgXpE8HDZy77AWXgVLDKg21r4FFicfv2mIkEVjI91/wt53
	 A3+ENCqmzlvqLFJNuLJOxwWWo6NzeDaqP+2mH55ly3ShykAQQtq2e51QpBPuHci5Dz
	 Voi6CUBGANWXw==
Message-ID: <sashiko-outbox-196580@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 23/25] dmaengine: sdxi: Add unit tests for descriptor
 encoding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-23-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-23-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:05:54 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Test the encoder function for each descriptor type the driver encodes.
>=20
> Decode descriptors with the packing API using independently specified
> bit offsets, so errors in the production bitfield masks can be detected.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D23

