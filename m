Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965419;
	b=er5koLf2KMFlhlflhLtaqd1c0ElfWVTxoEWF5SER/cInDa+KJk/xNLyLFZKEDi9V2dFd
	 WP1zapSkvD9Ai6YEeCaTs/4QCr/iqJ7ELHVlGBog9ja8L9+O+EdSUe6RKNIpHo/cIUXTU
	 edA5CvzIaHmO/WxUdRRVGTSrj0RSVlvgPgp6rbAjS78q5DpJAp1WLsncjc8Y76nUXBsLL
	 tKzZTAVqQl14wQ8qX1Ps3m4ZvkAKPT9M/3wcqQRifaZdZZPM1ya4l0ny76tyO7jKkj67R
	 moJ2j71SmUQpvOiqF7VQYL+ScezV9eFlz9rnqEw/2n+tTuu6uwhLpPCzMPmE2gyHYUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=//1nDRyZxF741ECN3aSZ1BzdF8W9osxEdbYtbD5J8IE=;
	b=AbDuOk3NOHao0Xb3B/qa+Qil43j8OExVAOXoCO5MUHXBmdKA4zpcJXM81NScBMAsmtiy
	 QQ7aJ7aGZANthN75XhL0Kz1F6/2DqSQqb+8/7kH3WItAf812Y59oA5K6KpI1DavocOv8u
	 IzRNDd0AZSNG4w7JgFBfIWI7XWBVzXqc04TFU0Ge8q24J8ZtJfulylp32geFskvNKVUh8
	 zDb2ghZy2cyZ5FnbWWAhU4GS0ZRuAgSq73oWVgp/A/1tJyZnJ27KIKkzZHfCrSvdQnPmq
	 66csfJJ30pZrL81CdJAr8yrk/rBHIfDLSWyWt7PfjXXxMxpGmdbYAeUfuHfbe912QPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=optI52EE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A540606C7C6;
	Fri,  6 Nov 2026 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=optI52EE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8102B1F00903;
	Fri,  6 Nov 2026 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965418;
	bh=//1nDRyZxF741ECN3aSZ1BzdF8W9osxEdbYtbD5J8IE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=optI52EE6SxdAum9GVP8R7eOKXfXFW6RlkrXDoVRxD2EsSMRSeduEBtZNITM0FMCt
	 doClio9D5ejWG/WgSFwk/KiHNFn8FJHjhXI9RF3gr2lYo7XCGgVM3J6yZE2Iz4lX+b
	 ZVIZULpu9IVPr9JPdC0iOwsKb7D1ot5VmyB3um47ppv1OIV5gtPtql1uE2oxnZ6+86
	 LrwNgbMh8qdA4T2djVXV4nGK0tXF2Flv1ge7hU5DQZbQRDB9s8f6J6cdPM+GZQfw2Z
	 GceSgfDFQpxTAb+UAI1Keypw0ZH3sfyOdbu83YrMi9UtEdPQQJMAVWzZLWjYFuUvty
	 gDAEARB836wUQ==
Message-ID: <sashiko-outbox-201334@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/17] Input: gameport - attach manual drivers through
 the driver core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-1-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-1-1e536825b4eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 11:43:38 +0000
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
> Manual gameport binding calls connect before publishing the binding, so
> driver-core admission cannot reject a device before functional setup.
>=20
> Use device_driver_attach() to run the existing bus probe and removal
> callbacks under the device lock. This gives manual attachment the same
> admission, setup and failure cleanup as automatic probing.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D1

