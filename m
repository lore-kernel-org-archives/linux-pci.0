Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC9338DC78
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031930; cv=none; b=nYA8hrkFQCOAnzdOirEQArdR5tMC24LxLgQVg9YnkpMlK4dAHJIPtn1noHoTvuZBVKNIkU8iOJiTmoEmlopxuu6/a4gmyVFkz5zi1Irp2/461FAAlp8QiNS6wcsjHQpjKTrzUpBGBbEnM1Fob3OcXaBguK6LL/U8DPRxgvDYQFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031930; c=relaxed/simple;
	bh=b2rvGN8a/hwFRXqmD9Oi0dRRCMRXZ2H/tyXPbdR/QQI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ohi2SCgcjMRyjw3QnM+qaBVb/bQVknetKjs+3EoJvZYtNRgEQV2vxsPid9iSvhvuGvh/z7l4y+AO5YeBVykJ7i+M1ylAxvqNh22BtcOGoYoRZv+aVJJQAh/80VllJh32sbP5NvaBpfcUtEx1MvEekmD4QHTPLd1DgoGzLcEWmSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fLztRJ11; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fLztRJ11"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58701F00893;
	Thu, 10 Sep 2026 09:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031929;
	bh=b2rvGN8a/hwFRXqmD9Oi0dRRCMRXZ2H/tyXPbdR/QQI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLztRJ11gMHHdPALILH78p9/vBilVUbuNADwY9UYJPcuYvXfVeHpdDMp1ITRZJvHe
	 XjZcmya7kCFOVb/I3E54U/TBa5c2llec3pXOIRuhBWAkP8K5LhNJxKDa1mXuaYc+wn
	 Ye346f3n2be6FUPBgxegE4vip4jrksD/4hyMfKc4cg1mfK5YTmL5iEV02dOCeeCPcE
	 /Mux/23If7BltIhPEYGf1v/3usd/X+FMGCn/FOz0DRdFmgDL3Zy2+1H/EhdGmoQlVO
	 EOUrz+SMvXC2VEzKxJ6CrUL2Ci/krNVkYdwOA0Yk+bKya0LZ/0lw6ocX1GKHjHS0+c
	 XfrY6jdHEJ+kw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 7/9] rust: page: convert to `AlwaysRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, gary@garyguo.net, ojeda@kernel.org
In-Reply-To: <20260910-unique-ref-v21-7-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-7-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:18:48 +0000
Message-Id: <20260910091848.E58701F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> `struct page` is managed by a native reference count, and kernel C
> code routinely takes its own references to pages, for example when a
> page is inserted into a VMA with `vm_insert_page()`.
>=20
> Thus, implement `RefCounted` for `Page`, backed by `get_page()` and
> `put_page()`, mark it `AlwaysRefCounted`, and return `ARef<Page>` from
> `Page::alloc_page()`. The page is freed when the last reference to it is
> dropped; for the order-0 pages allocated here, this is equivalent to
> `__free_pages()`.
>=20
> This also allows `Page` references to be returned as borrowed
> references without owning the `struct page`. Remove `BorrowedPage`
> and update users to use `&Page` and `ARef<Page>`.
>=20
> Assisted-by: LLM
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D7

