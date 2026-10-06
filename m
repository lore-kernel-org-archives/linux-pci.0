Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15AD3BBA01;
	Tue,  6 Oct 2026 08:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791276697; cv=none; b=sVX5vEkl52tNE1YTPF2kEnBgdobSje+XwcdgsYNtFjGlMjmO6GahG4A2lE5zoKe9MFzm/EPYzR0vyo8IsizicrKZ+rDqetZXzwpwob3QA+4YSLWKQtKfUyLGJo1U4K4VwQxwXYTMhsf/klEXRrst8nj2RKTIHKMFRlUbhw1De1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791276697; c=relaxed/simple;
	bh=gQv66e+Onm1n14Q5LxLD2h10vkFa/Yz69PR19g5Iv0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GXdVJLpp5c4zyYBZpK/NCRo9tlI0tH//65AMKr+hV3qREQlBJmI88kw1KiBPJdaJFpednsyDBgn57Kef1e0fdGGvsCEHY1XAW6m9D5VKfcdArwXV5XCeoEtztwPTAoQdOkzflpCsFcnFflRHniK5Krv64XlJqJ+8NdRhV30rPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llcjtPHE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llcjtPHE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1305A1F000FF;
	Tue,  6 Oct 2026 08:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791276696;
	bh=gQv66e+Onm1n14Q5LxLD2h10vkFa/Yz69PR19g5Iv0c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=llcjtPHEVkbuIaz/fNfGaQfe7zh2muptpeB8T9y1W/y7+tY1Y/QdXZVaonr0wAkFS
	 PV8FvlKTyZjiM4TPx6GAV0SzsQQplHneeX4uX7/9lSAYU1l3keF7nG7mPYO4PoO0cy
	 rqPxAUw6B2ZUaELImJLs2a0eWhRjqG5/F9l0lJgZHmCDk6LS7q5Xhb3eMeEhd9PoAp
	 /h93yz4JcFQcK1tMEXb6lwV7BHXu9yGM2j8VaIkxgaSYeE1JqRcj7qKDVsFHy+S9Ti
	 nau13zwLUKUY0W/NcZzh+Ivi44KjVpWpMcBV/suGhftuvNEyKI5e7nm8nrYig+xMNM
	 Djjb92pPBtLzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 06/18] PCI: rcar-gen4: Move deinitialization helpers
 before SoC initialization
Reply-To: sashiko-reviews@lists.linux.dev
To: "Koichiro Den" <den@valinux.co.jp>
Cc: robh@kernel.org, wsa+renesas@sang-engineering.com, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <20261006084638.3821710-7-den@valinux.co.jp>
References: <20261006084638.3821710-1-den@valinux.co.jp>
 <20261006084638.3821710-7-den@valinux.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 08:51:35 +0000
Message-Id: <20261006085136.1305A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Move common_deinit() next to common_init(), ahead of
> rcar_gen5_pcie_init(), which will call it when PHY initialization fails.
> Place rcar_gen5_pcie_deinit() before rcar_gen5_pcie_init() as well.
>=20
> Keep these moves separate from the following initialization refactoring
> to make that patch easier to review. The function bodies are unchanged.
>=20
> No functional changes.
>=20
> Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006084638.3821=
710-1-den@valinux.co.jp?part=3D6

