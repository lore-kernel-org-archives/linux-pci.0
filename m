Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795460620;
	b=5Sf9LqW39hLfFRfu/zh126tfvobHWTiUmDyZj6aqCzZQQNrIaDvBU7vd4ns15Fmd0fsb
	 ZevgIMOmFrw6EKebwPAjlflc/TeFuYkZkk0DFycc2B44sj7OUhHbVBjZ/TAs6R/S0QhZA
	 4Jx4SU5i3LiR9Bux+yCGiFHyyY6KLFpUb3SF/0KSbM6PPV32qD0XURL7c/W395LEPdOOf
	 jtYSfMhjW8stjrAppmAxy9FqZ84rq8rO/NlErX3n4RvNJdt7APoGm2Dl456+OSj6+3Vt5
	 CHmEQPOrEOsPyJ/jJeVPg4rEFF24MgfkxJXmvdTW+GtZB0nIwNgFBctwpW++IPaksuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795460620;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=srd7A8Px0pWz2BTVMFMBIEagss8SSqXkeJsLFnOz6vw=;
	b=DJMM3UxpAbSaFDPO3lANRKR7hTyyU011kmSvwzx+bCXFz8S2AP+8Xl91xzpbdkyva8YG
	 2yXMceYus9SaeV47wpOIV/NFiW3Oa+8Kftdij//djleLcABvm28C46IvCztdNZa/QKfGj
	 g5MCg6tKnyyThxClhe73WOeNx2RDnWd7OvnXy8+nB8WV7PV0p1Re7pNtt5raxGoe5Qys0
	 ZFckEP9meyF+zBTZyS5p9066xbqXPgutaxRP0sF045F2vJJDg05Ws3iitUWAIWYNR0GVu
	 xX5THbO8zNobj/PSERP/7P6r9fNgKJMdfqa+Ie4U3zTJSggAfXWxthp1XfHt4Evvptw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UAp5tdW/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5472606A31A
	for <linux-pci@vger.kernel.org>; Mon, 23 Nov 2026 19:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAp5tdW/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE1EF1F000C0;
	Mon, 23 Nov 2026 19:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795460620;
	bh=srd7A8Px0pWz2BTVMFMBIEagss8SSqXkeJsLFnOz6vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UAp5tdW/6wfEljyNOjA7Ou6pReQqwzpzgwgH9ftvki/W/a8xyPBEGwIE48GycmcUv
	 AyjHCIffHrPNhSL+4TXV25JIhvZtzIJcLChmTZDxNyES7yHcfA8M3/LJJ29gah+0Zh
	 EUsqRiN8BbFT98OJHscCGPNXrFkh1TFDM9GjWUimo7rYouTVDscz0CFZYi5vEdJZJ2
	 q1NFJUysPDwjjF6IaWWKDqe9CREqV4KG8DvsdWvhXDIXn9w+agO+dgf3SEzVPaIcaM
	 QnD+7jZSp88oDtcMpzN5JxfFw+I6YG1WwsHtRxWgRFNhwTbQg2VxgI7TBzIU90w1DY
	 QjnJvNtpO+wkA==
Message-ID: <sashiko-outbox-229905@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] fixup! PCI: liveupdate: Track incoming preserved PCI
 devices
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
In-Reply-To: <20261123190045.2166865-1-dmatlack@google.com>
References: <20261118223704.3286085-4-dmatlack@google.com>
 <20261123190045.2166865-1-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 19:03:38 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> pci_flb_finish() logged args->data, but LUO does not pass args->data to
> the FLB .finish() callback, so it always logged 0x0. Log the physical
> address of the incoming struct pci_ser instead.
>=20
> Reported by Sashiko.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123190045.2166=
865-1-dmatlack@google.com?part=3D1
