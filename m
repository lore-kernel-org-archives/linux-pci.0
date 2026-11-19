Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127916;
	b=KjbI25cXFA0SbE6vWgvWUXvRNJpDu07zrJzWeRk+DPkXM933DvTVvFZovdDG/pe2/upy
	 XO4TOI9zEOLKwSvCUlc4zYpq8UZOBfRC/GOCtqb9/Ul0xZrE8ZJcWLYiaZXqzcfd3qd2a
	 oNkBNiIbSNZch3DFWk61AgXnxkuQGHDH1vF8KCKGberFLVwDgnxdbxKBJFrYoPxaKJyBG
	 VzBhTopaRQeDUc31tbpoqjLcHO4EJZxR+gUUzcJ+7JfLpq4skoW7Gqut5qNAVTkyWq0vF
	 n0XyAtgG5f34+srDKKazsdGYMCNCmYRFlLlBiXDclyYn7VlsjzS+kFi2vXOfkgMvtuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127916;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SC8h+zDQaBZWH6G2HF3lPpzecIAbPoNIyVZcCrTdZfY=;
	b=TlqrsFVVUSu2CyEiwDdSVOqWXMWY9IvLc+//5QQz7snnN8kVWZloVp3NcE/z72PTFrSP
	 9l1ykfzZ91/3VcMtdIBcO0ctTBaLtFcsFvOMt8OQtT7GyLg91wizs3SfGoTvRpoZDmWsF
	 O9hteeHTB/LTan38/5SdpUjRfMz6iqnNj0RdFG0F0kjCe58/qeS2tj4w/8Vim+chD+PWf
	 b9p+qAUx1Vx3TeVtBqaT7tK4FlI/fxLd9S2T/vVCJhBANPWHmv4m847YcG9qGgl+/DiTt
	 WWEAfS9DX+bZdl9l4CAHwLllELnLyrZsHkFR0oTS0lGD9/+2w2dUBMn0oBy/BqRNTeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OL/Xy+ag";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E5606A325
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OL/Xy+ag
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E96EF1F000C0;
	Thu, 19 Nov 2026 22:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127916;
	bh=SC8h+zDQaBZWH6G2HF3lPpzecIAbPoNIyVZcCrTdZfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OL/Xy+agxNjttpyvulvD2puIJoN9OHjCLeeXHxNOdpGcs/pH2lYU4EdUETX5zAkUD
	 UDjimiUsEk00GPq2eR0kVX+nFd508/XdmRU+ldYfl+Q78FSXRRI7oLN/OOewoUSQDh
	 zhaYbzVPH+hiC2fNGTMu8do80O2BXKcywQsWi1ZVuaXn9pbGG0vkRdHeF/H6opLPcu
	 4u7b4bf7xAn1szzjdmQVSr7lUz1QBhPywk3CIwmFFtF3EHCqHnbgY0Vju5arJaXbOI
	 qPH2E9ozTlZawBN0JDJSC5gxqrXdYYwyIz8/gC+N9JsjtfRKOwjnL7iP4ZKe3kgiXi
	 MKAT0ZUdC6hKA==
Message-ID: <sashiko-outbox-224143@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 08/13] PCI: Save and restore the ACS Control
 register and Egress Control Vector
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
In-Reply-To: <20261118223704.3286085-9-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-9-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:33 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Save the ACS Control register and the ACS Egress Control Vector in
> pci_save_state() and write them back in pci_restore_state(), instead of
> recomputing the ACS controls from scratch with pci_enable_acs().
>=20
> This makes ACS symmetric with the rest of a device's saved state. Today
> pci_save_state() ignores ACS entirely and pci_restore_state() re-enables
> the ACS controls from the kernel's current ACS policy. As a result, a
> device can come out of a reset with different ACS controls than it went
> in with, e.g. any controls programmed outside of pci_enable_acs() are
> silently dropped.
>=20
> This also lets a later patch adopt the ACS controls established by a
> previous kernel across a Live Update rather than assigning new ones
> through pci_enable_acs().
>=20
> [ ... ]
> keep that configuration outside of the ACS Control register, so don't
> allocate an ACS save buffer for them. Keep configuring ACS from scratch
> on restore for any device that has no saved ACS state.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D8

