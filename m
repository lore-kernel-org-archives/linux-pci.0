Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157573;
	b=eqYSLW2+OJUMttCDhSIVGUrMcaFa7aJNCOfMVGDZLN13Bi2xNLI4OhmfnrjmyYbD1Scy
	 BObyejt7mt5WOTW2tXYd3HLkVcuAfVLp7M2ZXE9tt7X61IpE6mWsoJBI+b4VECfB1ywkn
	 giVKTJVqjvuvKYe0Nzpmp7/Ham+OCpZjakmtuxoFfAaV/EWAXPHeclTWDeYMFn++mFEbm
	 fPlqQtl+BVtzROgdxCmM9HQoCtHybSYoyNLqTtM0gyQtwIXZSryX/dbNwOxGdk20pTVpU
	 TvJ+cdKi1hRJGmkDhDqG//BJSTB1t2jfHXVyoVZhtJKzbDMKbvRL0GCPL9iKLK//8ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=y/1l3tyv0dX/suZCe5Jdbgr9pRVU8jOSz2x6fY45qfo=;
	b=KwKhbn9QUIJxda3yAYsCVKlP1snGVZDlbfX1/EQkp6c+/y/6oEBQWQdw/PtED5Lwx/cg
	 55kZkQ6TsYBXB4iQTV06JLibsHLhDZ/7VTcsh1RxTqBSFEWDTybw4dG0+YKHYjPKn6QJm
	 P+VyLBkfSWwME0gFEivyicToO3vnim6f1IuBnnRSOhH2uwgEXsZmHUNWUfJSmiCA/lVOZ
	 OkhBp5zq8gMp0ovDYh9RQxbVi1Ne5VXRML78cDN6rtB/QF5IkgYzHhXiT9IVovCdzGZl1
	 GgpGvMTlWsCtFaOFO7XsFDYU0ZOGWmcmlQjkjarzI7nOEC9iPCu2UfnAq/zCnxzNlTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RxMxz+7/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC3C606A31A
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxMxz+7/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5DA31F01825;
	Wed, 28 Oct 2026 03:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157573;
	bh=y/1l3tyv0dX/suZCe5Jdbgr9pRVU8jOSz2x6fY45qfo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RxMxz+7/Ipp5dB0rDLCajQchpHKNiBhZY6XzjQvB5ed9Vs5meE4smwljYe19A1c+V
	 mfQjlMzbZXD84BnPlvS1bNSyiACtBC9/uY9mwrYxWqAbqHuOzN7REY3TWg4dodwsdL
	 rf3Dd2O4Tg9pZnZ6HOEllyQzoq3TLlaORBkj+/xVIfRCCvEQvJA/IeTwrKXsoydZiv
	 yDhlRXc4x+6/z4n60oYFYqBlDFLteJs80/U+YFFOf7OedSpNByptlBnTS/Q5it0Co+
	 nj0Dt81Lnv7rV3hbi1pK2dboOOD2mQ6Xzd+rICh7ARit8IUgNg4V9CeuUJ+wmRc+29
	 WLDsCcCC0hLjA==
Message-ID: <sashiko-outbox-187415@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 16/16] PCI: dwc: ultrarisc: Use cached PCIe
 capability offset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hans Zhang" <18255117159@163.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028030652.2917756-17-18255117159@163.com>
References: <20261028030652.2917756-1-18255117159@163.com>
 <20261028030652.2917756-17-18255117159@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 03:19:32 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> ultrarisc_pcie_host_init() runs from the .init callback with the
> controller already enabled. Replace the capability search with
> dw_pcie_get_pcie_cap(). Since the lookup is performed lazily at the
> point of use, the driver no longer depends on any earlier caching step
> and the offset is always valid here.
>=20
> Signed-off-by: Hans Zhang <18255117159@163.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028030652.2917=
756-1-18255117159@163.com?part=3D16

