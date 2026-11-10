Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794285426;
	b=SPaFCVL0r3NXqfyQsEZxpZj4+0WKWHITqGpw5G1Jj5ZYM3kDvly6cGQkm4nop8CTipir
	 VFZeFB5Kp/KGPBVH5oCEtrG1hH1ch1DEZlxzCOR842gdAxFjbB6pSudiLS0mO8TjoMosn
	 e4J6mwKjyd3c829iLfkfrwpkulXPxH5ArjyqOQbnZpZ9RSvdb1dO94zoIi1w4zKKSUoxc
	 x3dTVCHVRCqx7ZAfHAPO3PlxrvF0E23dMK60JdOztBFw5hjvB+YjAGiYLSSvQQP7QSrIs
	 561MIIBejAKvpdxCSstjC20o7XctQ7j5HgPqKB4zDzaIa/b1mB1ot7kZY5oRBSQs4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IqSDRN8gCewi8Gm4VToL4uGvVfNyvqSc9FVdJKKAE00=;
	b=hTHxS0qIMURu9Yb03yXKEsicXaLrXYXh7Qjtam/Paav8fl54pbS5LzmnjzTTCkXVTTLu
	 9A78xBAp0q9SBg0LjQRD66M2ZpKZK/iijakF2Swzsmq91qXrGN9Ba9B3GpSyz8IVcjqUE
	 LvcIqQYvbrQ2w8K3Lm5WRSI9EBJ9or57vi3Q0PMGRBzrkcPZalSHzzvLvKtgxu4LkVBg6
	 9MyU9mFKyY6hy6XNQjxSQYpRuXaH6kvPgMCRfY+7pBoOWTTR9+udsoXmtus2vZzVMYTQk
	 o/JgfElf0BMbLqBDdZMZxvbd0xQkDKOTcbjQ+b3GWDTBm5Zx/oQMIyoZyZWXpesi9MQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBdCzvIC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B1606A33F
	for <linux-pci@vger.kernel.org>; Tue, 10 Nov 2026 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBdCzvIC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE291F0089F;
	Tue, 10 Nov 2026 04:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285425;
	bh=IqSDRN8gCewi8Gm4VToL4uGvVfNyvqSc9FVdJKKAE00=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=aBdCzvICkGHBAPzMVpmH0X+3Wbo1nOlMZ6AM5ERDJoZEpq+s1B2JIY5to4vZ0WzJU
	 LOkAAyDQXmAuKoQRWZaV26Wza9W0yZ2B9iiBfQSF/LQPJRs8dkgO++7oIP/CqEuf6A
	 ya5agQ5HHdREoGHAyYWSulOW0a0Cja0GSTz3kFSZSbiU0yTnHsgOEsKXIpj61SnMwv
	 u4aEOaJH/99gWWKpbwFuM69HCs+CYk4V5LeX+tV5wlaY9QD1JocZcDPvnNKYXmMCVF
	 B3P3acF3xYulNKleKWLVphNQjg9RFE5LaSfyEuPftUbn6wGswWwjyp8ivabViQ1Fpj
	 mw5mqPj9JAxQg==
Message-ID: <sashiko-outbox-206219@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/25] rust: kernel: Add crypto hash bindings
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com, linux-pci@vger.kernel.org
In-Reply-To: <20261110041832.1730924-17-alistair.francis@wdc.com>
References: <20261110041832.1730924-1-alistair.francis@wdc.com>
 <20261110041832.1730924-17-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 04:37:05 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Initial support for the kernel crypto hash bindings, which will be used
> by the SPDM library.
>=20
> This is just a few functions that the Rust SPDM implementation will use
> in the next few commits.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110041832.1730=
924-1-alistair.francis@wdc.com?part=3D16

