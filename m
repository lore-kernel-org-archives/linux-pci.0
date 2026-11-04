Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761105;
	b=B8Jj1W7di2nJyCN64po/ZoaTTI+V7fc5bwWbGNSkUllpPjNyaugW5ABMqx++1Eps9tn3
	 IOi6FctCmtEgHVQp/tvcF2iAigu2DPQLjYG5dftBrPxw5dVY7kkn43AtvdPgkVjGCUMUk
	 qwl5JjRhBgWGBOOJSpiPj41wkfLa1zGV3TTo9rTAxVTrUj2Db/3SMOlqieeZ/c+vBjy6G
	 31Q9r6PKcHVENauD657kotyVQR0sF/0C5hT9KUo3/lcbfUDqpvTBtp5gD3lhFSctc376n
	 9DQcV1HEFnSVde/+0q799wxs0wKxf/IvRMdR2Enc3q/Npq+QPiCvGVQk04VBRQRkn8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761105;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rll8ywl4dJ3bYmsaPCkt12aRCyyXljax2wZSAg9nGRQ=;
	b=XC07qjCAxevT6RSLApWXuKOuOig7487O8D1MSmaY7j86tZEnC21R/0NoXCbqXyzu+92y
	 snprCW+9hUdkezZME/LX0Dr5u8/EAFIdOaLDXErLIvagwrcXqxpsOb9U+w12giys37jOV
	 5QfgkglOsRZHgsWECzVTSZbJ9Cw+v2SBkFFkzjD8qcxrGMVTTNJnmvKK3+JwjW8lORAXV
	 uqD4dpweuJTo7o8zw2ZseFXDfUZ+2ktWJJz/LDkBAWpyk03UwHbnVWhQ5pXnL3DNKsn/4
	 5nB1R2yfDfnY/QcgS3i0sb+XUWsj1jcNtyUXb9isOu1EXI5dj65caer/O9WpmpzlU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3tXQiv7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D01E606A329
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h3tXQiv7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79581F000C1;
	Wed,  4 Nov 2026 02:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761105;
	bh=rll8ywl4dJ3bYmsaPCkt12aRCyyXljax2wZSAg9nGRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h3tXQiv7qbr040b/poLrXSc+Y1p8XAvavNFmaMXZNpyTAruKtpSTfX5vutxgK34sc
	 4CKyV7Hi+sH91++HIVdkntjEzVzeQ1nqL3bU0f/YyK0/VmQ+qRXVUiWTTVdc3qWBR/
	 AUy1tNRhCVj3LBY7qTxAJZOH2vASXmrnGhvWPAsQ4KoB2UZ7mtNTHnYeAZiD6HSwlC
	 x2cybnUoMwNwRpPo8EiSSGZs5x47q3Yb2PEI+Y7UZUAGGgBACg/EtFj8PefmbrQ7Sv
	 4si2JAWmoWZsdnGMQ2GVKMl0vOQ3ft6H2K6UVZaRT3pT1gewTshNjaGQ22tu4XAufO
	 k4p3nW1gfAazg==
Message-ID: <sashiko-outbox-196553@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/25] dmaengine: sdxi: Install administrative
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nathan Lynch" <nathan.lynch@amd.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103-sdxi-base-v4-10-3668ccc7aab8@amd.com>
References: <20261103-sdxi-base-v4-0-3668ccc7aab8@amd.com>
 <20261103-sdxi-base-v4-10-3668ccc7aab8@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:58:24 +0000
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
> Serialize the context control block, akey table, and L1 entry for the
> admin context, making its descriptor ring, write index, and context
> status block visible to the SDXI implementation once it is activated.
>=20
> Co-developed-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Wei Huang <wei.huang2@amd.com>
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-sdxi-base-=
v4-0-3668ccc7aab8@amd.com?part=3D10

