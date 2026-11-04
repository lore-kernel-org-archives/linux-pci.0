Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760853;
	b=M2sjaJDDaBHDpZS+V1koaXRuXp+FApGY4i1janF07aeZw8al8ESt6ZZ6Vdptrccq06FF
	 wRxrP7ZB1gE2Yc4xW19JdzzrymrKCzlRcyifJKET9xUGParUjazasznqWzWslg/oYbOZE
	 v//o4QLAORCjnutDjZNnGqyKwcMPWI6FpcWCyMGOnOlISheurUm+z83h+1zoUaHjB+PxD
	 lxnV2YHii2ZwM6XxI+t3kE/nAey/cmFn0BIXQQehd/t/hVYzBDLRddoZdJsDbYndQ1PXU
	 0UKP96/5iulWhTHRKYNXSADU6wAfUFFjlkp2DeNrbgzbPeRtX3W+qAZwoPi1LCoUHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760853;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1n1ArURROX4dXSy3vjbkpXwa90MBTPyzB9T7XvvCOTI=;
	b=mpjgWIF5AoZVd6DnF3IV7L/U7PkV7hX8ad6xIYM0htvKjbukJfAFGherf/UkfELQZkOU
	 B9kDh4WXY4JGxaVBtcMLXA0kQ2v21gjJZAk7Jdl2rSnG+3wtYcdq5SMcG946qumGd6cKf
	 Pu7cTbNQ+OYFrdw9Lqqlm+uM3NDi5MFrQuPQRVIf7LtgubDvbkOxG4Ec4SOTC4wytvTM+
	 +iRLH+PA9gafXfpzLAFbbMHMcSmiN375cCQP0r1j92x2DzH67p+4/5JuJben3l0baS1/N
	 KlkxeMKzcq7YAwWzYYMWSj6Oo+nemHKusBxDOPEVYyNum/3Ecjdud8Pw7a6EHbwoFlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RIpDbRi/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71110606A32D
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RIpDbRi/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F04E1F000C1;
	Wed,  4 Nov 2026 02:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793760852;
	bh=1n1ArURROX4dXSy3vjbkpXwa90MBTPyzB9T7XvvCOTI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RIpDbRi/3huvgOZsCysC9ry2EQgoEo9PLKNe25+foCiVqeeueEfdSn0A2p7aBVhDZ
	 KrGVy9JdPeV7cz4ncUVNLvqm+nbAXuFW8tFtF5j8l6x3y00IBexc8V/yZSAJWjNfoi
	 WrHXC0Hgx5nWtiQawQ8phu464ddhyhEscBKzI3Wi5plFUBIcnAf3PkqSIc//IM6oH0
	 Qk0rU6Zpz9Izq2cdGSR/UpkUUZBb7NfEK5wmQMHAZW9wJnEV1zOuBqH213F15spOm+
	 ZA//+OhfJfEXU/C36lK8Zepj+y+yJEX1b1CX6h9D9qMaz4psIXIh5V8T18xLgktSUp
	 EmVB7sCpJg/5g==
Message-ID: <sashiko-outbox-196543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/25] dmaengine: sdxi: Allocate context control DMA
 pool
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-7-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-7-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:54:12 +0000
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
> Each SDXI context has a control block (CXT_CTL) that identifies its
> descriptor ring, context status block, and write index.
>=20
> Define the CXT_CTL layout and create a DMA pool for them during
> function initialization.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D7

