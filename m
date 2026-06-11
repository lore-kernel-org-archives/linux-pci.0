Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040749251C
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 18:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781202231; cv=none; b=U0NRuBeU5kHLUanwwrRYHlqT1PcZWRkPsFntVw2HJiGhaXVHfE/cgPZC+op8k9Zkxtq8CXc22AyKFbMGuNV2UVsPsDURCLcxHzvBV8FoWekiVZSuglNTyCfv//Qb2W/Y02DEHBTHMc9GSF4vsLSQwnRLSFXlMVpGE1xm3vJU2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781202231; c=relaxed/simple;
	bh=0ePGyr9FeM7BGyn+B1rmgAO7JJ7vcNls3G7B4yfyxlQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AUl2ZSvvdkOI4J7lp1jucp6PRWm3Jyc09WhHelb9slzbOqOfhzNv1/Ka+KSV89TiY2pyLWPd5o+r9e+vic6Yh1lK1xeeuVjLf0WecEa4UB7MBOUHi3u+JHx6PTw05sVqz6x+/qk7Nb4GqwtpqpqrqFa7kMIQmbGD15rzYrerYa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjgdM80V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjgdM80V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B341F000E9;
	Thu, 11 Jun 2026 18:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781202228;
	bh=PpLHiFEXngw1hRUk9fHiWZeHjcqZs1KhBfZARUvmQXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SjgdM80V480/76xhE07txOGJaUQRxk7L34PrCNNV76U9+fKsolTO6oYWCjzcYykMC
	 yqXy4ZYi8NQgozpBVTiXozMvu6kJ+930Ldkc9GTg+x9JpwW72KNWkGRO18ujlR2du0
	 jO+QJ6qAhozwjgkyzltp+9Q69stuGJTA60KwQG2CL+0Ip3JsBMcXmZ9XVMj/J/nwop
	 fxxbwKi6N0aThsEsF4oAEwjSL8RcvcKH91Nx06Ea9xbDomovk+w8FQJhI4z6BvCl6o
	 5EU8NgHsmhWmKd7k50yneit3wBOrIPNrg+dgMl81Ltb7Kf2fV9bi3yXXioZhs/L2gB
	 iSfirFz518tDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 14/20] rust: io: add I/O backend for system memory
 with volatile access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Danilo Krummrich" <dakr@kernel.org>, linux-pci@vger.kernel.org, ojeda@kernel.org, dri-devel@lists.freedesktop.org, "Alexandre
 Courbot" <acourbot@nvidia.com>
In-Reply-To: <20260611-io_projection-v4-14-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-14-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 18:23:48 +0000
Message-Id: <20260611182348.65B341F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SysMem allows unaligned volatile reads and writes because it fails=
 to enforce base pointer alignment for the types accessed via the Io trait.
--

commit ab556784fb75f6ee7bad0986c5ef780c29189dc2
Author: Laura Nao <laura.nao@collabora.com>

Add SysMem, an Io trait implementation for kernel virtual address ranges.

This commit introduces SysMem to provide safe access to shared memory
that may be concurrently accessed by external hardware. It uses volatile
accessors and implements IoCapable for standard primitive types. This
provides an alternative to Coherent when other layers handle mapping
the system memory to the device.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index c7a9952af995..a418c8cbb031 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

> +/// Implements [`IoCapable`] on `SysMemBackend` for `$ty` using `read_vo=
latile` and
> +/// `write_volatile`.
> +macro_rules! impl_sysmem_io_capable {
> +    ($ty:ty) =3D> {
> +        impl IoCapable<$ty> for SysMemBackend {
> +            #[inline]
> +            fn io_read(view: SysMem<'_, $ty>) -> $ty {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using read_volatile() here so that race with hardwa=
re is well-defined.
> +                // - Using read_volatile() here is not sound if it races=
 with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                // - The macro is only used on primitives so all bit pat=
terns are valid.
> +                unsafe { view.ptr.read_volatile() }

[Severity: High]
If the original type T is something with a 1-byte alignment like [u8], does
SysMem::new() allow the base pointer to also be 1-byte aligned?

The offset checks in the Io framework only guarantee that the offset is
aligned for the target type, not the absolute resulting pointer. When
SysMemBackend::project_view() creates a view for a larger type like u32, the
resulting pointer could be unaligned.

Could this lead to undefined behavior and kernel panics on architectures li=
ke
ARM or RISC-V when read_volatile() is executed here on an unaligned pointer?

> +            }
> +
> +            #[inline]
> +            fn io_write(view: SysMem<'_, $ty>, value: $ty) {
> +                // SAFETY:
> +                // - Per type invariant, `ptr` is valid and aligned.
> +                // - Using write_volatile() here so that race with hardw=
are is well-defined.
> +                // - Using write_volatile() here is not sound if it race=
s with other CPU per Rust
> +                //   rules, but this is allowed per LKMM.
> +                unsafe { view.ptr.write_volatile(value) }
> +            }
> +        }
> +    };
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D14
