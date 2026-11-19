Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127918;
	b=xSV6eIR/hIsAIbY2WYIT7nVqGX6WdRLyREbXaIa+s7WYy+qHAr2P+k4CwxT+jgQkNdQl
	 xadlS/z483qTGrzOakUrYf0YK1Cx0tUIwXl9YjWdpLPThwWEAFXt0JBr/R1kT0+1rTpQg
	 QVk9sDw6Ap9uaEYfaGtSA16AgrNcpeiVyMGf9rvXie5CR/4GQaWPYN2fDbXWxSgYq0rbU
	 75W/erJEbgQeepK/jJ5jQAk8Y4rN3X1f2EGNPjiKWIPhmmQO0Jqz0DCxREexxGORUUhRB
	 TpkBYywZxkHeXzeR+DVEnA8izlBgUyx81dIfogoyPnzxORBNg+YYtxzIEe/K1cgj1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127918;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h+V3LMWnhSAOQbYaMO5Wnwd+d6TugLH8Q5qaI2Zp0Zc=;
	b=cCorAow/uX064FupzDqlo6irmeGLU5VjbiPLW4niMrbf3FwIE1wm2A/8cDv4lf1IA14J
	 3qyyuENe8wpDJ6/N8bU/Jg7SDr2HrqFn/dnYJc002njvU0ePFzJFLxIj+8xXDVVWjHh1H
	 7Oq9cc5hLU51+6T+UopOYnZDAzt85a4xUTa3O+Aan9GGIQEZbOaIQ3zVKYUKcE1cJotuJ
	 nP5l8rIPB8AqdHt7ubJ4HDrhGXqWoijiju3Trm7VaIKkbpuRUBDoRT+4vdTpCVjCgamB2
	 DOsN7TGzKBpmUoSgQ1SBwg6VeHJeQfQ6uZjNpN0yIknDC78pTBGb9kPMbyXn5Drbu2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4R0qDbZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F220606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h4R0qDbZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED571F000CF;
	Thu, 19 Nov 2026 22:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127918;
	bh=h+V3LMWnhSAOQbYaMO5Wnwd+d6TugLH8Q5qaI2Zp0Zc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h4R0qDbZSHu/Bmiz9yDL1jUK7cnWi5HVS7JQmBp/FTROlSLxBHpMZhr+jWgsdUfcx
	 fc+D0JrdAqsOr0UkN2KjGmNEB83n40WvaDWetXs/40uxmy3AQP/9jvkrdnP1P7ZFpy
	 z/jyTkQPXgRETT9J5is+sZ1SVgNR6bzWPZNHJV0uGBhv8LiMPmKh8DGHPmKvLPV16c
	 aPfygyoFMgJ0F1+XNcu9N5IfmKMkZjM5/LLw45PJq8TOvHeTErxzttbLwBpFFjDRVt
	 mrCiTbP4JpOcwaGwpFY2EsUGnuDq3ntWLqPmE+YoevyKHLA6CsD5huvh+YZCL5xdVd
	 NJDQc379lintg==
Message-ID: <sashiko-outbox-224144@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 09/13] PCI: liveupdate: Adopt ACS controls in
 incoming preserved devices
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
In-Reply-To: <20261118223704.3286085-10-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-10-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Adopt Access Control Services (ACS) controls on all incoming preserved
> devices (endpoints and upstream bridges) during a Live Update.
>=20
> Adopting ACS controls avoids changing routing rules while memory
> transactions are in flight from preserved devices. It also keeps IOMMU
> groups from changing during or after Live Update.
>=20
> The adopted controls are recorded by the pci_save_state() call in
> pci_bus_add_device(), which runs before drivers bind, so they are
> reapplied by pci_restore_state() if the device is reset. Allocate the
> ACS save buffer for incoming preserved devices even if they match a
> device-specific ACS quirk, since their adopted controls live in the ACS
> capability, and panic if it could not be allocated.
>=20
> To simplify ACS adoption, reject preserving any devices that require
> quirks to enable ACS as those quirks would also have to take Live Update
> into account. If such a quirk matches an incoming preserved device
> anyway, e.g. because it was added in the new kernel, log a warning and
> adopt the device's ACS controls regardless, rather than reprogram a
> device in the path of a preserved device's memory transactions.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D9

