Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB91483BD1
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 06:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393059; cv=none; b=ZF3kMhBSs1ZEu9lRHC8/oYFlzah7QHu62KDL8awyWJzKPLkU6FwBUJRL8Lv06rLmoxqLwMsfc8AF/PodDqAjmaGf+ZIWpH2BElxR+NK0yuQNrUcPc0WqqeG12ixvSbuT9kRoEXIyfN/qkK65tAyBS+1p3zy12Rk7UXHMSzpKuWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393059; c=relaxed/simple;
	bh=KQdIk5wdZeUfJtvA6JuJYm/xQ1GNIGwJAEM5HGE2c4w=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=DP0yZurgmh2WoGj6aboF64CdGSxup5RQ6Cdj7pwvKRQCxV8VwVM6+CjNwlBZaeZ7yPMb1zgCCJMxkjoyrXSsFzS6fZ6fAMaE0YI4BHcaDsaeNSQvyrmK/kp7CzH2LUPaQxI1IDb5nyUmL4awcVPZ155YBuZsf3F+GI2EobuWQ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0MRKIUU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0MRKIUU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB451F000C4;
	Mon, 19 Oct 2026 06:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393058;
	bh=KQdIk5wdZeUfJtvA6JuJYm/xQ1GNIGwJAEM5HGE2c4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=E0MRKIUUUWySgOTYwifkgn2WhC4WLNyH9WBQwbSnFn8Yc0RKnQykOtGm5xpGIYYTU
	 MAq5gPpwKn8iYwicSgeiER4RQA4tHq2yrv7R/kPE9rxAmRyfkUmMgl4QRsaiUYMDtI
	 p9lFFvMg8lVDvOqus+3tBGgVnCFJmMyW4Wck4YO5LAEs7uxUeVLLtilf3u/jzWR626
	 mNViU9oHHY5YGp2VDVPN8XF/nKs/aDLKKVgr0tYTfUqORELliYk+MwKgjdOSm6nqci
	 bcZ8H0qhIonLlFFtxCpLRzRpW32d4Si/DSmRSrK6AE8H/XlIzwbaOxNEK9hwpaGLgw
	 ZdT9tu69a5Qug==
Message-ID: <sashiko-outbox-176724@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/14] PCI: rzg3s-host: Follow hardware manual
 clock/reset initialization order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-2-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-2-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 06:57:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The RZ/G3S PCIe hardware manual specifies that the clocks must be enabled
> before the reset signals are deasserted during initialization.
>=20
> Follow this sequence in the probe(), suspend(), and resume() paths to
> match the hardware requirements and avoid potential issues.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D1

