Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794377798;
	b=wXx2KLEh976gw2Mby7Xxh3S5zkty5Dhhg5ZNhF63R+meQjFRMRtyI0mRY1Hf09rpt+U+
	 j2IJvR3sItD4PkURFISmiVDuujAnCG/BoWam/m6amgg8TcbX4R704WiKxmiY3DqXtoO2Z
	 1heQkuULvndV994Vz/aKOS3lMxexv0oqADZMtP8LdxnncLM9vMg1XxW1AJNd9Q9I95/sF
	 faATiniZ/OIQ6lo8u6Lx4+uuRdyG09Kd9uXwbHKe0gVfwRBqCtlFK4Ffk+4vgc2Vhheeg
	 LwlOGLdkE2qy8p1ZL6dgdHYpP7y8o+PTQ0k0CCybO+LCfwATbBLFI+WNHh1Ot2OhIEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794377798;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=jmri/3hIXC1hkulfS1LbY1DwiOs1O/U8k06v0LuYAfU=;
	b=N/Dl92Aq+POgaU5waAahaJtbBw34AMhe5xDujXRH6y9bJtMz+pGR+rzk/fSMffv1VDkB
	 D18uzLcKgHXMh1gwVEWU/8qd2uMtJHYtE4lkcapIeGusV2T7/bd5iQjctVgQRsxYUFbBV
	 ZhcJnRH35r6+kWOV3coWpUj4Ey9vM/890ygYnDN7PNGKnyu4IgxxQoIAddeN7qHpIXNX1
	 WPh67xzcN5hiJhde/g3dmyr7qdznbvx2ICPA8Hfl+r0KaXzdK6cS9FBOd+qm/UqeDg0Y0
	 Kaa1fGCGia6Fr36rEE2sOQ2Q/CXsrvJhXM3S+zSAeg8IgHd3G1U5QxLed0FeYR2ACEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wc+xg9hT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327DF606A332
	for <linux-pci@vger.kernel.org>; Wed, 11 Nov 2026 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wc+xg9hT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BDA1F00A06;
	Wed, 11 Nov 2026 06:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794377797;
	bh=jmri/3hIXC1hkulfS1LbY1DwiOs1O/U8k06v0LuYAfU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wc+xg9hT5y5WkcAg7unw4Vgvrn/WaES8C73CCGxuxj62uYfJ1ys2T7cn5dPN8lKzE
	 xEtbc3Fb2BGBrqVohk2iEVY+3ybuyvy9FWLfn51iM6XNXvJo9WbaF2imxSV/wCg5IZ
	 8z2eQoaHPSi26C1lVj1HXoeUOWo6JdJQgdDeaDEHuWe3sLEynXVF0A8wd2Hopo/Jf2
	 Js4nOEdzoS20+4EeegSi1oTgmOMaVgLBBabJwy9g4QcSuI+mHY1w2ALylp6hGgulzu
	 kE5e/Lgc923grLjIIX5wGwxLnJbCx9hDh09o8twSuIsbp4HOvqv1zzRbOr+aRB8aSg
	 VZo29WtpQkF3Q==
Message-ID: <sashiko-outbox-208409@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 06/19] kho: kexec_metadata: Add the feature header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Mike
 Rapoport" <rppt@kernel.org>, robin.murphy@arm.com, maz@kernel.org, will@kernel.org, "David
 Matlack" <dmatlack@google.com>, "Alexander Graf" <graf@amazon.com>, seanjc@google.com, jgg@nvidia.com, loganodell@google.com, arnd@arndb.de, dwmw2@infradead.org, baolu.lu@linux.intel.com, "Bjorn
 Helgaas" <bhelgaas@google.com>, oupton@kernel.org, alex@shazbot.org, gle.com@google.com, pbonzini@redhat.com, "Andrew
 Morton" <akpm@linux-foundation.org>, kevin.tian@intel.com, joro@8bytes.org
Cc: linux-pci@vger.kernel.org, "Pratyush Yadav" <pratyush@kernel.org>, kexec@lists.infradead.org, skhawaja@google.com, sagis@google.com
In-Reply-To: <20261110050202.529473-7-tarunsahu@google.com>
References: <20261110050202.529473-1-tarunsahu@google.com>
 <20261110050202.529473-7-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 06:16:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> The kexec metadata subtree currently uses a monolithic u32 version field
> to identify the metadata structure layout. Any change to the structure,
> even an optional additive field, requires incrementing the version and
> breaks compatibility between adjacent kernels.
>=20
> Replace the u32 version field in struct kho_kexec_metadata with
> struct kho_ser_hdr using DECLARE_KHO_SER. Later fields can be appended
> under new feature indices without breaking compatibility across kexec.
> Also make the 3-byte padding hole between previous_release and kexec_count
> explicit as reserved[3].
>=20
> During deserialization, validate the blob size against the header size
> and reject unknown required features. A legacy v1 metadata blob is
> ignored with a warning.
>=20
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110050202.5294=
73-1-tarunsahu@google.com?part=3D6

