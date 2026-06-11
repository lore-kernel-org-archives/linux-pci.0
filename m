Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7686B3E0C53
	for <linux-pci@vger.kernel.org>; Thu, 11 Jun 2026 19:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781205077; cv=none; b=NzHE73gAH19+gewZ4b4SDDdruPiSJvbru4mJamsF6WrLScDvV58tfrn+Bj35UxFjnBpiIf3G3vA/mmNFjjUwt1H6C7q1ZYKwaDs+MswTTq/PB5S7J5w/Vy3ZwIA895N8hlQUwQm9+rkxl/w5fdjY5eDMGfgnVwzXE9s5qCbRee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781205077; c=relaxed/simple;
	bh=lFytD9grraT7GyakczxVqjS3kKTdfWQdYKZxuZ/nLXw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M9zy6D2Aop0V9SlP40ea7NfDq/VB5F5eoGk6lEw7UiZEfKSOqoJEc422ztZ2uiZj+jWKlVKAVcOWueaV7mYqasvZQ143c4YYfwEURi2hfe0oryk3hRv1j88z/g0N9ws3we5XIA43sDJM/JZRK4HvAHl66z9PgEVPLUCTUvlD0Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BGihwIuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BGihwIuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BEAE1F000E9;
	Thu, 11 Jun 2026 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781205076;
	bh=lfgexUbHdHBM2MGIFjbfXOj8UbBK/USzNFmSi6La/LA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BGihwIuPYO6jseR8W1DR+c+ztTbuQ4Uo2yt7jN9Dq1xN/4QdV6QCgYHhgz6gMROfv
	 D+1UIPOyWBZzA5g/5upk//DWrlz06Ik/TXhWGflx26v7mxcg95q1zfjQiiMRO1oO+e
	 YHIvIE7+vABXrHQ6TIc5Pee4ZPL3p9UmHqH55zIXdh+waU5dTkIwgCN6xkJ7FBZJjp
	 UZDrhzQzS6Fodce4v3nE5TJPh6TDKFKd9XQ0bNeMcu/nNIMKabVz/VEQyhZpPcKo8A
	 fgtUZIMwoci+tRQb/bed+4GIUaKYG/CWpmOHp4cXEx4g8S4fLmKcZDVN4KSwhKQlxt
	 /oGs6aYsMxarw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 19/20] rust: io: add copying methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: linux-pci@vger.kernel.org, "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo
 Krummrich" <dakr@kernel.org>, dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260611-io_projection-v4-19-1f7224b02dcb@garyguo.net>
References: <20260611-io_projection-v4-19-1f7224b02dcb@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 19:11:15 +0000
Message-Id: <20260611191116.1BEAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] SysMemBackend::copy_read and copy_write use read_volatile and writ=
e_volatile on arbitrary generic types T, violating LKMM and LLVM constraint=
s.
- [High] MmioBackend::copy_from_io and copy_to_io map bulk copies to memcpy=
_fromio/memcpy_toio, violating endianness subsystem guidelines.
- [High] SysMemBackend::copy_from_io and copy_to_io rely on bindings::memcp=
y for volatile semantics, leading to TOCTOU and data races.
--

commit 8004726b3c24d7011df864d4b9595e8a500deac8
Author: Gary Guo <gary@garyguo.net>

rust: io: re-introduce copy methods

This commit re-introduces the ability to read and write large structs that
was lost when migrating to the io_read and io_write macros. It adds copying
methods that model memcpy semantics to ensure users expect a lack of
atomicity. It also extends these methods for MMIO via memcpy_fromio and
memcpy_toio.

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index f64ca2202ff2..16f818d396bf 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs

[ ... ]

> @@ -981,6 +1154,28 @@ fn io_write(view: <$backend as IoBackend>::View<'_,=
 $ty>, value: $ty) {
>  #[cfg(CONFIG_64BIT)]
>  impl_mmio_io_capable!(MmioBackend, u64, readq, writeq);
> =20
> +impl IoCopyable for MmioBackend {
> +    #[inline]
> +    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
> +        // SAFETY:
> +        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
> +        // - `buffer` is valid for write for `view.size()` bytes.
> +        unsafe {
> +            bindings::memcpy_fromio(buffer.cast(), view.ptr.cast(), view=
.size());
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^

[Severity: High]
Will this implementation violate the endianness subsystem guidelines for
MmioBackend?

The MmioBackend implements copy_from_io using memcpy_fromio, which is a
stream accessor that copies memory byte-for-byte without performing
CPU-to-device endianness byteswapping.

In contrast, scalar MMIO accessors (like io_read/io_write using
readl/writel) perform implicit byteswapping. If a user reads a hardware
struct using copy_read, multi-byte integer fields will retain the device's
byte order on big-endian systems, whereas reading them individually via
io_read would swap them to native CPU endianness.

Mixing stream and register accessors for the same memory region can lead
to silent data corruption on big-endian architectures.

> +        }
> +    }
> +
> +    #[inline]
> +    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
> +        // SAFETY:
> +        // - `view.ptr` is valid MMIO memory for `view.size()` bytes.
> +        // - `buffer` is valid for read for `view.size()` bytes.
> +        unsafe {
> +            bindings::memcpy_toio(view.ptr.cast(), buffer.cast(), view.s=
ize());
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^

[Severity: High]
Could using memcpy_toio here also bypass endianness byteswapping?

Using a stream accessor for a generic bulk copy instead of scalar register
accessors might lead to endianness portability bugs when used alongside
io_write on the same memory region.

> +        }
> +    }
> +}

