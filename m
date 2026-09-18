Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBB3C8C52;
	Fri, 18 Sep 2026 03:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702044; cv=none; b=ohiTuH+5oytBTjCgYkEI0T20O94Bmwt0Qusm7GG+YwTzbeGIebSvaSGjWmdU3YCWsEpmaO4k7b4dqmKULwpAlxcbR/dCrPZxj9ZfijVUALVxsynC7CDNBktxTP3fACI14G4ym7rf5dQEHDLwc8krTfO8ZRfEbMarpCsmdj0vvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702044; c=relaxed/simple;
	bh=N8QQsG7WSXYtBaXG1kI/VEJthCyQBby/SBxZe/h0fAo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=encRTf+MLq0hrvv2N1OGus7LmXO5ERfZBFK2sy8XdXZ/qX/HIbjyElpPWLzGp7belFq6Nyafzmft7fJ6Uuy40HnLsa2mlmuPDZBhSq2FB4c9sQXBUmUyLrpIj7ywZ/L4CanusLXiWWSyn5NUiBFKMCItrwaIb0AVApjHLtNcrNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGcX2hS6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGcX2hS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5210D1F000FF;
	Fri, 18 Sep 2026 03:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789702041;
	bh=N8QQsG7WSXYtBaXG1kI/VEJthCyQBby/SBxZe/h0fAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XGcX2hS67AxMxyVvLTtH1ofCIKgG9ao34z6Zx2nlIhGfwYFQTyLEn0WcM7LbYnuXh
	 6Bu1X6y+SBnV9cxb/qoDe5PER1dz9iP1GhZDdJ/e9LrLqRFxbKEFb9MDJHMXBo1B/Q
	 0Hbz7tapaDjn30VDFfou5PZ2UyYJWBACkkOftG3fhXvCt8UrWk54Bk9fTHG9Okc6z0
	 WhJx1pyx6a49Ub/lgF3biSSSO/oNFaccNeT4lTWZ+4B17ytX1dSoge0n6aRmKbjsKq
	 avta6Ac23CjG2tfNWyZXNUkHRDlxuij+G7jkk89hDnbAcNklnrfsevvw20iWDUNKWu
	 dr486WiEjH2LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/11] PCI: rcar-gen4: Split reusable hardware
 initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260918032038.2216471-6-den@valinux.co.jp>
References: <20260918032038.2216471-1-den@valinux.co.jp>
 <20260918032038.2216471-6-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 03:27:21 +0000
Message-Id: <20260918032721.5210D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Prepare for Root Port recovery, which is going to reset and reinitialize
> the controller with the same sequence probe uses, minus the steps that
> must only run once.
>=20
> Move clock enabling out of rcar_gen4_pcie_common_init() into
> rcar_gen4_pcie_clk_enable(), so the power reset and mode setup in
> common_init() can be re-run with the clocks already on. Gating the
> clocks as well would add nothing: the "pwr" reset is the controller's
> cold reset (power_up_rst_n) and resets all PCIEC registers by itself.
>=20
> Split rcar_gen4_pcie_host_init() into rcar_gen4_pcie_host_hw_init(),
> the part Root Port reset will reuse, and a probe-only wrapper.
>=20
> The power reset is now asserted unconditionally, since recovery calls
> common_init() with the controller running. At probe the block is
> usually held in reset already, so this only adds a 1 ms wait there.
>=20
> Propagate reset-controller errors while at it.
>=20
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918032038.2216=
471-1-den@valinux.co.jp?part=3D5

