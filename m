Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B86920ED;
	Fri, 11 Sep 2026 05:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102871; cv=none; b=mwG3DnmnkLGLjYfK00gfUbsoRvJ7IY4mm2VSbccGFgBcRJc3UUo5JSTv9qmGc+hTRI3mIvUykXufhjsF3aV7u7tSHkCwFddmi54/LcnT5Uyyc8gP81VluyoJrbegOm7omtspCY6hepHPxyofnSdA091wT8+UJUXeBX5hn8Cjic8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102871; c=relaxed/simple;
	bh=EWCFZyqZRFXrUzy1urkQlPkhhfvHVAN1sWXFOm/cKPo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=noy9Xy9n4IcWygA46mwAktrZpP4Jdpj8OVsA+OZKbBNk7lwEtfysqxussTGVAgXHDIK1flQ6Av25kGbR1ca3ilwBqUVD+rcy1XXQqlneuXQDCp8qgknv/p3CNSr6a4XM6Brb3dJm0JrQ6jktVgTNKEIwREIGPL3c0VKzDbPo/LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me; spf=pass smtp.mailfrom=alistair23.me; dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b=lrmF4eHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fLeVGZ7E; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alistair23.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alistair23.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="lrmF4eHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fLeVGZ7E"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 567061D000E5;
	Fri, 11 Sep 2026 01:01:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 11 Sep 2026 01:01:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1789102868; x=1789189268; bh=EWCFZyqZRFXrUzy1urkQlPkhhfvHVAN1
	sWXFOm/cKPo=; b=lrmF4eHqJNzq9TcQUvTdjD+CcRZTCe1g0EKd4t6p4L0lhn5l
	V5+jGNIfk+3xdjW6yvW2ICaQJsKR2Ec1LYZD5k6ce+qiHI71ldEOvtYoF6az5AI5
	L42SrHFcc9/c0zoMdLldHMjYMEH2rMi1qzkbvCjR7Z3S4H5TpfjK2Z11p7dEiAJv
	Su9U9zdBrFpsXLqTq8GhgJgZFJNL6uQMKcbfaUNsfGkRUdpn9CuJZnFlAhBm5IJi
	Blo9naMm2SHlGx8e4MjtUzXIz8LBVAyDSx0JH+C4FLZDff2N/Ygv3xD9EIYYJKwN
	JjOSdCglAEiECVjnsHmWyAvchPOf4MEJ5tmrzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789102868; x=
	1789189268; bh=EWCFZyqZRFXrUzy1urkQlPkhhfvHVAN1sWXFOm/cKPo=; b=f
	LeVGZ7EKU/jNThi422s2VFpRtRWSgciZs/mdGPB4wRbrjcvp1rk4GxUJxmH5/Pr4
	j+zX1NLAwBmUa83tA+CGmTmrPcAEoPNBguW3ItvVLhSjHoEsspyLmj8cwVyTrwZS
	ej7sr0ETXhqPyxa363cBWT6NS0TugWgJSDCyBeIV6RKaCkrQYmQ5Vor/2GAkgsVi
	vd/7ecP+/QtBSMwZOU47lIYCmVEF1+OM7gZ0QJSox7ydkcmbb+sjnAjmVEzxCGg1
	rq0JgE0vfZMAfuSEThhY2jCiTQbIUdabqEuXgTQqQj3wgFOEv54Uw6IxpjtrvUgq
	ClcOQp+x+ZRipoWH3rMiA==
X-ME-Sender: <xms:E4ujavIWgcR_lllY5svcvTmFQ6Yc_BLGHifHcKCSFJSDVh2okE2B5g>
    <xme:E4ujajjlunK63SMeAZxWnKcEsY3hujXg0SCx-F6cEmnB8H7UmzxBdsH7r23sR37uy
    _tlKC8U3pWp4-FUKFeGBXcSzfVawsL5bg5dNQluoUBkchxCTikhdOfy>
