Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716435E1A4
	for <linux-pci@vger.kernel.org>; Fri, 21 Aug 2026 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341674; cv=none; b=vAqVftiNikv7E1xodEB/+pJpLE9DSl5LyozInxp8O7wMAlsqgOsYqW/4V7SJDVL2OXvYBlkyldQmNuXEcDcDml1BHPpItlHIEz9ktEpgUOzLVZkElTBUyYuxH4CDttIo1lOSr1TUz/nuThQuGfy8Prx54NzKzYIshc0m6MMCJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341674; c=relaxed/simple;
	bh=hh3hUqw6n5PtGMW85XmmnPvwE33Ph1yr8opvPRdkv1Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ntoWr4J5R8q04Yd7cbCsSQD1P9hGR9NXmASyhoDtAF7MS/QCjkmodAAtiiA0P63aVleePEfgb37Z7dQtYVslSSQ093V2y6zOIZSyV4eKwdRzHy47MdFAmhEuITA1vgQ3cvHWVHsJyZjX9T/zNkW9REsi1/cL7HvMes8WPypvgeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk8skxXK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk8skxXK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D66F1F000E9;
	Fri, 21 Aug 2026 19:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341672;
	bh=hh3hUqw6n5PtGMW85XmmnPvwE33Ph1yr8opvPRdkv1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bk8skxXKQKt2ScUIip/ZT4M4CQoIOxH2Q7l/IVOEu74wDfvi6ExpaGZq5nNxU4VJP
	 ehKopBhSRy9cHvh3jrDSv5eATIVQW2w/i1nDx+q6cE4Ar+qAXS5mGTJdAzFFQErHv9
	 z4adxn2iVj/GxSNtRlCovP1YkHeR7rzPprWjPYyBDZkuYuK0E9hdcmWuNeLJG60sXA
	 4bPBdEA0V6ZJieqrfZHbhBoNIc3d15GbsR9tgLi/cyBWyx4VdvPGSJ6K1z/y8nH9bA
	 iC8VGx/MkdFezk5pdk3Q5kHRw4eSpoGSHJV7QRPLTwrHEXDx160M56kVMHKWfK0Nzp
	 XU1g1idl8+hdg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/18] PCI/P2PDMA: Gate the host bridge whitelist
 warning on verbose
Reply-To: sashiko-reviews@lists.linux.dev
To: "Leon Romanovsky" <leon@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
References: <20260821-fix-p2p-acs-v4-0-v4-0-94426b96de73@nvidia.com>
 <20260821-fix-p2p-acs-v4-0-v4-6-94426b96de73@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 19:47:52 +0000
Message-Id: <20260821194752.9D66F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Leon Romanovsky <leonro@nvidia.com>
>=20
> calc_map_type_and_dist() prints every other diagnostic under its verbose
> argument, but reaches the "Host bridge not in P2PDMA whitelist" warning
> through host_bridge_whitelist(), which it hands acs_redirects instead.
> A caller that asked for a silent answer still gets the warning whenever
> any port on the path has an ACS redirect bit set, the CPU is not
> whitelisted by cpu_supports_p2pdma(), and the host bridge is not in
> pci_p2pdma_whitelist[].
>=20
> pci_p2pmem_find_many() is such a caller. It sweeps every device with
> published p2pmem and asks for the distance to each client with
> verbose=3Dfalse, and pci_p2pdma_distance_many() recomputes rather than
> consulting the map_types cache, so the warning repeats on every sweep.
>=20
> [ ... ]
> which vendor and device would have to be added to the whitelist.
>=20
> Tested-by: Tushar Dave <tdave@nvidia.com>
> Fixes: d1b8dc09dd71 ("PCI/P2PDMA: Simplify distance calculation")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821-fix-p2p-ac=
s-v4-0-v4-0-94426b96de73@nvidia.com?part=3D6

