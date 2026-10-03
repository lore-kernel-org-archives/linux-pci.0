Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB13AE191;
	Sat,  3 Oct 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791065379; cv=none; b=eUGD0Z5WUl4SXvt0E0OaC2NfyTwOnguzBbivtcNLmiAMSOxewv+RFqlUsu6y+l+pTaLoop+PDBEQBgCzKZbkszjH2zb4aMoYOg5aCxQWdKvg1ud/VhDuHZf3U7KivoBA3vQ3cwyjr4Fk5SsBi8stFU8vhrKC/ctQijv+uC/M9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791065379; c=relaxed/simple;
	bh=4RyUKCNSiC79Q0a1We/sN6p3O59aPxEYDUWmMAvwa6M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iM5lKHGpcysyuzomwzctmoluCMFW32Rc7HHVcFww3hmwigs43Eq/2hTY6N7EcuX/p9d1rVVf0+Sg64uR43GcQxSFiLvd30C2xfCcZPWQ+1bOzJK98+3ZgQceflAMQflCld7Xe3JLlC5ISNtygH7NMM9qEgEPs38gdIuenIaa+QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDEJO5Ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDEJO5Ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C6D1F0089B;
	Sat,  3 Oct 2026 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791065376;
	bh=4RyUKCNSiC79Q0a1We/sN6p3O59aPxEYDUWmMAvwa6M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EDEJO5BaeMAjn2tsMPuEC6cy0a0LU26ypsILXZIGrDm/AXlRlMO9ar7T0xL8bwPRn
	 iA2Cqgd13H7OcuL+5qW+nbl8KIcumqQ/FO3DEXapeL0pRRcl4ezgwsgFvahqsGP8xS
	 kPeDQoR8/h/ByzMEzdy+W4X2D6FVD9aOssSqolmyt8BASy0qPUNiXC4G4Id8ZaZvPN
	 vo7mRnWCWIiw+LfWouC4PixNVcjctv/XLJZK+/sxqZPeEDzBUO1bNuDQ/HHxXnDbdy
	 sVgN+NaXQXJ9dymmjn2nT551CCN8zJqoUNt3G5dtDZcAw9qbihDHwCkkKbW+JZQpVa
	 ZMuGOJSO8HE8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: rcar-gen4-pci-host: Replace sft_ce
 IRQ with AER IRQ on R-Car Gen5
Reply-To: sashiko-reviews@lists.linux.dev
To: "Marek Vasut" <marek.vasut+renesas@mailbox.org>
Cc: robh@kernel.org, conor+dt@kernel.org, wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
References: <20261003215710.792518-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 22:09:36 +0000
Message-Id: <20261003220936.85C6D1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> The R-Car Gen5 SoC PCIe4 controller does not have dedicated sft_ce IRQ.
> Make that interrupt conditionally available only on R-Car Gen4 SoC PCIe
> controller.
>=20
> The R-Car Gen5 SoC PCIe4 controller does have dedicated AER interrupt,
> include it from the beginning. R-Car Gen4 SoC PCIe controller also has
> an AER interrupt, but to retain binding backward compatibility, this
> interrupt is kept optional and added in a separate patchset.
>=20
> Fixes: 5b555a496160 ("dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car X5H=
 PCIe4 compatible")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261003215710.7925=
18-1-marek.vasut+renesas@mailbox.org?part=3D1

