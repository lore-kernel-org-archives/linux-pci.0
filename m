Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6D415F20
	for <linux-pci@vger.kernel.org>; Wed, 30 Sep 2026 10:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764557; cv=none; b=SZEF9SkuyW8gx0WxW52X4ZU2MO1gas0xckIcalsco5mD81Nt8MoRvYPuulUJofge1vCGJKCiETKDmtTOS8NWAXO3uOfrnSuze54YayWFZ4Mm9Y8rMTahyDa7MYn/I5AiWE5fIwQ91NZ7MEctro/2awajom/PWs1LLWS0gBrPf2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764557; c=relaxed/simple;
	bh=bUskpDZwVscAQglmrgvVk1VBqMpS621RfS/YaPmZP9A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o4P5vxNadyPlWr/moe+pyYAaKVlatObSbb8425c2jvZyM3ZnTVkpO/p5Hu1u1x/U3cl9cx2F8NEA9USC0eor1B3P1pZYU8ykhf1GAxUZ9ptFxzFcQUJmKsFYMfuHis20iGLoSTAK20D5QIXexBwNiFcz//81++yFDvwmjonUD7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJRswpEo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJRswpEo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F7EC1F000FF;
	Wed, 30 Sep 2026 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790764553;
	bh=bUskpDZwVscAQglmrgvVk1VBqMpS621RfS/YaPmZP9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aJRswpEoMkr0L1gUzDJ/UZ5pYj41bSFCsyqAPGQjVYrfXynLvRZ/2r/x48nV9T2h6
	 jLP7KPAAbdOW1j1b7xmwRczO2BbButRnfiH93075I5LEMYaBLra3bp5vblfIi8Rku+
	 NUVi2vjPVW37xQG4XhC/CG7B3wbfI8CQBKEJccMjGMiPN5SdglNARoIaNvaWYgHTC4
	 kRwJGYrxzoFkfOLAb55e2I4Q04hWpMxhKJmZhIhow/dpszaBLT+ans84ismpQC+bVH
	 oGtK5LY5Q6BhpzeAkGZi+5KC7oBOGQ52C7L+3MOj9N9FC3KBknN3pJcTIMSHDcQR08
	 z+ByOmyBT5yWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] PCI: Add __pci_bus_alloc_resource() to allocate
 with explicit flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ard Biesheuvel" <ardb+git@google.com>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260930103036.248989-5-ardb+git@google.com>
References: <20260930103036.248989-4-ardb+git@google.com>
 <20260930103036.248989-5-ardb+git@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 10:35:52 +0000
Message-Id: <20260930103553.3F7EC1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Ard Biesheuvel <ardb@kernel.org>
>=20
> pci_bus_alloc_resource() decides which bus resources a resource may be
> allocated from based on the flags of that resource: the type bits
> selected by @type_mask must match, a non-prefetchable resource is never
> allocated from a prefetchable bus resource, and only a 64-bit resource
> may be placed above 4 GB.
>=20
> In preparation for placing some non-prefetchable BARs in prefetchable
> bridge windows, factor out __pci_bus_alloc_resource(), which takes the
> flags to match against the bus resources as a separate argument, and
> implement pci_bus_alloc_resource() on top of it by passing the flags of
> the resource itself.
>=20
> No functional change intended.
>=20
> Assisted-by: LLM
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930103036.2489=
89-4-ardb+git@google.com?part=3D1

