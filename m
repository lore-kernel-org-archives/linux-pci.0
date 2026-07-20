Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F023C109B
	for <linux-pci@vger.kernel.org>; Mon, 20 Jul 2026 21:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784581822; cv=none; b=cvSYqENCu7ElkszCHpfTgBZxPOtxSpGlqbGCnH8MR2Vchp9AUjiKnPQkUKvkW1Cn3hyA4s7X9SF4gpffriGhHA9PxDOgvndVJdIboVh0zbfCLG/h/6NtktyuTCxuLCOcfo2XShOmW8JYokXRv5SxLwSgSRPQRC30WYHO41MjYRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784581822; c=relaxed/simple;
	bh=uGFWSzZh+cXK98fJ7pmbk/TN5g10xMMwM9FEPbTbobk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kMJpM8VY3PpiwOzmWAGu46zNFI7C1XadBlmpOmbgtVlxZmv806b3OFesbP5BjTbVASkkDmj2Nfrh3+QwGWpPqc5V5slCDlJUcuKkAPSCRAZkjp4lKkz2sPNPGVFKL8lhv8hVN4Cu7aXgPQT8xra2ivJaWtzvz6EWipffaJaLWKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jhTxsZab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jhTxsZab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF76C1F000E9;
	Mon, 20 Jul 2026 21:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784581820;
	bh=Ch2ZUllGfIG5PLm4aNhFMjs2OWoZ/cKcG4Ccq57HGeU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jhTxsZabPXFvBb7JI2iBz9iAP9Llr5SETAmBhtzITfGP+NB31H+63CjA25j2r5t1v
	 Ow/xkWwHykvEjWUyxbHMv4SrCWLrVbHOqD97pmdq+PFQ3PthieSy1Q1RyPSoj/6iGr
	 2QSjshqLdCSqx1U75UynZYMl5gYqHhKB9PARLT0bArmyIMpnJj52wH79rfb9IqhPNd
	 y0XHQglelvaZ7Y9/1Ji+kdmwcE7PF7iv7aVq/B5g1r/e+Wmku+trohK015W5SPeQ30
	 dMt0EHC4zDxQJCgxY4OTAMgdtgJdD9TAouUK6SLyr0fWeigYdWV9PB+q5lGfaRED4N
	 uDe9NzajBHdXg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: Use %pe format specifier to print error pointers
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260720210839.1507406-1-kwilczynski@kernel.org>
References: <20260720210839.1507406-1-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 21:10:20 +0000
Message-Id: <20260720211020.AF76C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Currently, several files in the PCI tree print error pointers using
> the %ld format specifier together with an explicit PTR_ERR()
> conversion, which prints the numeric errno value.
>=20
> Thus, at every affected call site, use the %pe format specifier, which
> exists specifically to print error pointers, and pass the error pointer
> directly.  With CONFIG_SYMBOLIC_ERRNAME enabled, this prints a symbolic
> error name such as -ENOMEM, falling back to the numeric errno value
> otherwise.  As such, the explicit PTR_ERR() conversion is no longer
> needed.
>=20
> No functional changes intended.
>=20
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720210839.1507=
406-1-kwilczynski@kernel.org?part=3D1

