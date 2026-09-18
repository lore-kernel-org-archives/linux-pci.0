Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F735237BA;
	Fri, 18 Sep 2026 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789762483; cv=none; b=IU/ElgOYqLHITCPfqQeIYVz29fuCRYYkAMeXns5DN/ujYuI4QGQBwm5vQUAbKr8Lyk0VEllvJnCkYP+r7LIqjwr4gkEZvcjNUMxZwBoHb7d5anDjbWiH4tuL0ZeN8u9pIQlpBo6hOkCdqozIREPugb4U6S8EEJDbn3g1mT5BsRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789762483; c=relaxed/simple;
	bh=Q17JrGUK4X2t1hdvERj4yssWTWrML9FbBLdlOjJS310=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0OQMv1p9/gMx7rVPX09i8CCa0CmAbxoLTlHZII1apUrX+EbMMJYC57DVhoshVporrf2Cosq/ZCdGxPvaPciw/Mv4kYma4hxcgT9i0rNPvyuMcMRacNdwuy3zJZgNnqETt5R+Spv7rFoGTePmoPckWs25VGTvo5BagvCDoALzYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ETBEHQSj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ETBEHQSj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DEB01F000FF;
	Fri, 18 Sep 2026 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789762477;
	bh=Q17JrGUK4X2t1hdvERj4yssWTWrML9FbBLdlOjJS310=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ETBEHQSjaEbWTS0FCNxpNsb4d8LaDdQvdvmy91bRbiFD/AtP90FJQjYsAaWVb2aqA
	 OmMgE7vCtF8xOjhn9m38ewd62M/91G0v6uoI1y+8AMBTyOmyK0tXrJV60eaBtA8ZVB
	 ZnpMvv3o7E33QrBp5wb5ZnyRGO5/VBIPM1JVEpN1nKSQ0KIxK3vBeW11oCyqgdI7e/
	 7CwIRWGIipa5Q1VNV7xrMLrNBkL1KIOKc6hU2iUjiyTsqlwWBgx/M18t1++jdRB+NE
	 ulLb1dshJBfQS38N259RH8mEbQROFMLVWMYs6vE2xJRh1NWybcJ+jM/Gtl79jg9t5L
	 hbf9pGUtrElYg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/13] Documentation: PCI: Add documentation for Live
 Update
Reply-To: sashiko-reviews@lists.linux.dev
To: linux-kernel@vger.kernel.org, "David Matlack" <dmatlack@google.com>, linux-doc@vger.kernel.org, linux-mm@kvack.org
Cc: "Randy Dunlap" <rdunlap@infradead.org>, "Lukas Wunner" <lukas@wunner.de>, kexec@lists.infradead.org, "Adithya
 Jayachandran" <ajayachandra@nvidia.com>, "Alex Williamson" <alex@shazbot.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Shuah Khan" <skhan@linuxfoundation.org>, "Jacob
 Pan" <jacob.pan@linux.microsoft.com>, "Pranjal Shrivastava" <praan@google.com>, "William
 Tu" <witu@nvidia.com>, "Bjorn Helgaas" <bhelgaas@google.com>, "Alexander
 Graf" <graf@amazon.com>, "Jason Gunthorpe" <jgg@nvidia.com>, "Parav Pandit" <parav@nvidia.com>, "Samiullah
 Khawaja" <skhawaja@google.com>, "Vipin Sharma" <vipinsh@google.com>, "David
 Rientjes" <rientjes@google.com>, "Jonathan Corbet" <corbet@lwn.net>, "Pratyush
 Yadav" <pratyush@kernel.org>, linux-pci@vger.kernel.org, "Mike Rapoport" <rppt@kernel.org>, "Saeed
 Mahameed" <saeedm@nvidia.com>, "Josh Hilke" <jrhilke@google.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, "Chris Li" <chrisl@kernel.org>, "Yi Liu" <yi.l.liu@intel.com>
In-Reply-To: <20260918200640.887030-14-dmatlack@google.com>
References: <20260918200640.887030-1-dmatlack@google.com>
 <20260918200640.887030-14-dmatlack@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 20:14:35 +0000
Message-Id: <20260918201436.0DEB01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add documentation files for the PCI subsystem's participation in Live
> Update.
>=20
> These documentation files are generated from the kernel-doc comments in
> the PCI Live Update source code. They describe the File-Lifecycle-Bound
> (FLB) API, the device tracking API, and the specific policies applied to
> preserved devices (such as bus number inheritance and bus mastering
> preservation).
>=20
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: David Matlack <dmatlack@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918200640.8870=
30-1-dmatlack@google.com?part=3D13

