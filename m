Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793231505;
	b=aJ4muep4D3i9f6O9Z31TuVc1/tQKfK1e+WXWZuE+z1wWPU3o9ZumOc5Dg7eqRBqxhP+b
	 drkNixoRDzH9Yt+37ewDMLYhXmSjradxKYoboIAzl9zihiWvNZZbzCILNyF3Z4gC4a1KH
	 NChJx/Giv38+ryrQHK2wMNwqG9fs/2WAKGAkUnk5BW0H2NuqyaHLd/GqNbAbleFe+dRNI
	 GUb9itbbJSqkqcTbRITy/6mWrYL+8BMESBOlW0u4J+Xctkh2nIGzqdzJ2nA+YGmwP58DP
	 1oE7LNl8Cx+oHSCd4ZRGTdkseIZnjC7JG0fxn5FQhvGH1XV56LOES7L0T8kvTbJvz2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793231505;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jWFhUYZCHiWYiadn3ltcY+PPcUKcRLuYQQ29kTBH2cY=;
	b=3zV4HNEk7FFmYnJ4VA1LJBQfc8svA5LOHqbSzymR0eRp8OkOoI4Ze+ZlpwntzoMHscWf
	 uK2kKILqLHMz0RZeQT6KbqUfGbKlKuEjb6/yDI4thG/DpYZrEr/J6Ldq7ACTLBtoOB33b
	 wjTDFWL388OYzqOSGPvd67edL2/+vk+2J79qC1yWWu+t1B9nstyEe4Ez7uJMaNulvTGiM
	 reA1xsiffJoKzui3pJHUZo13BowX+gAhK51/Y2GlOGZPKGkMIWGVgAa/GZ/l5Wm4mk1Ky
	 6PPnicM1VyWJB2N53t8sLJOUIbV327tUIhD8Gc2hwrp1GkZQTT7pvKHvOWMCLu42Aow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GShce41l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E44606A31C
	for <linux-pci@vger.kernel.org>; Wed, 28 Oct 2026 23:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GShce41l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDB01F01825;
	Wed, 28 Oct 2026 23:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793231505;
	bh=jWFhUYZCHiWYiadn3ltcY+PPcUKcRLuYQQ29kTBH2cY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GShce41lxVZZM1A56TlHWeR6003ZJJpz7hi2q4MoNuQiiOnkZn6X7NfTLvCcm/ABN
	 NZZVhNdaoJyAgCKw4vh2yoRrCkYVBxBGFdAH4f9lqtpvtnzclCeeCfSKbppie/mFeI
	 UW5io1HlTkIJS8c7eD1ulUIZbtmCcKQNI5jNKV79CcK3UhS+M16iEyVnJGe+Nz3SZE
	 kQoz3VWqzibm1F5Sl4gbMg/MfKiejmDLoqJmnzOuX9CcPQUsKNGEFcuLjB9LrQrhHD
	 Cy+6uoSfVgVQaBC82RhxAFJmF6RX964ePaz630mK9KdNKDEUebRooUHhG8o/HUZn9f
	 LhgzjQRuPZA6g==
Message-ID: <sashiko-outbox-188552@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI/ATS: Disable ATS when ACS TB is set upstream
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danny Gonzalez" <digonzal@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261028233651.960835-1-digonzal@google.com>
References: <20261028233651.960835-1-digonzal@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 23:51:44 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Enabling ATS allows an endpoint to cache translations and initiate DMA
> requests with Translated addresses, which an upstream bridge with ACS
> Translation Blocking (PCI_ACS_TB) set will block as ACS Violations.
> Because pci_enable_acs() preserves existing PCI_ACS_CTRL bits (e.g., from
> firmware, a kexec kernel, or "pci=3Dconfig_acs=3D") without relaxing them,
> PCI_ACS_TB may remain set on upstream bridges.
>=20
> Add pci_ats_check_acs() and call it from pci_dma_configure() after
> pci_enable_acs() to walk upstream bridges and clear dev->ats_cap if any
> bridge has PCI_ACS_TB enabled, leaving the endpoint to use Untranslated
> addresses.
>=20
> Tested by booting a machine with an endpoint advertising the ATS Capabili=
ty
> behind a Root Port with PCI_ACS_TB set; verified ATS is disabled and the
> system boots cleanly.
>=20
> Signed-off-by: Danny Gonzalez <digonzal@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028233651.9608=
35-1-digonzal@google.com?part=3D1

