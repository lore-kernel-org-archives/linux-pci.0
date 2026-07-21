Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC403E1729
	for <linux-pci@vger.kernel.org>; Tue, 21 Jul 2026 17:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653702; cv=none; b=shwiQFeocVYZmZWCMXKi13lPde+JhTT3r6FpiutQtfzUHTXJPo2XydqdzphHs21xT2a9rs2WHCFTR+XyvTZujeUdobuDKGqiTwqg01o81L2rpsmIh6XU2K90XYC9ldNXCUMr9uzySEghKVGwBd8pmbgKzIM0a9gqxrX4yFKqVv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653702; c=relaxed/simple;
	bh=+bY2ApLUqDdmCc2wd7AHrjw72f4OjWesYX/26duxKUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnMHlyXfZQYVaQ0ooWCTZrL3zBrlkYqjd91LZQcY5IfDmtwOdX5/CSIWGdWnaoh2nYt4Lz5oE6vPCFLwWInyDdWP5d0mhsyUpe37tDg/mgPI2y9flRp9ejM/EdQvkaMMfU8xBs4AjNF7ASH0TKHaa5ZcBI0TX8cCu0YqJRqEe2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll28XigN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll28XigN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5549E1F00AC4;
	Tue, 21 Jul 2026 17:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653699;
	bh=j6ZzlgGKGZcub9UYCbEX3rIU6JVbMn7XKVo6dJ9ogYw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ll28XigNkSCEbQJxyTaz8ZAGH78OYnH3rlz5ibdH+XzpfVJwIaxY5QyU93RRqsqom
	 T0KFNhUjwxISFB/N5B6//mIU8UaMu8Y8hB5dJOWrug24ud0YyOHMAuj7JkrmebC/sl
	 qqCbNyul0RSz7BubvaBa8v0NtDB/JHrMLDCMlLGk7gaCZLmxm05HCYZuAk1alYcr4O
	 U+aAX25gDWbXf/FbmpBoiwspQBeANz4alIJESuue++cL81ysydreOPNpxooyAb45eO
	 WsLP9pJahcBWqHRxf6RQx8euVPf9ao1Z7bBARnEfvSxt3an+3rUrjmoTFCdCrFuay6
	 dgC8WJrWw5xTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/10] rust: io: register: remove relative registers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, "Alexandre Courbot" <acourbot@nvidia.com>, ojeda@kernel.org, linux-pci@vger.kernel.org, "Danilo
 Krummrich" <dakr@kernel.org>
In-Reply-To: <20260721-typed_register-v1-10-452d72b60262@garyguo.net>
References: <20260721-typed_register-v1-0-452d72b60262@garyguo.net>
 <20260721-typed_register-v1-10-452d72b60262@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 17:08:18 +0000
Message-Id: <20260721170819.5549E1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] Broken intra-doc link for `WithBase` in module documentation.
- [Low] Leftover macro syntax for relative register aliases (`+ $alias_offs=
et`) causes confusing internal macro errors.
--

--- Patch [10]: [PATCH 10/10] rust: io: register: remove relative registers=
 ---
commit 9b1276cccc7f1b5ecb5c4e81e0c27d5b7d2f2492
Author: Gary Guo <gary@garyguo.net>

rust: io: register: remove relative registers

Relative registers can be better served by projection to subregion instead
of ad-hoc handling in register macro. Projection composes better (e.g. it
natively allows relative registers of relative registers without needing
additional support).

> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index df47c28ba4f40..88ead1c1874fb 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -191,78 +191,6 @@ fn offset(self) -> usize {
>      }
>  }
> =20
> -/// Trait providing a base address to be added to the offset of a relati=
ve register to obtain
> -/// its actual offset.
[ ... ]
> -/// Trait implemented by all registers that are relative to a base.
> -pub trait WithBase {

[Severity: Low]
With WithBase removed here, does the register.rs module documentation need
to be updated? The module doc still references it in its intra-doc links:

//! items you might want to import from this module are [`WithBase`] and [`=
Array`].

Since kernel rustdoc compilation is strict about broken intra-doc links, co=
uld
this cause the rustdoc build to fail?

[ ... ]

> @@ -847,7 +479,7 @@ macro_rules! register {
>          $(
>              $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
>                  $([ $size:expr $(, stride =3D $stride:expr)? ])?
> -                $(@ $($base:ident +)? $offset:literal)?
> +                $(@ $offset:literal)?
>                  $(=3D> $alias:ident $(+ $alias_offset:ident)? $([$alias_=
idx:expr])? )?
>              { $($fields:tt)* }
>          )*
> @@ -855,7 +487,7 @@ macro_rules! register {
>          $(
>          $crate::register!(
>              @reg [$reg_base] $(#[$attr])* $vis $name ($storage) $([$size=
 $(, stride =3D $stride)?])?
> -                $(@ $($base +)? $offset)?
> +                $(@ $offset)?
>                  $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?

[Severity: Low]
Does the macro entry point still need to parse $(+ $alias_offset:ident)? and
forward $(+ $alias_offset)? now that the internal @reg macro arms handling
relative alias syntax have been removed?

If someone accidentally defines a register using the removed relative alias
syntax (e.g., =3D> Base + Alias), could this cause a confusing internal mac=
ro
matching error instead of a clean rejection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-typed_regi=
ster-v1-0-452d72b60262@garyguo.net?part=3D10
