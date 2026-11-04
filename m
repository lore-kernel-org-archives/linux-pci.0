Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833885;
	b=knHXjEUOgs0ae7h5sIRgUm6uJplADfcbwZC8qHrA4nn9E1WKhhEWQBoOHriBBYRpTl6C
	 28lQDy1/zZCEeWi5vOPnFHWOU6rahydQgMGH8/Mkqx5CLVldlkHEQK2v1mWxcgOqKBiY6
	 bxqOAvAUMABrPyTjKACQET8rWeYPRjuUpaKw6dZvrbrkpSw0nNGvEkhEnRP9u9l7YUjXG
	 VL5v2YRNVjR1Bsm5SkfA2MSwXUlalnfrvJiPlNfGq2e4HvaQS0Mt9YewT5ctbxCzm9eb6
	 /yg5sBGdieotyZTbEvOM6SGkkTCzFsZUvgJUY7tJ0CwojVU4/ari4MAfXBEDmkwE/LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833885;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B+T75TT93tfM4nAipEJBYUwEbLPy/SgUw/s/PN8HVGg=;
	b=qtRtLgpPHGY47yzP/wAYkYCvLvBORFz5DN1X88nXBQnS/Iry/VOT5VSne+IempMnQpmC
	 XHgOJOOdSE6b6AQS0duudTVQIRZki3IlWTYIcJ9H/dlt/OQClctEI/yF+NtunNlsHpp4Y
	 AFI4AsXbntUvFXcVD0x03udU6vu70CdaG++AYM4X7otrdquQwbNxQSy+usWkdarzihe+w
	 zQUsfxXSUE9nhqhZLfa1l2eZ/KoTLf5BRnBHslRBV9sioaF52gB1w9JWJvfPHyXlKP3pr
	 4HK11MgE9ZsZdhbGoME1C+4dkU2weHlXG86QQHtsRlbK4gxjWywm7I84TsegpXam2BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8q+cIv9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9050606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8q+cIv9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26F4A1F000C1;
	Wed,  4 Nov 2026 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833884;
	bh=B+T75TT93tfM4nAipEJBYUwEbLPy/SgUw/s/PN8HVGg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P8q+cIv9mhuFVU1zntcDE8s6YfksEG96lsCWghEL5yNjUQf+bD24HtgaAPmSRx63F
	 lTVZhh7MYO3YrzEeCxg9k+OX7fFszcrzPlPG+hNUck8OdavIwIei1eCvMWvQlwH8Lk
	 kOTsVVclTPRrMSNpnthApBVlGE75dkqlnIhYO6armaTJRzoHWKjxHTn5xnL1v0fF3I
	 h6HeC1SQXFOmDfDvY4qTfLlv8VvVAY8TELxGSQGJM8iMqwQiLdX8Hge4L5+vQnNXt4
	 i3bifTZnHeWw/23rLpvQybMg8/sY2/A7200gUR0rBAIqStifuW+xczPKUUasxnx0Up
	 prFHRgHTUDAlA==
Message-ID: <sashiko-outbox-198273@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] rust: pci: require an enable guard for
 `set_master()`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-3-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-3-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:11:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Require a borrowed `DeviceEnableGuard` for the same device before enabling
> bus-mastering. Check device identity so a guard for another device cannot
> satisfy this requirement.
>=20
> Keep `set_master()` on `Device<Core>` to retain callback synchronization:
> the guard is shareable, while `pci_set_master()` modifies device state
> without locking. Convert nova-core to pass its enable guard.
>=20
> Link: https://lore.kernel.org/rust-for-linux/DLNQ5C9BTIAJ.1XEWLZ13TU1VF@k=
ernel.org
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D3

