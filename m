Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0937882A
	for <linux-pci@vger.kernel.org>; Fri, 26 Jun 2026 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782486328; cv=none; b=R2kRdUEaisIajrpUPXaMZOJ1K+UAPtqJrbNSKEHizq/EEsTx7nIpbdYpdFejSgVh+0KoT4czef56WOCPK3Ex7NdtH8HjQnc9rOop7kglTJqHHpQqB3Ga9mijImDTiiZxfyAlYAG41mBMy5FAX1XIPCpMidXnl1qtBB5DEn3Nrw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782486328; c=relaxed/simple;
	bh=g9FhMoP+9ojL0Ruu94/5bRsaT5Sm0EZTbo/FRhAmIr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bdBLk6KLE1Cx2+3/Uu49CErLuIx92VD6PqsGmgDPmKNJAP23Tbno+donpcKZW7okbLcbYVVDX9wmcqu7ynZU1buzldl3E8ZX8QZUHwWVoxNGcWBi8WcXVxYf6muKOmqT92EqZAmrqI3UenGL3DUlL1JrmiPzXMFckfM88OB6MMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5yNFkYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5yNFkYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4381F00A3A;
	Fri, 26 Jun 2026 15:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782486319;
	bh=hIMH/CW8sOItdSGkkqGRNFq3zKeoOYtSzviJ3wvaV6g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f5yNFkYjMcVjwsSvo+vtFVjuuUE1LAQufFQR234cztX+uolEr7cxqx7FrGw+7wVoW
	 XPllW9IUFmE0qH9JIr0baONau5lkDEHOnKriTcdHBB5IxvtGQjDvhABCWrn/P9TpJn
	 pzNGVuK5HAmX1xdXvEMB/lu99mGlne1CEHGjotlGCE6l7KYLx27BaNILIaSTVRWufC
	 QZDSiOqDKSqo2kQzFV2Co4o3CwvRho7zIF7CMCyZ5yfs90eKhUeOpXQ2vSWgF39Y/b
	 6u8oq+Q90ayN5Aki6r+WQfIKNPSOnGugeaGoCqktGITF0KHU+sWksQn8aKkeyKHdPE
	 KT+vKdAe9yOlQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jun 2026 15:05:18 +0000
Message-Id: <20260626150519.4D4381F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] `CoherentView<'a, T>` automatically implements `Send` when `T: Syn=
c`, but provides an `as_mut()` capability to generate `&mut T`, allowing th=
read-safety bounds bypass.
- [High] `CoherentView::as_mut` consumes `self` by value on a `Copy` type a=
nd returns `&'a mut T`, but its safety documentation fails to require stric=
t exclusivity.
--

commit 12e6f6d7abcd0a26719f3c4f268f24a07774b118
Author: Gary Guo <gary@garyguo.net>

rust: io: implement a view type for `Coherent`

Implement a `CoherentView` type which is a view of `Coherent`. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once.

Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
method to erase the DMA handle and give out a `SysMem` view, if the user
does not need the `dma_handle`.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..ab6504910e4f5 100644
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

[Severity: High]
Since SysMem<'a, T> automatically implements Send when T: Sync, CoherentView
also implements Send when T: Sync.

If T is !Send, can a caller move CoherentView to another thread and call
as_mut() to get a mutable reference? This appears to allow bypassing Rust's
concurrency guarantees and could lead to data races or memory corruption if
the type relies on thread-local invariants.

Note that this same pattern seems to pre-exist in Coherent<T> as well.

[ ... ]

> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a read o=
r write to the same region
> +    ///   while the returned reference is live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {

[Severity: High]
Because CoherentView derives Copy and as_mut() takes self by value instead =
of
taking a mutable borrow, can a caller call as_mut() multiple times in
succession to create overlapping mutable references?

While the safety documentation requires callers to prevent races, it does
not explicitly require strict exclusivity. Could a caller sequentially use
two aliases without data races, believing they adhered to the safety
contract, but still trigger undefined behavior due to aliasing violations?

This documentation omission might also exist in the preexisting
Coherent::as_mut.

> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260626-io_project=
ion-v5-0-d0961471ae50@garyguo.net?part=3D15
