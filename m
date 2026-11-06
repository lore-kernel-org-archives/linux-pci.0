Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965421;
	b=nnhMnap+3FHswjacMxn8K5AHC/v3QD+O08L2DcI3uMK27dLZEE/H707UD6er4cEpn5fa
	 bNMA13YLQp+/IYo0mC51PPJRFINtU+HQZ/Kc8UuxJnovxylGRTbRXacedk/IHnQn2RAcE
	 nConn/xZ7dHMrs0lGiEOs3gx6pDc08HQsJY3Apmt+Av8n0+N0MLLonkOwS+cOa1O0rT4y
	 ZoINqm90iZIWbtVMF63iv0+BUBOjAUe0XM3b+SgVgJOR53TcS47XmNqUpqp8WVbod4Sj4
	 ldRpCmwMMoePmNJyCWvxWLFjdlKpAx3tps6tomIHjrNK5Sm6TVixe+nPAFp6YK4PI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965421;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Ci9FyLyeu+ZkycMDIZ+zvKSCrF61HHUplnNWZr8aWU=;
	b=gNTrh/vxQ9MttWK7XyQscdme5Advfe5UIyvcjLTjLX8XFMrpVWiiWJw1rVyVnn65LCfh
	 HfVZVvEcVmEV8Jx7JYlt2Nf4xZIPBg8aCLdliVCiNKmubc6N8WFgMuvNXJ87RLtbEadyr
	 bOZJcxZaLv6PcTQub2nME91ASpm89Efkwi330XpcdR9IHarXxroqOdfzOJCeUB+K1/skP
	 hT/71yIuDt5+/ETeazHjn6Kem2ylBs+4MVv79LD6/reDXug7a73lwCo6f6eI9IEGLQiju
	 yGCC2SHKR5p1mg5/mTTi7dSBoMeH2QpfknpUdI90UITC0JHcBFu42VfWmG+dFdnzrNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Npdq9fYh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60A9606C7F1;
	Fri,  6 Nov 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Npdq9fYh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 922551F008BD;
	Fri,  6 Nov 2026 11:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965420;
	bh=8Ci9FyLyeu+ZkycMDIZ+zvKSCrF61HHUplnNWZr8aWU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Npdq9fYhfEuyUROKmbSAvmU1wfPFfAaZWhB+u5c5bwN4inNm2BEBDyt3KhF+BEBmx
	 GKyNjIuz03XSbik1z95uRHc5ifUp4oiKwznozoCMc2LUbn7bFzjdIeoOIpRlteT15Q
	 U/JMmg69JeCyilC8zn66faqxVWOHMQAjcK73djMIYbGy8LUox8aNbzRm9lHoiN3EA1
	 OJGNJ+zACqV97DC5/xvRmZ0UObsx189HvQjA6jxcgBwVlIBtWb0pBvLaL7di4mj/4m
	 gflsqapntoppJV9zakGNE5IWYx36JRGtjADGRrJwJOVxqiagh3qEABY3A93xGmdvuT
	 7UHn4U18xIYLg==
Message-ID: <sashiko-outbox-201337@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/17] wifi: mac80211_hwsim: lock device for manual
 driver binding
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-4-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-4-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:40 +0000
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
> The documented API contract for device_bind_driver() requires the device
> lock. mac80211_hwsim uses it for a newly created class device with no bus,
> so no automatic driver-core path can bind the device concurrently and the
> missing lock was safe.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D4

