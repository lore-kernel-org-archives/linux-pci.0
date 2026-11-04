Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761658;
	b=IJQ+Sz19dZFsXAhLcmMCK+2kGF5SWkCXnetQwM22cd1GXksnwOApZI9dNXVhCachaoAV
	 4I335EFm0m2BN/yTA2qlgTR1HGJIps89lkiSyDZVJmlx1noaOKvUavBJ8pFZmir3YIjja
	 Hz6g3vkVvl26sUT4gZ4n8YugazZ7fgWIqRdJ8HMo1y8VA84RMbWacplzsVDM9X91a13wk
	 2bX2z4TcB/QEEX6J3WtFS5IuInP7kSBJ4bJKLpjPKFECdoDlAqEbnV20qulQd27tIkE7o
	 G8BkUf3EJ1e26cQ0BkdC4xxG6hTlDnBSU81qThc83y/76WTCbZK4vGHWP4kXgVP4fmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761658;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+Jg+a/NXV9oiPACO29t/EVvawS0Cg1TTybc8COcV79w=;
	b=wzdCao04IPSFhs/pHaifioh0neNBE4UovBdNL1jdPqWc1yEfbMcHJtMpXoArH12jd2eF
	 yuGmBItmj8a7ChbhhSCprzi1b2qg90zbwzLHXTRbSz7PhkjF7SHsegPAI9azJJ7IZl8x5
	 HWZ5O8e1dQzhfjbE7n6gw1We+GCIk4y06Q2Gztgfve/QbrBEIiHlGaUL+zeuiM90XvK1E
	 Q0dsUqyBfbVDkgLO/gZeuxbC2q2p8nY3BC3W9jbaD13FbpuU8b9MfngFUiA6S+5JN/T00
	 UiLldQ7/KHUsDNmVFiqcwK7ayR9pdmxDTviYq5ka2cJDXMXXgAMc0RCCfXdp3hx2qNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrsBl+VH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE07606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mrsBl+VH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9471F000C1;
	Wed,  4 Nov 2026 03:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761657;
	bh=+Jg+a/NXV9oiPACO29t/EVvawS0Cg1TTybc8COcV79w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mrsBl+VHfiRhhGoLjhU0dsF9PnEnNzoePLVoLh6w0FEFeTVNLKzBWdqBrXewSobJu
	 vxzrAG89JBSrQDp9o8BvTXRUVoJYo8ZxAKwwraCGwwN3idjuIPvZicKZUumnydSum7
	 SkimYS4z43Zij6vNh0u0TyQckMXl67xaSuhd973KrhLYIFgFs7QoLTxsyt2XzWRwzS
	 T/H4BvvsTKajBBuKRyURwkrBjD1wIfAtPJpnbpu1dCBN6AC9MsXi48MqKOeM5QqzQq
	 AZp0JZd5aDMRDq2Fnjk9PkQ9fYNCv4AoM7c8O4o0Fw9shvYctcVQpQxNVrAbGQ638l
	 WppmcSmLbnQRA==
Message-ID: <sashiko-outbox-196584@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 22/25] dmaengine: sdxi: Encode copy and interrupt
 descriptors
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-22-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:07:37 +0000
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
> Add copy and interrupt descriptor layouts and encoders. Both encoders
> accept operation-specific parameter structs.
>=20
> Copy descriptors are used to implement memcpy offload for the DMA
> engine provider, and interrupt descriptors are used to signal the
> completion of preceding descriptors in the ring.
>=20
> Conditionally expose sdxi_encode_size32() for unit testing.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D22

