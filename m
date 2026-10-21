Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792557212;
	b=qooGDbyeMLJ4slZzflDHPaC8nCSdQ8M0u/B45yPskAUzhEqEzNkCUYDdU+xMs/GpiOBh
	 iN3CvIeNpBY5tMguMalYSkzZuMb+qBDY0wKK+8+7a+BtwTPZx5w5F4MupscHQSXNu0giL
	 Uo71spc0OdCAkPuN68sLYwb3JB2gFi8ebV1JyGLLJlz8gWK7WvF5JeYSUBrq0Ho5Dce/u
	 R9LW83gApbcEn+u62oIYy9tyVmXAqxw7xYsTXbNy6rXCBVE+AeJgMUM8tP954VxlZbQJz
	 JcQFhkXUdIU4pfNjFhdMhFp52+ztsXvBjzmOmcwrSMZ8pdFb4joOHNl0hdHLHIYt4KA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792557212;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VLqpe7j4Q9h/YqOkFa6Q/QvAG0shwC/enE07t1pZxmc=;
	b=2z2UqsiLcIbuDr0vYSeQf228i7SEdtC3RW+JtQ0SUTKyrVthbjOfkhhZF0Qwr2InTxAM
	 unfr2SbgVdG6kU8fxOV2sJ58b0NSj8EZDDfYwqjdTHDe5F4uFCx0zkeQhKcj58z3plFGk
	 SMEPvMrApmIGtmiT6S1YNepEXAbOK8fLJC/qq1tr0MlhntHXsOwwJPOVTgZhBl1ajeQLP
	 DhrgC/xxlNvCG/rXU1qAjC53Mf0K+f4twfUutzrtXtYLdztCBw/JPiBeWmB4FFKtnJWfM
	 0uo+Su2mzaKs3090SXm0EtzJzbPyQA3N/ynXyHDLUOYHgy6jXnKJ+XGvkHCUXuXocsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+ZPY2ae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09860606A319
	for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2026 04:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i+ZPY2ae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EA31F000C9;
	Wed, 21 Oct 2026 04:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792557211;
	bh=VLqpe7j4Q9h/YqOkFa6Q/QvAG0shwC/enE07t1pZxmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i+ZPY2aezH/dJsos2qS0B503dqlrxIAskEcRpNVSvq7QzfJ8IQGTZ4O0FY1va28FP
	 3tfpaXCnC+cQbI/YEJwnYvLAgaVPLUXBVS0DZGsEjBTmd4Y7ZHwks2WmLH4pJ+vUNc
	 Dkl1Dx2gDIDljJzIvzyV+MeI8HpZtmwPUB+6uNnCPvlEEG5v5uE/kxGrw3fT+llnel
	 d9s9dl4glQprWlJfur8hd6S9coRdUGSD/o0gX4SJYBZUQBYR3xRmUL+1//LObJTRWO
	 Q4LJFy+mFXkIhMC55qN2O0HGVNn2HrYplWY/9M+8r23rGeVg6wgegsmF6/BNDBEF9G
	 3ObrJynxjdX6w==
Message-ID: <sashiko-outbox-179785@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/10] NTB: ntb_hw_epf: Support DMA and MW sharing a
 BAR
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261021042229.2280937-11-den@valinux.co.jp>
References: <20261021042229.2280937-1-den@valinux.co.jp>
 <20261021042229.2280937-11-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 04:33:30 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> A vNTB endpoint can place DMA resources after an MW in the same BAR.
> Limit the MW to the advertised boundary so clients cannot overwrite
> those resources.
>=20
> Advertise this support in LINK_UP, including when DMA is unavailable.
> Older endpoints ignore the argument.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021042229.2280=
937-1-den@valinux.co.jp?part=3D10

