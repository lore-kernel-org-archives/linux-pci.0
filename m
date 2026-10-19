Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00943603DB
	for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2026 07:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393427; cv=none; b=Dh1jxcq02AWmibvc/YQ12WNfCVLLifBdOuCaaHVBifIA+Fa4rOULWEW9hhj2TdCjRMXnz40/W0NkzAMIV/zxNKpCC4newirEK28WEN95q4hXyr9etAKTEwbZgeiyWJvm0+QD50XGePCSKlLtVQ+TALivsdNBtiGld3Yd/v0UHAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393427; c=relaxed/simple;
	bh=S5IJu1+O+Ol68fMZO5ZutzH2M6XzwmgVeYKeofv9Xm8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=nzcJArox4k+CjdVUvMjmvh8jjEpes4C0bbV0aoNUHcEh1wysbnHvUAbqFj2/VzehOs7aC+RT/qXFAAk8+OOcA0LyxN/9SouBABTcYWzBZ4vajE5IIaCtzwDr4mVR8TnuHfRvqGkNtKk5Ugr1bFn8g5lWrng7Clc3Nyrju+wd+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bu5ijm/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bu5ijm/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723521F000C4;
	Mon, 19 Oct 2026 07:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792393426;
	bh=S5IJu1+O+Ol68fMZO5ZutzH2M6XzwmgVeYKeofv9Xm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bu5ijm/VTlWxh9hneWL5hL98VWck5vN1r0icaSIgcsgqczeshgwu2h25LzZ/iD69+
	 0Gb60je2GV56yPznI7N/L/qGuHYWprFAVbyvmZA8qbV5MEK2Nig2ptn4M3QdwKJplY
	 O1sI5/n4K2T8Aim3CXaw/Tono3TyWPKwzJP8MdZJ5e22+jiGPtJBO+Ci9Q9qY0z6+9
	 +dvuHNGwBAOK6z70SzZAMZjb9ljdUqrVWN2D3cWHdsYvR97kuhHussEqqfhhfMbj0y
	 U19eDg05oGSgOIea/0N4QSnS1t4cGYl0Z1Q0wvBINmycFHOIdgXq7o3VYZVDe/H4WS
	 4gLInCxs9aNxg==
Message-ID: <sashiko-outbox-176729@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] PCI: rzg3s-host: Initialize the IRQ domains
 after the IRQs are masked
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261019065025.2146539-6-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
 <20261019065025.2146539-6-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 07:03:45 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The IRQ domain initialization requests the interrupts and installs the
> chained handlers before rzg3s_pcie_irq_init() masks the controller
> interrupt sources. An interrupt left enabled (e.g. by the bootloader,
> or latched from a previous controller state) could therefore fire
> before the controller initialization is complete and be handled on
> half-initialized state.
>=20
> Move the IRQ domain initialization after rzg3s_pcie_irq_init(), so that
> all the interrupt sources are masked by the time the handlers are
> installed.
>=20
> Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019065025.2146=
539-1-claudiu.beznea@kernel.org?part=3D5

