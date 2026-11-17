Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794925380;
	b=37rOUK6omymvm1v5ExYJbn5Ks0c9HkdU7KntKaGdlJecmJ8borDVLDD/WgZEZX2dMBOd
	 4Ncgk9DH7/lclUEmohkelfg3J9vM4/8YWjxZayGI84gsQOyPfw6KKhqazy3z/Ew1ldcH3
	 k/cW4GunkC+IwWS0hkFf1QjJ/6m9yjxV44UIruEjADFmRd3iOnZd6RYeHJj9U3GM/b1qi
	 Cxay6660VknKA1+WsxiPcMkXbXRmcTb+XX2ke/br4ofQ5mIpizv4pBLgQfcgyD8LXV6Hh
	 A4RKq3u9pf4AwyLkP3rzHHqCFEd984HEfW3PZnLT5Pd+PpBIeLaBwiOZdf/Jah3+Vbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794925380;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=6j6WgfFAOPDn3WVH0eKNETgyevIGR2sCrwHJ+rqUpFQ=;
	b=V2hljx6bRIMkj9lDlrz1ffMOuXqcC3fTtbBbcSfTWghVDRWqxARIyE2ImJppVUcCTj8y
	 0GhUaQuJxSRJXsl6chjrmz1WK7aSuPU85c1cMvG3m7hOhxO9dnyO1UbPlKSvewhPRO01Y
	 GP9SkTMlzQafflshVDDF2gnVWO+pZ95RFBB85mPwpA4NjngyZ0owhrMWhByxr9YDGmu6f
	 fxPnLGB8Y4DPFzYtmGvbtI7kXEWlarsqMNk+ITv7Kh84XHQiJHRpxw9gAs7rJOeMpJzVP
	 6Ezg0Y9S6wL/wmF1GoJ9z+/2cE8MjadF53a7/Di4xqreY3yf+AdqZHb4SPDgmRtnL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIc6nih1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EE1606A33B;
	Tue, 17 Nov 2026 14:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIc6nih1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FC531F000D0;
	Tue, 17 Nov 2026 14:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794925380;
	bh=6j6WgfFAOPDn3WVH0eKNETgyevIGR2sCrwHJ+rqUpFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gIc6nih1RcR72RFVaGWgZRziQFkRCd4aSsx6yxn/waVdqj+YA4cBnQhaXLWku/LE2
	 KZxL+YxoTgBd15mpGKQMW0+jmuSLW01uErIIm1hKwCPMIpHBWFJofcZGGhugZhjn8g
	 ReFldf7jt2WzvoTxI6GwerQopaOYaSucpJqCOuQ2jl+i+s7wdm3+qOIekujO+9w+bA
	 lql5xakuUAdgAPGGo4dbKYMGwjSYzhKszeow8MQ+2+4RSPUpKGRbnQrCd4IGKEbcBX
	 z710Q0X41s7YtQUKiov1cDSoZtnYmo9qu0UUp9cWOKTXb4bbYcaWxiFkYrX0b/c79r
	 W+heJebj+wirA==
Message-ID: <sashiko-outbox-218954@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v22 2/5] rust: types: Add Ownable/Owned types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-security-module@vger.kernel.org, linux-pci@vger.kernel.org, linux-usb@vger.kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20261116-unique-ref-v22-2-12029383206d@kernel.org>
References: <20261116-unique-ref-v22-0-12029383206d@kernel.org>
 <20261116-unique-ref-v22-2-12029383206d@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 14:22:59 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

> From: Asahi Lina <lina+kernel@asahilina.net>
>=20
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unli=
ke
> an `ARef<T>`, an `Owned<T>` cannot be cloned. At most one `Owned<T>` exis=
ts
> for an object at any time, and the type `T` decides whether other
> references to the object may exist together with it.
>=20
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>=20
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
>   - Fixes to documentation and commit message.
> ]
>=20
> Link: https://lore.kernel.org/all/20250202-rust-page-v1-1-e3170d7fe55e@as=
ahilina.net/
> Signed-off-by: Asahi Lina <lina+kernel@asahilina.net>
> Co-developed-by: Oliver Mangold <oliver.mangold@pm.me>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> [ Andreas: Updated documentation, examples, and formatting. Change safety
>   requirements, safety comments. Let `T` decide whether other references
>   may exist together with an `Owned<T>`. ]
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-unique-ref=
-v22-0-12029383206d@kernel.org?part=3D2

