Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BD2377EC3
	for <linux-pci@vger.kernel.org>; Thu, 15 Oct 2026 03:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792035525; cv=none; b=K7xq73P6bQcN2h0zcuJGmtBTRDnGtbf8+Pxff7JQ8OfSpQy8wCNq5PNFF3z3Tz4f4UBnROpk2opzG8grW8mg9LIK8NuxOKM5VrYJseWn9BW6UQz1LyFXRE4aZU1iY85LBnP6qccAdZgHzBh4N5+G2OTubePClrBkFPh3M6M2lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792035525; c=relaxed/simple;
	bh=wUXWnPa3+hOmXQkp4CWmfSak4XiHvIaExjzFwpGvrG8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=E0l/FArVDUfEPlxgQ6hPNmK8YEM83avGp1LLKWeRJajIkhCWdh/JUCi6QsmK0uS7YaGRUdnsQqpZRkdDymdYdpO7mhPanSOYSIdoKVy7ggE09PzU3C5f/Q9+zbpObo+GhmZ96JlMi5rF5w4VVlllmwZAaBfr1gFX5hR37udE75E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJC2pHO1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJC2pHO1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C1A1F000CC;
	Thu, 15 Oct 2026 03:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792035524;
	bh=wUXWnPa3+hOmXQkp4CWmfSak4XiHvIaExjzFwpGvrG8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lJC2pHO1hf+KssxLQ6ccRODQTE6J+8osyIiMrko3TY3vOSpzMkC76mWZ2pFXMaXDZ
	 9p39sZmsmlokl1pIhyDjQKoWmTWz4jhmHHiwvM/9tsgYK9fBunBcQqoJOLwYSEVuvM
	 jH4H/bnHEOTYh6TVAxgRwqucN2H7uGIJXj4P0HiPGMBtfEaq2TNMDlcdcL8IB79SPB
	 H6FwruYf4couO9b9cM77cMuInWX+2H5jeSj6rVfshcIlOBG66KEcksxfzhEMBsFwvQ
	 kRn4Hu0ktVU+NtnH/5roNH5FhCWM5yJGEDDh9hzKmkJyBdNEeQ8lMDebCS8Xn2gzsv
	 EbuwI7OVD/WZA==
Message-ID: <sashiko-outbox-172208@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/18] PCI: rcar-gen4: Assert resets when Gen5 SoC
 PHY initialization fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261015033103.3076869-8-den@valinux.co.jp>
References: <20261015033103.3076869-1-den@valinux.co.jp>
 <20261015033103.3076869-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 03:38:44 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> common_init() enables the clocks and deasserts the power and
> Application/Local resets before phy_init(). If phy_init() fails, the
> error path only disables the clocks, leaving those resets deasserted.
>=20
> Assert both resets before disabling the clocks to unwind the completed
> common initialization.
>=20
> Fixes: 3283c4db6009 ("PCI: rcar-gen4: Add support for R-Car X5H PCIe4")
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015033103.3076=
869-1-den@valinux.co.jp?part=3D7

