Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127910;
	b=q8bwhHWIuDFXiyUOdh/ZDOtlsCrgCvYTKscL6VHnr0mAHB70yer3n+sUJyhPvU6qVf7n
	 UZ/x94iF2mvycsVDT5SeBJJz6IB6kPjh5wXBA3fBHXzd8Y4sovtLeUaFpQ+FBtKCTxAKQ
	 yxfZC1+4g+65wKD2TIL96E5jprLV2e4oMaEI5maXdYr/mGwDq3aDS53RxaXlr7GS7sDkN
	 RxQ9VD9AB+xhc35olUA2kXdnnuiok8lWugDaR6ssVEOsEVvqd/S+/f53+ziZJpbcaC+rB
	 6YYIrGKJgnalRQayZSTWCtgF/IAY0hRgusGAP1IykSuB9UCk4W2NnGWzLVIah0D7XTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127910;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Coph6eFhW2l3OLj95aOAwsUun97wVKoM1gQqRkRPxkM=;
	b=UBVioKmY0luA0E+mVTPQQFEIf+09NLxnfLBsB5eO9jlwBMilOq2B0pdtrWTf4yu07qyd
	 tX9D5riOj1P7O+aoGuaxdXdUJkJBwmMyIEASV7F7remTYCw+WgH3l3SzBVRAgcZnzxvca
	 WeV1LaW9+gSRW3WzojzN2GXiBN0bo4CtSvoIj2Wp1ctP89NjxI7gLOlN2HYDByhYlVWX3
	 7r7okBcFEA44e+nfC4Pd2xvLXmKALoPv7FPXCaQVCIWbpNBKLYDibWbHLoj98k3u88U4g
	 2IcGMZjuJxAcEtKENLoljckDZuPWi6LaqQQ8tW4bXNcsW8lWCxmy+qsgtjgejGpp3Tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaBBy+Pe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340DA606A326
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VaBBy+Pe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E701F000D1;
	Thu, 19 Nov 2026 22:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127909;
	bh=Coph6eFhW2l3OLj95aOAwsUun97wVKoM1gQqRkRPxkM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VaBBy+PeRlIBgewixRGlvlwxRM80bTUxG+q34R8xZ7Gs/rsAXu4ocXwTvN6fBfvFX
	 YaAnwwGGLqbuuXY68R7z2IQXMr/HYKs4snMCfvsxrMJ4mC8vdfTNOXs7TW7AxoDsXD
	 8iUHnv9L/2tY2wWVOsfNHoo6yZ/MnC2UaX+2ZIyXJR0vbvyKFSnd2kfrcvfmadLxca
	 bkmJ2egtYlerHoh+lY+S/2vNhJmzcRWEPLTquj19Vq0Q0Taqu3+A/fhKInNByiPO5/
	 sZgFsMx5KkT8rAgBsVuvOEMVl57CBmooUfJCZS8YSnSafenX3g3TJPFd02cks2pkDF
	 HbmkzMMGD6YIQ==
Message-ID: <sashiko-outbox-224140@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 05/13] PCI: liveupdate: Auto-preserve upstream
 bridges across Live Update
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
In-Reply-To: <20261118223704.3286085-6-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-6-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:27 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Automatically preserve every bridge between a preserved device and its
> root port when the device is preserved.
>=20
> Subsequent commits use this to ensure that preserved devices can
> continue performing memory transactions without a disruption or change
> in routing.
>=20
> Track the number of preserved devices at or below each bridge with a
> reference count in struct pci_dev_ser. A bridge stays preserved until
> all of its downstream preserved devices are unpreserved or finish their
> participation in the Live Update.
>=20
> struct pci_ser::nr_devices counts the struct pci_dev_ser entries that are
> in use, so it only changes when a device's entry is allocated or
> released, i.e. when its reference count goes from 0 to 1 or from 1 to 0,
> not on every preserve and unpreserve.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D5

