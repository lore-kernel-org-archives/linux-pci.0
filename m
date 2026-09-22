Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22E43B2D10;
	Tue, 22 Sep 2026 08:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066834; cv=none; b=UWrCr79qphJHPYzwG+N64FcNG7jm+cHomdknEVG6nlUZ8S3eXjZUWCsF6ffaKC/dCTW6xNFkVyAxuKXchpcc1cr7YOZJVg0CdTs2NGmg9w8l2HKbvdazHLnbWJJx62bdpBfgPUCH0+edIq7muMd/EiY6TmpfpPGl1WLhi1z9PG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066834; c=relaxed/simple;
	bh=wCQP1lP3ptqp9HLbAd5KKvdS8+wQYS5O3VIJsH8kwXs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R6M7duU/OC/KKfQ9YQO1oErHu6p0z7YF5Q9atLoxWOK1TKtfYMBoq3i+g0mQWgEWNoPXSgYoTaDbPfgJRErxmBHMaC9t+TVHnx1E39zDDSycy1opHRl6B4svZo4txTcVDWGKIz1WV+8l3MvLekWHWSMwJxgtWyEMfQqp1IBFqU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ov20Ck+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ov20Ck+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118261F000FF;
	Tue, 22 Sep 2026 08:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790066833;
	bh=wCQP1lP3ptqp9HLbAd5KKvdS8+wQYS5O3VIJsH8kwXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ov20Ck+hTLINI6wHuSOThA5cxpTy/DwVIoHbMiibOvVOe+M8iRGKGMCDNolz+IJip
	 m2LuRZQyrhrRuMx6fYgsoX24UQ/MvSNQh8wziPQEf9V9DGYXjgZknZ23yVdzdDtYpK
	 NsymjeU/pgbyx6cOgL1xRbZk1aOlgrPpeRxNoeS7zHiOAUplyvhT9nVOyGM7DlO1BW
	 nBK/L66YV3P3V7G6cwOMpRZ6Pjep2grNb76AfMktjeQmcH+y9gyz+pukGwcDxkIVr9
	 3Rhhm1AaeIh6ZxMZ2adaG1rAa0Of0kYkCMjHp5eK8KlgoSYM+NRNCfUIXyO9fC6aUa
	 080pyFBS5O4fQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 02/15] cxl: Share CXL port upstream PCI device
 lookup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260922083924.2451158-3-smadhavan@nvidia.com>
References: <20260922083924.2451158-1-smadhavan@nvidia.com>
 <20260922083924.2451158-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 08:47:12 +0000
Message-Id: <20260922084713.118261F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> read_cdat_data() resolves a CXL port's upstream device to its backing PCI
> device. HDM cache updates need the same mapping.
>=20
> Factor the lookup into cxl_port_get_uport_pci_dev() and return a referenc=
ed
> PCI device to make caller ownership explicit.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922083924.2451=
158-1-smadhavan@nvidia.com?part=3D2

