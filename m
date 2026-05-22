Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE41A9F82
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408842; cv=none; b=qhNXQBye2WWxjZ9D+QXeKcV35kkMWav5bscMu0TpiwQ9VMy0x2yVts5k3jTFEQl+O5YQ+nY0xumK5ehxu99hsr/CSO+zTEx3y8wuCSwuWyU0Pf9DUc3gIRtHjBXXhXGcsOqe8xq07dyFRTZkwKAJNKTaYY4BMXQEgZTBWZJ+CTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408842; c=relaxed/simple;
	bh=5lBOTskNCGs38Z9SRsYJ//bZWCDpV8ZD586b/2Dis+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IFTWPxui8CHtOzlky+0TNZoOH6R4LVXMx/Zw8o4fdfTDX9JNjVg+5C7fOA15nEwk94D0xqIEEgGp42JaZL4IIlInkDzRo+z9lc5TGUktVkWNsyqWuliCwNfgGxmaXCON0l5MU/segOGyi7r5gQgdHc/lUiHv2CsVoxDHwxBZEL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1OQeQfn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1OQeQfn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA1CC1F000E9;
	Fri, 22 May 2026 00:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779408840;
	bh=ObQqOBVL127m9NMHNNXAS7syScsYm+T6ofcF8s99tt0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U1OQeQfnqCoQ8s/IGpqpNG8QJ7iXFTMFCxNQWf9/nB5RFxQSwB+6uQ2lUHo3ONnHv
	 k0ueNYh2GHrsUhrkjQDzZLEzgwDIvRXJd1kNfPcMDpBZvehN38FG3vvtRa+oxTldzX
	 mZ+nRMjWcH9e0xDsBNKhYssAhdNOT8K+KjSAwhw7CCQwG3hGBQU6gT5Qcy5AGBZjT8
	 GVpePDmQuIO1YZaSSGm/HsUls2yKbnIdY2+Fm1YGafn4biGNExzepFp2vag32omcBP
	 amsbffQDomZ2EfprBIvwhKI4S0ab53Rl6RAgTosm5hOBwHKwVSYr3APKBvBcNqf7Tx
	 pf+95U9Ql49aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 01/27] rust: alloc: remove `'static` bound on
 `ForeignOwnable`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-2-dakr@kernel.org>
References: <20260521233501.1191842-2-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:13:59 +0000
Message-Id: <20260522001359.BA1CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Removing the `'static` bound on `Box` and `Pin<Box>` implement=
ations of `ForeignOwnable` allows safe Rust code to cause use-after-free vu=
lnerabilities by passing short-lived references to long-lived C subsystems.
- [Low] The commit lifts the `'static` requirement from the `ForeignOwnable=
` trait for `Box` implementations but fails to apply it uniformly, leaving =
`Arc<T>` inconsistently restricted.
--

commit 3010ad31fe43876a42708e20baf90c11f6c4ba78
Author: Gary Guo <gary@garyguo.net>

rust: alloc: remove 'static bound on ForeignOwnable

The 'static bound is currently necessary because there's no
restriction on the lifetime of the GAT. Add a Self: 'a bound to
restrict possible lifetimes on Borrowed and BorrowedMut, and lift
the 'static requirement.

> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index c824ed6e15233..2f8c16473c2cf 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs

[ ... ]

> @@ -477,7 +477,7 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -=
> Result<Self, E>
> =20
>  // SAFETY: The pointer returned by `into_foreign` comes from a well alig=
ned
>  // pointer to `T` allocated by `A`.
> -unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
> +unsafe impl<T, A> ForeignOwnable for Box<T, A>

[Severity: Critical]
Does removing the 'static bound here allow safe Rust code to cause use-afte=
r-free
vulnerabilities by passing short-lived references to long-lived C subsystem=
s?

For example, GenDiskBuilder::build accepts a generic Operations type T, tak=
es
its QueueData, and stores it in the C subsystem via ForeignOwnable::into_fo=
reign.
Previously, the 'static bound implicitly ensured QueueData did not contain =
local
references.

If safe code constructs a GenDisk using a Box holding stack references, and=
 then
that GenDisk is leaked via core::mem::forget(disk), the block device would
remain registered in C while the stack frame ends.=20

When the C callback queue_rq executes asynchronously, could it dereference a
dangling pointer resulting in a use-after-free?


[Severity: Low]
This isn't a bug, but should the 'static bound on Arc<T> in rust/kernel/syn=
c/arc.rs
also be removed for consistency?

The commit message implies lifting the 'static requirement generally, but it
appears Arc<T> still retains its explicit unsafe impl<T: 'static> ForeignOw=
nable
for Arc<T> implementation.

>  where
>      A: Allocator,
>  {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D1