X-ME-Received: <xmr:E4ujao323SEXyL9whwrjKf1WKe1h0YJgUvZKBClYqeoKrROFHyHr-Cys4Hn7RaeqTNFSwq9TnEZRXfy9W4YaIc3WOxE>
X-ME-Proxy-Cause: dmFkZTF7hgcu7GHxYYmGlxiI8fB69kQzj15ESgtg0KpvjpId2fB0RPjCxNjA/ebMyR7dep
    GzE+QzUZ4XMLNdHGLHa/y+x0O5hxU3UotjKqi+zis/7KeVFho2+TOtbIpPAEYANhrwUgsd
    RRftb7kSu8TJJ66ePZmi42okx4iNJGXHvJy2W+rVBvDknwJITQYWS/47UPn1tRa3StH0o3
    riEXqgBWIp5rDhNW59xvSgmGsb+h+apy89nBJPxLZTCP2lPdaCjSyJtqALMlCvlfDybKV0
    cj/yl0BeLAb8m8B/H6unSOdPNH5aR0p9MAJIwNw/kc5hZV8Ja6xuxP4TLTY4bZf544ZpC+
    Z+1LMlYa3tuU/sBivs8WeFSTiG1vnSBkU/t6D0LVOuOhxe/WWtZxB0Ga1mCwDL6f8PdkdL
    6h7/fgXB9w0Cj5TOHvOMvltUAfctgs99AWnZhlcarq4LbcGFBt7K+8O4dz1TNlWgWXsHZk
    6endl5nIBj5JjM6+l6MgZjUk0c5C8AfaIu1QaFs32lB+XRpjANSWWiOaB6uSEZnGF2N4kE
    Oz6eO7IUqfYsTmem44FLWYGZicV+PjoYiKsay1YI+jx6kiuhVMNtox4X7PAfoZmxXFPuDv
    gc/y/qAjEUE7oie/NSTHFaKf8WBnHp/KE58i57ZXvGAE0MgeauuqU1MEn+sA
X-ME-Proxy: <xmx:E4ujakZZ0gSNIBDhTTv1eBAZmtzksIoQFas7Rz5HCfMCVabI8rNHFQ>
    <xmx:E4ujaljre6U1cGQqAFyRqdqYrJ69ojtB3C79cFwTDaWP85_iX2G2rg>
    <xmx:E4ujakjsD7urDD1KEmGkwscEm7sX2g7UxbPc4Arno9f76_7v3_4VMg>
    <xmx:E4ujaiDolXyPCjQ8YtLsLctzU0OJq9KJ6DAhuvTNJIPDgGEXewpeEg>
    <xmx:FIujaoI1qyHxwhgq88ZWnU7WIuOUxC7XimjncSiuHdcuVrcGdGYQdw1S>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 01:01:01 -0400 (EDT)
Message-ID: <f9b1c0410e622f7ac1e6feacaa3eae98951bcd79.camel@alistair23.me>
Subject: Re: [PATCH v3 10/21] PCI/TSM: Rename pf0 to host
From: Alistair <alistair@alistair23.me>
To: Jonathan Cameron <jic23@kernel.org>, alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, Jonathan.Cameron@huawei.com, djbw@kernel.org,
 	rust-for-linux@vger.kernel.org, lukas@wunner.de,
 linux-cxl@vger.kernel.org, 	bhelgaas@google.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, 	gary@garyguo.net, ojeda@kernel.org,
 benno.lossin@proton.me, a.hindborg@kernel.org, 	wilfred.mallawa@wdc.com,
 tmgross@umich.edu, boqun.feng@gmail.com, 	bjorn3_gh@protonmail.com,
 alex.gaynor@gmail.com, aliceryhl@google.com
Date: Fri, 11 Sep 2026 15:00:59 +1000
In-Reply-To: <20260909000158.78ffa790@jic23-huawei>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
		<20260901010347.2614656-11-alistair.francis@wdc.com>
	 <20260909000158.78ffa790@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-09 at 00:01 +0100, Jonathan Cameron wrote:
> On Tue,=C2=A0 1 Sep 2026 11:03:36 +1000
> alistair23@gmail.com=C2=A0wrote:
>=20
> > From: Alistair Francis <alistair.francis@wdc.com>
> >=20
> > Rename pci_tsm_pf0 to pci_tsm_host (and rename variables and
> > function
> > names from pf0 to host) as part of converting pci_tsm_host
> > to be any device that knows how to speak any of CMA, IDE, or
> > TDISP.
>=20
> I'm not against the change, but I would like at least one example of
> 'what' other type of device you plan to use this for.
>=20
> vf or something else?

It's based on the reply here: https://lkml.org/lkml/2026/6/18/1741

I don't know PCIe that well, so honestly I'm not sure.

My use case is a root complex integrated endpoint

Alistair

>=20
> >=20
> > This commit just renames the functions and provides no functional
> > change. That will happen in the next commit.
> >=20
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > =C2=A0drivers/crypto/ccp/sev-dev-tio.h |=C2=A0 4 +-
> > =C2=A0drivers/crypto/ccp/sev-dev-tsm.c | 12 ++---
> > =C2=A0drivers/pci/tsm.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 84 ++++++++++++++++-----------=
-
> > ----
> > =C2=A0include/linux/pci-tsm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 18 ++++---
> > =C2=A04 files changed, 61 insertions(+), 57 deletions(-)
> >=20
