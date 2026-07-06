Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C8342089F
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343000; cv=none; b=qkQbAYwl5kqydl/ye9OVLYzOaJLTkyswvK8d7Yx/0daYfk2ANTtjSIcXlJVMdfn3eular6+JKRmyt3pxaH8+arpwUyVix9AS2XnK0eqzclErZQrQYAOohWnZbsF2gbhtB5aAwAiG4jhoA5pFIeunt3/QrBqLS5ibddc2j03zKeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343000; c=relaxed/simple;
	bh=rnnTVWWUO/2MhO51kwmSx5nkqIvhGnlt55sjFgsRWUs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MZPsaVd4KUCfSvEDWF4YAsS9lASBmsA2Qygkm4khyD/7ydOmJEyUcJYVWjxXBc0khmmtOLrkya5BiTrKrlbIMAfed8mb7CxJr09Pr2OfSQFbQWs9d37zSYP/EyYdbidzR/NNlYd5puEt7LYybSXRiqFRADGWEG3TAnf1yq/HfAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxyyS9/A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxyyS9/A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5758C1F000E9;
	Mon,  6 Jul 2026 13:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342997;
	bh=MP8VboAyZaUbXRnwq6ovrV0/VarvGBmOTNmhBmvvLog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XxyyS9/AP4H5fsIA0lVrjTRknTESkZ5hNCpRpHwpQ3QF35rH/7pASMm0AqT5K3RG7
	 esMzlPAtP0NSLHERj7uXBm27f6X8XpYxbh8fSrt4A8mfAnykqnZtIsJptH4zxdo7rN
	 uGBv/BgqBJ7T3VzI1vIUP99DFoInnMjaUDZGqHHXUZ7IQhSFKBnEMgMKKb2YwXkGXy
	 xbrSAKoVDJoP1lO/sKTFhWtorpEmy9dc5PKwF+Qv80OrK2WgtxQfxRwqgfem2gTlzk
	 Pb7ajV2jz5visQu1Gq80lVq1KS6RLAg88TXwQKD7m6TZJsYpkKD4D+v6T1da8TkYlu
	 KkSFhVd1FFqxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 15/20] rust: io: implement a view type for `Coherent`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260706-io_projection-v6-15-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-15-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:03:16 +0000
Message-Id: <20260706130317.5758C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `CoherentView::as_mut` allows converting a shared reference `&Co=
herent<T>` into a mutable reference `&mut T` on another thread without requ=
iring `T: Send`.
--

commit 4f4557edee91d32bf035e749630652363a232ff1
Author: Gary Guo <gary@garyguo.net>

rust: io: implement a view type for Coherent

Implement a CoherentView type which is a view of Coherent. To be able
to give out DMA handles, the view type contains both CPU and DMA pointers,
and the projection method projects both at once. Delegate most of the Io
implementation to SysMemBackend.

> diff --git a/rust/kernel/dma.rs b/rust/kernel/dma.rs
> index 200def84fb69e..1535bc6eec642 100644
> --- a/rust/kernel/dma.rs
> +++ b/rust/kernel/dma.rs

[ ... ]

> +impl<'a, T: ?Sized> CoherentView<'a, T> {

[ ... ]

> +    /// Returns a mutable reference to the data in the region.
> +    ///
> +    /// # Safety
> +    ///
> +    /// * Callers must ensure that the device does not read/write to/fro=
m memory while the returned
> +    ///   reference is live.
> +    /// * Callers must ensure that this call does not race with a read (=
including call to `as_ref`)
> +    ///   or write (including call to `as_mut`) to the same region while=
 the returned reference is
> +    ///   live.
> +    #[inline]
> +    pub unsafe fn as_mut(self) -> &'a mut T {
> +        // SAFETY: pointer is aligned and valid per type invariant. Alia=
sing rule is satisfied per
> +        // safety requirement.
> +        unsafe { &mut *self.cpu_addr.as_ptr() }
> +    }

[Severity: Medium]
Since as_mut() returns a mutable reference &'a mut T, could this allow a
type that is not thread-safe to be mutated on another thread?

If a custom type T is Sync but not Send, CoherentView could still be sent
across threads. Calling as_mut() on the second thread would then yield a
mutable reference to a !Send type, which seems to bypass Rust's thread
safety guarantees.

Does as_mut() need a T: Send bound to ensure soundness?

[ ... ]

> +impl<'a, T: ?Sized + KnownSize> IoBase<'a> for &'a Coherent<T> {
> +    type Backend =3D CoherentIoBackend;
> +    type Target =3D T;
> +
> +    #[inline]
> +    fn as_view(self) -> CoherentView<'a, Self::Target> {
> +        CoherentView {
> +            // SAFETY: `cpu_addr` is valid and aligned kernel accessible=
 memory.
> +            cpu_addr: unsafe { SysMem::new(self.cpu_addr.as_ptr()) },
> +            dma_handle: self.dma_handle,
> +        }
> +    }
> +}

[Severity: Medium]
This isn't a bug in the trait implementation itself, but this is where
the shared reference &'a Coherent<T> gets converted into a CoherentView.

Combined with the as_mut() method above, does this create a path to gain
mutable access from a shared reference without a T: Send requirement?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D15
