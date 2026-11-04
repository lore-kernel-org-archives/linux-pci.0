Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793809297;
	b=2gjQKfKhfynXWpLJUC5siDVYm8Ha7VHAwoYxiCxyec4x1d7VK0BfWZI/JtC4GkHJqG79
	 QYMVTLBcq4toaYptQFEOIRgH1AWOS9zp/HngZx0YvVwkOjNhniRhhOPk2c9IKiG+WsVFz
	 5OdPxNfnsk5rB6zqVjkTG41Bv/tsikDeyuQVOxJZTPTUf8lfVcti5CNo67SQwhWncOKXv
	 DaXxkAuLD9ejrGTSMNVpOxxGCWvrN9l/k24rJBBKyO0aenG/9YGHACQx5+kQfO/edA/vM
	 zBhPFjrqBK7FBP35WiIypGl19isZH4sUR5iwqx4UWjbm00jyamEKTQEuAqngRA+Ww9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809297;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w1msfwnt1fSEx/EJwr2JvnwqBQYjOBhFcXFgJNqfBNI=;
	b=dOdnuiIfTLTOGbJr7t58lXClp/ktdBqvLcWH3bGL2p9c6vjmRkjkEuV1hzGclZOf40hW
	 DiDPeL2XI3MRCCbFrxuQ2R4nclLU0S142+BzP62IOszJ+lhgVgB5gtZ4Cvr/XaWwtSvo9
	 UQH4TwR4KjO6nEM/AT1G1njXHnRFrrBKody1DXR/hIzCFyeYVPHuyn6sGo7fPrae5DSw6
	 2BBiieJxH5gqkDTodzWav8NSh8J5Fd826wNufQ7jSFu23jsCr2pOg+hfoXuJ+eq4gRE3I
	 GxUCdi5t9ivPfbr14dNBbFVeRTzEnvA6THI16Goh0V9RnPpDttace6qbz0QHKJT9cjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM9HzSy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361A7606A32C
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jM9HzSy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0F531F000C1;
	Wed,  4 Nov 2026 16:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809297;
	bh=w1msfwnt1fSEx/EJwr2JvnwqBQYjOBhFcXFgJNqfBNI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jM9HzSy5M1gP6GTds1k6WTR0rfa7NeTwcWIx997iAyWdvXFk/7xsu7r+3xewRkFUU
	 H9nh/EAUVkL/USRXOJtxSrtTdScBD2erztMNfndHKvgS/idP8KP1nStHd29NFJ6O6M
	 PDqJ1ELQxsQpbssrB3/xWeUrzShs9G0FL6blU74xtYTqGeP0MPWWfVrWEXwNPM8+rw
	 i+FxS768lVyl3Sq3bfL86obxEkE3WXRcLGUIsw711rvj4vHNz7byL4he1yRmHcwD0F
	 1MFiVbx1St1J4ocIS6Cn1W2s2ZyMqeXzo2CySRpBniTmWI28HecGz32T/6fBTE5Sf7
	 ftGZHjVKxQCPg==
Message-ID: <sashiko-outbox-197596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 5/7] dmaengine: dw-edma: Use HDMA watermark
 interrupts as LL progress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261104161227.1742005-6-den@valinux.co.jp>
References: <20261104161227.1742005-1-den@valinux.co.jp>
 <20261104161227.1742005-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 16:21:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> While HDMA is running, DMA_LLP is updated only at watermark events.
> Enable watermark interrupts to track progress without waiting for the
> channel to stop.
>=20
> Set the watermark bits on entries that request an interrupt, configure
> local or remote delivery, and pass events to the LL progress handler.
> Unmask local watermark interrupts only for LL channels in local IRQ mode.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261104161227.1742=
005-1-den@valinux.co.jp?part=3D5

