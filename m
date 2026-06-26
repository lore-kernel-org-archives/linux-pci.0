Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA8428725B
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475360; cv=none; b=tpPm0OR6CwB2KJsdYW9awtwE0FYrflp0wlIvwU+UqE2pBGr+p12GusYiE27LbVsIUrvG3yqzyB3kkCePuZdS3c2RMb0qAzYI7hPtpe3Tf2ilgRPsPV5BJ5XogGZO0IliB1cg6c2HoiSY+qeN+dNhdo8cQBqY9fjXGNlYVNIEqkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475360; c=relaxed/simple;
	bh=+8XuwZC44k2EX0RuGmrB62EzO0CaCFm4uL+NBXkDguw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WnXSuogzk2yZk64hBsqL2L3Bz4Es/H6+cFbek2X38Xf7jcRCD5c351FsPN6kHaDMf9hN+pz3c7BSe6nSsWKnXaVpe5y3uTNw+QRUL+s3S7bSUb3xq6lVMcjSfPwzsy4448GZY6U1MoNI7i5giuD9APPkkH7ih0YAKocFhScP8zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AygZIf6a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AygZIf6a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A799F1F000E9;
	Fri, 26 Jun 2026 12:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782475359;
	bh=CLl+B7C+bN3r7S8yLnEe5nbMmmPmdYMtzvPCA9H3rhs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AygZIf6a5UL9r/vtV5RFYu6+K/wCq2Lm/RXw6ZAcnzB704Nj1pOUhCJQp2JaxbQEL
	 IEkGk1Muuv723CwLDvmd2b1B+VE85nsrlZBR94pIpI3JAv/prVfj7Tq1ZFoUrnmJ4c
	 cNU91tj0rLUnmZ/iK4AZJk9XMLYx+yuXSsBUCQCI71XYbQRSbExr8ylHIKM7LMJbJa
	 RxWheAKBKd9bz9uBKpMrJBvNlpKPcNhu/5xFWJSSqeWsJeerVQzU1MdD3/NPMetxsm
	 4gGNVB0mqFEWz7j7nfnPDs3D9/+jGEIWKIxyxJ8bsO2uIJ2wXp6ZH/Lkznb0RYcFVk
	 vOsrz2ge0Fh8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 6/8] rust: Add missing SAFETY documentation for
 `ARef` example
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260626-unique-ref-v19-6-2607ca88dfdf@kernel.org>
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-6-2607ca88dfdf@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 12:02:38 +0000
Message-Id: <20260626120238.A799F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added SAFETY comments in the rustdoc example incorrect=
ly justify an unsound trait implementation that violates the safety invaria=
nts of `RefCounted`.
--

commit 8c6c2bf519778f423165d5e3c916d3965bebb093
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add missing SAFETY documentation for ARef example

This commit replaces TODO safety comments in the rustdoc example for
ARef::into_raw with explanations of why the unsafe operations are permitted.

> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index ea5a16b8163a6..f26ca39b84d0d 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
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

[Severity: Medium]
Does this explanation violate the safety invariants of the RefCounted trait?

The RefCounted trait strictly requires that increments to the reference cou=
nt
keep the object alive, and that all instances are reference-counted.

By using a no-op inc_ref and dec_ref, this example demonstrates an
unsound implementation of the trait, which might lead developers to
introduce use-after-free bugs if they copy this pattern into production
code.

>      /// }
>      ///
>      /// let mut data =3D Empty {};
>      /// let ptr =3D NonNull::<Empty>::new(&mut data).unwrap();
> -    /// # // SAFETY: TODO.
> +    /// // SAFETY: We keep `data` around longer than the `ARef`.
>      /// let data_ref: ARef<Empty> =3D unsafe { ARef::from_raw(ptr) };

[Severity: Medium]
Is it safe to rely on stack-variable lifetimes here to bypass the normal
reference counting expectations?

ARef::from_raw and the RefCounted trait expect the object's lifetime to be
handled inherently via reference counting. Relying on keeping a stack
variable around longer than the ARef bypasses ARef::from_raw safety
preconditions.

Could this documentation lead others to incorrectly apply ARef to stack
variables?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-unique-ref=
-v19-0-2607ca88dfdf@kernel.org?part=3D6
