Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793833749;
	b=1BiX8FOMAazCwDPmXzN2AKiUv1kKP4y6T30AGFW6sjZRErcWqfkWFhKkRHpeUHH+0B+Q
	 M7RUyj87Xr2BDXtnadhAJvyGS7nUUl4qDzocH4oVHlNMO1Kne+KlPp5Hb5NHTgvfpK/6y
	 jiTxUWga2gz5Q35mCRzf9m8iYhB7dTvY5U83K6/uTw17Gq/vdYJ/+LkwXcp024WXykD9A
	 paIFZ4TzXQd4LU+3aLSx9/aChRJKdSJaWtkxMsH4r85qOBsHVCOApCcgrjjf60yM3gjdk
	 uoQOunqh87ULbeUPW9tUhA4mgexH8RJScVSjvSKGlj5Jm8BljYeWtXJuKAbGFXOY64A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833749;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=A2NmPJpnO755P9rAc/leUlKyEuGgVEKvzt41qAW07R4=;
	b=T6zSVer5s4LRGnnwH4L6DZsfD1JnSMWUbuDHVGjdxftQ82U0IXS8NomDIQF0Ryj5gjAm
	 tQPfmcfIS8wltVDJstcU8OX1mzAmRVFR2joo472FM8WsTYZ4e83YJFKlNlM4Io8LUGnjX
	 vsBez6SOV6hQrn4wcPj4O7ccLXCNF/oA3jp1Ctg1ODguUSRjv53pz1j+rBrM/tQe8E2GZ
	 xn9emEssCa2HPIFgr5JynD65k6H905sNxn03uSjN45NKR6Y0+JLmmIaWHSTYzPvjcGOS3
	 R2mMxwqJQvVlR9HOQbVNo6JDZ5/dlbubyh9ATl2H+LfCuOgrqAFfILbTs+8L7zwjl2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgFF9sHV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5A5606A326
	for <linux-pci@vger.kernel.org>; Wed,  4 Nov 2026 23:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgFF9sHV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA3C1F000C1;
	Wed,  4 Nov 2026 23:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793833749;
	bh=A2NmPJpnO755P9rAc/leUlKyEuGgVEKvzt41qAW07R4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lgFF9sHVgh/HHPvqytNlLNfVrazUPWwrKZxbVqqirtJ20s9kDHiY+9ggMATmdQS9/
	 3U8hzwRqq+oQqmenhEOKjq/24KDaA2wJ2X+7u8MFRbv9ZmRDQ3DTODKJMNS7ct8Zyh
	 5DpgiHXDo1rbcps8RwaAAqPlEOYL1pZH0Q2Tb6b0FMYSCqdKpr6xVhIkEv3SgSO8BX
	 /LnTqZtdTA6YKwYATuAsMiqgBUVoOQVYybzlHbmctcgpYyv9Wii0Ls1tB8Klm6uXzS
	 HtSVRixGkSP4O098lFJJKhKTLQufFhhttLxWRQSUQGD5f1/Cp5BTqZGrqL15viafUs
	 QsMdRJG6nvKkg==
Message-ID: <sashiko-outbox-198265@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/7] PCI: Add QEMU vendor ID
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-4-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-4-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:09:08 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> QEMU's emulated PCI devices that predate its Red Hat vendor IDs (stdvga,
> bochs-display, edu) use vendor ID 0x1234. It is not registered with
> PCI-SIG, but it is a de-facto QEMU ID matched by more than one driver:
> `drivers/gpu/drm/tiny/bochs.c` open-codes it, and the Rust EDU sample
> needs it too.
>=20
> Add `PCI_VENDOR_ID_QEMU` so these drivers can share the definition.
>=20
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D4

