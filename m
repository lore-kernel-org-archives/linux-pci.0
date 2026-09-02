Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37C137F312;
	Wed,  2 Sep 2026 07:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788334835; cv=none; b=EiN2CeZEor9RpxWKu9RvsZrNfsIeN/Ywi83nyGhY/Gy52/xcRGkoSfMUPXNzzHwibjVgM0uRuYrNstwcPyI2OWdVCT9PcDd/1tY58UMZLxr3CXEMdb1yoKZGBAZJIWAELTApXOeDZR8nunzHVdUOtwgg1JSOWA5BiVUuhvSfvPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788334835; c=relaxed/simple;
	bh=0AhZTX3Oz1RvxXF4duuaJyhNdof6jqAqheZBRbxoh9U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zh3KP1peCMl1c1Lsw9ehP/8rlD6JaO5NL/dVn/SFoiYd8ZTk7J8GB8nf0+Nt+Wls3S2wm0rPgAqMHjdpPB13x0gbKniUcwmuK+/6+F4WUESEsi9Ixt3tn7JCAOg+X6xT5czYF8yxymbIdaAiyUx02QXcgIfPrcrQzZkpFQbjriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aScBVaK8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aScBVaK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 842A41F000E9;
	Wed,  2 Sep 2026 07:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788334833;
	bh=0AhZTX3Oz1RvxXF4duuaJyhNdof6jqAqheZBRbxoh9U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aScBVaK8hJcxATMkLNyhVOnAlGAm+nVeVz+zdjcOyS9nNqHDNe1wr456M9UeKm/xr
	 YwDXn1L3vn7kVly2pFGLgKyKU6FKqDSXK5wkvc1Ba7+K908/Gn/QN5L732bQbA1e/u
	 mIt/Xz9bl9LvG+IMVpENgrEjlH6xiOzax5eDV6P/tYGAOtT1HqwhAzZa8j63iswdLt
	 AMgUWURO/idSHspp5KgMiVNPHuDZ5Lecal0WpWWTXTHtIY3B1h8vcCl3QpBmCpRrmo
	 +IhSjVgaxUP0/kWYSks+DQY0N+Y689qWmg56/89D1ihTfawZ2d6c25BzE9CgsUiYy0
	 P2eqG4CGRytXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 04/12] cxl: Cache decoder settings on PCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org
In-Reply-To: <20260902072804.665639-5-smadhavan@nvidia.com>
References: <20260902072804.665639-1-smadhavan@nvidia.com>
 <20260902072804.665639-5-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 07:40:33 +0000
Message-Id: <20260902074033.842A41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Add CXL core plumbing to refresh a PCI device HDM decoder cache when
> decoders are enumerated, committed, or reset. PCI reset paths can use
> this snapshot to restore HDM programming without walking CXL topology
> during reset recovery.
>=20
> The cache is populated by PCI-side discovery in a follow-on patch. Until
> then, the CXL core update path is a no-op when no PCI HDM cache is
> present.
>=20
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902072804.6656=
39-1-smadhavan@nvidia.com?part=3D4

