Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135A51B16B
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909659; cv=none; b=n+PiKAv2SueK3WY+JQtKuVIasAldsLe/NNEkSczlN811Ft1PZDQrAII52teqFk2ctwE3X6Cp5MHsEKKMahCjd/Ruu70nfp55cHJp3U42fM+19F/Qki12guWlW7BKwXKHtXg56dBnhewPf0Ow7xBNgubGV+5TnJI201EYulzLx90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909659; c=relaxed/simple;
	bh=vU9iDpTw6BhQUXTMuwZ7IfGm84e7qgJyw7tFxT1/9fE=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u1BWK4knOw4xg2X4fyNwBctd3qY5hFd3d6RnujPzzXW4G067tbJVT/ksxkOP9RtydBD/iRez6FT6ub/PQFQY6g0MFxM7zY58CgV0Sj3btDzCHJVndytNZ/CeWQ8bWWR5rF8xVd13L7tzjB7Jq/PFClrluoHv6dnEVtdk6i65BhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMRtbK7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMRtbK7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D411F00893;
	Tue, 13 Oct 2026 16:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909658;
	bh=vU9iDpTw6BhQUXTMuwZ7IfGm84e7qgJyw7tFxT1/9fE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RMRtbK7UcA5SdLsEX5/pelGjDR8F208CZNPjIkSj/2ZD27wPtooimHoiVmLTs12hs
	 a/w1aTYGmNzA3jcEPaUEUV/ma5629qBG2Mevvul8O37z2AgvliDBxQmqEW6cWlMTe8
	 tKuKjH5aPQ7ryVQ+SimIKlN1p0e8YBI4aSZBZVJRpwe6DnkHwLZiy2oHr7K/Eoqa4Y
	 v7jZc1Oy+klAOVHcK0hvCRhJDjYXe9mUVcCrsBI4Wl30XrKQrgwZ1ubnrePlyyGBMV
	 OalTqaR83FYwW1I5lHOFRT/BaPR8HZ/yX50GtNUTo8pco2//wEoGJsVoYoWbAvmTdP
	 4+xxTiVqNRXMQ==
Message-ID: <sashiko-outbox-170134@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 10/13] PCI: liveupdate: Adopt ARI Forwarding Enable
 on preserved bridges
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Matlack" <dmatlack@google.com>, kexec@lists.infradead.org, linux-pci@vger.kernel.org
Cc: "Adithya Jayachandran" <ajayachandra@nvidia.com>, "Alexander Graf" <graf@amazon.com>, "Alex
 Williamson" <alex@shazbot.org>, "Bjorn Helgaas" <bhelgaas@google.com>, "Chris
 Li" <chrisl@kernel.org>, "David Rientjes" <rientjes@google.com>, "Jacob Pan" <jacob.pan@linux.microsoft.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "Jonathan Corbet" <corbet@lwn.net>, "Josh
 Hilke" <jrhilke@google.com>, "Leon Romanovsky" <leonro@nvidia.com>, "Lukas
 Wunner" <lukas@wunner.de>, "Mike Rapoport" <rppt@kernel.org>, "Parav Pandit" <parav@nvidia.com>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pranjal Shrivastava" <praan@google.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Samiullah Khawaja" <skhawaja@google.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Vipin Sharma" <vipinsh@google.com>, "William
 Tu" <witu@nvidia.com>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20261013162529.1928093-11-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-11-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:40:57 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Adopt the ARI Forwarding Enable bit on preserved bridges and update
> pci_dev->ari_enabled accordingly during a Live Update. This ensures that
> the preserved devices on the bridge's secondary bus can be identified
> with the same expanded 8-bit function number after a Live Update.
>=20
> pci_liveupdate_adopt_ari() updates the bridge's ari_enabled the same way,
> and from the same context, as pci_configure_ari() already does when it
> enables or disables ARI Forwarding on the bridge.
>=20
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D10

