Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB873DDB1F
	for <linux-pci@vger.kernel.org>; Mon,  6 Jul 2026 13:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783342920; cv=none; b=QPi0XRxmLCdKVgiCsKgNT/7IqrDwacm08bP35plawCULQQ+9VK2yuF3x66OVJoyLK3jJ2inG8nQwfLYBb/pAMyJu4rYQrAOsrvvagPu81/tkgdMyDoPNKHBzlzhmML+rinEK7GLfn+S7/zkiemFACA6HAPnw++fL14Xc2SHdVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783342920; c=relaxed/simple;
	bh=6y+MFKM8FK6FI6vAUyrQtaX8ybVsV3ndRJ9X7q7rkf8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oBuyvOLqNa6qdwRoDghIW/l4oe6tmx4A1qhXjssnt/Fh/C+PBcVA0YurlM7igK3WQpbdG9ycyaxJXu3IU1l5aQeXGuI45Abd8HVhfCWQ0oMF1780lc+QJCisU1nVzjO1Z4gODJP72JXBN1ed92DD1prua4Kcpa4fF+sFzdJ66Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnoeaQqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnoeaQqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD0C1F00A3A;
	Mon,  6 Jul 2026 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783342919;
	bh=OGmcyP6BmS9wQc7/06ZhpmOGMu2PkE14odFg3emM7FI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JnoeaQqn4NU0cOna5olKzlDfV+nDyX5+m/u0/e1BC0uzXbtlE907X0k8vMDtl0ZwK
	 e7S8ES0unCnuPEBXpWGuGaLaO6dfcqRZbzvbQbHF7OkNmsktF1kTwEREw7sa6ZIRSb
	 Bpk5fI5n2C8RsnkK32u8VeaF8Oat4xAYGal1rD2MPSh/YwTK3XU3r+4NZ4AihV8FVb
	 svb7pWRNeeRObm242nQqBwBRJSY1AIF/n4GqHt12KZhFtYIxVGHqma8vk1tjZaS8CC
	 hXAKoCgldcQrZs+6yBzwzglVRJRvtlnfwJz8/h/jt4nM8SoymhCq3A4kpbHZODyAda
	 DIThiuDh8jgIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/20] rust: io: add I/O backend for system memory
 with volatile access
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, linux-pci@vger.kernel.org, dri-devel@lists.freedesktop.org, "Danilo
 Krummrich" <dakr@kernel.org>, ojeda@kernel.org
In-Reply-To: <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
 <20260706-io_projection-v6-14-72cd5d055d54@garyguo.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 13:01:59 +0000
Message-Id: <20260706130159.5FD0C1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] SysMem silently breaks the implicit endianness and memory ordering=
 contracts of the Io trait, making generic I/O abstraction unsafe on big-en=
dian architectures and weakly-ordered CPUs.
--

commit f9c9f4f480b4daad1545ae67d8a19099030dc2fd
Author: Laura Nao <laura.nao@collabora.com>

rust: io: add I/O backend for system memory with volatile access

This commit adds a SysMem backend for the Io trait, intended for kernel=20
virtual address ranges. It uses volatile accessors to provide access to=20
shared memory, allowing alternative mapping layers to devices.

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 62643b23e9042..78c6ae2a0db82 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs

[ ... ]

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

[Severity: High]
Do these volatile accessors break the implicit endianness and memory orderi=
ng
contracts established for the Io trait?

The MmioBackend implements io_write and io_read using writel and readl,
which perform little-endian byte-swapping and include memory barriers. In
contrast, SysMemBackend uses native-endian write_volatile and read_volatile
without memory barriers.

If a driver uses the Io trait generically, could this difference lead to
data corruption or DMA race conditions on big-endian or weakly-ordered
architectures? For instance, if a driver manually byte-swaps to little-endi=
an,
MmioBackend would double-swap it, whereas SysMemBackend would write the
manually swapped data.

> +        }
> +    };
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-io_project=
ion-v6-0-72cd5d055d54@garyguo.net?part=3D14
