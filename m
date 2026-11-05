Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895810;
	b=fnnfTpUQBMd/mahmD8so55AElkIMHkhyXXouK18oEl0Udtyb2ifqwdq0iTQG3g+IbWgd
	 ys5grm2IGOrSj2vU7MMd7+EphYZEn2X1xC3IQouW2kXkRTv0YbboHFbTMtm7m6GUSboi8
	 J1atrTIVnFZQj7XHXwWyHwQhfjIeVCEp/rLDg1OjkAk8Yowcdy+elEdCQNZo96+tLcNoa
	 /vBkNlpr86XHozODTOBGNT+4+Vl3UbraHgJy4WZcppWGobZhBFFx+c0PPJaTavd1rV9Bn
	 J4G6w6aYPB5+A405vbDTVk5QpMcui73BjrzChaZ9J9nJNp8GRyzCbuks3fo1yvWQQ3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895810;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+mCofnFaABBBFgEAqlDR8YdjrWFoYjnfcRVz5Rl/wCM=;
	b=kfIE9YIPA/t1LvsVTIKSon96E5AsociTLIWwrJK/bleBzLnz1HejEfDKyw9e8u9ukDjq
	 jFEDM0DnSFZFeawLqcGvUFmmV2l0rqSgnzWfWCts6Pe6igeFym7bD0R5JpBJoaTsqkQNr
	 Jei1lrqAXsd5vmro2+jhDjurHU/z4ExOJ5Yu6Zio7j8pNitmcdcszA2MiCwWTMQ4E8uc5
	 JynxZ4qOXHUg+Auf6+1htdSrpVYJthd87FsOzZ44ck6dZ3dth9pVG0gtIxTZcAPabPuNz
	 tihiWR0sTkoGmryqv6+GL0s7IKNLZeTGxoOaIbEEtIX2EvB83j5obPkwr1ytqY4Ezzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYSYXTOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D771606A31B
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JYSYXTOq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772111F00A16;
	Thu,  5 Nov 2026 16:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895809;
	bh=+mCofnFaABBBFgEAqlDR8YdjrWFoYjnfcRVz5Rl/wCM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JYSYXTOqgN51eGzh+roF17Sqkx8xrh0ys9xLNWaNiC74TNtR0grJf02OF6YBH13Kg
	 Er/h5/3MSnM2j4frnsvv4cJNSnHmwt8TRTqSis0nNGeB/Lov7wlslIIkSUNeLUyRAf
	 XOQd32nLiosHEy+NV0Ba2CpbPQlw94AOOw3IhtFsPFeYLb6QN5PNjrW5blEeinhlpw
	 +FnOWYFMNqhW4s+iLqXh7HsT4tr29/XuhnxcTRT1rtsKGm8YyseIRvcDZVpq6auhaU
	 wCncxMT6+2upL4dnaQDdaLaFvPy5Ohbyge0nHLzOMpw+jaggdKXBPBcdTulrg/dF+G
	 f8P9Jq+GSwXjw==
Message-ID: <sashiko-outbox-199476@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 09/10] PCI: of: Remove fwnode_dev_initialized() call
 for a PCI root bridge node
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-10-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-10-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:23:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During the instantiation of devices described by a device-tree overlay
> applied on a PCI device, devlink displays the following kind of debug
> messages instead of creating the expected links:
>    'Not linking xxxx - might never become dev'
>=20
> Without those expected links, the device removal order cannot be
> correct.
>=20
> Those debug traces are printed by fw_devlink_create_devlink(). In our
> use case, they are all printed because the supplier of the link has at
> least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
> set.
>=20
> The culprit ancestor is the PCI root bridge.
>=20
> [ ... ]
> are correctly created.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D9

