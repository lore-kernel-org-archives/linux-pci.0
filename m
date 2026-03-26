Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7352BDC03;
	Thu, 26 Mar 2026 13:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774530295; cv=none; b=gDLg5RwtVffMoIAxNryVUX8i6K2ni1ohE8NE1wGpvTHrUGzDjL18fjHbOFN8Wdo1C87qC9adDWHP2JMlHS0IueQSftQFPGP6XejlOQi1SHqBLjiedavLvck0w06ias8U5Qc7GRRDtjlWp51TLQj1j+vQcJA+KVqWYsls0EfVZUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774530295; c=relaxed/simple;
	bh=p+/+XYruYOm+4/dQGicjJQI45qgozHZLu0iAWiz85c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n36dG6AbK6NivqpJY/it4HZ8t9UqjF+98im031kmiyojmtrc1jyoqz9FGAp8TQJZzt9WQtzpQGsEXTtfrUVYBktBKoLQEqVrIsVJPRRfZtAIqJsCd4/sJmHVBilo0W9yl+BTHW0R+bnyNFV7MC/fZrsMUM6R996dMA5fIXETrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABKH3HCt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABKH3HCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69A25C116C6;
	Thu, 26 Mar 2026 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774530295;
	bh=p+/+XYruYOm+4/dQGicjJQI45qgozHZLu0iAWiz85c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ABKH3HCtVpzsOhZUFIsmFol3gcEwj71cYxAcMriC/PYYXzXnFOsM1eGV/O3HqO6Ro
	 CQ8K+ltSIjofr5wcreoN1J1Q/tCgD91BJ9sknbW/Mt2ocMDIhMEk/j+a9422bvxjj6
	 aV9N8WgsergofSEq/fuWelBpfbfj9sEHord+8WIPZBW5vKbTtQbyVz4kT8oM05JIoL
	 HHCsGPfzHeqMBEQC8ftoEekxhIFTOxBr+gamMk6hSX5rT1gdnh5Yz4OWiuLDO401Ir
	 aKHkEsDhtNXgajOyx8FqcKC15qpVlm/Vbuz+aImsLB1OtzDXqCs1M0cQt6k+gZoy09
	 CkjNgeBm5NAMQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
In-Reply-To: <20260323153807.1360705-3-gary@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <_GdG2BR4qqT-8cwpiurteKJJr58WPTCsM6UyCU0NsA1DK6yTNMiSGOBZlm79OMaLm_tIMM7feHDx7mKljWea4A==@protonmail.internalid>
 <20260323153807.1360705-3-gary@kernel.org>
Date: Thu, 26 Mar 2026 14:04:46 +0100
Message-ID: <87o6kayc5t.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@kernel.org> writes:

> From: Gary Guo <gary@garyguo.net>
>
> Currently, `io::Mmio` always represent an untyped region of a compile-time
> known minimum size, which is roughly equivalent to `void __iomem*` (but
> with bound checks). However, it is useful to also be to represent I/O
> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>
> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or a
> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
> change brings the MMIO closer to the DMA coherent allocation types that we
> have, which is already typed.
>
> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
> `KnownSize` trait to represent compile-time known minimum size of a
> specific type.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  rust/kernel/devres.rs      |  2 +-
>  rust/kernel/io.rs          | 63 ++++++++++++++++++++++----------------
>  rust/kernel/io/mem.rs      |  4 +--
>  rust/kernel/io/poll.rs     |  6 ++--
>  rust/kernel/io/register.rs | 19 +++++++-----
>  rust/kernel/pci/io.rs      |  2 +-
>  rust/kernel/ptr.rs         |  7 +++++
>  7 files changed, 64 insertions(+), 39 deletions(-)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 65a4082122af..3e22c63efb98 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -106,7 +106,7 @@ struct Inner<T> {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target = Mmio<SIZE>;
> +///    type Target = Mmio<Region<SIZE>>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index d7f2145fa9b9..5a26b1e7e533 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize = 0> {
>  }
>
>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
> +    const MIN_SIZE: usize = SIZE;
> +
>      #[inline(always)]
>      fn size(p: *const Self) -> usize {
>          (p as *const [u8]).len()
> @@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
>  /// }
>  ///
>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
> -///    type Target = Mmio<SIZE>;
> +///    type Target = Mmio<Region<SIZE>>;
>  ///
>  ///    fn deref(&self) -> &Self::Target {
>  ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
> @@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
>  /// # }
>  /// ```
>  #[repr(transparent)]
> -pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
> +pub struct Mmio<T: ?Sized>(MmioRaw<T>);

Why not have the `KnownSize` bound here? I think that would be more clear.


Best regards,
Andreas Hindborg


