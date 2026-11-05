Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793894940;
	b=Vzdlw1IXTAfnAPY2VhLrWkZVCvDFqOAbtKZK+rny49DsZk5H0EvMDFv71vKU5YCOsX8E
	 eEKDVPxS6ZxDQCS8gk/UHPzzatdKQkE01PafnD22R2SdUEEf6JSVGFnpfOXNEt8iV0oxx
	 oAaQh1mWPuQ/DcxJpY5qOHaD8CjIL9KesNR8QGGiyVY5Gu/7azivzndeUuOjLkWTDTjYx
	 TorMsnGa/9s2VHxP5ScoXF2sCcoVkO5EQSwsfoy3F+Rzb1R9NU6VEXgVAqkfGTwC0y8y/
	 4o8BZlwqvKEo5tk1BVcwBapTUdp6rAAIJ8giw7cktw21ljrnpQ0d5E2i+hePiqlhxqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894940;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VYLJryO3jvHz84oHg5G11gt/JePZgcNOeekMXMhyHAo=;
	b=YsdunU1RIQq2wbq7oKRrZPOVpmEG/R0KaFsoeRHzCN0IN2SP+VRayPMXM2myvson6Uaw
	 cDSaeZ6vKH7R+I4N+rcIiQIrDxBpe+X2xgfWCkVoagC/6RSzsMt11erH90dCEn8Vf8JcB
	 Dk4cY5Dp3Euh48vyfHbyBkSueJn5Wek1hAObVXiK9FHZmcKe/GPeow5TYEhY67hGwSma6
	 Wim6iDRmZMJACzLujSWx4yaDTbpap2Ps1PjJU9TeC2ao6YvUzMrnS5Pu5OGli39hhOB2Q
	 LuhXbq3cnHkbucTHoEW4zFcCzmWQQMGl5LokIajaQzgKqSgn8pVtE6i0NL6bX+rVswA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFvQ4iRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAA9606A32F
	for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2026 16:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PFvQ4iRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B5DE1F000C1;
	Thu,  5 Nov 2026 16:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793894940;
	bh=VYLJryO3jvHz84oHg5G11gt/JePZgcNOeekMXMhyHAo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PFvQ4iRl8CjMveRKQhnzGInI2l43rugBVWAoSXV9MHpubuqyI8zQakiEA4is+6KUJ
	 vsuA3+A0GhA7EaAG0oXzs12AmahnA2B8yer6EnXbu0gIc0NGcgMpZ++lpgXcLIGipz
	 3CWz5G/N+A0PVkaHf0PBbqKBBEOwBy+v4MYvU+MfFFX9YNBM7UbPNHKTGQWweZP3jk
	 pmLvGAOg6AlGwOhsxSn8APEPLRxoETJyDCSuo2gSQLoRSSRYRsi3LvI3DYtfg4HQnm
	 MS5wTrSKUiBBN5N1NynQwgO2dnNWPjFl6zTB0pJImBfaFozh2NsT+1ZBW/38uo4Vxp
	 RNniK8dEgilLA==
Message-ID: <sashiko-outbox-199423@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v14 07/10] PCI: of: Clear fwnode->dev during root bridge
 node removal and error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Herve Codina" <herve.codina@bootlin.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261103155540.365294-8-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
 <20261103155540.365294-8-herve.codina@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:08:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> During the of_pci_make_host_bridge_node() call, an OF node is created
> dynamically and its fwnode device (fwnode->dev) is set to the PCI root
> bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
> call.
>=20
> On removal, of_pci_remove_host_bridge_node() is called and calls
> device_remove_of_node() which in turn set to NULL the related
> dev->fwnode.
>=20
> Later in the removal sequence, device_del() is called and runs its
> cleanup logic:
>=20
>     if (dev->fwnode && dev->fwnode->dev =3D=3D dev)
>         fw_devlink_set_device(dev->fwnode, NULL);
>=20
> [ ... ]
> error path.
>=20
> Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103155540.3652=
94-1-herve.codina@bootlin.com?part=3D7

