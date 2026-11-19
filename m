Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116576;
	b=Oi1fOAiFsSSWTtY1gDen8ZRrlwJXgWiLGTaWoJGlZfU8xpNtefVs6bIHwEdYfSLYBcxM
	 OUvRB+6RZyPnewOoKznTm1hytfMdgTiPFsS5mUwgRRjXBZ82pQum4sJdc6VHHk8Cf1u2B
	 EjYNAU3ScRoXwhnBPjqHUFQGTG1l9EIdPODO6RYtteyDsy/w6krd8NBr21lnStR/H7bET
	 4Dtaio/wGZ2f/5rntcxR+70MrGGarqq11QSW/G1vJuqRVNi7yPn75hdQ8UPCtvZ4+uc1S
	 7KVgX4MDSNQZFYJ3kusKDkhonvip6i66Y4FxyJHboX78PM4isLXFEP8/eH+97E7IprQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116576;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=xmXhIZ3R0JE2LbkJamgdZZk+b/CNgaLuBk9wCh3NKIs=;
	b=r3fXJowaBvQDoLo8F9x4xPZWGs21VmEkzW/Of1biTeVk3h8YAbxup90W/hM1/GHKZTiG
	 +qfxborv8t0l3BcHYg0R3DDMD5X0ODzfiETvFCZBq+RRpdVi1g0NpIJmJcUtRzncyAxnm
	 I8msQu1TU+NoXQG7tX4RldwhygxeVNK3zjX9weQQ5i2XX3j+aitItWqUka9VWpXke8nOw
	 mC3Foh5slWfXkAGFP77WCrHhPXFMjOLXa/GABl6eYmhEitkIejEu2xc8fssic64/gOkb8
	 l72GQEeP2T4+yvWUIR9JMjtWLnLKP05TuECKY+PiF0DbgdKP/YHLuozQ3QOJ+PN5hmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mb4BQVuV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF160A2600;
	Thu, 19 Nov 2026 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mb4BQVuV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 408F51F000C6;
	Thu, 19 Nov 2026 19:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116576;
	bh=xmXhIZ3R0JE2LbkJamgdZZk+b/CNgaLuBk9wCh3NKIs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mb4BQVuV1Xa5d1ATbhudRjEdUb8ekCdFiZ3hvv+/ez9ch0Ci3vruJasFJMewjpHFR
	 gw5wMrBaZVrr7BQnclgEGRE+TCYXCOyn6pLjw7MrE5b3c7BskdwV7GmzJFeHphgR/R
	 xVITirA4yX1p7GgyVL1YRxy+zzGaMCcpvC5hnF0VYLj3mVl9Vvjklxbe59e9+WL3oR
	 erEAfBf/eBPOp0yP0T5SricKG1T/QDLHv2F/Y9T2FrDxNkrVcAX29nVrG51G3ufMea
	 eEQ/xG4w9leGz0jui/RUbaDMhjy8WR+88R5LCne8krqLl7bmokGDcJb9BkM1aRuY6L
	 cjB90RtNns8fA==
Message-ID: <sashiko-outbox-223903@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/31] Input: serio - use the compatibility driver
 attachment API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261118-device-trust-core-v3-17-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-0-d655875c4bfb@nvidia.com>
 <20261118-device-trust-core-v3-17-d655875c4bfb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:35 +0000
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
> Manual serio binding holds serio_mutex, but generic sysfs probing does
> not take that mutex. The two paths can race while updating driver state
> or cleaning up a failed probe.
>=20
> Use device_driver_attach_unrestricted() after the port ID check to
> centralize binding and cleanup. Acquire the device lock with
> device_trylock() to exclude generic probing, returning -EBUSY instead of
> waiting while holding serio_mutex. Map legacy -1 connect failures to
> -ENODEV in the probe callback so they are not reported as -EPERM, while
> preserving errors returned by the attachment helper.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-device-tru=
st-core-v3-0-d655875c4bfb@nvidia.com?part=3D17

