Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460690;
	b=A2/AdXwOD2TCJMIYXZmz9CBRqPAOaq70up144lzzI1CpA8xGI8DoO9L8C05wWsVALvvT
	 KKOMFc1n0gD37/BLrjbW9DxG2+yrJfPk0Y+3y8Omik8HBuxslWGUQR21gl1P8PiNp7Toy
	 3rnpk8vMjP4f/YuMKEz4+/bVMAfXN+cGR9S/s5WiqB3sUHvD45v4rwV5yShh2GS/1pOli
	 HyLcmELKBKGGikRmFEc8646/FLmjhqYRo5TL0UyqUaN5aCog0xL7QWHjjMZR/WkCg4uvk
	 3Nwhsa72DgBgLECe+Ip5GraM5kg7eqkXcwCn2uxuTz7cRBcF2SNChQrx/Q2Kp7/8Bkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EKwQUwz0yWxrcL6JeB0c02x+qfb+CTKWxiC1vuBRywM=;
	b=oivGwyiyH/62HFIKNmmgS12vxFcsh1Y0l/0ilJJeSkIylbxlCoblropoqeUEBHGXomHL
	 SLY4l5VQkbr0/cIiwrLyuE1hCGoJLXzFsN3kwIswfiwUwDiHsfO0phy2oEtRZUsN2yxtN
	 ttg2MslCf/mRI9EMpgtBginauU95GZO4dXlugi6/LdjoAKIz1hQCy+PpokXFVYxc7RhhP
	 G3K5+oA2auWnuJsCAWuI/xTfPbJapNSX/VFEvAwT5bTi7tbWuSEcQM7lRB65nt18G1rRj
	 b2+dBt6+Zr7Juv9QEI3vUtiOqand0PNgpFZkxmgpfsooeTpXLcFNonnZRxZueL22J7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiKKH9J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79944606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=apiKKH9J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AB11F000C6;
	Mon, 23 Nov 2026 19:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460690;
	bh=EKwQUwz0yWxrcL6JeB0c02x+qfb+CTKWxiC1vuBRywM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apiKKH9JSz8QPW1M0/SO1hoRbY3BGfdMp4zg16LOH5i0hm4GSKKgkLeFq0Z4nvjSY
	 dlB7toGtjqfp1i3dRdL4L4BJ8wji5mOrtPNcpGePUYNI8pJKV74t2X8sVWrE2PVA/8
	 +fxrOQ4cT2CxdTmuqOCS/82mbADZ5/soIOQeZph/baVaDWLyrMIUxomkWMvd4VWm7L
	 sBKfoBxnu2SPQzxIt3tssc5clPUiGqavLRPsGDbwdOdEdQeQAxymyMwUfbAOGoJPWE
	 fkZXuNDp9lzj6PLw4VbN4+U9TvHDEUehFaB3+goNgseUyPK4wkpbo31K9Rw93qWVOC
	 URf81o3DwIlTQ==
Message-ID: <sashiko-outbox-229907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amend! PCI: liveupdate: Adopt ACS controls in incoming
 preserved devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alex Williamson" <alex.williamson@nvidia.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, "Chris Down" <chris@chrisdown.name>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261123190045.2166865-2-dmatlack@google.com>
References: <20261118223704.3286085-10-dmatlack@google.com>
 <20261123190045.2166865-2-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:04:47 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI: liveupdate: Adopt ACS controls in incoming preserved devices
>=20
> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Adopting ACS controls avoids changing routing rules while memory
> transactions are in flight from preserved devices. It also keeps IOMMU
> groups from changing during or after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> reapplied by pci_restore_state() if the device is reset. Panic if an
> incoming preserved device has no ACS save buffer, since the adopted
> controls would be silently lost by the first reset.
>=20
> To simplify ACS adoption, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account. If such a quirk matches an incoming preserved device
> anyway, e.g. because it was added in the new kernel, log a warning and
> adopt the device's ACS controls regardless, rather than reprogram a
> device in the path of a preserved device's memory transactions. The
> previous kernel did not apply such a quirk, so it programmed the
> standard ACS Control register. Allocate the ACS save buffer for these
> devices too, so that the adopted controls are kept across resets.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Alex Williamson <alex.williamson@nvidia.com>
> Link: https://patch.msgid.link/20261118223704.3286085-10-dmatlack@google.=
com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-2-dmatlack@google.com?part=3D1
