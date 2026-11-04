Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761174;
	b=a45IrO3lIzcsaVzYNTnHyFfvLg3Racxc+HiYgTXBvoYiTicCjvrxRcAyGj6RVakQ+Gq5
	 iz8dakIwIeE3JN6AhXMJHkw3wwCrwj5MJXNcnR1BzmaEtN3j/rcAwwDefZ5vPuq8caKx3
	 cW/kyhRzuzRZZ8V3ZyG32JxJ/nnTasth9fbiDexkTfienAA8GGoHEnQLWf706NGWyb26T
	 9lCo2rwkwvcsPyGDDbMqtazQJUMzuTtigkWs26Hy5aSWUtnA5MxZ0ADD5A/sz7bvPvkFN
	 4Ofeq/wFdE2Q0JqWyELser7cdQckfi6UaXv5kBWWe1fZrbteTZqGQAi83MsuMt+K+iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761174;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3NPxcqt9gxB7n9rvXULH55857LvBhTkdMuUcfiBC1K8=;
	b=yEkcLGMPXSYwISJc0OahZpmfCDKgN7cNKw3lnkXHuMfJYQAC/bFDaKB2Qbj2dE3aAvU8
	 r01416QvFNsJsD7RGodoti8yAmHYwS6WeoK+JOumC6T4G+xm5FbXQHXNO93YdtvuNf7JV
	 Dfpn20GLc98p29oO5/kP6O+rq0v09D+od3CFvv2bh2Q0UxK4Is/JUIihI8nsNp5OKVoWy
	 Q9sgKEO3vKI1xHXrQOdAqJIHDIzlyztf5elE+ATn3elTrSd8rCECDuB1XBqiBWeYpRGdl
	 Dtqz1M42vreurzn4GYEtHRfQu2898OddAlEwrcu3uEEwQZEd0M+pHiV8zBB9rGO2xGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfyzxVy4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A13606A31B
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hfyzxVy4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99FA1F000C1;
	Wed,  4 Nov 2026 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761174;
	bh=3NPxcqt9gxB7n9rvXULH55857LvBhTkdMuUcfiBC1K8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfyzxVy4oCBWYMBRUZHm+YYF7cc+VfNAD6T4zpsc/Wg1ftcMUDUwP10tkYZzJ24OQ
	 +zYsLLH90EiQbQf9WCQ2RXvFz/9FpTH4skO6wu1ggwQfz5JlhIBrkQdpBVdSJ4n38z
	 mC34BiTA+u9kzTt72niqebWjqemMrDcfNjZrBMJCocF2iTc1PXud/4914VT0yNJnJD
	 F+Kj/TNVPlY+BKsBwg2vfj9H0p0wk7Rei/OctykY7ufmIOOVURWrrMbFLtLA2HurAD
	 i7d+xVLy5NKIA0Vc4sFIbR59WlqRoC8pMEdyhCil6SKNVf66r1fM+wb8Cx/pQpFA0Z
	 8P71zH8asSnPw==
Message-ID: <sashiko-outbox-196556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/25] dmaengine: sdxi: Add completion status block
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-16-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-16-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:59:33 +0000
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
> Introduce completion status handling and a fixed-capacity pool owned by
> each context. Only the 32-byte-aligned status blocks are DMA-visible;
> a private bitmap and spinlock track claims independently of descriptor
> ring indices.
>=20
> Preallocate storage during context allocation. Claiming and initializing
> a block cannot allocate memory and fails only when capacity is exhausted.
> Provide a bounded, killable wait for administrative callers, and wake
> waiters when blocks are returned. Release blocks only after consumption,
> unpublished rollback, or hardware quiescence; destroy the pool only when
> hardware and software no longer access it.
>=20
> Represent a completion-status block by its CPU pointer and DMA address.
> Check the little-endian signal with READ_ONCE(), then use dma_rmb() before
> consuming error status or operation results. Polling returns success,
> -EIO for a terminal error, or -ETIMEDOUT without relinquishing ownership.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D16

