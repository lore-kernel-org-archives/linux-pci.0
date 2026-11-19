Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127929;
	b=iaAbx7aP4ylM5TGJqigEUija2VhtJaSc0l5frUHPcTbgwct2ys3kCY/bsMbC5Sg5RaVT
	 5qmxSj2Oa8/N1WgQnBQeVHf0UnmT2tlyvEJ4ufFj24PKvqm0jwaPwNZ4WKptCv5h38n8K
	 M2rlimLSfH6B5sy3cLRxjPPSq6RqAGsnWlso6bDKLGIYhmNo5zqFCM/l0BbHmVfbuxl85
	 qHzzD+Ai4ofZumQIaqN9VtOXQGniHJ1UrLDe7hSKugqqHIlfueH8j+2rrVNpiQRkPNNn8
	 b7A43obVIfTGrorltFov3cBtNqtFENite5SIXWevxT8zZOoax8DG9U2sRHxx9/D8+oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127929;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=irXaiLNxNIRor6WB81c8MCLuB6vzrviLIeUiIXwvLkw=;
	b=jwa5sHMsEj1LhlaroscUWjQlEgufDBxeK5x3J5DDskze6Or5xAT0TPqQOA0B4WDZQUdX
	 YlUrmUReVFauOgOiUNaPcXoIkPBQd9/w/DHMpqGMfBgdcrgJ7JkaxGZ/ftHoD724TuVYH
	 pQDMQND3DXiZ5qllNILiraYe2zeh+9gUHrdO0pfFPDqTdkBWX8vaIZGi11ujuwHtLQKhM
	 4jpdbp0Pf9nbCL4JpwTj6pc0Yle6Kt/Jf7qLQgBS+cr5uW+R90AAUHlK1wtkMyxK7J0Tt
	 LBWux5YPdZJX0+lBINjordUU0TE+x3e1LL/3HifNu4R+pwV2NeZaqRHdD+1VA1MAfdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEhYgGIv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BCB606A333
	for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2026 22:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iEhYgGIv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420571F000C4;
	Thu, 19 Nov 2026 22:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795127928;
	bh=irXaiLNxNIRor6WB81c8MCLuB6vzrviLIeUiIXwvLkw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iEhYgGIvRTH185Wz3HIJSmjnBqXEoow0hpHIF39JYGfu8ZGY5CxlPUwC8hRqXcFap
	 SV1OPq0caLVxEAqJmgVNkkrCzUf95RBDqRqawkBF2kdsCsdLXuoQNVucpCoAiXMF+Q
	 lE6G0AI1uMtFAspf1bvjYj8a37VJCsEUfrx/HhqRw1GyUBajsoWTpMZEb9U8uMFnDp
	 vpDZRXz88/55BxuFNf2qJM2Ctwjkf5p9+gg5vzWq5De83h+EhWsGFGH07f1wjjzJag
	 E+vl7kkUMYj7D+X7h2d6S3kIjd5A7J8JwJwKjPDE3IIKSRCurJMT8B6wK+u8eXhZE4
	 dAuvtF+wVVxfQ==
Message-ID: <sashiko-outbox-224148@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/13] Documentation: PCI: Add documentation for
 Live Update
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
In-Reply-To: <20261118223704.3286085-14-dmatlack@google.com>
References: <20261118223704.3286085-1-dmatlack@google.com>
 <20261118223704.3286085-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 22:38:46 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> Add Documentation/PCI/liveupdate.rst, which pulls in the kernel-doc from
> drivers/pci/liveupdate.c and include/linux/kho/abi/pci.h, and link it
> from the PCI index and the Live Update Orchestrator documentation.
>=20
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118223704.3286=
085-1-dmatlack@google.com?part=3D13

