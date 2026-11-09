Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794258870;
	b=Q4zDf4vTPoFYkOfwRY10IG4QzhNFKyrEoNUfOGVCkszNt5tJNG2d1eEOkobGAdGO4SmA
	 DoxoykxVluuo15pMIkruC7TFSjSfKyFVqvY7+wWnei0ePip2KexKtkMOCWAwMoId0YYEm
	 x7mIvE9/2O1P2KjJt8VWKVOwiVwrH+gVMxEDq7+R3S3b/vB8o5rLgXkJFiWCYKk9AZR2m
	 eNfwRaOI0Re1n7RPgrUyiJEkeNpoZoQdVa/7Fvccu6vYG9DfaFkZZsPbegVg8jcvjzmLW
	 pdRKp5SmKYz/qnY2pezvPQparRPtAAI5570RhuUBdrf1gN/RAdQH8M+2+G+llRkbB9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794258870;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gR9BGbEtAvln5bYkYBSCTNsYgEWBZo6TfGYOVUxlauE=;
	b=Dja7Yf7Oqb6HgIAjaIMbnYgo6lVbQ7J5v5tmbgdAYJNWnfshxpAhe2YFRz+5gjfML8CU
	 pdkBQW73QbXZWO4FlFXFO4N6J4sB8z/E6d4+7gq/pRGcIwgYYZWCRAIy2j84fto5+/tk3
	 XyjDdQ0RTY/cjj9sREG4eRC1KLs460FaYBmNVBFP6XPVB1avwEDkA+V3gdO3WJogy4Kt/
	 vfZ6n6RcH2OnZMR6xYWWW+LDgFxWmJty6Nx43cDqCiFDOMZJmqv4MVtaoezMkIMnLwIon
	 fcTVYlBOWnddajAW9mSxnql1yNgdN7Vqfffjz0EKlEAz31cqbDFGtRCQG6NzOx+pVlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6aR5GYZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133E7606A325
	for <linux-pci@vger.kernel.org>; Mon,  9 Nov 2026 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b6aR5GYZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D9441F0089F;
	Mon,  9 Nov 2026 21:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794258869;
	bh=gR9BGbEtAvln5bYkYBSCTNsYgEWBZo6TfGYOVUxlauE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=b6aR5GYZqr4nY8wgnxJn3U6zQSgcsIbhmc15OHxqLw3cgr/IIm7hzWFHz7jHXHzNq
	 wPR0l+VLeZ8jyUnzLfUPRZ0flR6gT6np48MTaJfnGi/3YNr78Z3mJ4/GQ+JajkdqXc
	 Si/dKjUqJu2A7eTWPROeB1HQ9igTLdT0yrPj7AoswvCSbT/ahtGti5MRDr9oOP35/O
	 ry+8lYA8VQi4gBf2Qaw5R4WcYBPQBIhyRTTiebBz7raXGyVG2a+UMj4TVSMsWSMX5U
	 00W1wgUwSPQOwBA0sKDNuhQg6hn9yTzZ3tUv2DfqRmx9x2MTA+bLFnt5LQjUI4660V
	 f+B3GfCmdHJ+g==
Message-ID: <sashiko-outbox-205650@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/11] PCI: Move CardBus legacy mode quirk to
 setup-cardbus.c
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261109210714.3862-10-ilpo.jarvinen@linux.intel.com>
References: <20261109210714.3862-1-ilpo.jarvinen@linux.intel.com>
 <20261109210714.3862-10-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 21:14:28 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> quirk_cardbus_legacy() disables the legacy i82365 mode of CardBus
> bridges. It was originally applied even without CardBus support to keep
> the i82365 driver away from CardBus bridges, but that driver was removed
> by commit b3c26ea81ccc ("pcmcia: remove obsolete host controller
> drivers").
>=20
> CardBus bridges are no longer set up when CONFIG_CARDBUS is not set, so
> the quirk only matters with CARDBUS. Move it to setup-cardbus.c.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109210714.3862=
-1-ilpo.jarvinen@linux.intel.com?part=3D9

