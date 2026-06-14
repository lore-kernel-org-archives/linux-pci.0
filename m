Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697261FF5E3
	for <linux-pci@vger.kernel.org>; Sun, 14 Jun 2026 16:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781453072; cv=none; b=uy+iQwn4WXzUeDR0gQN9vaUR3PZhr27nO7EFrDOrAP60VQjaH/pUuPVBEQs8wL8hWhJtJg0c7n6qShQuIbdUVSYm8NnW5vcgohY0Y6AIHrNH/xg/WSzK1XPl2nR3v2j2/sy35hv+zRwGJDcnI2ZtRP/RowOQUJgIDosrh2ikR2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781453072; c=relaxed/simple;
	bh=+97NjOchPUnAyL91FsLJUkursjPzR/0m6Hok4sqPlBo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=h8R2mW4d9VdBLQqMNQGGaGy9lehv8Tvqei2kF2nBTBu2OUqd+DxHLTDqvle5F+P0Kw29DAW+NZ9UovIZ6vIC1E1BKL+Nkq/7NdPWQBbHFzTu3YFsLxDqRHfvCyJ7ZpPpfVl8Ka2JrAJcOytlPqqsczy0iOv1V48SQ3LUKh/q87Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxg+Hs++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxg+Hs++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FD11F000E9;
	Sun, 14 Jun 2026 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781453071;
	bh=+97NjOchPUnAyL91FsLJUkursjPzR/0m6Hok4sqPlBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cxg+Hs++3r5dcfsezGBzoJ2ooRRsvpcYxCHNm9NUk7JhaiQhu1h1NynRvQAY0PRPz
	 AWYWkzMYtbcEuW0qDnPnEdzGI34ZSKZ/6L8veY7kOU0Dvynws4cek15/lBdFFslJ24
	 sqCeE+FwBFnhVZfGIkbRlw2e9+shN/DSJWGGRnisjdDTLq7LHO3usiW0FTqUTe0jiR
	 dQuelVUnMUtCc33sj2nIQEbj0ul08uPoEomLuQPUJQJpWJ4sdDRHei9+BeZPg9g5XN
	 EQqV+V9ewuAX+UJb8x0uQ2vrFa9HG4emjgrCFi3pI+RtxR4kwMilN22diZ2EnJvYkx
	 41b9tCyUbjijQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] rust: pci: make Vendor::from_raw() public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260614-b4-rust-pci-edu-driver-v1-1-e3f2471b595c@mailbox.org>
References: <20260614-b4-rust-pci-edu-driver-v1-1-e3f2471b595c@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 16:04:30 +0000
Message-Id: <20260614160430.E2FD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> Vendor::from_raw() is currently pub(super), so a Vendor can only be
> obtained through the named constants generated from the PCI_VENDOR_ID_*
> defines in <linux/pci_ids.h>. A driver therefore cannot match a device
> whose vendor ID has no symbolic name.
>=20
> Such devices exist. QEMU's "edu" educational device and the legacy
> qemu/Bochs stdvga both use vendor ID 0x1234, which is not registered in
> pci_ids.h. Per the policy stated at the top of that header, IDs are only
> added there when shared between multiple drivers; a single-driver ID is
> expected to be open-coded in the driver instead. C drivers already do
> this -- see drivers/gpu/drm/tiny/bochs.c, which matches with a bare
> ".vendor =3D 0x1234".
>=20
> The Rust abstraction has no equivalent escape hatch: there is no public
> way to express an unregistered vendor. Make Vendor::from_raw() public (and
> const, so it can be used in the const device-ID tables built by
> pci_device_table!) so that drivers can construct a Vendor from a raw ID,
> matching what C drivers can already do.
>=20
> Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260614-b4-rust-pc=
i-edu-driver-v1-0-e3f2471b595c@mailbox.org?part=3D1

