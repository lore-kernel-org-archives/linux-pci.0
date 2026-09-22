Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E8B51CF76
	for <linux-pci@vger.kernel.org>; Tue, 22 Sep 2026 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110828; cv=none; b=WmK8dliXL0TWFLSB4umbVkyI85lNb26W94m+ApjTF6NHzXD0vX/26AiJjUKoGS5dEc3pOA/FZjzyujJaeEKCQwdCA/VPOjS1PyBWvBZK30a3IOQmv2YympmXrrqG+sS2G/n6ddPp21UrrBAN/o0TGs8ss8VAA4YzdC18Qgsx3OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110828; c=relaxed/simple;
	bh=GqGnXRrcaesIWlnat3cK/J1AEAt3444het0FqqIpi+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U8dejLRbq+lrCDUaMlL88mi6QccHC11fRT+Kt24aMUN7x+6V3Ej9tT+YqF7tksm3AB28G0d/LE1ia5Zd6UCBuupxy/JJ2Ac15KvG3RAKPlt1JsnsW/FI5euH2LD5IxP6pNzy2pvVC68UUzPjROcAOcNIdM5fzOx7B841LgUxdeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HPINlrxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HPINlrxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE5EA1F000FF;
	Tue, 22 Sep 2026 21:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790110821;
	bh=PPtlOaT1TYqAWGc3pAGOTBm2XVI4cSmQ+hEBcHpTn2I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPINlrxiZBsyGutOBRRQVDnL7DY+O8anEtT4ArEONGH1FcURdrF3t+XzdeBSD2Dii
	 dRvEfWz3XK6AKj8bLp1Jdtm9kaYmWR/3Vyknteg22MkolTYYClCn0BMLSUwzalZPRu
	 +Y1Ql8vMEgdIeGEjKGZt8ksjWyDv9OEIJ81vuQCQzLMYCZ9+sNVWKVv9HCWu14A8Ol
	 G32iUbqsPUiNZPZuVn+nxeLNGNzqY+YdYkWgTkcMA2vMPCntd65ah8NJZeisAi65ZX
	 ExdpvZXsHSMSOnRmR1/BxmH0Q2U9F79Y7HXMUgAj0gTc6uGsjlj9fdQ4GEW3LaJSV3
	 Dsyo3dgnMmYvw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 4/4] PCI: Centralize pci_aer_available() checking
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260922204548.3884906-5-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20260922204548.3884906-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20260922204548.3884906-5-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 21:00:21 +0000
Message-Id: <20260922210021.AE5EA1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> "pci=3Dnoaer" tells us not to use AER.  pci_aer_available() reports that,
> and it also reports the other cases where the OS cannot use AER at all,
> namely CONFIG_PCIEAER=3Dn and MSI being unavailable.
>=20
> Set host_bridge->native_aer from pci_aer_available() when we initialize
> the host bridge, so callers only have to look at native_aer and we do not
> have to test pci_aer_available() separately in each of them.
>=20
> Do this in pci_init_host_bridge() rather than in acpi_pci_root_create()
> so it also covers host bridges that are not described by ACPI and never
> reach acpi_pci_root_create().
>=20
> This subsumes the CONFIG_PCIEPORTBUS check for native_aer, since
> pci_aer_available() is false when CONFIG_PCIEAER=3Dn and PCIEAER depends =
on
> PCIEPORTBUS.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@l=
inux.intel.com>
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922204548.3884=
906-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D4

