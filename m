Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A8E3BB694;
	Tue,  6 Oct 2026 08:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276890; cv=none; b=KmB8DqizWO59y/SDXtdh9kR84hFC5X/LT7fEy7fWNWI5TtPaalOPT30zv9PjA1wT41d6rO8SPFpJlQQKuEYKdXNVhB/K2Vzojr9HuHJMx/HDXaGR1CQ0HqXvEWd3+mtTmsRGl3uV8OEdRnnIsiS8Yz+O4HTTO1bhQITH71x0SpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276890; c=relaxed/simple;
	bh=3/NnPRuPkyeqs6ofN5Co+JJho2CU510tBGpJ2KYPIIE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nI7tlBysH+McZ+SgBkAxztljDSEBLHwDbmPzX0nUrbJjRhFaHr28Vn0Zyl2Itd1yzHKgYLC1BI8FHVZVUgkkeOsi11fX1pL+2GZhpO38Q6Gg5RlnsNdYHS/IkBMtiPTC12Crd/ZED/X/i0TOJMlUDb5uzl4Gi2SXMNNI+Kl7eLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXouRmgx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXouRmgx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07E31F000FF;
	Tue,  6 Oct 2026 08:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276889;
	bh=3/NnPRuPkyeqs6ofN5Co+JJho2CU510tBGpJ2KYPIIE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QXouRmgxoxo+RSjp8EQt8zxk0iZp7NFoh5/D7Llka0Un2b3I1Ac1sbn+e88vilQAx
	 eRifpdP/mnFPxudLkH44JtlCC6DDgTdwRH0tnG+QWecLHrNJ9r9qbkBpbCPouiUoy8
	 YmISQbAcs+6kHmwyA5MAkBCkNnVyY7kIN5/k7Q5oYyKBBX0T8Mlgp2YhenmEuq30Hn
	 gAWYbn6PFHeuOLUBB/HcGiQRZBVhQHSaoyUdXjd1pcig/gTvURETvFCdDtv8vWbJ/I
	 CI9VtlUNrMSXdyTQTzo3OA6I+4M7mHMlnMpYBhWVtgCbdf27Zq7B/UUduCJj8S0Kru
	 ybDgQ26AuKVBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 07/18] PCI: rcar-gen4: Assert resets when Gen5 SoC
 PHY initialization fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: conor+dt@kernel.org, robh@kernel.org, devicetree@vger.kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20261006084638.3821710-8-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-8-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:54:48 +0000
Message-Id: <20261006085448.B07E31F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D7

