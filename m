Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21A62472B6
	for <linux-pci@vger.kernel.org>; Thu,  4 Jun 2026 20:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604977; cv=none; b=S1ZXnRd8ejFIWR99X8wMhhokdUoO4LFs20WIn/nhxBy9j6dm6sJPfYHhPVsqzgyqftjtB1yiVHuaeh//kEGsfxeAzhHOmgrGZiSwFi16tZTRxb2LWIuOj3Q2jeysZ9KjBFb11zTvU/SYtIh32DJjaaqFstbxPuy8+SRexw+5u5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604977; c=relaxed/simple;
	bh=utfff9KlHqqblh72hSquRTsCK8xp3wYdgHlRBhapWnI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LFrkDeBAiK4Ap7sRKGPtMocidwDJ0FxNACaRQcARpxOH21EldwNBkGVKW/EXSrvivu+YI/6/UzxGwtG71+DCRdCpX2cGrGi7vwK8s+w4ia9K3WlIE+8okOVF+5f8EXg+O+lj/JPArwnKtQBoJqvKxYbdKYy3CVnQ+zoPJ3gtrBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpZvO6ly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpZvO6ly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAB1F00893;
	Thu,  4 Jun 2026 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780604976;
	bh=59EunC7qVZIMvYW9w4hgNx9rxThiRb6+4nIItZza+Uw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EpZvO6lydE33ZNXzIIzJ/U9JHWtAQ7urxj2ylvp+XbZPiQ6r8De5uP+JJW/FG44mW
	 mKt75x9refTCUry95sIG89ArDpdqS+/wtc915QVSZkWQTFaPD6rxJAEFb+KMRBetWG
	 Ss94/f6mFFB7r+eGTWkFwWO85BZXZPZ/GP89fBwxAYbBe2qBDlGwLRAb3atGEHNfTM
	 P8gUJ48+wVcEve/czkRVa9t6aYXEw2oiqUWc14qlCZ3PDeJ9ej7MyACJDtwtPJzp1G
	 T5Nc6kcyMIZOekIqviptoKeh3PBw5FH00/x4vLOESVkQKmh4EEy+qNzMp35SjgQnSF
	 880aH5aVkRj6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 05/10] rust: page: convert to `Ownable`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
References: <20260604-unique-ref-v17-5-7b4c3d2930b9@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 20:29:35 +0000
Message-Id: <20260604202936.0EDAB1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Latent Memory Corruption / Pointer Tagging via incorrect `FOREIGN_=
ALIGN` on `Owned<T>`
- [Medium] Documentation and Type Invariant Violation in `Page`
- [Medium] Missing Safety Contract for `Ownable` implementation on `Page`
- [Medium] API Regression: `BorrowedPage` implicitly loses `Send` and `Sync=
` traits
- [Low] Unnecessary unsafe block and verbose pointer cast
- [Low] Incomplete Refactoring: Redundant `ManuallyDrop` wrapper
--

commit 3edfb37d39b0c201b33aed199fe66b3c430e3c6b
Author: Asahi Lina <lina+kernel@asahilina.net>
Subject: rust: page: convert to Ownable

This patch converts the Page reference implementation to use the Ownable
trait. This allows Page references to be returned as borrowed references
without necessarily owning the struct page.

> diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
> index 3bdcee0e16a8d..844c75e541345 100644
> --- a/rust/kernel/page.rs
> +++ b/rust/kernel/page.rs
[ ... ]
> @@ -105,7 +110,7 @@ pub const fn page_align(addr: usize) -> Option<usize>=
 {
>  ///
>  /// [`VBox`]: kernel::alloc::VBox
>  /// [`Vmalloc`]: kernel::alloc::allocator::Vmalloc
> -pub struct BorrowedPage<'a>(ManuallyDrop<Page>, PhantomData<&'a Page>);
> +pub struct BorrowedPage<'a>(ManuallyDrop<NonNull<Page>>, PhantomData<&'a=
 Page>);

