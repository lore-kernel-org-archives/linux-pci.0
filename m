Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127913;
	b=G8pOOabBVxeyjXbQAwKlAVWFZXtqo2cb3G6Yo7TwRQCXP4Ji8+GfnedZEla2Mj74vl0Q
	 fLRd/fh4V93OCxBP5EmCl9Ujdu3vYcSHuAe81u/lzVQ9yvKnau1Mk7QqqKrRJWk5SMhVc
	 ktZuKno2xYqF03K18XUIbjQsxD0Zn671tRQoDIvz0awCJGkI/wighQkMvHP9L1fJYWov9
	 BxHUAzYDcS7XuaiMS4Qw/fSn0dZ33DuEKPiMKkeJFOGh89Ui3AtSaYLZJLwtL9EZvowvi
	 sFilZisXECP4za9vOhrmighOHojsB+GhVLgp5sDyTjwtYPfLWysqbbh8uDkRtoEhF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127913;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8eGubJTOCnJnITzIXMMxMGy3wCz1aEDqmrPh5iTYuKQ=;
	b=1oIW110gzHt2EOGcN82n27R8UbCOQZxCVgUfrSY2vGC16jL6A3FeXdJjLfQIj6Z2YWON
	 yujuFGfy3oOMuNxeEe254YwS0b2BSTQVChtdpRG3v5OxqSzcy2cRnBWGUYoZH2SkGrnOr
	 A8tGrCanpq6bv9iWtl818lf1k05EXwctgsS5zAsSlLHwmgBLu3UZGinx6XKAFAnFP9Q8x
	 hQjW/805yvapq6FcOzEX/5X4PlEBUPY6BiII8qKNLGNCFGeHQZunsWAcWjYp3+EOEeX+L
	 bF85Nh3eRn7/gB5KskudU4lo9CPix0v/h2Pz6Bs3759XAqd4ppKCtXDBbMkX9JgBs9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJKcaicv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2C8606A320
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YJKcaicv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3411F000C4;
	Thu, 19 Nov 2026 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127913;
	bh=8eGubJTOCnJnITzIXMMxMGy3wCz1aEDqmrPh5iTYuKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YJKcaicvr+GE5HrDzT+MnxN47v+qwt7PKKGcCq9VaPgWsg0MOCHRjVbWco5vgHsbL
	 LsMTitZpQWGhKqbXrP2GVNYgr+5ZXJuwNh8Mn1EvQBLeUJkfyP6EKmBDu/59BgcmBM
	 do9kDIbYLgJHufnALWxC/Oa19y7+kmjWmCFnRxX4JY61QT+n0LNtN/gbvAl7GI9BX9
	 Tj4R6jpfJ6FUrG0lsRsdyJm/O+Q6UU43T+52F74JT+lupbQTPhmUXAFKgi37qBxGL/
	 3uGBYbLgEBNUNc6fCWthhtPUQdERkRkx9/Q2Gt852o1lYDlG0NZ6kesDP/64Re+EvV
	 xLtxyXdnzV7ZA==
Message-ID: <sashiko-outbox-224142@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 07/13] PCI: Refactor matching logic for
 pci_dev_acs_ops
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
In-Reply-To: <20261118223704.3286085-8-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-8-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:31 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Refactor the logic to match devices to pci_dev_acs_ops by factoring out
> the device matching loop into its own routine, pci_dev_acs_ops_get().
> Move the per-quirk device checks into a new .match callback so that
> pci_dev_acs_ops_get() can return the single matching entry.
>=20
> This eliminates duplicate code between pci_dev_specific_enable_acs() and
> pci_dev_specific_disable_acs_redir(), and will also be used in a
> subsequent commit to check if a device requires device-specific
> enable_acs() during a Live Update.
>=20
> No functional change intended.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D7

