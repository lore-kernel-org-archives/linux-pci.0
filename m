Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB04191;
	Mon, 29 Jun 2026 22:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782771418; cv=none; b=NqcXKgTk8mUJAWapWerGSP4vufb0twsu5sgbh/TMkJXI8l8VmeZKoYRnrMYa+Jv96LUQkdWOHMVSS8S3alVU7SU/lkxXcE0O7wT8kF1HDzgwMJbW0Muckn4LfEf+7oqF6HzepkUcz55yD9ZQU6rBNjdP9QbJ1WlkklsJt10dOUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782771418; c=relaxed/simple;
	bh=AGfMJBMByvaNwcIcdNYaRh/QI4GMZznW+k/lnUDsEFk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=el8P9pz0/5FHkRPGBcXD5Isa2rx19vzMCKp94hTafb+RK0fYJ/DqhOf2IsxQAkDOBlHqUe7C3t8+43IeYcDVcv3vOvUlU84qzyhu/6u2yDe6Oxnlm5FuuLTFG5oo6EakPn2FkgvUbiJoeyr3ATml/4B4D/5MU8QJI0kHuZdJ/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEVZ9hZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEVZ9hZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902A11F000E9;
	Mon, 29 Jun 2026 22:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782771416;
	bh=AGfMJBMByvaNwcIcdNYaRh/QI4GMZznW+k/lnUDsEFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TEVZ9hZB/zMTZl+tvYGbn0J1nlbQ+P+QgSrgwaXOMXYqbLVOeBBLMXlV7Z3+A1hfL
	 54l/UE0M9KxMpAbli0Vz7rHab9LWeHpmFYcFcTBPpiBK+Yihko4HNPKt0+RTVUNy6q
	 z8EftgCqEbpr2oUTS33b0GfU72SvigDTM9XWj3BTaMIwx5OLxxP049Aoe5PCNBRMg7
	 JRKGox86TVvzUQ0ow9qEkUhb5uzYjjl1xsYAUHhsYsEOXUfKSuJ6R8l36h7pxyGfsx
	 r6//SxdRzoz+s68OssuN1TbLLmY7+iCXNBJSOBvqeF+FcW1DGXqyu5Mmoe4BkDwWjT
	 Ex/nCdHM/ogSg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
Reply-To: sashiko-reviews@lists.linux.dev
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, robh@kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260629220932.861445-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629220932.861445-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20260629220932.861445-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 22:16:56 +0000
Message-Id: <20260629221656.902A11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> Add support for the RZ/V2H(P) SoC PCIe controllers to the rzg3s-host
> driver.
>=20
> The RZ/V2H(P) SoC features two independent PCIe controllers that share
> four physical lanes. The hardware supports two configuration modes:
> single x4 mode where the first controller uses all four lanes, or dual
> x2 mode where both controllers use two lanes each.
>=20
> Introduce a setup_lanes() function pointer to configure the PCIe lanes
> based on the hardware instance. Implement rzv2h_pcie_setup_lanes() to
> detect the configuration at boot time and program the lane mode via the
> system controller.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629220932.8614=
45-1-prabhakar.mahadev-lad.rj@bp.renesas.com?part=3D4

