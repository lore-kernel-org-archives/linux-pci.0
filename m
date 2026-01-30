Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A11322B6D
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769783112; cv=none; b=anu2kwW9DG7QpTIIa89XtjU/KFaIxujKgZn4vn3p1eICB5+m8m4tsrVOdDD+FkVld6j03HHHZID2RuJZTKiuZGhEDJTfsJvHejlVxifMM78fqd1JIKoaGQcOn0277/cne+s6rwzIDJrXSOXuuj7I8uFukOkI5IcdNYAYpLbrnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769783112; c=relaxed/simple;
	bh=ky56pFmagL53l/6EDJ0oTxsX72fRm9RrAm1uoEG+cnM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iNj0gL8O4FPVALuNFzir2z+MH5ovnyVa7SndeaseMnBhLZUo4CPob7ft3F7J95vMOrPgRwcOivdurXxKZJ/w+sMlRJGZvyHXoPDs6HgTsrBAsspTR0RUD16UABdypFnlDWJrajnuhSvmdD+rbLndz+Z6HXZoj7laEpRxAdpnNzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=OAY3hYQ3; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="OAY3hYQ3"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5A817240029
	for <linux-pci@vger.kernel.org>; Fri, 30 Jan 2026 15:25:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1769783107; bh=NuU7o3acHMY5tPPTqWm/q6sOOEfui3MF1FN/fdWnEZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 From;
	b=OAY3hYQ3JiCNZ8d1tyjL++nVkypuHUaYKRREjN8KhuK+U1AuV0SFXc7K93xcQrVUw
	 4th8MZn7A+zPGwwb5cMcT89odCBmwQekO5kMxV8xPbC4V147WSDBPpbyy2jf4t+Ln0
	 QK/yfwS617lEmyyR7KkqIyDimsNccjLg7Qyy+7N1jP0alSA9DCuttSkNm/yaAriOH/
	 uTHY8JI50WtrSxyeYtZnOMdmQ41fOi1/TKtZnjSAYxCjcBdYgcx/CHF8YL36oYqFUL
	 T2BeDpG1TCMwI9QnwYTXMlaub2U5g5fL20jCkWrdsaBhk0/7kcpBsr2Uq5vEQYiaNK
	 Ko65FK8TFWnAQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4f2dZS2jQQz9rxQ;
	Fri, 30 Jan 2026 15:25:04 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>,  Alice Ryhl <aliceryhl@google.com>,
  Daniel Almeida <daniel.almeida@collabora.com>,  Miguel Ojeda
 <ojeda@kernel.org>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <lossin@kernel.org>,  Andreas Hindborg <a.hindborg@kernel.org>,
  Trevor Gross <tmgross@umich.edu>,  Bjorn Helgaas <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Zhi Wang
 <zhiw@nvidia.com>,  driver-core@lists.linux.dev,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: io: move MIN_SIZE and io_addr_assert to IoKnownSize
In-Reply-To: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>
References: <20260130-io-min-size-v1-1-65a546e3104d@nvidia.com>
Date: Fri, 30 Jan 2026 14:25:06 +0000
Message-ID: <87bjibtby8.fsf@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexandre Courbot <acourbot@nvidia.com> writes:

> `MIN_SIZE` are `io_addr_assert` only ever used for IO types which

Hi,

Typo? should be "and" instead of "are"?

Cheers,
C. Mitrodimas

