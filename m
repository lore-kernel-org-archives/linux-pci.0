Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116580;
	b=vR3THUnwvKgykb5XAqxvJKI3ARLpbhzPXNaWIJWhip2i+XEljDwkP+86jqjJeeAlTPJ6
	 6mIc//Z2lusI/BK0rgwSk9E3aBTrB/mgehFDdNiwB719V2qxaRuvwhGOhvMHFbqxBPnK1
	 y0V59TpWiadjJSvL8b/XRcR/LCOK8OthovRJ7icO89Q8Q93cOQjIn52pkbF3GRWMVEfcP
	 wM8rDOw6V/BhdFqu7KxyYPm0d/T9gtZVsM2yV6Ou9HDx+zqgYNTM/BMu2uQaJL785OnoG
	 GePpaPavhwxStLnecPxC6fXe620xpjrFxBDJ0Cue6GHU8jFoX+0J5R1PQ7s6UrijRdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116580;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s0ZFt8QMJU6Im7MfBdZKMYVrafrRkZfgP7k+3/j/jzY=;
	b=wVx0R2k/WHQVRNJNjbpBwXvTHRj2PTBejOe5bBQ8C+21d7FhEXNMivHcvy8jNilmAmYT
	 zANogvQfpx4lKkg4mh4EhIAgRcL4hQnUdI0ETg0wwhtlNC2ZXQ68kD5a1ugE9yF8bfu1k
	 Ou9L/itT5aHt+tPQrzNfJTSUVSZ0oywKjv20srzUEap7OsL1LC+M5nagselksE/zDYXId
	 qTcYMY9Qe748z7gC/G9kCIgsF4rEwYyZpf2Euu51TUwc/YbNUVLUd0isCMHaOCcsLQPo8
	 D9KFajKCqtIoNJGS3nZ56eejcVXnbPWli5FtNv98PhkC5pRU2/r12P7GjjrdiYG1txw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3XyqQdK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD160A2629;
	Thu, 19 Nov 2026 19:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q3XyqQdK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7A61F000CC;
	Thu, 19 Nov 2026 19:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116579;
	bh=s0ZFt8QMJU6Im7MfBdZKMYVrafrRkZfgP7k+3/j/jzY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q3XyqQdKQR8K9LMOzIoNlQZUOvr9feJj+OCAUlChPRltsLe6YDYVz997NNDJxIGhh
	 NIOynJp5AhuDspvuMiSWB5CeXEvepORK+bxiLNxk2BMqF9CIhE634/AdrGqGEOjtIe
	 f1SGK7Gh+NP3lZxxphAnvegYRL/bV6bl3lNtP0wTBHzI5nAwpwg5k1aJWw/6YRdzkF
	 DtU2y5lxahvYGX5bhQvq9Iw/b+KRQNE0CRpsKXXq6+wr6me1A69MjjjxnrK5w3vw4E
	 nep7bhbi7u94+zzMb7FgWAsuoKJhBjVcBpGcJA9gwxwVQZXksrF9Tmo5KQnTk4u9kz
	 Q3U8BUh8u7OAQ==
Message-ID: <sashiko-outbox-223908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 22/31] driver core: Accept device trust policy by
 driver name
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-22-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-22-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:39 +0000
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
> Device names can depend on enumeration order, making device-specific boot
> exceptions difficult to reuse across machines. Userspace is also too late
> to establish policy for drivers that probe during boot.
>=20
> Allow exceptions selected by bus and driver name, using the names publish=
ed
> in sysfs so policy does not depend on module aliases. Preserve more
> specific device rules and prior authorization. Keep a matched rule fixed
> across retries so changing the candidate driver cannot replace that choic=
e.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D22

