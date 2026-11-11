Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794441309;
	b=PRR3sTLBjr4wnRsexMvh1J3hBF9PUVXo3XriPZ+5c0giYSTIIRipxaUw//HZUUMtBpsV
	 TXhw7sjq1GLe80nEUwQDrw23L70ngpxlNfWCLEUpjcg5J43/k8jVhudTIGY+BfLtW8OMH
	 f5oXnAoQuPO32sXbTCBEdt9kn2GdcyliCbw2a2ksbD04a/AXA1ivSGt7mHqdJ9c2CfJDH
	 thHr1CMf4rkknoaXKPNrqLVdkU91j+igXnd7BJ0D18Gsp83kdYvLITz7kXLc8VpaF1RcD
	 3H8ZXmMsXxliuDPEmry7cGAJ8OjSrwfz5T9k43PybTsRAQh+Fjfo4TJTO2Y8FsnAunQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794441309;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5EBamSmKx1vpp7qjo9Fb29HeX8CMmIpaWHQ/PNiWiMA=;
	b=zt86zCq4vuekVfERRbXMbzn2URgck5wX1ohi34Wy4Kzdt/aCGgHIrpLx6BannxbpD6tx
	 s5eprzWbNa1vefj06mNiUOMgP/BfN1Wjdocn9v7KB1ZVXogvgTQ09FbDT50P5GEvZyyPu
	 VTlHw+/0YyaDC+mhvjvveycv3kF/ln/o0MXzI6p5G/JPcGT7daOx//Z8Z8MXidRpj8mI8
	 5Olv1Hz1wqwO6B8oA8s2Mx0nBkTkdm3RATU7TkV4wsgW7UqOiMYl9SKV0hWx9ZGY1Kels
	 fgny5adDyeauiBcPOaiXq2HAXYaTvsYLkBm8w4t4CUzBVe8Agpo1kBmGCPhy0dTSzTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKWJunk2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BB2606A326
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKWJunk2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ED71F00A06;
	Wed, 11 Nov 2026 23:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794441309;
	bh=5EBamSmKx1vpp7qjo9Fb29HeX8CMmIpaWHQ/PNiWiMA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EKWJunk2yVfFFvwhx9Z4XKRv7Od6e/Uy+J48hykNhnwFPZYr0bj2PkoQixOPFVGz0
	 A7mGn7+/2QPJkH6eAYXsmP7vYb2/k2aO0jecoPIgtHCkC4BReTJ7TCCi42mBKkb9WK
	 7aFGDj/THQ4DPOX41+pYafVPZKwZdFfWzEtGiqrppwLmRGiAC0ORBwDoWhTgq4vudD
	 CKaMZEbwnhOS+cw+n6dzvsT3V0Hy5SveWx3G41SojFA+IwIlThP8Z3d3/4gtwgOjcL
	 9/8B8czQO3oMWTbcxGuzy1qVjPyRVaShZRd9ODxHDs3yzIYT49tLARxCmBc5y/eo7Z
	 OnutCH71UY5Iw==
Message-ID: <sashiko-outbox-209869@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/11] rust: pci: add SriovEnable::enable_all(), to
 enable all requested VFs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Simon Song" <xinmengs@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261111223337.508989-10-xinmengs@nvidia.com>
References: <20261111223337.508989-1-xinmengs@nvidia.com>
 <20261111223337.508989-10-xinmengs@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 23:55:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PF drivers typically enable all VFs that userspace requests through
> sriov_numvfs. With the SriovEnable token this takes two steps:
> enable() consumes the token, so the requested count has to be read
> from it first:
>=20
> 	let num_vfs =3D token.num_vfs();
> 	token.enable(num_vfs)
>=20
> Add enable_all() for this common case. It passes the requested number
> of VFs to enable(), so callers do not need to handle the count.
>=20
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Simon Song <xinmengs@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111223337.5089=
89-1-xinmengs@nvidia.com?part=3D9

