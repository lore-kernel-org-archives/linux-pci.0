Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521183;
	b=1HGBMWKTBxBgGDeaIizPS1ac94DP3rFF00Fakp3BBpKHm4HURB/MSNWGM6M4N+X3gyw1
	 kGGbuebVGTaobVSFCxoHp9wtVitHhnB/QmcplA6tv4qHMOOU+mIZPmkfEUl2KtvmlQ6IY
	 vbickxXw3ih4YTWFXYdskfMaICt0F+g2DDbII/JAbnbVaOc/ZD834dNCuXSStVfK0d/K9
	 9kUx7xyopKZR+9D82jXEEnKhN423FDcxRhnNF3GTgBEDboNtg9jY7eYfQ0Q7T8/gkSBrS
	 Bd+kX5t77eZTki6vY/hNnz7TPfRe9r2CsW/QTOm1VlfeniiZGjy9FqI2WJ3nKkiOFAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521183;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vYpcr/+qRtwznC4OTm0ms1nrzKq11lbLw+jtSi8IvBA=;
	b=ygGA1wYAYgma70vCrLumF6j4+Dr9NXGLz3kVQOLKFyjA3Tcmwp6Lc7ID1zZ/RFRXEGUV
	 wxWGdwOgsKz2uZfM0oBHiq651ldj3zmSTiCHqFxeDj7AX4t89qBjWm4Zmlk69Qq7mjMgK
	 3zqZY7nVNFmnH9/ERLiG0/MJjtaxPvyGW4mopNs77WkNKpsETSzvcXUEiBLI8AoWZk4Jv
	 bD9t23olxoj1uhthHieSDLT3ELjXu7zY0XFOqdmr+QYF7bacHNpV3Exy/3s/xjFij1deG
	 QK+iws10/StAkaCimuVJw5+MBUDsYPqwb9zsdoA+Kpvokx0emekK9Jx7cHEbSfh8+Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ha/srlcZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C870606A31A
	for <linux-pci@vger.kernel.org>; Tue, 20 Oct 2026 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ha/srlcZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0061F000C9;
	Tue, 20 Oct 2026 18:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521183;
	bh=vYpcr/+qRtwznC4OTm0ms1nrzKq11lbLw+jtSi8IvBA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ha/srlcZBZ5OwMYb7O0MycWyz8POvkexOAex5KlvHJEIRge3DFn4jTqtzCW7RBLER
	 BZs1fg0gevjKhTV9JWvFN3SpauW3X0oN8Zp76+oOo06F/ENgP8r3QgKuA43Jvkt4nQ
	 7Fg7t02J5SvX2nTveOcqd07vA0vvvhyn9abXMugXBTtPUTlv0g2S0Y8HoyUhaULHHA
	 Mp2VPWbHYoQ2nRNw0Q3Cle3Oz3v1YkkgcI+Q/Uh+rKDXjio3DxGjxg5h1/1yN/L6Ra
	 q+BDlKBfAkmCPmwZ1H9iDbRwgVmN3FRv5qt0f21At8jQAegC6iCLMm62BKFwMUgFJE
	 I1kMJVbWI2Vxg==
Message-ID: <sashiko-outbox-179478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/6] PCI/ACPI: Request DPC control only together with
 AER control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261020181924.3003553-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261020181924.3003553-6-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 18:33:02 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI Firmware r3.3, sec 4.5.2.4, requires the OS to request AER control
> when it requests DPC control.  calculate_control() requests DPC control
> whenever CONFIG_PCIE_DPC is enabled, even if it does not request AER
> control, e.g., with "pci=3Dnoaer" or when MSI is disabled.
>=20
> Request DPC control only if AER control is also requested.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020181924.3003=
553-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D5

