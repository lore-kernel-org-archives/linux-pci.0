Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4C53191D6;
	Mon, 28 Sep 2026 01:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559593; cv=none; b=VOyu1fZYANkSfw209/E9VsFhHvuYDRX1aAlwmyg84wFH46tlSxkcC9rsyRZDJup4pgcv5ukv0eJYDqwoweaD5rhqA7/FUXLzBZEhWR9srQLZOwvU92urUuoaZf1VwKBuXbLKkIKk3fsWB2Cb6wVL+mMX7KXng9Z+gnmFKqwuu2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559593; c=relaxed/simple;
	bh=bLaUlaJY2QA1XdUwMIT3rbOwJYyLdJpMK5RxdmfSb38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YHDHmpo3xPZUecjCb2ppOVvRWQXtG8xb11abFW4phJ6Q/RwX1FD9RuPzjo43TaRY1yFoppJloE02qewxdMWYf01qj8VzdUfurfoHYdENRnPFSTanmEJTV7maywq4DX02dH1xntZaySfcdxdwZypGSIqyyUuToFoTibJ54cncWUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CtdjY9yy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CtdjY9yy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489211F000FF;
	Mon, 28 Sep 2026 01:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559591;
	bh=bLaUlaJY2QA1XdUwMIT3rbOwJYyLdJpMK5RxdmfSb38=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CtdjY9yytqDBfhEY8d+pqmTsUGhyeib5ad1TK6l04lySOKkKjchbnWHIMXDZfDvU1
	 Ya8DH06vF7m1gHbJS4/laWX/tyNCbb3XwsGeZr4eDrFYYsivREpbNON4+75GLzpGNe
	 VTKLDsdTfnt7Jm003Y7vxfF4kovU8F1MZchb4Co3ghe9ofHsZkM0Jf/vdBa79Sk9no
	 A0JujMbNQNXaiBJH/27vHiI2NMLpv4jh2Pf+lNT6k9MCvodIjAmUXq8SNXgA7/nq29
	 JaZvIrHU0MVi5DOhR8lQENy3kuB/QWJLfmpQJguK39n2gPsj34udflJNgeODDpuFEG
	 0TiaHHTva4SRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/22] X.509: Make certificate parser public
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260928011123.450800-6-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-6-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:39:50 +0000
Message-Id: <20260928013951.489211F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lukas Wunner <lukas@wunner.de>
>=20
> The upcoming support for PCI device authentication with CMA-SPDM
> (PCIe r6.1 sec 6.31) requires validating the Subject Alternative Name
> in X.509 certificates.
>=20
> High-level functions for X.509 parsing such as key_create_or_update()
> throw away the internal, low-level struct x509_certificate after
> extracting the struct public_key and public_key_signature from it.
> The Subject Alternative Name is thus inaccessible when using those
> functions.
>=20
> Afford CMA-SPDM access to the Subject Alternative Name by making struct
> x509_certificate public, together with the functions for parsing an
> X.509 certificate into such a struct and freeing such a struct.
>=20
> No functional change intended.
>=20
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D5

