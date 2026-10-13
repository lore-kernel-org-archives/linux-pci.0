Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B049D5AE
	for <linux-pci@vger.kernel.org>; Tue, 13 Oct 2026 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909598; cv=none; b=maWWzj54NivkxJe7GMNYukfSV0Wklo8lVJ8I28iEkhjDkSNcj7Re9QreCxRLnVJP8F4qVvok97WubuZw0hovBT9QjxrwTV2s9fMbGufo9anXBttMNmGO+dHnapbpaSHsVBvP6llya0dRKqj6F0n9vqzFTfvdvNTOU8aBSUJmEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909598; c=relaxed/simple;
	bh=a0HIsecP77lzQZZppYz4eZx4iBntpmKFcBBBTudX1wU=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=gVXJ5ZJRdtfKMnlLg0mj68GZVt3VeBeUC8E7sPVrZTQ2AT43AnoZ+dF/Q2IhqeIzmAqoewhLFfJCGk3u/bZp4ItpqTSxwBrW5EO0MW/5tfMloFc8EsanUOJ1bRVz83ZeK/QTiByLjGtBdI1ZK3USCR66mnBRxhhX5wRXkxFCHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvdgtXVW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvdgtXVW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6061F000FF;
	Tue, 13 Oct 2026 16:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909597;
	bh=a0HIsecP77lzQZZppYz4eZx4iBntpmKFcBBBTudX1wU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KvdgtXVWTwSNmjsP2kz7kh7UTl5Vn2N7E2h1mgnGpah5z2cQGxZNeiLfNnEgM4i+R
	 GdCgMyLPiBxo427bSep4saLIJGUkhviJyxHB0tELG1JtUA6ARhLuCuejd2t7/fC5Fe
	 ZYoYuJuaL5VIeZn8X4WVqMEQ7y43I9ddnhGMbAFeJUo+dBal/VMzPOdVxqexU2NxLj
	 DS/uUUWep9nbOpA7ZsYNziqeTW0OPtVVEQtycvgBvxz5V+hih3OMFOC9sIH24WYURP
	 RU1wA1HQVWXCpl/qBtK7PT7puKiQGlZoLQ/K4gUVthcr9SZxqU8gVt0RU1D4Eapo8D
	 sFFNV+966nXag==
Message-ID: <sashiko-outbox-170131@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 06/13] PCI: liveupdate: Preserve bus numbers during
 Live Update
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
In-Reply-To: <20261013162529.1928093-7-dmatlack@google.com>
References: <20261013162529.1928093-1-dmatlack@google.com>
 <20261013162529.1928093-7-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:39:55 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Keep the secondary and subordinate bus numbers that the previous kernel
> programmed into bridges, rather than assigning new ones, if the previous
> kernel preserved any device across a Live Update. Do this even on
> architectures that would otherwise always assign bus numbers themselves,
> e.g. when pci=3Dassign-busses is passed.
>=20
> Preserved devices must be allowed to continue performing memory
> transactions across a Live Update, so the kernel cannot change the
> fabric topology. Changing the bus numbers of a bridge changes the
> RequesterIDs of the devices below it, which would require disabling and
> flushing any in-flight memory transactions first.
>=20
> Apply the policy globally rather than only to the paths that contain
> preserved devices. Bus numbers have to be preserved above a preserved
> device anyway, since an upstream bridge cannot expand its window. A
> [ ... ]
> Require that CONFIG_CARDBUS is not enabled to enable
> CONFIG_PCI_LIVEUPDATE since preserving bus numbers on PCI-to-CardBus
> bridges requires additional work but is not a priority at the moment.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261013162529.1928=
093-1-dmatlack@google.com?part=3D6

