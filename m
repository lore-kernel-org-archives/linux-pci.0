Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F813B5837;
	Wed, 23 Sep 2026 03:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134946; cv=none; b=mH6h67CC9Es1ABq2pBdc8PtujXn4NJBtNyDx5fX4bBkDjOFmTJ2KvOl0/SbKrDbBesdNRytlH6m4wwYYQp2m2o4n6b1tkr3DjViUTIqJQMWtPpEeJ2jeMm9C0GFqla7EMQiHZMuAfNPLrn3aaYjQIr/85Y5gv3QiywgaTQ8KrPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134946; c=relaxed/simple;
	bh=DSWi2C0r8cqwdbL+D/oXhhGYggJoGev4OcBXZnAtWFY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eoaiKKs++crCQ8njDn/R7oPFpeVj3V1HrP8EznySIpucjPboWiPefdKroJiJb6lmGJxME+h/1QKqvMxuKiPIHoc9ktV8JIc+Gic8deViQQQakkM89VbJ9XCdzCOXSLIzaYCTEoQBfqskoX5H/H3tzwRMD8BJyfAqdtWdTFWN8KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=PRx++WoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K55jbmV5; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="PRx++WoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K55jbmV5"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id DF6491D0004C;
	Tue, 22 Sep 2026 23:42:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 22 Sep 2026 23:42:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1790134941; x=1790221341; bh=DSWi2C0r8cqwdbL+D/oXhhGYggJoGev4
	OcBXZnAtWFY=; b=PRx++WoTUWOsvJJFym88XUCOYrkBFJtThSya95aFTGESCAJJ
	j6r0oqIzbFiXwgipGYtogG2LWflBSo/MHlZn9/l+mqpIjtNp9DyajOOHCSxwWYHO
	tAQ+D3envhK8zH61bVoslEAWTgcD6kTcwEHuchWY+EiYD+n2B5t3yyEzROAmRQ9M
	g3o5lBU5OpAEW9OtA6z6hmgSwzR3Hw9LOX+4zguiRCjg3LD7hSQVcGRqIJdQ+nm4
	gYlxnAhog79+nFF8JTwcap3mUFM8H0VlBqjY2yKrTCm5rvHts6GcIMOuqVpvuOav
	PLqdjEFxXdS5UBlE6Z4vDIb1xudsoT6f5qopIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790134941; x=
	1790221341; bh=DSWi2C0r8cqwdbL+D/oXhhGYggJoGev4OcBXZnAtWFY=; b=K
	55jbmV5fObulKuAGe1zelj26AbdJg9xUAT0cYUeLgxPOkmXQgv1RHxPrAvwG6CFc
	kr4xYE0PzuUTgZYFKLE20rXaey3b+21d3tiiLlxPAjWdsqTRQXV5cnZQ2/rNMFzZ
	mcrPGnQr/C5mYqelZF8grwaoPeZXBvbThoXVN5kN6wQdyiA7oJdvalBIIlwB239o
	UBlUlWEdco96RmF6HFh4b87qnoQxyDptlXDsNcfOokjWeJx1+M1sk+rCAptb8+ZH
	Zlw2+0sPaMcUhdeC6eRzM2RW7BCPDtEDH8eeUgyjQF401sp+6MdgQmkPj38aLQUs
	GqjlRhgIVbK+GMplJ19Sg==
X-ME-Sender: <xms:nEqzanPof6OC4VujRL9AgMU7P9EjGQqb7wDRZak7FbFppdb9mAI9LQ>
    <xme:nEqzaiX_X1ajAzmmVkZI9GKdoIHDB1rLVvvGLsMFAocZCa9GPGYNcU-uIpKTX9Ojp
    Aog8Xt08Qm9O0NjwCqYaOLlbHdWD1mKNx86rTj5MG1g0DrNvqCsfReQ>
