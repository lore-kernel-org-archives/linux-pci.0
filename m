Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965424;
	b=qNJk+B0bCQZXJUQ7meZqUe6BPoFN5pULJZhxuO2B4J+A5mc3uxRZN17nAAMYFSGsisAo
	 FU8teB5S7IPklqtdT9nKh1bgp1FknEZDmVE3yEJy2mgGfDr40CXceS5VYz9TuCEaM5VK0
	 HdnLDN/Pxp/jlHGDP+pbIkAamB3rN5yE9w4DhsnR5CH8kwnsHwojUwg7yLti1TMxRw7N8
	 ZlVTAm+9GzVIT+szX4vgxLF8TUEX+H1XFpTyEiTgu9YUO8yEfHdAHg8Esa1j0SbKBD3fT
	 p2mZCUzPLuabpKijPQ6Tg3HAnJODP8WcX3MB5V9zGL6YMGmi9kUvDBCLwNxK/jh6HPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965424;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a85oHYpYmovUstxa4GWsk7CEcnTXgEc15MdsIscNNXU=;
	b=AYLrtg2Wp/Id3H7rbfBEM4BEcQ/ZKw55d9MK5Vp2BnpiuHWCoiWQZYaZZ0hiZ4VEX+zx
	 ng3tJYdbyJk6I5lAycR5uEQHvbcw5irYCp3t0rhK6JuOy7F0tqhAvVx52QcAGxpZ/7a2R
	 f/FGjysfQ4mE9Rdsx6JXG4rJyAXCCP+0B4GAeSIR0cBSCECwNaEbwEkaLyF5dKl86y1aF
	 MRfMcErw8StQDJTX4/NbK6z7Lj+DGK5C56kF6s1HSvXm4Iw+1hYta+7p90cs0vDoeKN0e
	 kfEzBN1LgeFN6kx5g5uTT4kzKjxJ6e4b2QYAAuA4eGqLexc/bV8WkB9nA3Q202Nv3lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl3oiDjR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B6606D823;
	Fri,  6 Nov 2026 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dl3oiDjR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA8E1F0089F;
	Fri,  6 Nov 2026 11:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965424;
	bh=a85oHYpYmovUstxa4GWsk7CEcnTXgEc15MdsIscNNXU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dl3oiDjRCOpLSoqRsKz4CxABgW4u5LrKTptWOmvAUCVccAV2lEiqB91EhNx5sVGZ2
	 N+cL+ifmioAzipw3R1SV+rkJd6fTQ0iUT6HJ185RMZort02OzXd7hTSGdUl6M7LqYn
	 chwJk1/xQNq3igV+8VgRnnJSk4arSp3ZRttmyX2H0Ohwuug5Cv8ZgAm0FT7pwYm9Ws
	 8y7ytBa6X+bSFRU5mGWnFwn+pWhd1++O2sD57kaXFfSI09WtAHwY/8uiC6O4Q9jQ1+
	 h6819Ghg6LUxW3Ha3ZoimXHMSQcUTxgb1mLa15Ct0DQSZXv5yKOCE8snRiP2Dp3e0I
	 QvejwTcI6D7aQ==
Message-ID: <sashiko-outbox-201342@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/17] driver core: Introduce a generic device trust
 level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-9-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-9-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:43 +0000
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
> For a long time now there has been a PCI concept of 'untrusted' that
> is set for things like Thunderbolt devices. The way the kernel uses
> 'untrusted' means the device should be assumed 'adversarial' (credit
> to DJW for the name), that it could attack the kernel through its
> operations.
>=20
> This makes sense in a Thunderbolt context where you could just plug in
> some PCIe device and get up to trouble. Currently the kernel responds
> to this by forcing the iommu to strict mode, but we can also imagine
> further defenses.
>=20
> Take this general idea and promote it to a first class citizen in the
> driver core so all busses can use it consistently, including the uAPI
> [ ... ]
>=20
> Keep the active level in struct device, so lockless readers do not
> depend on the lifetime of device_private.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D9

