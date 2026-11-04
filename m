Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761714;
	b=sjp8aGS91Rrs7z7YMlldWeZHuz5ezf/QxHfOEMJHf3sFtl3MpggmBp8hN2CoP9nzE+B4
	 lQf7HEJtcoXfh4qJ8ZP+VXnCA9b3v6CoJ2GpC2Oak1AY/ugPlRBYjA7W89tHSllsyCw+W
	 N3sUk9rblXib1NRpGqXpDUT6jwMuYWBaAu7PLEPvQ/0Vt6KnyMIQJU0LBMt38oUqoLGVe
	 ZIDaAUi7Nzd0DnpBzKIDDDS4BcuzulhwfHZSce5Y1tXP3AjaiaJUMiZcIRhFXCsUa/GmQ
	 Py067ON9Uj6eOLYGtnfu2WU7OgQX5OLE1l0tWLazI+/bftH10qWWKmS8x43rhHkXNcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761714;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1BHT0zMk5QvZ2uYmucK/D2X47iwLEbM509NzKZ6Pok8=;
	b=VpYrF73DmmJF9x/j/EWtc5km9mARoXN0zQl/uJnN2D3VLQS56bwASjLpjvyTO50WTae0
	 9/24iNgoLuolAxtFmf01z/QFxtHD3Gn9pb17AK6VY8jyUn0YVdm1Bm8tl9N2aqI1bKUB/
	 mP5dEaDBVIEkzLhoXq9+qe9u8QomXtKAFANSuzTOgALih8Q4qXLQ/uFazB2cD9zO+FWXz
	 w46ttfleZhic6HAZUnwM/lt1kNFc/KVJFSi/CAp0vvLrIzwCvpxK/suUALOe5iNyYMEqo
	 G6RZoOr9E+gsv9j4pQ7bqY3SHaa0TBSP5LaWdGstr34daWYQ3OhNfoZ1ZYci8tX/r4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpgEKnFh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B5606A32E
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XpgEKnFh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F631F000C1;
	Wed,  4 Nov 2026 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761714;
	bh=1BHT0zMk5QvZ2uYmucK/D2X47iwLEbM509NzKZ6Pok8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XpgEKnFh2rrEdKJc522vHtF62/Z4U+rfr3obOSO7WozesfC1Fx7RHkXApPiOxPljG
	 5Kmkp/6fsuDNgruJqV9KM7cfng6511xJ497XdhpIKEzHFwz08vQcZvBGxkjAsC2zrV
	 dn0fngzGRF3yNkKgHFLIW45Lin3O1FVYXNjcrZq3Juo/t/dnrkHUkmVlf2knFc1jLK
	 X7AIOyLurr8FaOsZlawDSy07gYSoPgRib0A9zdTPXy/2xCaI6kuAYWZDy/4MJklH4+
	 yOpsz9+0K63Bz4E/fZ3M4uu5HaafkdQr56D/9xGsVDzizsN4uB10yCfGIwSsQdj9LL
	 U0UtAJJNKQmZw==
Message-ID: <sashiko-outbox-196586@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/25] dmaengine: sdxi: Add descriptor ring
 management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-13-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-13-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:08:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Nathan Lynch <nathan.lynch@amd.com>
>=20
> Introduce software state and reservation helpers for driving an SDXI
> submission queue. A spinlock serializes space checks and write-index
> updates; blocking reservations use a bounded, killable wait.
>=20
> Provide exact-size and bounded-size reservations, with descriptor access
> through a ring slot carrying its index and ring state. Reservations
> publish the write index and cannot be rolled back, so callers must
> populate and publish every reserved slot.
>=20
> Allocate and initialize ring state with each administrative or client
> context, and free it during context release.
>=20
> The hardware read index bounds descriptor reuse. Completion handlers
> wake blocked reservations as hardware consumes slots.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D13

