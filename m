Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC71929405;
	Wed,  8 Jul 2026 04:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783483854; cv=none; b=ft1OtgvbWPQHkAEEtHMkqYk9RVCdCCFWsrC5KRnEha2nye+oZe6CTyCKE7TPv6DYyTAh5gwFFZIMmFbmvJyKMiW29n47uB4dMqsAmR/Um9uZ5CKkEIazEEggutYfpZ3HZWKftKAsUWDslg7tna6ajNd04OX2+Vq9bV3hwEQaA3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783483854; c=relaxed/simple;
	bh=9tTb+m7EW4BfsXyEqk9FwJhOreMGgj15jbP5+biAxJI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NFRXOjgAjS3HporiXPZaHpxfvOKWbmAbW4TWD76WIOxwtX9+B+ds4p9V9L33L9+En0t1yguk0DFuWuk5pRTVNaoDUCDNYMQGqwERjjGQc0HxYGphJU8Pd6Q0tUwWtX/e+JGIqqA7kuA8rrpdxBEZnPH6rJRFNKPpDwMqUwQe6gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKf6xpHb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKf6xpHb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F39C1F000E9;
	Wed,  8 Jul 2026 04:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783483853;
	bh=9tTb+m7EW4BfsXyEqk9FwJhOreMGgj15jbP5+biAxJI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dKf6xpHbiN0iUoBlOdTg8Z8di+wo6YfmclwLlFCtPfHmtm8FG28MqNgn9Y2Z73Afk
	 Z/wwillkRh3Oof3B4ZBC1fLjl/WCciMXa5rNXejRf/N0WjMldyzyCy5DsPhJjb3aDF
	 QvMzWL3KsMcYwmF3wpJNWvwajD+zBKgaOks7Rp0507b3zqNQaeM0afILwwuRgdUpMW
	 R2PovjkdNlQMwMx0NvYRvrcCzQwS1ADvEd76Lrhttb/tGUPYuleVzIf4T8kj1PvlC2
	 vvUbnJ+xgnfMtSKw/69MHgIzsDev85qfnfl7FdW8E0TmNMmTBLelQjn/N5NxVSCuun
	 6U0K+Tpj35uaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Update MPLLB bandwidth to improve i.MX95
 Gen3 PCIe stability
Reply-To: sashiko-reviews@lists.linux.dev
To: hongxing.zhu@oss.nxp.com
Cc: linux-pci@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
References: <20260708035928.580236-1-hongxing.zhu@oss.nxp.com>
 <20260708035928.580236-3-hongxing.zhu@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 04:10:52 +0000
Message-Id: <20260708041053.5F39C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Richard Zhu <hongxing.zhu@nxp.com>
>=20
> Bandwidth marginality was observed during i.MX95 Gen3 PCIe tests with
> the default MPLLB_BINDWIDTH value. This margin degradation worsens
> across voltage and temperature (VT) variations and different test
> matrices, potentially causing link stability issues.
>=20
> Testing with MPLLB_BINDWIDTH value of 140 (0x8c) shows significant
> improvement in bandwidth margins across all VT conditions and test
> scenarios.
>=20
> Implement PHY register write helper function and configure:
> - MPLLB_BW_OVRD_IN =3D 140 (0x8c) for improved bandwidth margin
> - MPLLB_BW_OVRD_EN to enable the override
>=20
> This ensures robust PCIe Gen3 performance across all operating
> conditions.
>=20
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708035928.5802=
36-3-hongxing.zhu@oss.nxp.com?part=3D1

