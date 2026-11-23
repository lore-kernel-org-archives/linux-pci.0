Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460699;
	b=1M94MaO1hG1SIXb+Byb/s4kKT1+5Ft0qok4vXmo6xpZ0AHErFEOMZ/6FwinWYBdHIfzh
	 fsO64WYRMqMVVT5Xz8dpTikrAM6Nj5f9UxvqvrZZP7IKDCMUFjQ7Jw/nsEoYJXh0dW++m
	 rEmoz0bpHnN14Q1JZoWcOSj/dw3REVcPvqAh2XRJGhVIExU1BWIe8A1xisuSaSvqgEEV0
	 3Zd9lj1CHB5L5dQEgmZcu1zHqSpO3IdntqyGlcgeZo+DQDdnoQlW5nZHGyzq6ni8LBC5c
	 ect1B6OZvPwYe7XsOM7RxDS/pXXZQDOjI48Waua2Wp7DK933YRepJx2U6jqv4/tIB3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460699;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8yNQkmQ9W7+6H0nowxTvFVztBcdqeEWifqsvT5sSXQc=;
	b=ySvwXkqHNOeG3MhNRdaw+26l8ZKvjtlwFpwGPNA4ei268MX8J3G8OHK65CSUFXpwoZpT
	 v0Hu4vFjfRwIptVFRg2zjCPyRbL1xdJp/QTOTj9KpDmV8DtNvFcZHnrXA8wkC9+9H0Cl+
	 69p+//L9UDqwAiiOMoP8USMErvXFjcJIiEBl6hb/XFUcl6Wf2rZPFzEqwXE/6UPzd3HmZ
	 u2Z6PYldwvqoJw5e1wxJYpfrTIAXQ9Zkqx6eRaPummaRshsNlYxu55gxJ6KDY1h2+K5Gi
	 LowSNDmWD5OTCaxfRNk2fBk6axnO4e2Xde2IOeWuzN2Pci7MR8Pi+VU5knSAiAjusaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEBmzn5x;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09496606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HEBmzn5x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2454B1F000C4;
	Mon, 23 Nov 2026 19:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460698;
	bh=8yNQkmQ9W7+6H0nowxTvFVztBcdqeEWifqsvT5sSXQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HEBmzn5xQMmzwun5/DxZ22UzPCD2jKX/bQDvPKrMHsor7HNC4pIf5nh6EIejmJps0
	 EI2vp6qgoHMZ4hZEtkPgxLq3ft2hdDonJO8HZdqORS2g1vPPK87FtWympSEAo+g3Lb
	 rpdD6x5ru0d1hQBx8gQF8vE1FhrggKCfDwRQ982AtOgQrS2/f7aMid4P9yXgsgObHG
	 /V754oOG0zXkcahTENS6GSRwHWDxatJwfT0q1SZ8qN8lJkrHPgn6fMHBUa53pBYrgT
	 T7UlDfoWvLnB3S2ks8W1Ni5G9kmN3SDvQF0ebU5ztSGijo/510L4jvdc/tr/K47vGx
	 OpjMHp0f7KW2w==
Message-ID: <sashiko-outbox-229908@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] amend! PCI: liveupdate: Freeze preservation status
 during shutdown
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
In-Reply-To: <20261123190045.2166865-4-dmatlack@google.com>
References: <20261118223704.3286085-12-dmatlack@google.com>
 <20261123190045.2166865-4-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:04:56 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> PCI: liveupdate: Freeze preservation status during shutdown
>=20
> Freeze a device's outgoing preservation status (preserved or not
> preserved) during shutdown for kexec. This enables the PCI core and
> drivers to safely make decisions based on the device's preservation
> status during shutdown.
>=20
> The PCI core freezes every device in pci_device_shutdown(), not just
> preserved ones, so that no device can be preserved or unpreserved after
> its shutdown starts.
>=20
> Only freeze devices during kexec. Other shutdowns do not depend on the
> preservation status, and they do not serialize Live Update sessions
> first, so a session can still be torn down after its devices are shut
> down. Refusing to unpreserve those devices would make pci_flb_unpreserve()
> panic because they were never released.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20261118223704.3286085-12-dmatlack@google.=
com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-4-dmatlack@google.com?part=3D1
