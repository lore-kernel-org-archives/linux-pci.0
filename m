Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793703420;
	b=O82kA4U556vM0InfliPI9rTNFXM1JlWs5XPcN9Nn/ytOsZtHlPsipYTS3cQUIG/7lb0F
	 m21IpHbUAGWIM5V143F49tqXIlmWwHOVmbeLFJvgjM9dSPzKc52r499nvIpEFbyPyB1VN
	 xSHojuW26iNFJZMTqdBQQwgSL4z7c/yJoOKTklLvibnViyOJ5oWk8BU8jg13TbkMW1jqc
	 TAO7J/1F9l4zoczAVBTTZ2+3UUxa/LiSlFoqSr0Ba/d6bagNwi8IGmxQD/xXoXCv92Tbz
	 KILoI+/LgJIOzXbZfptmJYFbuYzuA4k5YPgIIB5fDdPRsZMmvS3ABhg7Jyxt34p2Ybw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793703420;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=T91WXvqO80bHM1PPk3yYe0S2ZHUwHOlHaYVZwVefpjE=;
	b=IBZw1XB20ozZHwsienp3FTi+9GVBO+bEGB0gw+w+zPdNqtXB/2HKhWxawN00gnGZp8fT
	 13X7cr37WiU7b6MhCmcRKwv54BfYbXjc2KszQ+d+KUis43b/z09PaX80KrCFPWyrY2aqC
	 K6bTvE8p8gLbH7QKvpUwUKF24zCK50XqyGYRDuxzqfe8lP2oDnAhMdn+LTV3LLxQRjQHq
	 qFXJBnHkMXJzmSlfXN+JScgniwB/ouWqUr47Klx77G1+Fp9Ep2Ia899LlC7ILDxWXBWki
	 XLnCvQnuiIjWhSE+8XpfmTFhPMB5pTbiq6ejeglv4udpxM+usF84zLv5dYNiYBojipQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJgqG6CM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA6D606BF97
	for <linux-pci@vger.kernel.org>; Tue,  3 Nov 2026 10:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJgqG6CM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422651F00A21;
	Tue,  3 Nov 2026 10:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793703419;
	bh=T91WXvqO80bHM1PPk3yYe0S2ZHUwHOlHaYVZwVefpjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iJgqG6CMKaLioi12vHuVKJfozbEeMKTcruYBZOymYcb6djx1F/v70u4clNlYq2X8m
	 O8eZ32L5LUKlznO1qzKnR11AXSVxc0kswCmjVmbTpM/9NsxVgMkpkdJzFtXD1tHXoU
	 NzvGkYDp+KRWhEoNJy+EDih2MA+gjAK7yc4GZz723sufs5K7YjoE7AQB2wYuW9mI70
	 wBiXM0JW6aMaFIRiYmqIGkj3lPOPYJg7XzKbmF+w44c2I6itXcc9fcBbRkiq7Jenpz
	 NTChBDoP/L42LE1ckP7nynNiMXKfeh4BuBurO5hWd9YjcQNu6EII5TgKaaAQWgaxlc
	 z2MSh8OQ6G2dA==
Message-ID: <sashiko-outbox-195087@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI/IOV: drop PF reference if max VF bus computation
 fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wentao Liang" <vulab@iscas.ac.cn>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103104239.1373721-1-vulab@iscas.ac.cn>
References: <20261103104239.1373721-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 10:56:58 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> sriov_init() takes a reference on the PF found on the bus and stores it
> in iov->dev.  The reference is normally released by sriov_release()
> through sriov_disable().  But if compute_max_vf_buses() fails, the
> error path clears dev->sriov and frees the iov without dropping that
> reference, so the PF device refcount is leaked once per failed SR-IOV
> initialisation.
>=20
> Release the PF reference on that path before freeing the iov.
>=20
> Fixes: ea9a8854161d ("PCI: Set SR-IOV NumVFs to zero after enumeration")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103104239.1373=
721-1-vulab@iscas.ac.cn?part=3D1

