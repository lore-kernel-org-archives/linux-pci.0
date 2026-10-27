Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118001;
	b=Zh3hFKYkim5aKofMwxlSGU4G56XVfEXu+c3uJNbzmN66WLJFJhCF21uhMg2n6xFS9D8v
	 osjRF/49GgFnASX8tGjy0sPich7CTN5HuFjMOeCPX6FfJ7Ae1pMFM6FiMUeLr8gTv+Zsl
	 72mRnmxzLtxECSoIqsBdTK+eNnf/2gLW5tCKZ8DneeCaYei74fIC/201ARQa00os+/q2Y
	 JdShrjpL67yDTiBYnhHXTzpo9HC3TgFwjgA6mtY6MPpJLfV40lmSJOx8qBwFw6FkVACnc
	 yFZGJ15t625Tg0M5gS4dRoEwYWBRKT5dKqTXHTRoeoo/NAXWd23NzOWjsFsqplR4nng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118001;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=IRY0lwyArkNhftwfNzoAkbGD0NTO9uX7tMPKFqes1mw=;
	b=unVTn2FymYvOzJVffdvqjEnmmKDfnDtTcxVUF23ySdWuBlA4yJOLoQt4jdo53/EP5y33
	 c63D1d1+260wGzr4vRmB5n24PuNUJsi1AH9RiSca4u/gHGPVo+UDHli/yJ5GuvgvoHpK+
	 2qHgfm3cBArBS4qVWEbrZWdaM5l7kX/KL7R8rB4d04fIfew7mdDoGXBhA8Mm/zNR6jyH0
	 DTa4s+7TLoRAUpLkX3L3XGM/Y9OUsXnwrDUoOlSaBScUK0lo9Ze5bG2s1FAlo3uoXxHKf
	 Jc6ef+HYV4JOpzwii9LL58SZgN3RJ/UgbmxOdAGfTREIKxrx2ANQ65+HZ/LENwCqwxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUEPTvNh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC9F60A2604
	for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2026 16:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUEPTvNh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EDBD1F01825;
	Tue, 27 Oct 2026 16:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793118000;
	bh=IRY0lwyArkNhftwfNzoAkbGD0NTO9uX7tMPKFqes1mw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=LUEPTvNhN+FOASRclNJPydyLiixUylNDpzDuDrEdWyKc/zms4pc9ybTRr+Uqn3VvT
	 fU/IVIwTFnLk9GrjkLDkbzB4cQ7O4Ugue6YVv3hxqBx7iaqtA9eo/EXFkctwARN/RZ
	 ABKeBhL44UBaCaMUdNUhzt/HTDGoMvYWB0m5uDxYLF0d5o5aRkb1R2FqC0lm8/QCKR
	 nfn0D7ksGLbbvKsa2scQBeVuvkNmkLIEOhlwcBpO71s5QhAkhLEEocSMVyCrLm5pcv
	 8YPFOH2e24O78pI22xMMZWOtpseKtMbjCHJb06/ZcDFB8u+U4P6bOnB9FO6us9s9Dz
	 3dPy8r3aP1Ekw==
Message-ID: <sashiko-outbox-186898@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] PCI/IOV: Introduce pci_iov_get_virtfn()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lukasz Laguna" <lukasz.laguna@intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261027160446.858300-2-lukasz.laguna@intel.com>
References: <20261027160446.858300-1-lukasz.laguna@intel.com>
 <20261027160446.858300-2-lukasz.laguna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 16:20:00 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add pci_iov_get_virtfn() to look up a VF of a PF by its VF ID. It
> returns the matching pci_dev with a reference held, or NULL if no device
> is present. The caller must drop the reference with pci_dev_put().
>=20
> Assisted-by: LLM
> Signed-off-by: Lukasz Laguna <lukasz.laguna@intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027160446.8583=
00-1-lukasz.laguna@intel.com?part=3D1