[Severity: Medium]
Does this change implicitly remove the Send and Sync auto-traits from
BorrowedPage?

Since NonNull is not Send or Sync, it seems BorrowedPage loses its
thread-safety, which might break concurrency APIs relying on borrowed
pages being thread-safe.

[Severity: Low]
Is the ManuallyDrop wrapper still necessary here?

Since NonNull implements Copy and has no drop glue, wrapping it in
ManuallyDrop appears to be functionally redundant now that it no longer
contains a Page struct that requires drop suppression.

>  impl<'a> BorrowedPage<'a> {
>      /// Constructs a [`BorrowedPage`] from a raw pointer to a `struct pa=
ge`.
> @@ -115,7 +120,9 @@ impl<'a> BorrowedPage<'a> {
>      /// - `ptr` must point to a valid `bindings::page`.
>      /// - `ptr` must remain valid for the entire lifetime `'a`.
>      pub unsafe fn from_raw(ptr: NonNull<bindings::page>) -> Self {
> -        let page =3D Page { page: ptr };
> +        let page: NonNull<Page> =3D
> +            // SAFETY: By function safety requirements `ptr` is non null.
> +            unsafe { NonNull::new_unchecked(ptr.as_ptr().cast()) };

[Severity: Low]
Can this verbose pointer cast be natively simplified?

It seems this could be safely replaced with the stable ptr.cast::<Page>()
method, avoiding the need for an unsafe block and safety comment altogether.

[ ... ]
> @@ -148,8 +156,9 @@ pub trait AsPageIter {
>  /// # Invariants
>  ///
>  /// The pointer is valid, and has ownership over the page.
> +#[repr(transparent)]
>  pub struct Page {
> -    page: NonNull<bindings::page>,
> +    page: Opaque<bindings::page>,
>  }

[Severity: Medium]
Does the documentation for Page need to be updated to match the new
semantics?

The doc and invariants still state it is "A pointer to a page that owns
the page allocation," but since it is now a transparent wrapper around
Opaque, it is no longer a pointer and no longer holds ownership directly.

[ ... ]
> @@ -370,10 +380,12 @@ pub unsafe fn copy_from_user_slice_raw(
>      }
>  }
> =20
> -impl Drop for Page {
> +impl Ownable for Page {
>      #[inline]
> -    fn drop(&mut self) {
> -        // SAFETY: By the type invariants, we have ownership of the page=
 and can free it.
> -        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
> +    unsafe fn release(&mut self) {
> +        let ptr: *mut Self =3D self;
> +        // SAFETY: By the function safety requirements, we have ownershi=
p of the page and can free
> +        // it. Since Page is transparent, we can cast the raw pointer di=
rectly.
> +        unsafe { bindings::__free_pages(ptr.cast(), 0) };
>      }
>  }

[Severity: Medium]
Does this missing safety contract allow silently freeing only part of a
higher-order page?

The release implementation hardcodes an order of 0. If a user constructs
an Owned<Page> from a higher-order allocation, dropping it would silently l=
eak
the rest or corrupt the buddy allocator.

Should this order-0 restriction be explicitly documented in the safety
requirements of Page or its Ownable implementation?

Additionally, while reviewing the underlying ForeignOwnable implementation
for Owned<T> in rust/kernel/owned.rs, I noticed the following:

[Severity: High]
Does the definition of FOREIGN_ALIGN in the ForeignOwnable implementation
for Owned<T> provide the correct alignment guarantee?

rust/kernel/owned.rs:ForeignOwnable for Owned<T> {
    ...
    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<Owned<T>>();
    ...
}

Since into_foreign returns a pointer to the inner T, if T has an alignment
smaller than 8 bytes, the returned pointer is not guaranteed to be 8-byte
aligned.

If another subsystem (like Workqueue or RBTree) stashes tag bits in the
lower bits of the pointer based on FOREIGN_ALIGN, wouldn't this mask off
valid address bits and cause memory corruption when the pointer is
reconstructed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604-unique-ref=
-v17-0-7b4c3d2930b9@kernel.org?part=3D5
