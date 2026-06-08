Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ECF31F9B4
	for <linux-pci@vger.kernel.org>; Mon,  8 Jun 2026 20:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780949615; cv=none; b=bxRbgy/GEDP0Jhuuv4zoRP0fzZlVPxUuNNPq+g7EG2Jp6hC1i6qiUmtiyqRAmo1QN0CihvIGrpFUABx2ekqdWwrqA7ZKAWmW9QJHMpjiIczo0Jb3A/8N4pqmSz54EzBG6mFLr5FflzhUUdNASEqJLi+hk4MgjKIZnDQUwPqZ7CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780949615; c=relaxed/simple;
	bh=PQb1TMX+zCqC+2MsP3KvmKevtopYyT54/absCJrXbR4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PmFYgXHsiYOfZfU5W0SUwm0ajy0DwNssIztdiMs+FuzcJUawcAhDQPGTelmpXgZX/WLuu3W+vphYQN524uHTbqJqEHA5sHYuqE3pblfX2sbiqWcpaq8rSo7s/nZtfqmksQVS5Ktl3NJ2xfQauEP/kXbBXSELK0OqvQelrwPL3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aF2JUpvs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aF2JUpvs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E3C1F00893;
	Mon,  8 Jun 2026 20:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780949614;
	bh=UvcQTI6EibJjPeOUTPMzYzCxMBLaGxs1pbLSUh6LVfI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aF2JUpvsWajlegNhd++mcAAw5DRYRpyfDvfYBkabuh5I3M/NyvzW0B/Y7mOJiYzy0
	 yXPRpCcczJ5moZmFGsT1E5+dRdl1lAgDMAHpEm5ipGx0TJvZn7IXBSsPbevhjiXl9J
	 kSYGVmOV+kI6uYikjWAYRrSPfFMBqTnHlqDeKJ5mN7GqT6hxvI/bfncKDxkwrswUbA
	 1VCs/IJMAM0rc1c21tpBDYTUyWhIDa2dVq2k7hHOHFp/UbaFdzpKX6DgnUOjKm2wYc
	 b6PM9gjrWY9J2Yrex/aXrB3i89vhCtl4dRo9mHES4D11UHhjWTvPD6uAmKf5S+o8Gt
	 5fcUE/Rp5JTFg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 02/19] rust: io: add missing safety requirement in
 `IoCapable` methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, ojeda@kernel.org, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260608-io_projection-v3-2-c5cde13a5ec4@garyguo.net>
References: <20260608-io_projection-v3-2-c5cde13a5ec4@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 20:13:33 +0000
Message-Id: <20260608201334.29E3C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Compile-time and runtime alignment checks in `Io` diverge, leading=
 to inconsistent validation for types where size exceeds alignment.
--

commit 5d5fe99db5fb0c140eaa13601726daff7a857423
Author: Gary Guo <gary@garyguo.net>

rust: io: add missing safety requirement in IoCapable methods

This commit updates the safety comments for io_read and io_write to cover
alignment requirements. It also expands the Io validation checks to take the
base address into account when verifying that an offset is aligned.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index dcf3b40ffa48f..a58fb9a21dcad 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -197,13 +197,15 @@ pub fn maxsize(&self) -> usize {
>  #[repr(transparent)]
>  pub struct Mmio<const SIZE: usize =3D 0>(MmioRaw<SIZE>);
> =20
> -/// Checks whether an access of type `U` at the given `offset`
> +/// Checks whether an access of type `U` at the given `base` and the giv=
en `offset`
>  /// is valid within this region.
> +///
> +/// The `base` is used for alignment checking only. This can be set to 0=
 to skip the check.
>  #[inline]
> -const fn offset_valid<U>(offset: usize, size: usize) -> bool {
> +const fn offset_valid<U>(base: usize, offset: usize, size: usize) -> boo=
l {
>      let type_size =3D core::mem::size_of::<U>();
>      if let Some(end) =3D offset.checked_add(type_size) {
> -        end <=3D size && offset % type_size =3D=3D 0
> +        end <=3D size && (base.wrapping_add(offset) % type_size =3D=3D 0)

[Severity: High]
Does this logic incorrectly use the type size instead of its alignment
requirement?

If a type has a size greater than its alignment, such as u64 on 32-bit
architectures or custom array types, checking modulo type_size demands an
overly strict alignment. This could force an array access to require a base
address aligned to the size of the entire array.

>      } else {
>          false
>      }

[ ... ]

> @@ -311,7 +315,11 @@ pub trait Io {
>      // Always inline to optimize out error path of `build_assert`.
>      #[inline(always)]
>      fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, Self::Target::MIN_SIZE));
> +        // We cannot check alignment with `offset_valid` using `self.add=
r()`. So set 0 for it and
> +        // ensure alignment by checking that the alignment of `U` is sma=
ller or equal to the
> +        // alignment of `Self::Target`.
> +        const_assert!(Alignment::of::<U>().as_usize() <=3D Self::Target:=
:MIN_ALIGN.as_usize());
> +        build_assert!(offset_valid::<U>(0, offset, Self::Target::MIN_SIZ=
E));

[Severity: High]
Does bypassing the base check here create a divergence between the compile-=
time
and runtime alignment checks?

Because offset_valid uses type_size rather than alignment, passing 0 for the
base here will cause the compile-time check to evaluate offset % size_of::<=
U>().
However, the runtime check in io_addr uses the true base address.

For example, if base is 4 and offset is 8 for an 8-byte sized type with 4-b=
yte
alignment, this compile-time check passes (8 % 8 =3D=3D 0) while the runtim=
e check
would fail ((4 + 8) % 8 !=3D 0). Conversely, if base is 4 and offset is 4,
the compile-time check fails (4 % 8 !=3D 0) but the runtime check passes.

Should offset_valid be updated to use align_of::<U>() to resolve both this
divergence and the overly strict array alignment constraint?

> =20
>          self.addr() + offset
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-io_project=
ion-v3-0-c5cde13a5ec4@garyguo.net?part=3D2
