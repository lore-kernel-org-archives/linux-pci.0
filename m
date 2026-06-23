Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3008230595C;
	Tue, 23 Jun 2026 03:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782186133; cv=none; b=EpvKk1RluR+0FLfHDH5NvdPJQEt0itE32h0HtDfErnFd76EL5qSa1Aob2hYeYQY1UxSAE0o8ezDB3hD/bQTqfvewQOOPDpiEXMYRymKLW+kM9cwdRzNTeODcaC3VqWtxrnx7c5wKkF39lEflxVyOJV8N74blcQSmIkaGx8AQe1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782186133; c=relaxed/simple;
	bh=Mp54zDqAz90ogy0zgw6hAaAAYKP1jgzBHLvW7iVNz64=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xiepmx+pajQ4J92F6jrooB7Tp3d5XK5dmvvNHB3YdREsOdymP2+7B7Np0NTlU7PQHyBRQbFlX6YgOyvC+nE4aaihn5qKEkFZRV1NOdoDN745fBCDHiJA01C553DX6jT3dd/N4YpPopHzpFM3W4EaNLikeaGRCUIUdiUNYKK9QAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0J7UxnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0J7UxnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDD21F000E9;
	Tue, 23 Jun 2026 03:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782186131;
	bh=Mp54zDqAz90ogy0zgw6hAaAAYKP1jgzBHLvW7iVNz64=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k0J7UxnX0goIGSeL41RXOHHIQjvFK5OKYBVSssvbU6682RJO3c3X8paXmQzN9s8k8
	 UFz/XJZiVcyAKNbOch4i52m5WjYo1jOnV3lQg6LCNZi+0eQcbJGZQLAHj24zyUbs/9
	 GnyQv2H/8a4IH2Bv3eRXUghAHsrGeZMVqH4dzZKyEvBXJFeRcVmQgNLyIicziKgzmU
	 +MFBTreiTVUimnoew/RNLYGYhkOO34P4yQ9vuIIue7yT1RMqWDRnLrrHST1lGIZ9ZY
	 qe3G5hDb4mBAD1Mq8CeawD8Nh3J8Az1sqFfPZb1l4HIvXW9Y68WwmunBbYTLP6WAeM
	 qBpVQUgDzgZdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/11] cxl: Split decoder programming into a reusable
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260623032453.3404772-2-smadhavan@nvidia.com>
References: <20260623032453.3404772-1-smadhavan@nvidia.com>
 <20260623032453.3404772-2-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 03:42:11 +0000
Message-Id: <20260623034211.9FDD21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common HDM decoder settings to include/cxl/cxl.h and route the
> register programming sequence through cxl_commit(). This lets reset code
> restore cached HDM state without depending on private cxl_core types while
> keeping hdm.c in charge of the existing commit policy checks.
>=20
> Build the low-level HDM helper under CONFIG_CXL_HDM so it is available ev=
en
> when cxl_core is modular.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623032453.3404=
772-1-smadhavan@nvidia.com?part=3D1

