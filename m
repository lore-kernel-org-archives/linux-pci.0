Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794296118;
	b=1ZEW/8rAoC9iDFfni96jDkLdgsFZmpovKlovaaJl6KzG2EkUdllX9RNoX1/aiJI2smlC
	 UXyts0kohQ9hL3YjyKAjvgPaDI3AJN9WL3ZqBbpEoF+0nT9Q1q2Fvs9AkGR+aqPiMDLK1
	 Lh1ye+Fn8Ii6al4puvQqODydQQd9jYsA9MHMQsbCXFEhrYu2xEKQ5SkFi5eNxJr6MTlfW
	 iHeD78LVaQxJr3/DZVk7Jh2gGII/S3gwxr+emoOtaJ0PvEMe6qXfmARsdBOr6zcl7V6J4
	 xrF56FUiLjdx4QLuoRr4VIcTiERZKYXm9zds7A0WEChm+y7qDiHO6LC1aUrPQfiJReg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794296118;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oiKoF2LmFxTv+wqYb/SncLxOqeiZk1hiI0B7Miq0yb8=;
	b=5oXJgNtNQr9VjI5PN39R33t4yj0ElOjlmcvSai+lsobYCFIDznSumWY0G5Ems6cOLJRu
	 AiVDDeZtsIOKi9Ud7Dmuq2LM6OO4a1N0oWQQURTmr+AKaUh0HA2H0rWfdycXqzKdT5jyT
	 TurdC2nqMkRkbcfzmqQE9SfKaHvVdZjFJGy1Hdxny0fn16dtxqNn6zO22RezZJ5TAXwvg
	 06sCfWmeYWFtL6CjoPoL8+yldvsNw8fHlveY6q+iZe0VBSmCKCU4/oltqAh+g7q0siEeV
	 AyIGoDbSduJQk1Edle3K/XFYOJyglnQmlWWZHVniEFImr0rvV4iRJB4Pa6X/wvo8+HA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFZyhtzl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFA460A261E;
	Tue, 10 Nov 2026 07:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFZyhtzl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 052FF1F008A3;
	Tue, 10 Nov 2026 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794296118;
	bh=oiKoF2LmFxTv+wqYb/SncLxOqeiZk1hiI0B7Miq0yb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HFZyhtzldsuJwrgaRd9feyqweiGrXLq8Vsxan2enEIAS1aGNcqKCOgqfZMIjzPwJa
	 aYXc2jOUeJ198SVsI86Ana4vYXukOlHIMbXStessefWHMiYIMVdHmbyAIZSSf+eI66
	 wIF0BwDOF5go7uoL++9CVC5togcK3Qknb0xlRn8ShaSLLYoRgC2XqpZst56YALQV4m
	 DDY/4SxShyFBnKl8eoaNFSe4B028Z31rYMaPj4KSTqdRsl8H6AhhujUPS0OfzaI0A3
	 0paNC6ljRBLk5h9UNnXrf3WEm5qEBVAlYhZ/FFYYstKZDx6boDRZAhjfWlfpzYvJsJ
	 fxs+yaF3Kdtgw==
Message-ID: <sashiko-outbox-206508@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/19] driver core: Add a compatibility API for
 manual driver attachment
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261109-device-trust-core-v2-8-3b12d9a9f861@nvidia.com>
References: <20261109-device-trust-core-v2-0-3b12d9a9f861@nvidia.com>
 <20261109-device-trust-core-v2-8-3b12d9a9f861@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 07:35:17 +0000
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
> Existing manual binding paths probe drivers under subsystem locks before
> publishing their bindings. Normal attachment would add device locking to
> these paths.
>=20
> Add device_driver_attach_full() to preserve their serialization while
> centralizing probe and binding cleanup. This compatibility API must not
> be used in any new code: it prevents devices from using the device trust
> authorization infrastructure. New code must use device_driver_attach().
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-device-tru=
st-core-v2-0-3b12d9a9f861@nvidia.com?part=3D8

