Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D019F3F39F9
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475522; cv=none; b=CSSZ9pwXRZNCGnAkC4DX83Z+c9VeL0OobyNkmYWY3HFW767Mk2cpXgMt0Ngt6pxBouUm8lI6SuIRSLpP2x6nBYbGFIVPBCIPWsrlDcXSUtUcQ62ovCk1xuq+PX5emL7hLg/jBQBEtWbSfYlGENMamM+m2j3ruWw9fo85GGw8i4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475522; c=relaxed/simple;
	bh=0Osr3VXerY32w6uKiUdxY7LofX41GJ0zuaLZNMGTP40=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JqRIKn2TXYdYxlgdZJUPgzp7kL4kBmwMob9y6EfmR1HUzZ22D56A7NUPvP1kPoBN+iJ5iPidADPIGPTAyvZxgnj/cvU56ChtHjXJNHow3DjMURUlv7yIeEDhbujP/886Gf+5v72AO6TvEhfVit3TyBLNmcN4Y3vM/7StiFU4UA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF1zxuvF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF1zxuvF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F7C1F000E9;
	Fri, 26 Jun 2026 12:05:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475521;
	bh=0Osr3VXerY32w6uKiUdxY7LofX41GJ0zuaLZNMGTP40=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bF1zxuvF34mJcgrMCZ13B6ET09AV4FELo0o5f1F2PnT6mpOCrJg6W0nFIldI0Bspk
	 +CaFyqWwCFKpJObs0Kk2oOo9pjAVjXT7PpGpMTgVPeZuQat6P3M6mMhRm8MXWLfUG4
	 L71M/zAtmrPcTjiqj9YpBAiR7aQwM51HHVeSI7zFdawuh12UxDg4l/4LE1WE6PiYUU
	 8GvgfsKemGR2EIQ2flHnvhOTzr9CZ9aommdP4EFpmGqxA8bEJF9FtL73WBgsZCHDVm
	 N6fPU/u2gzu0xnSmyqHID4DYCljBH51Ffvo7ogwL7erF/qGR+AO7gSA9bRn39AS70Y
	 OONmQGvvIUyQg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:05:20 +0000
Message-Id: <20260626120521.33F7C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Asahi Lina <lina@asahilina.net>
>=20
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>=20
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>=20
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D4

