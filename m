Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793974252;
	b=jngj0WNgE7p4qLEwCQf62oGWeIhhi0j9CmJaR7oJqNUePvS8X4kfxGiU0UttlvvcW5Il
	 lSwmCcYYAcBunJ8jUlQ6I3X+3mGFMqAyz0n5//wgW3L+WB8CklSMb1RtxnyNyKuJCLv4I
	 Q5qQoA5pTXigzL6DtPQRuyZXWMWsD1G/2Nam65WI8CQHzGk9e0NK6WMhROD2yHzqvZgEB
	 e85OGVHBUCqa1iSUMBUjRgHmqq25KoGtXO7DHAG2Myad6lY+WRGptIXNz7pgvT0wo++wz
	 44kg9FqFy13R03yjLrgcHn2p1LBCaq+yD39SbeqOwVHhIwmo/G+7BntuMCyiFsmAqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793974252;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qA0O/vhjUACmlCRKTcDrxaSxG74QrIigHfeLqEfdudU=;
	b=y67kGBiOWOzsB0DrcFOrHDY1/PH63XWmbn85Inb4UIFktWYAyMD7lRp8TcTm9MqXXAYE
	 5c6x+hpPf1cYaN9wif/q3x5pJOHPVydufqTvXMCruyPAx8ShZrPetN9tlljemrryJKxFD
	 7oedUJu/PLWottZXcNjv0O+LFnbtxoNpzfN/epIdxZ/274FKmcNx646gjvF/E6E9FTgim
	 DKMvLGHxsYPJZvOnGVQLHWG9LA1/6TbIsDEngiXeVP5XJVH37BnXWeNacVv1x3k02oAZp
	 DHi2xFXE1vRZQ4QJ2RkFy7m/kswubZZLBlNEh7xnoC4Un0ZRtgaml4gX9S3ZtDgi2cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9QmUzQO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69554606D804
	for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2026 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9QmUzQO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2616C1F0089F;
	Fri,  6 Nov 2026 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793974252;
	bh=qA0O/vhjUACmlCRKTcDrxaSxG74QrIigHfeLqEfdudU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=H9QmUzQOCN1Jr4/xLLQ4UpTwNrXrnSuJPgQsz3Gj3BrN/EOofldFTu5JC17kIVCDJ
	 /TP702TqyqwahSrs3f5ALoaTRnFUlCpDTjfw9isI5053AjF//SNWvwq9S3DQDmYB79
	 yIBooIJTzH6oUtqnT5dW11UaJBUKbMc0U2CattB1Pmw+0uNkARTlTxV8y900av7bk/
	 84YoAWo3hk9a2kBswc7mxvFpds6tvrTWaCGxiDVHlbP3ej7PreQCD1CkaSAEpB/LmN
	 qNASygggNSsLMKAewceYGMmqscdWopkmUySTTBLqojz0jTDCFfLmkfHRoIpmGkXwDl
	 eCGuqtIGLbBJQ==
Message-ID: <sashiko-outbox-201543@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 04/14] PCI: Use __ffs64() for resource_size_t typed
 align
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261106134341.39493-5-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
 <20261106134341.39493-5-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:10:51 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> __ffs() inputs unsigned long. With some 32-bit configurations
> resource_size_t can be 64 bits wide while unsigned long is only 32 bits
> wide.
>=20
> To prevent value truncation, convert __ffs() to __ffs64() when the
> input is resource_size_t.
>=20
> In practice >=3D4GB resource align is required for the problem to
> manifest itself which might not be present on systems running 32-bit
> kernels so the problem has not been noticed.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106134341.3949=
3-1-ilpo.jarvinen@linux.intel.com?part=3D4

