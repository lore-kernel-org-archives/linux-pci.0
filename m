Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19201A683C
	for <linux-pci@vger.kernel.org>; Sat, 20 Jun 2026 08:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781945424; cv=none; b=hWOwQG+c712DS5JDEKtqE9wMQbtx/PR4yTyKZIXX0dG0ozHsX3JdeK2IDa78z/uU1NixMq4fwDZHQm6COiwf70qa21aXEVpIiQKeauwLeCrZjLs+WWlt5rm7XNwKorYHoEXGHG/2+HwIwnCeW1GCmUDHjK/JwT5suCkHw8sq4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781945424; c=relaxed/simple;
	bh=6CM+LuDgNrHijrdHPeI2vU2skZ/nd8sHccyllaZDoHI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qj8iUF7VVp/ExfnJMRC4IwlTHWtHhNs2I9ZDL6MShE8cPrwNgaRuDFuy70pnsJ7DF2h5lc48FIQhO8z0vwIzd7Y4sTakd0es9navBVJoUkA/xY0E1pA3ykSvQ7M2bx1mIrzoGehi3LDIuWEmDQpmxsMLHIvp0U8gvrkwWKIPgPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CljHuT0n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CljHuT0n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491051F000E9;
	Sat, 20 Jun 2026 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781945423;
	bh=6CM+LuDgNrHijrdHPeI2vU2skZ/nd8sHccyllaZDoHI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CljHuT0nr8RZa6zoU/cx+2gKiAywrE5yl74NTVn+W6TtqwZNZrsOQKD76jYnP4VEB
	 kCCRM0nQ5UPptFRwDy+9CWJ/oBGXpO5uHScCD66ZGWSnyaXV6mVjtGvl1rLIh8w0ae
	 bS6q9jKEE5vfkHijkJtDZbwYeito3JGPOjP5KpAjw2r7mb/g3tK7uCk1vgOKt0UcwP
	 TavlZxaut8fG/3gPl4Vtn7OfwepO91BFHPKuufKgLXCydbRkWrPYBSK+QK8I0Mk3nB
	 Ltz+INtpVXOB73Hrs9NIdWfe0PCtGXl3qQwWVyRm/tt0Ijgb9yJ0YZQEOJxKIhAEhG
	 KhJG+ij/JWc5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] rust: pci: make Vendor::from_raw() public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260620-b4-rust-pci-edu-driver-v2-1-6fd6684f2c14@mailbox.org>
References: <20260620-b4-rust-pci-edu-driver-v2-0-6fd6684f2c14@mailbox.org>
 <20260620-b4-rust-pci-edu-driver-v2-1-6fd6684f2c14@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 08:50:22 +0000
Message-Id: <20260620085023.491051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `Vendor::from_raw()` is currently `pub(super)`, so a Vendor can only be
> obtained through the named constants generated from the
> `PCI_VENDOR_ID_*` defines in `<linux/pci_ids.h>`. A driver therefore
> cannot match a device whose vendor ID has no symbolic name.
>=20
> Such devices exist. QEMU's "edu" educational device and the legacy
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
> `pci_ids.h`. Per the policy stated at the top of that header, IDs are
> only added there when shared between multiple drivers; a single-driver
> ID is expected to be open-coded in the driver instead. C drivers already
> do this -- see `drivers/gpu/drm/tiny/bochs.c`, which matches with a bare
> ".vendor =3D 0x1234".
>=20
> The Rust abstraction has no equivalent escape hatch: there is no public
> way to express an unregistered vendor. Make `Vendor::from_raw()` public
> (and const, so it can be used in the const device-ID tables built by
> `pci_device_table!`) so that drivers can construct a Vendor from a raw
> ID, matching what C drivers can already do.
>=20
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620-b4-rust-pc=
i-edu-driver-v2-0-6fd6684f2c14@mailbox.org?part=3D1

