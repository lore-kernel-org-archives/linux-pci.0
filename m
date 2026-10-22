Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792682781;
	b=c1mxd8cIDbEnGK9B636d5ff4JY/OJGlrll5g+PaK7Kire612IZRJe1FYtZr0bCflciz/
	 QaAclV4pxz4/ZDd2BrU3qPqeFrNAnpSQWNcw34Zazt3ZrSQ5Xt8NHineyxnXhWzwbOyGk
	 yjr+TDJkUcylb09Uf4JbTrLoIpnFQw8Lv53y/BN8h9w46VQfFmZ735E1+vI8KTNnjSAbK
	 RJn6E3V0d1ZpB/0bP9CMoJ6jiMPL4vzakKwNR2bgxUDX3kAsOCSPudGiMtxwD8L/qDHyw
	 8uZI9p/6QIQKMtO7pXUXujJgU/MyTNFmPoS5Tud3mWkBLFCBPBrL81pCoh9rKqZpP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682781;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XE9yWNlXsvGeGCWhIwmUN0zA/ByHkLoM4gSXGnB7k80=;
	b=VjQolwO5UnvqWjggn8OrU675XWpMuNwhF95d9ZG26AtiuA5Dk2bEL65SPVrDX9lfi2IH
	 jioffZTP0p/dh70MmIv0BV5lXUEWoVODit5OZ+93ti5qzpeYqJcRiimHLrlrCBcXYUPwx
	 RZFdE8FA+Ye3w8XZJ+iqOAgsVr8XddCCY+vpQL2/ouFQf15Ok3IqA2+mSzMXvbg9aV5dy
	 XlLEtKZJgSBkLARHfuBR2v5PxYaloGxmEHFRREHs2Pm+W8QlvYbnVcBRJST+/pPe9ZKGd
	 QO2s35DBXlXLgfTEsLAd/D4j15Os3+7m2Cbz5wIxWPe1ZIG4HbC4xxgdBXiD7Aj1peg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O56pynoB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72727606A319
	for <linux-pci@vger.kernel.org>; Thu, 22 Oct 2026 15:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O56pynoB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9442C1F01825;
	Thu, 22 Oct 2026 15:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682781;
	bh=XE9yWNlXsvGeGCWhIwmUN0zA/ByHkLoM4gSXGnB7k80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O56pynoBI5KpalG2BPlOv25DBE/DEB5Jo16dwWZI1bKpSwVasiwoaBO1B+nBR3eOF
	 YrEtrKJrO9UkWi/jNc1BfYPdxje2j0uU60E6Pg+WdQaOrmL8g4EeCnA0KLeLbCb7i7
	 er3SvneVxCrxpHGAWPs5GmcYSwXSO7wtrEmLhMyWBHTUVOkYHN0NDjN9GUc9uO6oMY
	 cOzfWrc24kvsxvGG/LnXoNum4o0AxvpJVhyL5kv/WqiNeQ4T0zB4p8n5WLNGwhy2H9
	 0cVGOxksMK6cJDnWKS8W86VS2dru3kyz6Q+X1EdtUk/iRdG1ew7Tj9iyvnWzBcp+PF
	 84J3rrpwuU/ng==
Message-ID: <sashiko-outbox-181697@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string
 with a 2-bit pair feature header
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tarun Sahu" <tarunsahu@google.com>, "Andrew Morton" <akpm@linux-foundation.org>, joro@8bytes.org, "Mike
 Rapoport" <rppt@kernel.org>, "Pratyush Yadav" <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de, "David
 Matlack" <dmatlack@google.com>, jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com, oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org, dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com, will@kernel.org, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Alexander Graf" <graf@amazon.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, baolu.lu@linux.intel.com
Cc: sagis@google.com, linux-pci@vger.kernel.org, kexec@lists.infradead.org, skhawaja@google.com
In-Reply-To: <20261021152527.375070-4-tarunsahu@google.com>
References: <20261021152527.375070-1-tarunsahu@google.com>
 <20261021152527.375070-4-tarunsahu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:26:19 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> LUO and its file handlers validate handed-over state with monolithic
> compatibility strings ("luo-v5", "memfd-v2"). Any change to a serialized
> structure, even an optional additive one, must bump the string, which
> breaks live update between adjacent kernels. Replace the string in
> struct luo_ser with a feature header, so that the target kernel can
> accept or reject the source kernel state per feature.
>=20
> struct luo_feature_hdr is a fixed 128-byte header: the serialized
> structure size from the source kernel followed by 15 chained u64 feature
> flags entries. The fixed size keeps payload field offsets identical in
> every kernel, regardless of how many flags entries a source kernel uses.
>=20
> Each feature has a 2-bit pair (req, active) state (enum luo_feat_state:
> LUO_FEAT_DISABLED, LUO_FEAT_OPTIONAL, LUO_FEAT_REQUIRED). A flags entry
> holds 31 features, and bits [63:62] =3D 0b11 chain to the next entry (465
> [ ... ]
> Future changes add new entries to enum luo_core_feature before
> LUO_CORE_FEAT_MAX.
>=20
> Signed-off-by: Logan Odell <loganodell@google.com>
> Signed-off-by: Tarun Sahu <tarunsahu@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021152527.3750=
70-1-tarunsahu@google.com?part=3D3

