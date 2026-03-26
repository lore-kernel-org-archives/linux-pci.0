Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7543A3803;
	Thu, 26 Mar 2026 18:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549442; cv=none; b=i7AmEuSdgWGH0hh+P0+2vBTi+JMrdHGIFbv4S7H06XDXke2z9kR34cg0YalaMc7HgY0IINv2UYDj7BjmNUsHeIz/SUWaiX+S4ijMneWvkVL/COgyfxuqiSnsg3QxH86vD5gpb5Evblg0JjcH68/jov/0gWjJY2c3IR+isfxnmso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549442; c=relaxed/simple;
	bh=uAk+pjEaMh+nT4wwJQBe0ub0p3rD0eHGiODDm8RKEAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h1T2zaMYZFlUcOHeq5aGKKoWOG2a5Adry0HKQxxOTcv4qf0NBAzU2fCzUWdwBodiC0XOnK1ZItSh0hd52vNzRH20JQt2RXN0E5jZLZasKNQtWetW5Ls/ARqvkxHYmvgP/LZfqFOlsSbaBAHdlypElmu8Z1hb26KWTmMoiNf+50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUzctKT5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUzctKT5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98AF6C116C6;
	Thu, 26 Mar 2026 18:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549441;
	bh=uAk+pjEaMh+nT4wwJQBe0ub0p3rD0eHGiODDm8RKEAY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XUzctKT5rMuAloImHakMBDiY0jo1D02aLAz9PKhAYBCCQozAy9ZuF4cW24Us4bxHH
	 RX40m47lVZBQM/JUwR3p3I9/PqHw4CA0szbvA0TN5JlPyuHwDvAv4Wb15AnRrK2p3J
	 m5dMIpkfjCqse5hEusV9inOEpC1hi8yDx/jnr3kYYSsRCj5Us5K+4IKcxV5I1y2Vap
	 mAPlTdh03watV3YH+KCqXo/qynewnHh2hDhR07WRL9WFsYfO2BEefSseFj/HcWrzUk
	 pHBng94J3J9cS71VZNejbA6EDr6lPohgIou3RlnffIJXTLy9MOT2Riwlri9i/ZO8yF
	 NJqLb8S9rO/Fw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Gary Guo <gary@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/8] rust: io: generalize `Mmio` to arbitrary type
In-Reply-To: <DHCSCWVI38X2.2K7DBY0YPBS5N@garyguo.net>
References: <20260323153807.1360705-1-gary@kernel.org>
 <_GdG2BR4qqT-8cwpiurteKJJr58WPTCsM6UyCU0NsA1DK6yTNMiSGOBZlm79OMaLm_tIMM7feHDx7mKljWea4A==@protonmail.internalid>
 <20260323153807.1360705-3-gary@kernel.org>
 <87o6kayc5t.fsf@t14s.mail-host-address-is-not-set>
 <bhB8A8DQ2KuT2rRe-Niqt5dPHRePikSsZfFL2XCGm9ABnQEpzHCN7f_1CfKvSOhXffGqseuceJL6XoBlwA_8aQ==@protonmail.internalid>
 <DHCSCWVI38X2.2K7DBY0YPBS5N@garyguo.net>
Date: Thu, 26 Mar 2026 19:23:48 +0100
Message-ID: <87bjgaxxe3.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Gary Guo" <gary@garyguo.net> writes:

> On Thu Mar 26, 2026 at 1:04 PM GMT, Andreas Hindborg wrote:
>> "Gary Guo" <gary@kernel.org> writes:
>>
>>> From: Gary Guo <gary@garyguo.net>
>>>
>>> Currently, `io::Mmio` always represent an untyped region of a compile-time
>>> known minimum size, which is roughly equivalent to `void __iomem*` (but
>>> with bound checks). However, it is useful to also be to represent I/O
>>> memory of a specific type, e.g. `u32 __iomem*` or `struct foo __iomem*`.
>>>
>>> Thus, make `Mmio` generic on arbitrary `T`, where `T` is a sized type, or a
>>> DST that implements `KnownSize`. Similar to the `MmioRaw` change, the
>>> existing behaviour is preserved in the form of `Mmio<Region<SIZE>>`. This
>>> change brings the MMIO closer to the DMA coherent allocation types that we
>>> have, which is already typed.
>>>
>>> To be able to implement `IoKnownSize`, add a `MIN_SIZE` constant to
>>> `KnownSize` trait to represent compile-time known minimum size of a
>>> specific type.
>>>
>>> Signed-off-by: Gary Guo <gary@garyguo.net>
>>> ---
>>>  rust/kernel/devres.rs      |  2 +-
>>>  rust/kernel/io.rs          | 63 ++++++++++++++++++++++----------------
>>>  rust/kernel/io/mem.rs      |  4 +--
>>>  rust/kernel/io/poll.rs     |  6 ++--
>>>  rust/kernel/io/register.rs | 19 +++++++-----
>>>  rust/kernel/pci/io.rs      |  2 +-
>>>  rust/kernel/ptr.rs         |  7 +++++
>>>  7 files changed, 64 insertions(+), 39 deletions(-)
>>>
>>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>>> index 65a4082122af..3e22c63efb98 100644
>>> --- a/rust/kernel/devres.rs
>>> +++ b/rust/kernel/devres.rs
>>> @@ -106,7 +106,7 @@ struct Inner<T> {
>>>  /// }
>>>  ///
>>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>>> -///    type Target = Mmio<SIZE>;
>>> +///    type Target = Mmio<Region<SIZE>>;
>>>  ///
>>>  ///    fn deref(&self) -> &Self::Target {
>>>  ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
>>> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
>>> index d7f2145fa9b9..5a26b1e7e533 100644
>>> --- a/rust/kernel/io.rs
>>> +++ b/rust/kernel/io.rs
>>> @@ -44,6 +44,8 @@ pub struct Region<const SIZE: usize = 0> {
>>>  }
>>>
>>>  impl<const SIZE: usize> KnownSize for Region<SIZE> {
>>> +    const MIN_SIZE: usize = SIZE;
>>> +
>>>      #[inline(always)]
>>>      fn size(p: *const Self) -> usize {
>>>          (p as *const [u8]).len()
>>> @@ -169,7 +171,7 @@ pub fn size(&self) -> usize {
>>>  /// }
>>>  ///
>>>  /// impl<const SIZE: usize> Deref for IoMem<SIZE> {
>>> -///    type Target = Mmio<SIZE>;
>>> +///    type Target = Mmio<Region<SIZE>>;
>>>  ///
>>>  ///    fn deref(&self) -> &Self::Target {
>>>  ///         // SAFETY: The memory range stored in `self` has been properly mapped in `Self::new`.
>>> @@ -187,7 +189,7 @@ pub fn size(&self) -> usize {
>>>  /// # }
>>>  /// ```
>>>  #[repr(transparent)]
>>> -pub struct Mmio<const SIZE: usize = 0>(MmioRaw<Region<SIZE>>);
>>> +pub struct Mmio<T: ?Sized>(MmioRaw<T>);
>>
>> Why not have the `KnownSize` bound here? I think that would be more clear.
>>
>
> There's no need to put bounds on structs unless you need them for `Drop` or use
> of assoc types.

I understand there is no technical need, but it would help communicating
how the code is intended to work. Unless I am mistaken, T will always be
`KnownSize`, right?


Best regards,
Andreas Hindborg


