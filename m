Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805883BA222
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949912; cv=none; b=i1k+P6Uoexs0xe3bGPpU76weXFbtXAnNYg2nY2dyrIWd19/ornlTysNOfRNosf7Vz0Nn9zs5kQXasmxrH1FYmZUNSjYpkXHVs4FiBYVGwJ673BmIsThV9HJ9AgNG8Bgr82+XdqkjYJQOxiMagnQlE/Gr6DFItzX7vcJXUeLLons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949912; c=relaxed/simple;
	bh=MlFKwhR3ovHz4fYvTaVGNTGZOqMCmDF3EakKKnSCVJM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cCvxZPSCupwqSFbOGvzZsjJ1pU0eYkRbi4k4g9Jtt2qbXM24T3/vD3IFeuI0xxFkm3Ha2zeJSl7giNZ7qbF1QT9KtPNmBdaXfygVlAe0w4C5kCmvjWA3xOfdmIRXo5isWNNoq8J8Zee3zXhdA2E8t5Oue8WOqhT/c3dzbg/06dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=loRbYh+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="loRbYh+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258E01F0089D;
	Mon,  8 Jun 2026 20:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949911;
	bh=H39lqrdjBjLU5AlmwvRqMP1dgScgMjlGWS/4/l3fnQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=loRbYh+hzEDTl0EE5PPipVoPBVRTpDTXErTSTRnTVdxCZfoL51W9O2w4wFQB+EG02
	 aHoeQocNJF3dBrZFViYMIUuFuLwvvzH7YhNg343yD/8nkKgmmmd3MwLhC55L6lmXg+
	 1jGFVkYnGIiUVUdqX8inbZ/LPIdlz9AT3g1lpUUO6AWmY3YI4Fmv/KuAMkMgiGUfEV
	 StbovqNAsDEtpThUf5f2n8gWuiyxFz+cUAWq7B2c8mCitBzkyj45QDvl+C2tGNOIXF
	 Z+OeFMLFbIig57NO2fCD1V89YYuOyZMXBmdmT6e2bMXzmrqwY7eAv5A0wfUOKP7qRI
	 rlcGgA2EUs8Vw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 14/19] rust: io: implement a view type for `Coherent`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260608-io_projection-v3-14-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-14-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:18:30 +0000
Message-Id: <20260608201831.258E01F0089D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `CoherentView::as_mut` and `Coherent::as_mut` return mutable refer=
ences without requiring uniqueness in their safety contracts, leading to po=
tential UB.
- [Medium] Missing `?Sized` bound on `CoherentView` implementation block.
--

commit 0b0ac87fb8d6dae9b55b873481974c835edfff5a
Author: Gary Guo <gary@garyguo.net>

rust: io: implement a view type for Coherent
   =20
This commit implements a CoherentView type as a view of Coherent. It
contains both CPU and DMA pointers and delegates most of the Io
implementation to SysMemBackend.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..970a667b9be28 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs
[ ... ]
> @@ -1133,6 +1140,132 @@ unsafe impl Send for CoherentHandle {}
>  // plain `Copy` values.
>  unsafe impl Sync for CoherentHandle {}
> =20
> +/// View type for `Coherent`.
> +///
> +/// This is same as [`SysMem`] but with additional information that allo=
ws handing out a DMA handle.
> +pub struct CoherentView<'a, T: ?Sized> {
> +    cpu_addr: SysMem<'a, T>,
> +    dma_handle: DmaAddress,
> +}
> +
> +impl<T: ?Sized> Copy for CoherentView<'_, T> {}
> +impl<T: ?Sized> Clone for CoherentView<'_, T> {
> +    #[inline]
> +    fn clone(&self) -> Self {
> +        *self
> +    }
> +}
> +
> +impl<'a, T> CoherentView<'a, T> {

[Severity: Medium]
Since generic type parameters implicitly require Sized in Rust, this impl
block omits the ?Sized bound on T. Does this prevent dynamically-sized
views (like CoherentView<'_, [u8]>) from using the methods defined here
(as_sys_mem, dma_handle, as_ref, as_mut)?

> +    /// Erase the DMA handle information and obtain a [`SysMem`] view of=
 the same memory region.
> +    #[inline]
> +    pub fn as_sys_mem(self) -> SysMem<'a, T> {
[ ... ]
> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   slice is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned slice is live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {

[Severity: High]
Since CoherentView implements Copy, a caller could copy the view and call
as_mut(self) multiple times to yield multiple overlapping &'a mut T
references to the exact same memory. Does this same issue apply to
Coherent::as_mut when returning a mutable reference from a shared borrow?

Because the documented Safety contracts only forbid data races and omit
the requirement that callers must uphold Rust's strict aliasing rules for
uniqueness of mutable references, could following this contract still lead =
to
undefined behavior?

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D14
