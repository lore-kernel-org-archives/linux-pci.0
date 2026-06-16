Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0AF33A7586
	for <linux-pci@vger.kernel.org>; Tue, 16 Jun 2026 16:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627802; cv=none; b=c6nJwIxFel1C6buOUWAgV20rHjAtANgkpeMjyz+XjS7RZQd2jnI7f3U8tIxQE4Kic3avThMmBNJtk/9F350DcqzEjwNuEX/7ui5Ma+nnfBKzg1kG5bENzisJjRV2s/tuBPpIr2QaTiWrD4a9iXf5RYBwgZdQZ5njqB2UMvzK4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627802; c=relaxed/simple;
	bh=taGhMy55aTuxQuHiSlMvKhvKxHtl3MWoDW0R7uZbnzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D7cGDsKF/odsgHn00U9P94Z/LYcUG5uVwLDGPG+xjAEAnhM+AGf1DCwpe4v800JWKHKp7TMsxT5gURJdyJWYuCVepTIMN2fL5X5oXbp+/OZM7Am3BBNLtitsEpQQAPXlGOGY5+noTnCFOJ3OsB1a143u/siE3kglRmnLCx/+TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQqwohYU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQqwohYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B87D1F000E9;
	Tue, 16 Jun 2026 16:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627801;
	bh=C93TKaaKNGEgajri7sZF4w14iXJZalqd6mUoGufj+kI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NQqwohYUvDom4+C9Li2Y0pCI9DjqaDRE9q1mu5aQqvPkKYAN7mpcZ+V9l5DII95hr
	 vyKbd3M4aps5v+af8fDWzxZFIngkL+d1xzDzFTLYMiRURiYNotiX8B0WZy20Mk9HUw
	 UTiuTuRVOgSJUJoWJb44h6eGv97/0GDHkp+yxWoy7hNKwtvSYr1kRiaK1XBloTtqgu
	 6D/XwM+D6aUjUBi7WMRZcsd23TE25cZn7CcwzBMthbWwDfOzA0gepNI9O9iqdb30KG
	 etX2IAWoivfajSbeqaLxfLb+irSj0FAVUAL+WB8MxcZgNox2O1SSdEaGpzS1dLBytN
	 Q99QqnLZaL/2A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI/sysfs: Fix read byte order in
 pci_read_legacy_io()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260616163131.2763281-2-kwilczynski@kernel.org>
References: <20260616163131.2763281-2-kwilczynski@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 16 Jun 2026 16:36:41 +0000
Message-Id: <20260616163641.8B87D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> pci_read_legacy_io() passes the sysfs buffer directly to pci_legacy_read(=
):
>=20
>   return pci_legacy_read(bus, off, (u32 *)buf, count);
>=20
> The PowerPC implementation stores the result as a native-endian integer:
>=20
>   *((u16 *)val) =3D in_le16(addr);
>=20
> On big-endian PowerPC this stores the bytes in the wrong order, so
> a 2-byte read of a device register returns different bytes than two
> 1-byte reads at the same addresses.  The same applies to 4-byte
> reads.  On little-endian the native byte order already matches PCI
> I/O port byte order, so the conversion is a no-op.
>=20
> Thus, let pci_legacy_read() store into a local u32 variable, then
> copy the I/O port value to the sysfs buffer using put_unaligned_le16()
> and put_unaligned_le32() for the 2 and 4 byte cases, converting from
> the native integer to little-endian byte order matching PCI I/O port
> space.
>=20
> No changes are needed for the Alpha platform.
>=20
> The legacy_io file is root-only and exists only on Alpha and PowerPC,
> the two architectures that define HAVE_PCI_LEGACY.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260616163131.2763=
281-1-kwilczynski@kernel.org?part=3D2

