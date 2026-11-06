Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793965419;
	b=5SHGr8qmFPQILpdQRBV5QPDSFkysFVu5ygih2BCjJRXwGQiY5L6cDOcmU2T3lDTL+8K0
	 vQCwYWe7qAsbk57H34J6z9iUPccj7Dfr9KiqrVT8flP9LF9OAowaDLiXYUIj9rAhOgV7/
	 EQO9ZxY+zfr3BbBVh4odYbUFmblU3C95Ty7WlPUV7qt6088GvU2FfyLboR7Y3rIiWuUCf
	 OX/ktEKdklHChPjvFRlnhqERKJjsX+pgljt362/U9AhnYrzJ8p2PvKw4TSFpR1kX9hQvp
	 ibZY5XTiCViUR6Z4b66q5GyaQLxYZV0cT8eUJ61jwvtuA0wYjEi3e5hJ5G2bUZesqsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965419;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HQULXCUgdqXlqbPXuFuVMAuWcrdfuG7rS10G+8rErMo=;
	b=AR2bzPYIBsirWT4GTxwRXfQqKBr+ZSFFGAVngGHGpHzcJA6cipp0O/8q1xXU6sazf1bJ
	 ksEZe8OYMCXYhOQ30jptXcgMQayubUX5LUrdWnItSQWL+ullvb4OUd/BFM7l9h94dh472
	 CTct12rcgD1ChMY/Ynp6mHKgsd/k0AmroLB1TFYZlgdUPll49eKt+kfWoPrFEdzHsHbCR
	 hvbCAeYaLyjj8xcoVlLbznpK/2d+8DPYanN+ekJ/LcYDR3fhX7cVIHJN3aWtbpo+yGADP
	 43DG4E6DEphlrVVxEKi1NXF/xRanrqBbTC0w5Bs6XRgZZ1KVB9frZzsAShZRWlACe/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2UOIsDA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3214606A334;
	Fri,  6 Nov 2026 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2UOIsDA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BA061F0089F;
	Fri,  6 Nov 2026 11:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793965419;
	bh=HQULXCUgdqXlqbPXuFuVMAuWcrdfuG7rS10G+8rErMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=o2UOIsDAv/thsPbZf8Xf+FDUGZEd7iewKYhH3ewutD3J4FlAKdAXVvc+5ztOp2K5c
	 dQMq1N02MhRtbMTBcXROuuWK5+IoKWSMavIBtxH0ha2gP5nHROgNHvjqH2sX1zEosY
	 llDtIW1L0anIiDItWV+L8TBdGRgeURZlTJ2p0O/5kFbwk2YZRQi9oKrtV9KXitYyiL
	 wLiZpGAA8xLIeV499GFjMTDAJPGEg/qIjP6I1RjCZkahOVJExHxD8zsQ+pm8teKVr9
	 WbRCe5oOTT/OF/luUtWLSW+JdhIErFNYKwCkpsryAhWlE9ywZZlVwR6wGtY8/vbsLP
	 2VLbLXJqWoeyg==
Message-ID: <sashiko-outbox-201335@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/17] Input: serio - attach manual drivers through the
 driver core
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
References: <20261105-device-trust-core-v1-0-1e536825b4eb@nvidia.com>
 <20261105-device-trust-core-v1-2-1e536825b4eb@nvidia.com>
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
> Manual serio binding connects a driver before driver core can admit the
> device. A rejected binding therefore arrives after functional setup.
>=20
> Keep the port ID check and use device_driver_attach() for the existing bus
> probe path. Driver core then serializes admission and handles probe failu=
re
> before publishing the binding.
>=20
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-device-tru=
st-core-v1-0-1e536825b4eb@nvidia.com?part=3D2