> implement `IoKnownSize` and do not make sense for types that don't.
>
> It looks like they should have been there since the beginning, so move
> them while the code is still fresh.
>
> Also update `IoKnownSize`'s documentation since it is not just a marker
> trait anymore.
>
> Fixes: 121d87b28e1d ("rust: io: separate generic I/O helpers from MMIO implementation")
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/io.rs     | 36 ++++++++++++++++++------------------
>  rust/kernel/pci/io.rs |  7 +++----
>  2 files changed, 21 insertions(+), 22 deletions(-)
>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 056a3ec71647..c1cca7b438c3 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -301,9 +301,6 @@ pub trait IoCapable<T> {}
>  /// For MMIO regions, all widths (u8, u16, u32, and u64 on 64-bit systems) are typically
>  /// supported. For PCI configuration space, u8, u16, and u32 are supported but u64 is not.
>  pub trait Io {
> -    /// Minimum usable size of this region.
> -    const MIN_SIZE: usize;
> -
>      /// Returns the base address of this mapping.
>      fn addr(&self) -> usize;
>  
> @@ -323,16 +320,6 @@ fn io_addr<U>(&self, offset: usize) -> Result<usize> {
>          self.addr().checked_add(offset).ok_or(EINVAL)
>      }
>  
> -    /// Returns the absolute I/O address for a given `offset`,
> -    /// performing compile-time bound checks.
> -    // Always inline to optimize out error path of `build_assert`.
> -    #[inline(always)]
> -    fn io_addr_assert<U>(&self, offset: usize) -> usize {
> -        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> -
> -        self.addr() + offset
> -    }
> -
>      /// Fallible 8-bit read with runtime bounds check.
>      #[inline(always)]
>      fn try_read8(&self, _offset: usize) -> Result<u8>
> @@ -478,14 +465,27 @@ fn write64(&self, _value: u64, _offset: usize)
>      }
>  }
>  
> -/// Marker trait for types with a known size at compile time.
> +/// Trait for types with a known size at compile time.
>  ///
>  /// This trait is implemented by I/O backends that have a compile-time known size,
>  /// enabling the use of infallible I/O accessors with compile-time bounds checking.
>  ///
>  /// Types implementing this trait can use the infallible methods in [`Io`] trait
>  /// (e.g., `read8`, `write32`), which require `Self: IoKnownSize` bound.
> -pub trait IoKnownSize: Io {}
> +pub trait IoKnownSize: Io {
> +    /// Minimum usable size of this region.
> +    const MIN_SIZE: usize;
> +
> +    /// Returns the absolute I/O address for a given `offset`,
> +    /// performing compile-time bound checks.
> +    // Always inline to optimize out error path of `build_assert`.
> +    #[inline(always)]
> +    fn io_addr_assert<U>(&self, offset: usize) -> usize {
> +        build_assert!(offset_valid::<U>(offset, Self::MIN_SIZE));
> +
> +        self.addr() + offset
> +    }
> +}
>  
>  // MMIO regions support 8, 16, and 32-bit accesses.
>  impl<const SIZE: usize> IoCapable<u8> for Mmio<SIZE> {}
> @@ -497,8 +497,6 @@ impl<const SIZE: usize> IoCapable<u32> for Mmio<SIZE> {}
>  impl<const SIZE: usize> IoCapable<u64> for Mmio<SIZE> {}
>  
>  impl<const SIZE: usize> Io for Mmio<SIZE> {
> -    const MIN_SIZE: usize = SIZE;
> -
>      /// Returns the base address of this mapping.
>      #[inline]
>      fn addr(&self) -> usize {
> @@ -552,7 +550,9 @@ fn maxsize(&self) -> usize {
>      );
>  }
>  
> -impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {}
> +impl<const SIZE: usize> IoKnownSize for Mmio<SIZE> {
> +    const MIN_SIZE: usize = SIZE;
> +}
>  
>  impl<const SIZE: usize> Mmio<SIZE> {
>      /// Converts an `MmioRaw` into an `Mmio` instance, providing the accessors to the MMIO mapping.
> diff --git a/rust/kernel/pci/io.rs b/rust/kernel/pci/io.rs
> index 026e7a3b69bd..6ca4cf75594c 100644
> --- a/rust/kernel/pci/io.rs
> +++ b/rust/kernel/pci/io.rs
> @@ -148,8 +148,6 @@ impl<'a, S: ConfigSpaceKind> IoCapable<u16> for ConfigSpace<'a, S> {}
>  impl<'a, S: ConfigSpaceKind> IoCapable<u32> for ConfigSpace<'a, S> {}
>  
>  impl<'a, S: ConfigSpaceKind> Io for ConfigSpace<'a, S> {
> -    const MIN_SIZE: usize = S::SIZE;
> -
>      /// Returns the base address of the I/O region. It is always 0 for configuration space.
>      #[inline]
>      fn addr(&self) -> usize {
> @@ -174,8 +172,9 @@ fn maxsize(&self) -> usize {
>      define_write!(infallible, write32, call_config_write(pci_write_config_dword) <- u32);
>  }
>  
> -/// Marker trait indicating ConfigSpace has a known size at compile time.
> -impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {}
> +impl<'a, S: ConfigSpaceKind> IoKnownSize for ConfigSpace<'a, S> {
> +    const MIN_SIZE: usize = S::SIZE;
> +}
>  
>  /// A PCI BAR to perform I/O-Operations on.
>  ///
>
> ---
> base-commit: c71257394bc9c59ea727803f6e55e83fe63db74e
> change-id: 20260130-io-min-size-f3c289c148ae
>
> Best regards,