X-ME-Received: <xmr:nEqzanbu8NACHSTiR_I8INeU1uobgqiLGWUayr6UeVEKtim5yTM9RCowceLl_xwzMI1C8QU3D_lep58t8z5Gp5wUM_A>
X-ME-Proxy-Cause: dmFkZTFWQgVXt9bM2b6NNxDLU2jUhTZqo1HyJ/ceb/6fR6g5/ke7x/NK8aQ/wybD9G7sDE
    CmtX3QwVhvD3JUclCR9ETEfWsOI7v+reJwTYob7hpcIpPo/4iZmOqyG1I7KAWWIFLXUgLw
    v96DhGoz9UpYdkKeXc/hZBGnUfxawMjnjVtQDju3d8IVsfsa3zIyqXHLaCqTj4WNRQWGKq
    tmmTTBcnw0y3dZS7EgIm2YwfTUf4M4enUg6Kt4bClJIVQc/UjREJZ8GfwzQdia7ZNwkro3
    hK8iW8KSjamfbpmgjaynFsftX9uh5wvKPOsvXMNAxpHo+uCEXTvkZFkk6tJhDoEdtSwgV2
    6GBehN5HqwyviruHFjGv/WzLwxQoGkueti404EXE3kf7u8qkOyKvo4OvBLEYolmfapcnxB
    F4JccMi5Te1BZq7oMKbky2uQ5q7y7YKMULV0qOa2MFX9BJV98wv9AyL4iHxOPtRe730K9L
    MSrboLxu6gG8yVR+5HsIh88Utz5N2KkVtSu/M1zWI9+Se6WJeYQ6P9skWKqRz1Twj/uNfo
    iCDPvhJucpF8jjturp2P8zSMFq/LgsbLp5axv209DNCuwpcPaaDjlLg6YyrGhYpuOSvpup
    Tg7vJWck7+rmhOaNt3U0xJDq95oRSreJUPgUvIDr8xnPNvQkrkuFhhj47LIg
X-ME-Proxy: <xmx:nEqzans9bTMC1bKBz1twK_VLviUrmLn4zeL3QKe7-nefLy1468292g>
    <xmx:nEqzaumzUv1rsGahWuIrYxwXaD2Tbpu0aHfxi87oMm4mAC5GarLA0Q>
    <xmx:nEqzagWYYb2dfQ6GUgKoaSarfD0sCoSfqT8w4S_1T9pZokx7-frwIA>
    <xmx:nEqzapnV4xGZWN9rlPOX_qimTj87Mmpoko6U6zFu9VW8EjK7bB8Olw>
    <xmx:nUqzatDDdkgNtuOGYUS9GPknZSh2x6r0hLSKQZZlRCetsrAaQqNsJ_Wz>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Sep 2026 23:42:14 -0400 (EDT)
Message-ID: <0ba203994392fa8183c226d65c4caec5786112bc.camel@alistair23.me>
Subject: Re: [PATCH v3 10/21] PCI/TSM: Rename pf0 to host
From: Alistair <alistair@alistair23.me>
To: Jonathan Cameron <jic23@kernel.org>
Cc: alistair23@gmail.com, linux-pci@vger.kernel.org, 
	Jonathan.Cameron@huawei.com, djbw@kernel.org,
 rust-for-linux@vger.kernel.org, 	lukas@wunner.de,
 linux-cxl@vger.kernel.org, bhelgaas@google.com, 	akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, gary@garyguo.net, 	ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, 	wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, 	bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Date: Wed, 23 Sep 2026 13:42:12 +1000
In-Reply-To: <20260916031143.4fe2ae49@jic23-hlaptop>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
		<20260901010347.2614656-11-alistair.francis@wdc.com>
		<20260909000158.78ffa790@jic23-huawei>
		<f9b1c0410e622f7ac1e6feacaa3eae98951bcd79.camel@alistair23.me>
	 <20260916031143.4fe2ae49@jic23-hlaptop>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 03:11 +0100, Jonathan Cameron wrote:
> On Fri, 11 Sep 2026 15:00:59 +1000
> Alistair <alistair@alistair23.me> wrote:
>=20
> > On Wed, 2026-09-09 at 00:01 +0100, Jonathan Cameron wrote:
> > > On Tue,=C2=A0 1 Sep 2026 11:03:36 +1000
> > > alistair23@gmail.com=C2=A0wrote:
> > > =C2=A0=20
> > > > From: Alistair Francis <alistair.francis@wdc.com>
> > > >=20
> > > > Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and
> > > > function
> > > > names from pf0 to host) as part of converting pci_tsm_host
> > > > to be any device that knows how to speak any of CMA, IDE, or
> > > > TDISP.=C2=A0=20
> > >=20
> > > I'm not against the change, but I would like at least one example
> > > of
> > > 'what' other type of device you plan to use this for.
> > >=20
> > > vf or something else?=C2=A0=20
> >=20
> > It's based on the reply here: https://lkml.org/lkml/2026/6/18/1741
> >=20
> > I don't know PCIe that well, so honestly I'm not sure.
>=20
> Yeah, that's about both VFs and other physical functions.
> Those can exist on both real EPs and RCiEPs.
>=20
> >=20
> > My use case is a root complex integrated endpoint
>=20
> Any more info to share on that? Why isn't it attested etc as
> part of the host given it's integrated? Or is SPDM a path to

Oh, sorry. It's not integrated in the sense of on the board. It's just
a PCIe attached NVMe device. You can see the example for testing with
QEMU in the cover letter.

> something other than simple attestation here?=C2=A0 Fine to do it this
> way, just seems like overkill so I'm curious what the application
> is.

The next step is to expand this to support other transports, like the
storage ones.

Alistair

>=20
> Jonathan
