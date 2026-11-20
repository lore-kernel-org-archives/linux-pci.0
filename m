Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182809;
	b=Fx2r89QDhOohXdsqluayrkcGKs19whinb6ajp0F1GqnGS9C5IvFEANmHjEoqvnJ+KilB
	 Sm0g3sVlS4lZ/bAKGYLzk2A9IQHLNEiAedZWntWImKV8lSN5UFCxifbMj2Gg7JOazoTiN
	 XUaczPOUsg7ScFaPIkRiBVTJF50Hrmaoizhbnq+Fla2wZCHxCrs4fNqq8XENSdtgUO678
	 3Hx6zf4PGCaePSzyL4jKk9/rPr5lcWTTNnBjay/Dru0aC2cc3VLbWCTkz6MbA7aFBzLHI
	 U2rwzZ6PIPMiuO2oQHiNewEqMFAdbk2553axoaYoGJxYowhWTvEf2MOE04z951wnJUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182809;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pMZt55TDIhtHBmu/E1OxoJCk1oofQPHGYZHU4h42xxk=;
	b=hlIcSLdbcxxsPMYIcOTd2YKZbWq0bIrBsXlhilRL0n/O+V6x+w8RG+fC/rIWtjmcdHLR
	 V+V/zs9z4J9r0x54f1PXde0PUchnPt+Fq3iT0iyNLGqfKEQF+pGZVp613vdjmPvoTiTdd
	 hVZ1Pbiv1qkNktMywV9+YDEgZ5ojlJDPUiADdiH7j6Ee494rdyfoi9WslDoEABsopjsy1
	 NKzEDejfSvnAJcQK1IhzOgkEOPkpsY0lXMwhoo2mlMSfhWUPXVh6N9l4hv3K5VMktqYFz
	 ks7GwWQOkH7lxHzIcgJkWOpdWinDfBNdKZjqeWNnbeiEF2CiGiLEmSsjF7y3YJrRkCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="c/G7zoim";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44800606A336
	for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c/G7zoim
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F59A1F000C0;
	Fri, 20 Nov 2026 13:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795182808;
	bh=pMZt55TDIhtHBmu/E1OxoJCk1oofQPHGYZHU4h42xxk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=c/G7zoimMV7NfZpTaBQfRodR0z24NdhhJpiQ0D+bzF45lAp0MQpy8qg0uytgDTW1Y
	 CnvXntdyyfFVPEw4KVbQU36d22bgZzZ5ysdGZxmn6EdQv7k9UbDhnohXmQpws3Qbg0
	 Ag/fqoRc1KqrwHBxKPHrtE+Jz7CtA2LYRa0S8hpDZAyG6b53Vop+QgSdogtQTGR9uG
	 7BD2EjyPhxTK++gP7Y+/CRkhwAWSLFlCluUWgQVKajTKaL2OR+0IZJw0BwtiWWyvKI
	 Fhp2LBnXZVML+IU3jqbuoAwHVXip4V/tQk8sboByQidKktHqsDK9lmqfc1ZqZZbkrC
	 G4ajAqa4jSg3A==
Message-ID: <sashiko-outbox-225291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/16] PCI: Add pci_bus_size_and_assign_resources()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>, linux-pci@vger.kernel.org
In-Reply-To: <20261120134716.3027-2-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
 <20261120134716.3027-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 13:53:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Bridge window sizing and resource assignment must not run concurrently
> with another sizing and assignment pass or with device removal.
> Preventing that requires holding locks across both phases. Many callers
> outside of PCI core call pci_bus_size_bridges() immediately followed by
> pci_bus_assign_resources() and cannot hold the PCI core internal locks
> across the two calls.
>=20
> Add pci_bus_size_and_assign_resources() into PCI core which combines
> these two operations and convert the callers that call them back to
> back.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120134716.3027=
-1-ilpo.jarvinen@linux.intel.com?part=3D1

