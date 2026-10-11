Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7868123BCF7;
	Sun, 11 Oct 2026 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791685311; cv=none; b=bcyV2CTPEWe5Ms4xNLJIJ4+/3wJfNQSFLTtmfef9dnYLRFMKR0otarAJerzNREV9sB7U++OCgAR5PFaVqslPw+VtYXHKPX5ObRQsXXgQVzj3dVDHI0vGOg138P0oojO7N2xnBzYGSDVFFIwp/ZorYUp1YRf9Joecw8KBoaodfVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791685311; c=relaxed/simple;
	bh=6VzpkfwYEsZjhMZKnLmGkJY5QtnbmwfBwb0m99OKMdo=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=X6jrLZo7qM9z4KpqIyuTcj5vWPGrnHDjkrrB8PdNy5MRLmueimjA2rhSosoXGnOqEfCoqGZAc+uQaqRKrePFvvAwRUHkOCD6M8xcH1xU8JAtnpK219pxA6ikx9kBatS4xPwkCvccZJG7WssU0QFH9QN1Ohxp2NM09V4LlBixeSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbSGV1t1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbSGV1t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842C51F000FF;
	Sun, 11 Oct 2026 02:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791685309;
	bh=6VzpkfwYEsZjhMZKnLmGkJY5QtnbmwfBwb0m99OKMdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nbSGV1t1/P8BXNiht7EJ1NmiHJXyZgLtoaOscF6y6g3C9gmLFyZ7QLd0PsrBbqoPU
	 6UIxiDeaVhJRNQJo0W43Ejb4Fo6/yp885tGKnIL7RdoaQU4K6v9+BttCU6Pi55OoiY
	 nydGBs+q0TmWLFPZhyi2p/u55VPI/ravLDWQXGkUIKu4tdyL/iebmjmUdWWytmcIH+
	 E+dHdct5OIUB+sbn3Ua4pwbMpHLsbnklrz+GRE0F2/8dwUlBB1O8AQYSVBmIhsCzE2
	 2D53iZo8QSSWhyoF3+Y6KR7S5l7zR9/PhEc2T6IdROMtPAnZHDXRLvK/DtURfxK5rV
	 O8bTf0cOw1New==
Message-ID: <sashiko-outbox-166970@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 06/16] cxl: Move HDM decoder helpers to built-in
 code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261011021422.3428136-7-smadhavan@nvidia.com>
References: <20261011021422.3428136-1-smadhavan@nvidia.com>
 <20261011021422.3428136-7-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 02:21:49 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCI core will restore HDM decoders after a reset, possibly while no
> CXL driver is loaded, so it cannot call into cxl_core.
>=20
> Move the HDM register programming helpers from hdm.c to hdm_regs.c and
> build that file into the kernel whenever CXL_BUS is enabled, including
> when CXL_BUS is modular. Export only the symbols that cxl_core uses.
>=20
> Keep the DPA lock assertion in the normal decoder programming caller so
> the register helpers do not depend on cxl_rwsem. Leave cxl_rwsem in
> cxl_core until built-in cache management needs it.
>=20
> Link: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/co=
mmit/?id=3De0b476ea99567fb5aa416eac0cf61bca20724880
> Suggested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011021422.3428=
136-1-smadhavan@nvidia.com?part=3D6

