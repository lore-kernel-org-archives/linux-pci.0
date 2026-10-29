Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793286468;
	b=5LIN8Ez2jCnfSoQmuKrPnTXA9Prps1A1I9jc9QtXrtiyj1z05/v/emidJGFN85vXclpO
	 zs917oWOpJA/6PISgadCTTdJZUhrFnwk8YmPm5wmkE7/Ki9nLEakhJuqHw+xkBdnW3u99
	 ZS0w6a2n900y3/xDV5csqdbEgLnVZTF9dIRP2sLycx1FcTP3HBAymTgxxpzUHVFTtO05u
	 EjK2uN8PIY0TQAN1/uAeGIjHJiWkCQ8mwhyBfw/G9L0/STybs4ncZ1EzXutYm6nB3ohz1
	 0WjEiGoPR/StYY4hpA0oGOlk24Bk00TyHi2LoXZtEaG/D9xnniKr5R8tph//S1SRGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793286468;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UPamQS1TR2DrmaHvcJJNwW2dB0gX1ZlBLvpwrrh/m6U=;
	b=qKe7oWoBWM//ZgY/IlWKuPm6mVb+l4+d4i+bv4xM3uMfO+KCLWYZiiOoYRXKDpHgRemG
	 02ILySD33pYe/FMMlWaEeBTEXu9JQnSIpA2MdEZlZGFh6cX+25krB06TvDINIG/tdLFAy
	 zzUqyGpKVAfAWLyotFM9b98wMY0e0CqHnvk6vqXckMYOR8wI6QIkT83Qjl51fL9tlgJWa
	 8Orb5F+hg/Qx21In7WtMHCEKcVrHOnkRzqzxTBaOCMQNlhRNBZPr/F7bFBXq3qLuXh/oB
	 5lxDVgIdULiJODDlVgjcqjlgfVTCeyuoKGBK7FPQjGFfNLGbCIajPwdrTevFP6PN8jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDm2oero;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A18606A31A
	for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DDm2oero
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCFA1F01825;
	Thu, 29 Oct 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793286468;
	bh=UPamQS1TR2DrmaHvcJJNwW2dB0gX1ZlBLvpwrrh/m6U=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DDm2oeroTxIWb+taW7d5zo4Q+xRMKbsiqcQIhG0pmzKWv4xq3db2a4BLvMxJ31KvO
	 dHuKL6LF+NwAWPGYCvWfJE91C8OPiS+cAK67mSVoTS9m6S9i3OiEiNkCMMPgFqswi6
	 I9DxmElOxuE9ObkobU26pVY4C1qH+vJ+q1sn7H96DX7BzNSUIAYuj9qiDXTCoXVTT9
	 ZGgoR1QhByvHeb4lEClxj80zWPpzyTJ/h+zZMw7KRtwzfef93sekk6pBNjkV1+1LHH
	 XAb+YEplExo1l+9ngKNjCCuf+ygUVXNllb983cIcepZXDmLTqjT0x5OZRZL7SFxhxc
	 aQP4QyXT7cwfw==
Message-ID: <sashiko-outbox-189579@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v16 10/18] cxl: Build register block helpers into the
 kernel
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261029145703.2185231-11-smadhavan@nvidia.com>
References: <20261029145703.2185231-1-smadhavan@nvidia.com>
 <20261029145703.2185231-11-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 15:07:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Build register discovery with the built-in HDM helpers so PCI enumeration
> can use it even when cxl_core is modular. Export the interfaces used by
> cxl_core and preserve the BAR and offset in the register map.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029145703.2185=
231-1-smadhavan@nvidia.com?part=3D10

