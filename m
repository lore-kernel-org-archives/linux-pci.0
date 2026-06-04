Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A466E370D6B
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780605332; cv=none; b=JBWopBP54gm9oWrt8V4eW6hWW/u65GO8ANg843VHwLrV/zveM3Ym6dGp0cl3nMsn7dIvDHQlK/cm5x7drs5I7KBPS2dBLbwK5mgeyhMVyrpd2UvWw3DE++Wc56LEFE7ScGRzIxH0OL1R3YxnNhah7hxqLmTI4ocJyuzRnKm5oqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780605332; c=relaxed/simple;
	bh=HJzEuaTwM3/c1IPxpacborJNW2SoSgFc//fiBt5/apk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NkwzPyBRmQQyIyPgl5gZNUsTJPwYFKbBY9dYlNBMK9log12seShzyv8X+Y2Ir0SjhaZEYt2TWn76xcGYk6xEnh8e/5jT9RSI6Y7MuEIs3sLWlDZi0RuosvbGQ4Ed32yMB5oApiNz80nBZQGIlBDHlf8ZCEEsVWYHh+5nadR5EbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IhkPoGo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhkPoGo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1DC1F00893;
	Thu,  4 Jun 2026 20:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780605331;
	bh=IIxcMeNXT+0eKOWo78BZVp+nuWcgXzSKung3HXiYRPs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IhkPoGo4miUiP38H4AmI6GnagwrNWKJqDCBNXvlJ2PzC1dwg0oM3AvOiOKIDJ+dZ2
	 2aHKLgc7W6nhjslZ6xyaCy81xvYWY5tFW1IknwSk3LxijIbSNQ/Kef6MmrVQqyoK4S
	 qVut+TT+IDVXbLlAYb/1eI9y0zu00J2wfS8qHYxsCuAI4FswEnTglq0rMibFQaZAzi
	 4R6lVIEQJntN8bo+c5yWc8fo5DjgR9PUYMnVB0k9pMUPmL6AhJobv/Pfx9EKZtkemh
	 joOFyvYKx+alwsV4hGJVjNMFEk/GjOC01RNkHa0fcnNCAc4sQYJajscMK4KPPlT7jq
	 eZJlhvmAdvNzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/10] rust: Add `OwnableRefCounted`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: ojeda@kernel.org, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
In-Reply-To: <20260604-unique-ref-v17-9-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-9-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:35:30 +0000
Message-Id: <20260604203531.4F1DC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] `OwnableRefCounted` is a safe trait, but its default `into_shared`=
 method contains an `unsafe` block relying on undocumented invariants.
- [High] `ForeignOwnable::FOREIGN_ALIGN` for `Owned<T>` incorrectly promise=
s the alignment of `Owned<T>` rather than `T`, leading to under-aligned poi=
nters.
- [High] `Ownable::release` takes `&mut self` but is expected to free the u=
nderlying memory, violating Rust's Stacked Borrows aliasing rules.
- [Low] Incorrect link destination for `ARef<Self>` in doc comments.
- [Low] Missing `// INVARIANT:` comment when constructing `Foo` in the doct=
est.
- [Low] Missing `// INVARIANT:` comment when constructing `Owned<T>` in `Fo=
reignOwnable::from_foreign`.
- [Low] Unnecessary `mut` keyword in the doc example for `ARef::from(foo)`.
--

commit 7e04551249f9cff4815fc7ad79ac13555baea1a7
Author: Oliver Mangold <oliver.mangold@pm.me>

rust: Add OwnableRefCounted

This commit introduces the OwnableRefCounted trait to allow safe conversions
between ARef and Owned pointer types. It also updates documentation and adds
examples for reference-counted types requiring both shared and unique acces=
s.

> diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
> index bedd4fef84fa2..9db0daab22256 100644
> --- a/rust/kernel/owned.rs
> +++ b/rust/kernel/owned.rs
[ ... ]
>  pub trait Ownable {
[ ... ]
>      unsafe fn release(&mut self);

[Severity: High]
Does taking &mut self here violate Rust's Stacked Borrows aliasing rules?

The Ownable trait defines release as taking &mut self. Owned<T>'s Drop
implementation creates a mutable reference to the heap allocation and passes
it to T::release.

Implementations of release are expected to deallocate the memory backing th=
is
reference. Deallocating memory that a mutable reference points to before the
lifetime of that reference ends is Undefined Behavior in Rust.

Should release take a raw pointer like NonNull<Self> instead of a mutable
reference?

[ ... ]
>  impl<T: Ownable> Drop for Owned<T> {
>      #[inline]
>      fn drop(&mut self) {
>          // SAFETY: By existence of `&mut self` we exclusively own `self`=
 and the underlying `T`. As
>          // we are dropping `self`, we can transfer ownership of the `T` =
to the `release` method.
>          unsafe { T::release(self.ptr.as_mut()) };

[Severity: High]
Is it safe to pass self.ptr.as_mut() here if release frees the memory?

This creates the mutable reference that gets passed to release and is
subsequently deallocated, triggering the Stacked Borrows violation described
above.

[ ... ]
>  unsafe impl<T: Ownable + 'static> ForeignOwnable for Owned<T> {
>      const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();

[Severity: High]
Does this incorrectly promise the alignment of Owned<T> rather than T?

ForeignOwnable::into_foreign guarantees that the returned pointer has a
minimum alignment of FOREIGN_ALIGN. For Owned<T>, into_foreign returns a
raw pointer to T. Therefore, the alignment of this pointer is strictly
determined by T.

If T has an alignment smaller than 8, FOREIGN_ALIGN will falsely promise an
8-byte alignment. Data structures like XArray rely on this statically
guaranteed minimum alignment. Passing an under-aligned pointer will cause t=
he
pointer to be corrupted by tag data.

[ ... ]
>      #[inline]
>      unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
>          Self {
>              // SAFETY: By function safety contract, `ptr` came from
>              // `into_foreign` and cannot be null.
>              ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
>          }

[Severity: Low]
Should there be an // INVARIANT: comment here?

The struct Owned<T> has an Invariants section. ForeignOwnable::from_foreign
constructs Self { ptr: ... } without an // INVARIANT: comment to justify why
the ownership and pinning invariants are upheld.

[ ... ]
> @@ -231,3 +237,125 @@ unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_v=
oid) -> Self::BorrowedMut<'a>
[ ... ]
> +struct Foo {
> +    refcount: Cell<usize>,
> +}
> +
> +impl Foo {
> +    fn new() -> Result<Owned<Self>> {
> +        // We are just using a `KBox` here to handle the actual allocati=
on, as our `Foo` is
> +        // not actually a C-allocated object.
> +        let result =3D KBox::new(
> +            Foo {
> +                refcount: Cell::new(1),
> +            },
> +            flags::GFP_KERNEL,
> +        )?;

[Severity: Low]
Should we add an // INVARIANT: comment here?

The struct Foo is documented with invariants above, but this construction
lacks the comment explaining why the invariants are satisfied.

> +        let result =3D KBox::into_non_null(result);
> +        // SAFETY:
> +        //  - We just allocated the `Self`, thus it is valid and we own =
it.
> +        //  - We can transfer this ownership to the `from_raw` method.
> +        Ok(unsafe { Owned::from_raw(result) })
> +    }
> +}
[ ... ]
> +let foo =3D Foo::new()?;
> +let mut foo =3D ARef::from(foo);

[Severity: Low]
Can we remove the mut keyword here?

The variable foo is only cloned and consumed by Owned::try_from, but never
mutated. This will trigger an unused mutability warning which can break the
build for documentation tests when warnings are treated as errors.

> +{
> +    let bar =3D foo.clone();
> +    assert!(Owned::try_from(bar).is_err());
> +}
> +assert!(Owned::try_from(foo).is_ok());
> +# Ok::<(), Error>(())
> +```
> +pub trait OwnableRefCounted: RefCounted + Ownable + Sized {
> +    /// Checks if the [`ARef`] is unique and converts it to an [`Owned`]=
 if that is the case.
> +    /// Otherwise it returns again an [`ARef`] to the same underlying ob=
ject.
> +    fn try_from_shared(this: ARef<Self>) -> Result<Owned<Self>, ARef<Sel=
f>>;
> +
> +    /// Converts the [`Owned`] into an [`ARef`].
> +    #[inline]
> +    fn into_shared(this: Owned<Self>) -> ARef<Self> {
> +        // SAFETY: Safe by the requirements on implementing the trait.
> +        unsafe { ARef::from_raw(Owned::into_raw(this)) }

[Severity: High]
Does into_shared rely on undocumented invariants that make this unsafe block
unsound?

Since OwnableRefCounted is a safe trait, any safe code can implement it. The
default implementation of into_shared calls ARef::from_raw, which assumes t=
he
raw pointer has an active reference count increment that can be taken
ownership of.

Because there are no safety requirements on the trait preventing it, a user
could safely implement OwnableRefCounted for a type where Owned<T> does not
hold a reference count increment. Calling into_shared on such a type would
pass a pointer without an active refcount to ARef::from_raw, and when dropp=
ed,
it would decrement a non-existent refcount.

Should this trait be declared as unsafe trait OwnableRefCounted to prevent
undefined behavior?

> +    }
> +}
> diff --git a/rust/kernel/sync/aref.rs b/rust/kernel/sync/aref.rs
> index 818c84fa923a3..68d31f43e6743 100644
> --- a/rust/kernel/sync/aref.rs
> +++ b/rust/kernel/sync/aref.rs
[ ... ]
> @@ -35,7 +39,10 @@
>  /// Note: Implementing this trait allows types to be wrapped in an [`ARe=
f<Self>`]. It requires an
>  /// internal reference count and provides only shared references. If uni=
que references are required
>  /// [`Ownable`](crate::types::Ownable) should be implemented which allow=
s types to be wrapped in an
> -/// [`Owned<Self>`](crate::types::Owned).
> +/// [`Owned<Self>`](crate::types::Owned). Implementing the trait
> +/// [`OwnableRefCounted`] allows to convert between unique and
> +/// shared references (i.e. [`Owned<Self>`](crate::types::Owned) and
> +/// [`ARef<Self>`](crate::types::Owned)).

[Severity: Low]
Is this doc link destination correct for ARef<Self>?

The link target incorrectly points to Owned instead of ARef. It should point
to the correct type, e.g., crate::sync::aref::ARef.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D9
