Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1953E49F6
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035633; cv=none; b=WYnIUocHCBM9+fS0WAxcHNxw1CQQcnvctthQN2Q2BkaPIDW0SpaiOlEICA0UZgUqioUsiclNR/Jl+2hiAHj1kmR6P6qLhWXT5mlp3agwdACxKbI8hH7tT87eq4wnTENpZvEazVJ97+FYQXpvMUCtv/8nJck082aSYXEkX5mrrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035633; c=relaxed/simple;
	bh=E63OeAfIyRPeL4dG2lmWdBURavHr0ZikevFaQ/KAijQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=NLrpUNhnNXUpUCwfmB6/qO4MkBMj6MvYb3qzQUhWBYeWxdm6kMCeJdD8MjzCdccZMjxqGyloVUeA1/zDqgH3FA/EhL/t9EX96gmCCp9C+1x/ixMGQ1bMwcGlomQRsYULSr/kNe+aklujDjoostQ0YEnoHas+aiiMwIXO5HrjLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iP876fNi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iP876fNi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B211F000C4;
	Thu, 15 Oct 2026 03:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035626;
	bh=E63OeAfIyRPeL4dG2lmWdBURavHr0ZikevFaQ/KAijQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iP876fNig4fHivcor7kCoyy0v7th1KGRecX/RaRqD9LL0Pvw6B7z9BxHl6EhyCjcR
	 iG4Yhj8ItdMbJ8rXkfSynJcigi8G6cKg2JTBMxOIerLcPiSco72EmFyeA6nUyRhvXe
	 YTNAY2X7bDcaiaAZQA7UMU+h46bF5Mokwz1oOORNaJY5iZnqr2pQRaxa00TWhAFac6
	 Xxu2w24gTJAa5qwKf/Y6KHemY9g93UwlMmeE811xg33F2MJV6aq1f1uq5tulf/lE9U
	 7VqTJoEWcPr27pRWqgOo4tDTZdsqrwa48I7fveIOGWu0W0TGi6kjQrOQp51FPqUpug
	 NJBwqA/arDItQ==
Message-ID: <sashiko-outbox-172210@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/18] arm64: dts: renesas: r8a779f0: Describe the
 PCIe AER interrupts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-17-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-17-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:40:25 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The PCIe controllers report Root Port AER notifications through
> intreq_pci0_lperr (SPI 421) and intreq_pci1_lperr (SPI 428),
> respectively, separately from the integrated MSI receiver interrupts.
> Describe these interrupts with the "aer" name so the controller driver
> can use them for Root Port error reporting.
>=20
> Append the new interrupts to preserve the existing interrupt indices.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D16

