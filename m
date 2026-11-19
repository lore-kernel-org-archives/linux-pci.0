Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127906;
	b=yxmLbLrmtHoxEaUnE1IrBRglNIv9ve1wmnqOdq2zTHGou03QEFoZJynMDX1RCVp7GQsn
	 cGzGi+SAa/EaXHGhjRJZQBV2ew3uifFIrgHTqxuQRFDwF9YHvJaeb+AeajzJ0nB3H2UNE
	 aweEz0kuF6C5M34AmElSP6m4/zl9o6Rf4cbjNA8Ku9xVbxP0xGBj/jGy2FJMFFYMvKwhN
	 VgWwCZX6rYV50by4fuCbQGoc/tu8drcGn4rEKj32zhkEq54ySHVXPTNKIARKxWF4S5HET
	 Ffsyoz5GusLX6HpaPwMvMAtqys9YyGZCuckMr1DMS8TycAGx1XcJBqdSH7nT8AWLYHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127906;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=mXEmIYwQs6olh4tGCdDknJUtcZFRu5o00knNY6/pK70=;
	b=SH6i7kxir22omRqnZkmgVAoj8K1Tj1f42czWRPJ0J+DWFxFKD8PofASddsvZ7r07x17J
	 BX4W9tv52murUIly2OGV+3vsQdt/M9qKjB053ieTlp2JIuoVqlH/IGZJjvra+lh0+zImM
	 RIToPaaxNn12+dYWQrHby4nChIaqyDGR18MEDj25nsi4qf+GzJVqX8NJAxURtBROcLpYK
	 keFMqtNZ3nsMh/O7+KGNWXCnGMJ/cuOymraznTPYXMzgxIR8m5zBHnyLdcUVjsdbGgRZG
	 t/YR0SpVCm9+E9814HuX3zexKMpgR8rmD2YWVGLks853T4nkNga5Vt/DzidBY7ddj8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq4n5c21;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6C606A331
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mq4n5c21
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363EA1F000C0;
	Thu, 19 Nov 2026 22:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127905;
	bh=mXEmIYwQs6olh4tGCdDknJUtcZFRu5o00knNY6/pK70=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mq4n5c21rli6DqzcKFFDpWmbSABKkfRl5BaVQLXBMl52LVsDDio8ocK+SLg+fI9Fo
	 RXe070yO7nuuU3XiYab9Ezmgm7HZrx3h8vjcBjzPl2tlEj8ebEgMM/KC1oKLwpGtkF
	 PGPDDvSY6YFkDbDNO34fodqNvTulVJhlcRQhZonIIMmGYxR+sRS7dSvs7XIzv2B+2w
	 wusV14Tc301To1yumlhsARFChzaLZvDyjuF15wK16QAbtPteFKAENbWN9EPta8HxFx
	 tW88pT/sBS1AHjym+1So2VIVAG2tH30NZZ/bzRWE33L2jWQOQvrdURRNOyI9aFI//Y
	 clc+YWN0OrvgQ==
Message-ID: <sashiko-outbox-224138@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 03/13] PCI: liveupdate: Track incoming preserved PCI
 devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Alex Williamson" <alex.williamson@nvidia.com>, "Bjorn
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
In-Reply-To: <20261118223704.3286085-4-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Identify devices that the previous kernel preserved across Live Update
> ("incoming" devices) when they are enumerated, and add
> pci_liveupdate_finish() and pci_liveupdate_is_incoming() for drivers.
>=20
> The previous kernel passes state about the devices it preserved across
> kexec, and the PCI core needs this state to know which devices require
> special handling.
>=20
> Add pci_liveupdate_setup_device(), which is called during device setup
> to fetch the serialized state (struct pci_ser) from the Live Update
> Orchestrator. The first time this happens, pci_flb_retrieve() runs and
> loads the struct pci_dev_ser entries into an xarray so that they can be
> looked up efficiently.
>=20
> If a device is found in the xarray, the PCI core stores a pointer to its
> [ ... ]
>=20
> pci_flb_finish() panics if any preserved device was never finished,
> since that means a driver failed to call pci_liveupdate_finish().
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D3

