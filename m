Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5C140BCCE
	for <linux-pci@vger.kernel.org>; Mon, 24 Aug 2026 11:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570708; cv=none; b=iLJiAkAmnpikiroIweFxKhe9Q1ledRidDPbUgmjHZpzD9olq3gyXOVLrGXrV8MdP1t1emmBcR0MSbODOHxwg3+la1T89Nc0x1UoutanwBO6tGlmPhC3ByBYPXab3V8RkpgBntUj5Ng8RAhr7amzoZX9ueyXzL6/n3g3yhqUzVl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570708; c=relaxed/simple;
	bh=wraCZrxiG6e3A7NJ7gj+tLVM4TCndexCwII32Mzxx4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIeaUqUE7LP9buQk5y1Nudb+itkS2ZGkE3e9w69yS1vLQl/jD0V5sZjjctnrxpTVhwepmaCdJc1rMQdksX7M5Y1LZ5gbeDHlYF6uRAZHjx/lVXETFcHmsX6XyCmDODzUQGDv0VzCA+fItL7E3M171f0ur7fwoRZDos0mcNoNYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M3B6rrpy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3B6rrpy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A52091F000E9;
	Mon, 24 Aug 2026 11:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570706;
	bh=VIdaYXsFwC4fR7G0J2HjX1xXHf7oy9BGqGAvnj+mRnQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=M3B6rrpyrN6USt8mEzgiEfQ6/lnfFldbwrlcPtrtOMzOMtavtjP6bicGYuDVegXqa
	 7t2t4pUOZxABSkDqgCwUL7wel3Kmff51lugwAY4rY4qArCw57tLNj2mjClFON+/F4w
	 E2wGYfbfdEaLpSgbmj8DjNzS7iyoNEpAfoCvFDnHmYaDqXdG05bSw7vhH8gg4yMvWh
	 18ygOgbC3/IhkINz2xa7302oO5TgAKFu+mxYmPLws5ya78wYCkSXJscxitulMZX+bL
	 YGNcqmJbLSx4gVXXDbcayJ4q6PlpcFLBT3KJ2Hj3Abd2dEBHuH7NmJu33wMPeB7oH9
	 Op74q7EXrX+0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260824-unique-ref-v20-6-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-6-490735672187@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 11:25:06 +0000
Message-Id: <20260824112506.A52091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Mismatched and incorrect SAFETY comments in the `ARef::into_raw` do=
ctest, alongside an unsound `RefCounted` trait implementation.
--

--- Patch [6]: [PATCH v20 6/8] rust: Add missing SAFETY documentation for `=
ARef` example ---
commit 1891eeeba9b2ed0af7d99f9518dcd85941d2518c
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for ARef example

This commit updates the rustdoc example for ARef to replace the "TODO"
SAFETY comments with explanations for the RefCounted trait implementation
and ARef::from_raw call.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
> @@ -142,7 +142,9 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// struct Empty {}
>      ///
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: The `RefCounted` implementation for `Empty` does not =
count references and never
> +    /// // frees the underlying object. Thus we can act as owning an inc=
rement on the refcount for
> +    /// // the object that we pass to the newly created `ARef`.
>      /// unsafe impl RefCounted for Empty {
>      ///     fn inc_ref(&self) {}
>      ///     unsafe fn dec_ref(_obj: NonNull<Self>) {}

[Severity: Low]
Are the SAFETY comments for the trait implementation and from_raw call swap=
ped
here?

This comment justifies the caller requirement of ARef::from_raw (owning an
increment), rather than the trait's own safety requirement (that increments=
 keep
the object alive).

Additionally, does this explanation overlook the fact that the stack-alloca=
ted
variable data will eventually go out of scope and be freed?

If a developer copies this pattern and calls ARef::clone(), could it extend=
 the
pointer's lifetime beyond the stack frame without keeping the underlying ob=
ject
alive?

> @@ -150,7 +152,7 @@ pub unsafe fn from_raw(ptr: NonNull<T>) -> Self {
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };

[Severity: Low]
Does this comment justify the object's lifetime (which is the responsibilit=
y of
the RefCounted trait implementation) instead of addressing the specific saf=
ety
requirement of ARef::from_raw?

The from_raw method requires the caller to own a reference count increment.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-unique-ref=
-v20-0-490735672187@kernel.org?part=3D6
