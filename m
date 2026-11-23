Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460666;
	b=Mx0SdhNwMVcSchQ08wGlOanNPH2zLXs2eN9MUX9bQuYdqMsphCk1BcziVD7+/9dgfErL
	 Cs/xzdSvfWLzrCqfKJojVC0bdWSM52iZMZEgGQXQGBlNO3ZYo88+Ex2ZWnjlBLW0mIueC
	 1VaHlqgRHx8uoG4Pmp2gKaSLu6LawbKC4cbtHJl4fDiZeVdt77pqk922HItYjJ5udVQZe
	 HkZGSYh0rILWmY2JxbAsYTJhm3UJjauDHs0FpNzB1eSd9HR438qePsxVzaDnsx30yqo+l
	 v6HhCUnYdV2W0VolLUZwHEKhxm8gI1edNy3YAsQdllGhhK4sNI1dcT4O2ZNsg1TGJOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460666;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=d0+2tNhiFJflov+MWXi2AvsUab0DMDTfOzzEpvXOaCo=;
	b=oWQRz5dzDbE5PQq8mF8qq7zeyjd2f+qe/du2iAW4vT4ngLER3d+dx35ywZpuQtNPohCF
	 2hvAJhXQZMaeeawAOnWPoL6hDVnS3ZhVSy+rkSx1mO+PDUWaBo0tKeHuxw8i50PMQURa2
	 bj/rbAn+hMQl/Iu+botvyo0a5zvNplmQkvTjSXQftrOVFeY2SsNTjwUblIw3AqJMiFlvN
	 pxIyZl1TYsq5s12QtnSKY8HSAskGDUFB5zMqJlAiS/so7PbW9nbQePN/mm/Gp1fcmL092
	 1tI3CKgGS6Ix3ZuNWSRWkKHZVysDrqDn8yTmu/Ff6LMxIRBlNCuOmDD7DjZH0ATtujA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LBKfv2W/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6287606A32A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBKfv2W/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213491F000C4;
	Mon, 23 Nov 2026 19:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460666;
	bh=d0+2tNhiFJflov+MWXi2AvsUab0DMDTfOzzEpvXOaCo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LBKfv2W/WihCUWBZCD/WeN8/kea/RHHGPfzxz97KZLlJGvjc0xkZydEace0hfP2JP
	 pWaGgajMts6nc5VZYACrCzx6wCMavBIxtBX/6VVQzNabEl0d4MRCXX8qaDB/WDR+fi
	 Bb//hH80RG7wTQ9kspMVExrL5oy7SXDACL5YmOYvxtvLmdsaYy+wkcVEd1s7LBXTGW
	 lvU+s6fosVoNgMzc/9ZpESP1QXgmMXaAhRjVn+RNuMTjIq4dgeg6YIyVkoyHCIGOYD
	 luvUGRUJatHQpnQZ7NZH0uxnTTti6ckBlFsDKSnhDQwcbTRJvU14Ct2M9Hc6DGI5lM
	 CGw/xmE4kn2Fg==
Message-ID: <sashiko-outbox-229906@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fixup! PCI: liveupdate: Adopt ARI Forwarding Enable on
 preserved bridges
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
In-Reply-To: <20261123190045.2166865-3-dmatlack@google.com>
References: <20261118223704.3286085-11-dmatlack@google.com>
 <20261123190045.2166865-3-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:04:23 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Fix the comment in pci_liveupdate_adopt_ari(), which claimed that ARI
> Forwarding Enable is always recomputed after the preserved devices below
> the bridge finish. That is not true with pci=3Dnoari, where
> pci_configure_ari() leaves the bridge alone, so document that the adopted
> setting persists in that case.
>=20
> Reported by Sashiko.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-3-dmatlack@google.com?part=3D1