[ ... ]

> @@ -1145,6 +1340,47 @@ fn io_write(view: SysMem<'_, $ty>, value: $ty) {
>  #[cfg(CONFIG_64BIT)]
>  impl_sysmem_io_capable!(u64);
> =20
> +impl IoCopyable for SysMemBackend {
> +    #[inline]
> +    unsafe fn copy_from_io(view: Self::View<'_, [u8]>, buffer: *mut u8) {
> +        // Use bindings::memcpy instead of copy_nonoverlapping for volat=
ile.
> +        // SAFETY:
> +        // - `view.ptr` is in CPU address space and valid for read.
> +        // - `buffer` is valid for write for `view.size()` bytes which i=
s equal to `view.ptr.len()`.
> +        unsafe { bindings::memcpy(buffer.cast(), view.ptr.cast(), view.p=
tr.len()) };
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^

[Severity: High]
Is it safe to assume bindings::memcpy provides volatile access guarantees?

The comment states it uses bindings::memcpy instead of copy_nonoverlapping
for volatile, but bindings::memcpy provides no volatile guarantees in C or
LLVM.

Because memcpy is a standard memory operation, LLVM can aggressively
optimize it, potentially eliding the copy if the destination is unread
locally, reordering accesses, or tearing reads and writes to DMA coherent
memory.

This could strip the required volatile semantics and cause hardware
desynchronization or TOCTOU vulnerabilities.

> +    }
> +
> +    #[inline]
> +    unsafe fn copy_to_io(view: Self::View<'_, [u8]>, buffer: *const u8) {
> +        // Use bindings::memcpy instead of copy_nonoverlapping for volat=
ile.
> +        // SAFETY:
> +        // - `view.ptr` is in CPU address space and valid for write.
> +        // - `buffer` is valid for read for `view.size()` bytes which is=
 equal to `view.ptr.len()`.
> +        unsafe { bindings::memcpy(view.ptr.cast(), buffer.cast(), view.p=
tr.len()) };
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^

[Severity: High]
Might this copy also lack volatile guarantees for the same reason?

Calling bindings::memcpy does not ensure volatile memory access semantics,
which could lead to LLVM optimizing away the copy or reordering it.

> +    }
> +
> +    #[inline]
> +    fn copy_read<T: FromBytes>(view: Self::View<'_, T>) -> T {
> +        // SAFETY:
> +        // - Per type invariant, ptr is valid and aligned.
> +        // - Using read_volatile() here so that race with hardware is we=
ll-defined.
> +        // - Using read_volatile() here is not sound if it races with ot=
her CPU per Rust
> +        //   rules, but this is allowed per LKMM.
> +        // - The macro is only used on primitives so all bit patterns ar=
e valid.
> +        unsafe { view.ptr.read_volatile() }
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Can calling read_volatile() on a generic type T violate LKMM and LLVM
constraints?

Since copy_read is generic over T: FromBytes, T can be an arbitrarily
large structure. The Linux Kernel Memory Model (LKMM) restricts volatile
accesses to machine-word sizes or smaller.

Using read_volatile on large structures can lead to unpredictable LLVM
codegen, including non-volatile block copies or compiler crashes. The
safety comment mentions that the macro is only used on primitives, which
seems incorrectly copied from primitive accessors.

> +    }
> +
> +    #[inline]
> +    fn copy_write<T: IntoBytes>(view: Self::View<'_, T>, value: T) {
> +        // SAFETY:
> +        // - Per type invariant, ptr is valid and aligned.
> +        // - Using write_volatile() here so that race with hardware is w=
ell-defined.
> +        // - Using write_volatile() here is not sound if it races with o=
ther CPU per Rust
> +        //   rules, but this is allowed per LKMM.
> +        unsafe { view.ptr.write_volatile(value) }
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Are there similar LKMM constraint violations when using write_volatile()
on generic type T?

Similar to copy_read, T could be larger than a machine word, which is not
supported by LKMM for volatile writes and may cause unpredictable compiler
behavior.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611-io_project=
ion-v4-0-1f7224b02dcb@garyguo.net?part=3D19
