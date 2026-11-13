Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531936;
	b=RJhG/0lLAziQayjA6uRgpDKFwr7r6f6rbpZ+t2i6o4MIDi1NVgBDl67bZ7ApdUYFAD7w
	 ixFTApbdVfYjnivclxz9yujJxSjsnuT2brr1tINaBbpFHkcpROCyBcgDgLkXAwCuJlNuR
	 38OAOlTzmiMXAO/Za0IVgAY8CHYdz7gwud4UnxUMGhXXaMX45a3JGkOwOyzAnUDvDYqzj
	 C+6njrAmVYB0ftxbougt2e5mZ6VnEM/7gIAMq2uDWq7nWzmcP05SGoYAKD2MCzBO6ZHP5
	 w6U+OBL9avUM1lc5SaQ3c7a+svkgaBQVOJeuanMyiqALziS1iGs54zVc4HlEkEtasEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531936;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Xor1D90R6iiLgXTH6Jj6+gZ7TXwLffLx35r4VJvkDic=;
	b=MqauDPtv8O1Fx3s5E0mMR+ZgHRXvkfKDRL5OJtwt5GBcoA148eoGLtfqPoprpPurw/Ip
	 SVnow5LrmI1X3jJJxOrgofIuErYCKR/Ssn2u9zxoELd1cBRQ/K5hKVsNK8SnwfLO41ZOw
	 IK5k3pFui0A58KXNxwh9LbybhBt12HKBKsr3/HuvwBrD34dvigkgYNfD+ZGfoQ8THtvvw
	 0RjBUIN0p5bro3JlXnDVV4D2JC3pwqbWrX5ywb9vrICix7VB++SyuFCks72I16bvMkhe+
	 rbOq/MnazgnGGLeS5QLrlcf2tMXRMPHLdzo4eo/4D5EH3mw9n+fzXILsw7tvdI8E9Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maJrQxHB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1275D606A332
	for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2026 01:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maJrQxHB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676931F000C5;
	Fri, 13 Nov 2026 01:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531935;
	bh=Xor1D90R6iiLgXTH6Jj6+gZ7TXwLffLx35r4VJvkDic=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=maJrQxHBYDHvx+LuOe4ZPgDUH44hhKkJioVLZhm5y52tpkyaogIiD9NKUSal3Dc2M
	 cfqx7aVkF2BGTP+CtNbDME2ass3KIGdXwWoMZ2GOtXwNdADg1CC6ecv8pj+nm9W45L
	 Db1+sT4W8HfgX3MJdDZ9+ZHR3J1wGsjL6nSh5SI+Gf3Xr8T3WaMSCGYuJWVev9cOWc
	 nbwBGpB0W3mDeP+MV4ZFwYr0oDSYBH0PFzgJFF+t2S5BwPv+PJ1D0z2wN3zjhKDCWf
	 MvKFn/qoYaYT/G2BydKx8o16HfBYPq6JFRJi0yEC76BqslckHOjtVMMfw1GtWr50OL
	 59ciCpY7pZp7A==
Message-ID: <sashiko-outbox-212033@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/3] PCI: Cache bridge firmware secondary bus number
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mario Limonciello" <mario.limonciello@amd.com>
Cc: linux-pci@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
References: <20261112-vfct-regression-v7-0-69b1e0cf45c2@amd.com>
 <20261112-vfct-regression-v7-1-69b1e0cf45c2@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 01:05:35 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] PCI: dead fw_sec_bus_sampled in pci_read_bridge_windows() and
  log mismatch
--

commit d3720492f32e5a284ef73b3dc9f69d02b13df2c4
Author: Mario Limonciello <mario.limonciello@amd.com>

PCI: Cache bridge firmware secondary bus number

This commit caches the firmware-assigned secondary bus number on a PCI
bridge's struct pci_dev in pci_read_bridge_windows() before bus renumbering
can occur.

> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 27008e2ea5afc..f20a4b8f7a23b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -505,14 +505,26 @@ static void pci_read_bridge_mmio_pref(struct pci_de=
v *dev, struct resource *res,
>  static void pci_read_bridge_windows(struct pci_dev *bridge)
>  {
>  	u32 buses;
> +	u8 secondary;
> +	u8 subordinate;
>  	u16 io;
>  	u32 pmem, tmp;
>  	struct resource res;
> =20
>  	pci_read_config_dword(bridge, PCI_PRIMARY_BUS, &buses);
>  	res.flags =3D IORESOURCE_BUS;
> -	res.start =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> -	res.end =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	secondary =3D FIELD_GET(PCI_SECONDARY_BUS_MASK, buses);
> +	subordinate =3D FIELD_GET(PCI_SUBORDINATE_BUS_MASK, buses);
> +	res.start =3D secondary;
> +	res.end =3D subordinate;
> +
> +	if (!bridge->fw_sec_bus_sampled) {
> +		bridge->fw_sec_bus_sampled =3D true;
> +		if (secondary > 0 && secondary < 0xff) {
> +			bridge->fw_sec_busnr =3D secondary;
> +			bridge->fw_sec_bus_valid =3D true;
> +		}
> +	}

[Severity: Low]
As reported by Lazar, Lijo on v5 [1], is bridge->fw_sec_bus_sampled needed
here?

pci_read_bridge_windows() is only called from pci_setup_device() when
pci_scan_device() first allocates and initializes a new struct pci_dev.  On
later bus rescans, pci_scan_single_device() finds the existing device via
pci_get_slot() and returns early without calling pci_setup_device() or
pci_read_bridge_windows().  Because pci_read_bridge_windows() runs at most
once per bridge instance on a zero-initialized struct pci_dev,
fw_sec_bus_sampled is always false on entry and is never read elsewhere,
making the bitfield and the commit message's rescan explanation unnecessary.
In addition, since bus 0 is the root bus and fw_sec_busnr is only set when
secondary > 0 && secondary < 0xff, fw_sec_bus_valid is redundant with
checking whether fw_sec_busnr is non-zero.

[1] https://lore.kernel.org/r/eba45235-a6b1-4a48-9c56-9e069c299478@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-vfct-regre=
ssion-v7-0-69b1e0cf45c2@amd.com?part=3D1
