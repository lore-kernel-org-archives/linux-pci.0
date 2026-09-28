Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6325B2EEE86;
	Mon, 28 Sep 2026 01:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790559696; cv=none; b=Kgpslsj3W0YmLfAwmhozJVUqqwacQBYG2ekeA510SK5ypXiD/ujllbujDYWkQYK/FUuQWg8vvC7kVD8KerLZISZhZnluSqMEqYE5qKUO3OVQ4BsLtLUNpFlNJxWm590vf9PA5nKM5bmaXIntJ5fjbAeSzwGgqLeJNWUH17t0XUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790559696; c=relaxed/simple;
	bh=MiucvMsczsL8+sV7UWwBpoSZ/iFbbMj4oEhJkSUHUqo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OElLFahAw4Q4yKbhuDG9uRf6dQPKYSJuveO70yo1AAmxcifurB/jMeGMV3XxdX7UdvVDrrDV+3RpP0PRJyTbE6CtJD5yUNH6dQv7lvOog/VxVb8etqhdv6qx0bmuFjdXJlZeqL6pkG7sZvuqSFuxjFUKpaE8w4UO3M4r51y0rFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IngHo+bT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IngHo+bT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD7C1F000FF;
	Mon, 28 Sep 2026 01:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790559695;
	bh=0HibqYaBvg29HbCVAlTBOpuVZkCBQe8xX6tldNF0bec=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IngHo+bTaZensTzq9m9sdlyXkcuMy6OT2k+PthuajYHlZ0RmZ2bwaUMBGrJXeaISS
	 ROgUNhmqlzGHogSY8nk8+nAbxXDSTr4ZnUuBCJWGBbhR05e10JE5tlfzit0rfgguBC
	 if5njpgs+TCWtqJ8Der47GIdf6PKuP8oRGviFCMWcYmqRrtMHLg7dZWvLnHgpVFtKq
	 mW/tl2ECZxGQts2pKkvF5JRnB6U3lIztWrdpwm4GT6pfT6SzmNGJmMXsEd/INMoqYy
	 q8j8Bwo/Zt1KIORfc76JF2dI6pqHpMGfkNgRanvLS7dxTDqnJo2dk0pK9qoOaa9xfe
	 dCdfKOIr+iRCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/22] rust: create basic untrusted data API
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, gary@garyguo.net, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260928011123.450800-4-alistair.francis@wdc.com>
References: <20260928011123.450800-1-alistair.francis@wdc.com>
 <20260928011123.450800-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 01:41:34 +0000
Message-Id: <20260928014134.BFD7C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] rust: validate: Untrusted Deref implementations violate cast_slice=
 safety contract
- [Low] rust: validate: typo in module documentation
- [Low] rust: validate: imports do not follow vertical style
--

commit faffe058082273ce8374694a0c1cc53da4578ae7
Author: Benno Lossin <lossin@kernel.org>

rust: create basic untrusted data API

This commit introduces the Untrusted<T> wrapper type to explicitly mark data
originating from untrusted sources, such as userspace. It allows validating
the data before making logical decisions based on its value.

Link: Message-ID: <20250814124424.516191-3-lossin@kernel.org>

> diff --git a/rust/kernel/validate.rs b/rust/kernel/validate.rs
> new file mode 100644
> index 0000000000000..ca2e5abda3e25
> --- /dev/null
> +++ b/rust/kernel/validate.rs
> @@ -0,0 +1,147 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Untrusted data API.

[ ... ]

> +use core::ops::{Deref, DerefMut};

[Severity: Low]
Does this import follow the vertical import style? The subsystem guidelines
request following the vertical style for imports.

> +
> +use crate::{

[ ... ]

> +/// The reason for this is that `&mut Untrusted<[u8]>` can beconverted i=
nto `&mut [Untrusted<u8>]`

[Severity: Low]
There appears to be a typo here ("beconverted" instead of "be converted").

> +/// very easily, but the converse is not possible.

[ ... ]

> +impl<T> Deref for Untrusted<[T]> {
> +    type Target =3D [Untrusted<T>];
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(&self.0) }

[Severity: High]
Does this violate the safety contract of cast_slice? The documented safety
precondition of kernel::transmute::cast_slice requires that neither T nor U
have interior mutability. However, Untrusted::new and this Deref implementa=
tion
don't place any trait bounds on T preventing interior mutability, which cou=
ld
allow safely constructing and dereferencing something like
Untrusted<Vec<Cell<u8>>>.

> +    }
> +}
> +
> +impl<T> DerefMut for Untrusted<[T]> {
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(&mut self.0) }

[Severity: High]
Similarly, does this violate the safety contract of cast_slice_mut by lacki=
ng
a check against interior mutability?

> +    }
> +}
> +
> +impl<T, A: Allocator> Deref for Untrusted<Vec<T, A>> {
> +    type Target =3D [Untrusted<T>];
> +
> +    #[inline]
> +    fn deref(&self) -> &Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice(self.0.as_slice()) }

[Severity: High]
Does this violate the interior mutability ban for cast_slice?

> +    }
> +}
> +
> +impl<T, A: Allocator> DerefMut for Untrusted<Vec<T, A>> {
> +    #[inline]
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        // SAFETY: `Untrusted<T>` transparently wraps `T`.
> +        unsafe { cast_slice_mut(self.0.as_mut_slice()) }

[Severity: High]
Does this violate the interior mutability ban for cast_slice_mut?

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928011123.4508=
00-1-alistair.francis@wdc.com?part=3D3
