Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026264;
	b=dGo4wxDjiyxgi5VUAxQwvVH/+398Jd28dDGv4nYfLxg63WS4+PZ8l5M4jh5zvlhxANCQ
	 sdxygsZjXZks3OTd72abVWHy2Jt8IqM9ARjqcclk8k4FTBgepw++39jT1VhDTjSf40nzM
	 HBrOUI4QwBKw0t3BgTkiFHO32NU5o6REvUshoRkaCzjaiy0uIfwSAcO+vFvGu0svEX8sj
	 kiLttdQfwaAj2lt9HeY1qgDhCDUyBlri4IpHaIVq+yeW052JKQudE/mJf1JqQ/dR0X6FN
	 2HNmvKlA+3whOaq5UYt6TfiTLwEAR9p+sVazboRHyz//vjqNBZ5XTpZ3lYyrrE1OQBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026264;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BH/++B5S+FTwkzKu7cNt1ObI5JO0y5mAcxR2pErePbQ=;
	b=j9hH9T8fTQadNSiny25hfAy3USptQxawoa7dbsT2KZiTyTD5jwez51HUl9lw7KSGeZvh
	 MQ3UTyW5ZGdc3asC8wVj6B+LK44xmcBXA9IhGWJLyhNg1HuCARRdl/XY/Gt4/a8jgg0RG
	 ALEQ2Ays1fOKNO3KGidea8KB41FWhhzWDqQ9K9IS4KrmuJEPIlDuZIzPpSA0OC/d5gEF9
	 +pa5R16565OfgsBsLAvLyBCJ3NpLnMcN+MFD29w/p7XrPQMAjwFQ2Req/qr+0aiPv0dAd
	 tv0fXEZuAs57CTMA5eCGlENR7PX3Nv8zGM0jDILGt596EwaIyJGr0BI/SfYDMGQeQ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIv+GNFb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC760A2603
	for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2026 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIv+GNFb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04F6D1F000C4;
	Wed, 18 Nov 2026 18:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026264;
	bh=BH/++B5S+FTwkzKu7cNt1ObI5JO0y5mAcxR2pErePbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LIv+GNFbnxZpjWu4+2fkIK+9DpSOI9tbwtH2Pbu0BayPvmGKqH9aqRYMXq1dTNJYC
	 O/buyr1Qmv+Yw76sqCVWvExKvex9Iy4nVTFKrYZpXflN5W7Uxgf9y+NL0ap2AqGGZy
	 2rWRvmX7ZTbuPjzJ0rza7qpWGao8oJnzB3GLGRicGH7/A4nqc1QlWLYSUo5o3psX9v
	 1ZhSJCbZ7m8MT5nC3Yhy/auvUotDQbDAvFRufZZEUQGIXcRhHlpwzwh8dJg8ZkjSTf
	 q7ih1fSe5AGu4Brk/oFF3cm86uUG/GX2yN7ECNnIE8cadwaUDd9J1wjs4oT6k7FoB8
	 Eb2UbAb58q7Zg==
Message-ID: <sashiko-outbox-221744@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 6/6] PCI/portdrv: Bind DPC service based on
 host_bridge->native_dpc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuppuswamy Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261118181718.3907441-7-sathyanarayanan.kuppuswamy@linux.intel.com>
References: <20261118181718.3907441-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20261118181718.3907441-7-sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 18:24:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> get_port_device_capability() binds the DPC service if the port has a DPC
> capability and either "pcie_ports=3Ddpc-native" was given or the OS
> controls AER.  This repeats decisions that are already made elsewhere.
> It also ignores host_bridge->native_dpc, which is meant to say whether
> the OS owns DPC.
>=20
> Make host_bridge->native_dpc the single decider:
>=20
>   - In acpi_pci_root_create(), assume DPC control whenever _OSC grants
>     AER control.  PCI Firmware r3.3, sec 4.5.2.4, requires platforms to
>     retain AER if they retain DPC.  Put the other way, firmware that
>     grants AER does not keep DPC.  PCIe r7.0 sec 6.2.11 recommends that
>     the OS link control of DPC to control of AER.  Commit 97ca178c899d
>     ("PCI/DPC: Allow DPC on all Downstream Ports when OS controls AER")
>     relied on this link.  Keeping it means DPC still works with firmware
> [ ... ]
> this.  The OS now uses DPC there because firmware granted it.  Since
> "PCI/DPC: Reinstate support for AER-incapable ports", dpc_probe() no
> longer requires AER control.
>=20
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@lin=
ux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118181718.3907=
441-1-sathyanarayanan.kuppuswamy@linux.intel.com?part=3D6

