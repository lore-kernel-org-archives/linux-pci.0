Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520835;
	b=A9Qktu7sq5elGtxbU7pO7p1O8sDS1RDFVGf5JhYBT43PNI4opjOMt41VZ7kEWL27YBg0
	 BCl5N0nHAf6AGjA4Fx4UCaXVcEjXGbua48BMEHuSTlw6/AxBucydOsLJasJuaeHUgAu30
	 7gW7nkgV3DdI8H+/bkyUTdB4Y1KxAHOIGvSI6H9DARpnuJuwoUIPJrz/AUo85/MB1rNfr
	 aFFODjBIzSH3ndji9Rn7SaVPOGlTfymgx5lNiIBTGp83xS/zciKzIv5/KDet8qCKs+WfO
	 htMynI5QZkfkMnYTQf2pIUrykUx/+QqMEwPwVjYCMWjBH9IlwfhuQjLMtuAnqNIKaUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XzUjA8xpn+6BO6Q5FYyFmKC8fE1Op6xbQOpe9ddAm2c=;
	b=1O2mn50nxodNOM9NRb5LTROgFL7k5/wgke1TajQ9nz4qV0NPp73pLve44UpeMMe6cCpy
	 VdNnPElI0BCYhl+66xrOJdeTPwCTYdOhVFePLy8yYOBF7AcswlivnWP+ci1bdUVo/vbf2
	 PaCqY/COyNvfQlCKWbmngrn5/bGFfbcaM0b+MjV5+4hkzU+IkMr0BR36jVPaABbnnW/jQ
	 tc654OXsF6tbaBkl5jRzXgAtnBxlwltud9URpJw1kZJljiMetkoI4xWGfZbrEo4fZSUMB
	 SyFpUwv4+giH4eORJQ9/SOWS2VRi3RsUyXQuZBVwNDtpoQlKFxeeROLpELnKDG+4vUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDbfHDX1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDB606A319
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BDbfHDX1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741E41F000CA;
	Tue, 20 Oct 2026 18:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520834;
	bh=XzUjA8xpn+6BO6Q5FYyFmKC8fE1Op6xbQOpe9ddAm2c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BDbfHDX1jXE7+/OpTBmP11vr8ftY/i08Lbp3d72FD1Ci9gidXC6oEWqv6dJfNdMa3
	 soLD5Oloi+sWbL6W3FN3JpEy4AcKuLd9tx01aKfGYRpF6MVNVqxmgVLGbrL5gHsK7j
	 njJ9Nnc3XNHF3Lf1FXRXPRiFOwTtW56dhF1mnnYeyWj9x4pEQ2yZV13bdExgS789bG
	 lX+p6JoSazExSYf3v39UFNVc4BZhsmcAig2hntISeMhrwWyFztSCUwMkSa6pifFuVd
	 DAplbsM4AjCkKUsZqSszbYG3XQshu+LUgrN/cUyLIwr4+jUC/2hvH/vH4S8T5lYMm9
	 OlypXZSy6joTg==
Message-ID: <sashiko-outbox-179472@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] PCI/DPC: Reinstate support for AER-incapable
 ports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-3-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-3-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:27:14 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Lukas Wunner <lukas@wunner.de>
>=20
> Downstream Port Containment does not mandate presence of an Advanced Error
> Reporting capability, so a Downstream Port may support DPC, but not AER
> (PCIe r7.1 sec 6.2.11.2).
>=20
> Commit 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER
> ownership") seemingly inadvertently constrained DPC to AER-supporting
> Downstream Ports by inserting a call to pcie_aer_is_native() in
> dpc_probe(), which implicitly checks for presence of an AER capability.
>=20
> Drop the call.  It is superfluous because it duplicates the conditions
> applied by the PCIe port service driver when it decides whether to
> instantiate a DPC port service (see get_port_device_capability()).
> If the conditions are not met, no port service is instantiated and
> dpc_probe() isn't executed.
>=20
> The only difference between the conditions in dpc_probe() and the ones in
> get_port_device_capability() is the check for the AER capability, so by
> removing the checks from dpc_probe(), DPC is supported on AER-incapable
> Downstream Ports again.
>=20
> Fixes: 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST parsing for AER=
 ownership")
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D2

