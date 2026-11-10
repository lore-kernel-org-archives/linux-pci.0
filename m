Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285176;
	b=rhSaiK0C1kvlRf1RRqiaEU6Htc1Kr6Lu8Kkxj22NTvhQfzcvOlsk1hDavLk7ofjFo3iU
	 uEra9PxGHdaRNEjhSp9HATLS2C368L+VHiA2DNNB05/XDSxCJekxL4e1PUWTHLCCsClpK
	 KoE0TL80A+69/dGMvG2jkuo870VgAf9vNnYKwOKZrK2pwwqEEEBhqmjlVf3e9KUAAjoU9
	 DW1e2dGnndc2T+LcOHu6BUVPRLA2VXTVqyNK0jelegQayWJccfpxsi0eDX2b+w8ZoHTEO
	 kkHeu+D62tNfnX3hkfvryfjMkr7v5ec+rEESTxs6tfHEtumz7Kp6r3OVsmT/P68M5LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285176;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MO+azDzaPSMthUOau624HVqEPwDEByH15hq31DNGo5A=;
	b=bPSheXi2yI1uqcakruyjnbxFWLAEJtCejnbHmxoFOjq75eitP/1jmQO9en561MmLdai/
	 v+OiPufzmsNDoCay+za9dzx3Pt3zJMFZCilZT2kwpgILcyz6O0CvZMqnz3HP3NDYdcMPq
	 ZNo73BUYJPL0sqoRje2Z2Hf663anOgW2aJKIHdKUol/JX5LOUqm+DhcoY1n4hoe3kRVtk
	 eCUcuI22lQh5ttaecDQ0yOAdCoYS2Cye1ubiHlvJ9PUQORCWQwpKaIlPRVj4UePR7Rc7Y
	 Gm7vnhRTwVEorE86mHX4QZwKGAa8j5vcYjSNdvr4IgoR/ZPl0xW6LPtObRQJgBJbdCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWcQsWzg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBA160A6F76
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NWcQsWzg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B711F00900;
	Tue, 10 Nov 2026 04:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285175;
	bh=MO+azDzaPSMthUOau624HVqEPwDEByH15hq31DNGo5A=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NWcQsWzgRmJiKuDiY5gOrIH5RCRT75pRcZUvDJq6vtTo+0k33e5vBQBOmwPZOg786
	 CgEEEUPqbfyWdeW4h5DiikBLaRSlmfpNqpQi+N/tup079doMv/n8XuZhPpMeMF2UWj
	 xumnObMD5axhRKXPm2q5KTw2Xi5WZytCJlnxZ0IZmc+weu8qfFmPz/iuTUFJZmnZqF
	 2agwzQkuY5sFqapiKunYvtQpnILNR9D6VdUd86SKI3rsECElrUkFEP5iiAHk/is23C
	 v9XpRFKfswH40pPID2z7Sx5tE/rJWTUOlJQiJYPEauRCuCrNDvACjGBn1JEnEoImBc
	 Ar4YqMYhu2UGw==
Message-ID: <sashiko-outbox-206211@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/25] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-10-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:32:55 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> This is the initial commit of the Rust SPDM library.
>=20
> Security Protocols and Data Model (SPDM) [1] is used for authentication,
> attestation and key exchange. SPDM is generally used over a range of
> transports, such as PCIe, MCTP/SMBus/I3C, ATA, SCSI, NVMe or TCP.
>=20
> From the kernels perspective SPDM is used to authenticate and attest devi=
ces.
>=20
> This initial commit setups the framework for SPDM support. This uses the
> `Validate` and `Untrusted` traits, which means we can treat the
> responses as `Untrusted` until we validate them.
>=20
> The next few patches add SPDM functionality, which allows us to perform
> basic authentication.
>=20
> 1: https://www.dmtf.org/standards/spdm
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D9

