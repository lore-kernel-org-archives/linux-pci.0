Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150177;
	b=uaWRNZhcDvHXml2+PfXzr+Miw8UCegBvNJyfdFigmOLGsiQo6DCklE4P0hpE2wLD/j2P
	 RUEUjJKfdSoVmM9GSi1wk+OX+9eVPuV+6XA9SZrEY1upGxuOWXejG+8g8FCRii81Y0sQw
	 zKdviR/xBoL6hg3i/P2ji9wcK7whPPVNBYC5JPhUYX0eD/wcELES48G1Ap9/GC8hoLQ7J
	 QFmDCRys0jvPHug+OCZzN60r/WDqoAuC+iTdVAHfvziEg3cDYyc1YF+SGBxRG81hzi4od
	 IyVulnUfrLrcjNTU6rEqDy+dILkGfIciJmM4fGMn+z3TtREjsIekNnqi75178zBpIwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150177;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sVPF3gGPob4kD3jsBsrJOx1+G/ZuqRrWeTKpXtar4R0=;
	b=u3IEyHoqdSlFJewAunwrMbyjvAsq1J3l06/Q+VKXN5IHIW3UKvZ14XSAUr6wdukxVPqk
	 eBjrR7PWR11DN/cwsuDJwGeSuEsrfsqnWPQAWKBXivoOTXBZz8g0FocJ0Yp6cEgJBzF9t
	 wEUmB9+rTHd6lKfUAixRb7Fn+4MmgP4P+ndLFOCjsUmteeVa13w9mkJCQQ6WIUdPSsDMJ
	 /M2zDde2lQJZp1jP06oopBvI/vopIq7snNhgNuEM9QUfODxrnS5YEw+eEJlzSNaaPJfen
	 NZtiONSZwSMejWJU7w4nnILYthPJw3ek+lHM547wF7Qs1wUjUS/M2kKvPYl4xo7Uyeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bwx8Md3c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855360A2604
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 04:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bwx8Md3c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91481F000C4;
	Fri, 20 Nov 2026 04:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795150176;
	bh=sVPF3gGPob4kD3jsBsrJOx1+G/ZuqRrWeTKpXtar4R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bwx8Md3ca7fUecWJB2O4vwjXr/AqLJ9epE0GaweB2hkZSM5fZwvkX3b1KmN8wXsZT
	 oXJ5V+Q/2c5gVpyTvo4Yya6VAu7585PM0Uw35A7QyawXF4+s5E4AjzTOz3UJkbDxZ1
	 JvmRjfiQRrcpPBOMffUKcLEKipSOoktP3qIk4VLgtazw64MqmC8JKSt5rlE1iD58tc
	 shL9hXACVjWPPZ9LoQnOCAVezhXRqc4sVcg67GLL61Djq9KXaLUJfo/kHpgchfDh5Y
	 rshk3gqIlj0ANTf+XfjJbLlnb2JjOkB1SbkurfTA980AOk2a3hRGuszbSdweZ833zL
	 QKR4WRwRF+7hQ==
Message-ID: <sashiko-outbox-224475@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] gpu: nova-core: falcon: factor out the BROM and
 BOOTVEC programming
Reply-To: sashiko-reviews@lists.linux.dev
To: "John Hubbard" <jhubbard@nvidia.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261120044704.165223-4-jhubbard@nvidia.com>
References: <20261120044704.165223-1-jhubbard@nvidia.com>
 <20261120044704.165223-4-jhubbard@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 04:49:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The r000 boot protocol requires the driver to program the BROM registers
> and the BOOTVEC register of the GSP falcon for a binary that GSP-RM has
> placed in the framebuffer, as the PIO and DMA load paths already do for
> a firmware image.
>=20
> In order to make the programming available to a caller that has no
> firmware image, factor it out of the two load paths, into a falcon
> method that receives the BROM parameters and the boot address.
>=20
> No functional changes.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120044704.1652=
23-1-jhubbard@nvidia.com?part=3D3

