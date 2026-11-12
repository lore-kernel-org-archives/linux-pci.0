Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444734;
	b=mcdFltggRoAtz9vAUbQjGQw0feuUbtHYLLBsm2OwP+96LBzE2G2j5kr8MwkzE1tDu2r2
	 HmW5X2WrzDzCNrPTWNK+y45bT8jHDuyhBwOdlGApOF98T4jh1ch6ajVuJiSE7pqegOaMe
	 FaaUC/cpGJTasbsKDxhvEezfDFptiO55ku1so2aXM59/2y73mCRxE8CObQKtusJ6IYiKK
	 bvWI8z/pc76q5yNa1jPEnpxBuFCorxWaoR+7pSHTR+IqH/oxi8QlyWWcq6YzIvNn6Hr6r
	 EyN+6fLwqWj1LE60LgMUPIo+2WXZMC6y65GHYUnLoa8KOcQJAIZRk5vEswtUISgucqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444734;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qisiawYW1uk6ch3Sg/19+xWnp3HsTYNsaykfppfkZgo=;
	b=ItdzzTRByw3zzxw14VWjyHUugFG/NPpTqaWxksrGxgk1ge9iwobdG3uPeaxQAnVK6ON7
	 zMZZ5pp+Hd13hOARZ3RvZwdKtcn2RDBPxG21N0960U79mTbvVNrXxfxJQS5WJ7v7hXYO4
	 fH5ny0qe9IrMBhxmA769SqDQDeCYuhDEkUU0Sm8xOUGmwG0zxwOPtSpQun7yni/U5XlZ/
	 xjWpkqXj+/KSVXNFvNOFQfY7nBKQ4enxOV2H0jCumvj495QHDo7hhMgiHIk3kvR5NZIb/
	 0pdqLeBD7RSv1pQ1n7UKFINWqXA/1TwFiVnnxyy4cX/UINFvJom71/QXT8RQ8qGP2lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI2Fi2rW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD67A606A324;
	Thu, 12 Nov 2026 00:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI2Fi2rW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CF21F00A05;
	Thu, 12 Nov 2026 00:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444734;
	bh=qisiawYW1uk6ch3Sg/19+xWnp3HsTYNsaykfppfkZgo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WI2Fi2rWxHa0Ij52V8qmtU7J5hC6Z78dZhXTBdzmAf+loEp6s79pgeYM6INurGeFq
	 dItCx7Ekk5EuPbOhz5ynV7VvIF0bMa4NcwuNj1U25ZhzNl0s/dXjOETQKs+bDYxPaU
	 haHAzhT75Ek1vBISZGlVud+cY3N5TPwYeAD29WSb1JtOUao9V06CGchAXoJzs3Dh8+
	 7cMPqV8OaT1WsqaWfC8B7Z0wx0zyS0Db3OCzrpOJkbLUFYBqivytFIbC3zodbm0aaB
	 uvlfkl8H5VHFGzTX9Ns4Yprzh7y8n89DJ6pPYkHViA4Z7mHIX2TYOy9/tplkStc6WV
	 uhogqAzxXUTYA==
Message-ID: <sashiko-outbox-209994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/3] asm-generic: Add <asm-generic/cpu_device_id.h>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pavel Popov" <pavel.e.popov@intel.com>
Cc: virtualization@lists.linux.dev, linux-pci@vger.kernel.org, "Michael S.
 Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261111234439.4098-2-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
 <20261111234439.4098-2-pavel.e.popov@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 00:52:13 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> <asm/cpu_device_id.h> exists only on x86, so generic code that
> matches on x86 CPU models has to wrap the include in #ifdef
> CONFIG_X86.
>=20
> Add an empty generic version, so the header can be included
> unconditionally. The CPU match tables themselves still need
> CONFIG_X86 for the model defines.
>=20
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/r/25a0cdb4-9c4f-4531-bdf2-8d09eedd0883@app.=
fastmail.com
> Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111234439.4098=
-1-pavel.e.popov@intel.com?part=3D1

