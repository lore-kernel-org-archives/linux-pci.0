Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D83515D6
	for <linux-pci@vger.kernel.org>; Thu, 10 Sep 2026 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031220; cv=none; b=gHFbaigxQFnY5wa+zI2ZmcbIRkN6wLs1/Fso6k/e8HImyGhg1bT/sQ/8NThzcrs2mQym+0f3NEGNl//JBcIO3ZjKEOfoHci1j2fx1jnJ8JXXvXe/mPNFV888ap/XttL2XgWyQ6WT0Ig76PF7ZR/Yrb0hZNDh7Eczug0JMVoeNks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031220; c=relaxed/simple;
	bh=W3LnmGoflAKr+0vcQQJPyzX8ziTfzpDYz8GTkjG1doM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ndr/sPiv0zSo4/vOfTm8J21nkBN6Ba6sRXg9cKYQGqer18K+fawxskYdpGdjAeFSYPh17pxWlwK5/35mwLj/DJQ21hVnLI8duzK7kW4tljoAo/3YSWSQW8gNPeug9mEbG1POJawKjh5r4zRr9vXzQBKDaP/TAuPPde9RXMkMeEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dt0BzjCg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dt0BzjCg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6341F000FF;
	Thu, 10 Sep 2026 09:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789031219;
	bh=C2+p1+RQ3g7WvVBVNMvEerJl9JqhQMS+gKbSB5DW1GA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Dt0BzjCgRMFggvMlryciNkHf8GCR1WB+6gMhPtkcnhDL5r8mRfOCtv7GWD3Hq9ato
	 FQ/ofCdVWZUjdBXLEWxqYIjG777fT1DgGfI+/WJY2upmcnWGL0pxByCaQdEC5GtPzn
	 vNax/TgmjWwum+Ho9v1qBO7oj6j8AksJTMt35NVNThFeWpriSQoi9XsS2anyVJogRg
	 k4afGLa8DcSOBnXv11P9HKaNvR3Z6MTv2UxJ57fhdyvvifr+ONYI1Mnl53TUcMK5jo
	 XuH9ZrlFPaBXRh5GMAmJA4CUbz5jEKJ8xCtBJLW9H8TBVqhzL7Q4iC8NrxSqWwxelM
	 7fZ7uL0RCTx5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 2/9] rust: types: Add Ownable/Owned types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net, dri-devel@lists.freedesktop.org
In-Reply-To: <20260910-unique-ref-v21-2-e83257373062@kernel.org>
References: <20260910-unique-ref-v21-0-e83257373062@kernel.org>
 <20260910-unique-ref-v21-2-e83257373062@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 09:06:58 +0000
Message-Id: <20260910090659.0B6341F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

> From: Asahi Lina <lina+kernel@asahilina.net>
>=20
> By analogy to `AlwaysRefCounted` and `ARef`, an `Ownable` type is a
> (typically C FFI) type that *may* be owned by Rust, but need not be. Unli=
ke
> `AlwaysRefCounted`, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
>=20
> Conceptually, this is similar to a `KBox<T>`, except that it delegates
> resource management to the `T` instead of using a generic allocator.
>=20
> [ om:
>   - Split code into separate file and `pub use` it from types.rs.
>   - Make from_raw() and into_raw() public.
>   - Remove OwnableMut, and make DerefMut dependent on Unpin instead.
>   - Usage example/doctest for Ownable/Owned.
> [ ... ]
> [ Andreas: Updated documentation, examples, and formatting. Change safety
>   requirements, safety comments. ]
> Assisted-by: LLM
> Co-developed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-unique-ref=
-v21-0-e83257373062@kernel.org?part=3D2

