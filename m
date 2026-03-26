Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A753FBED0;
	Thu, 26 Mar 2026 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774534847; cv=none; b=oiF2AyGKDmy1vFLktLZVALcG+a1qqIhIQccjyG9s21TADeZHWoOVO5nWonShBSg1A0TgvavVWVBcXoLm8dSsg8bdNf7o9VdPFXrn2QkOnI5ADWblP/Hma6SAwfG512KMUvR+jr1CS+sdhFlCUXbWewu8NymuhtTjv0/xQFsDnFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774534847; c=relaxed/simple;
	bh=+gvO9WXnFBzP0gDjUrGdoVZH6cNoIT4E9swdA9rjBmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JN7fNTQ3vKI+ElojlLIKo9goFMjpi/E6frsVYUarZ8vz22fED0zaIPvzAKt/XvhEzR4q8amnc/g8peY6cQDk7q6+GbiZQn6Sm+FG6yqa9QP+BAdxBjkPs0Wy02oeA/ihohBx1JD10Kfbh0dWVkwT9o+4SsZ3jBfHz+l/Yv4tk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCfyPjeI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCfyPjeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C16BC116C6;
	Thu, 26 Mar 2026 14:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774534846;
	bh=+gvO9WXnFBzP0gDjUrGdoVZH6cNoIT4E9swdA9rjBmk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dCfyPjeIGlzamoXl+EZ6CBWSJ2XFyjHNAtT/0ynv2dlhiBsIgO0ekkfoDy8rR7xO9
	 hcShU+w5Vrh3vNZdpmlmwF6eNxFQ6EVEZouvieixwl7c0iBoiag69F2aNZFRLN/Uk8
	 2Bo36C0Arwry4abWUycZbCxMcbMKfQ77oKYOsLtB1djPUJXK6XNDNIMGD1OM6mtK3l
	 dA+uvD292thx2OaXmokKFKBjYLPBuckHGbA7MZyw5a443iRCvQUMcU7Zy3tKTutmwA
	 eT34mbqZ+6abH/rXFTNSgfklcrA9BO8dPJufhxOLq20UOQQuPvkd2bAfLd7jJYEJam
	 WsYWUhPVMBy8g==
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
Subject: Re: [PATCH 3/8] rust: io: use pointer types instead of address
In-Reply-To: <20260323153807.1360705-4-gary@kernel.org>
References: <20260323153807.1360705-1-gary@kernel.org>
 <U_v6wkMtfgu8yfV2Nh5Im8t1w4KZ7mdbG3VQciT2g3DULhsKBXJgIz2psuj76-V94TPNtUry3J727gLTbUByug==@protonmail.internalid>
 <20260323153807.1360705-4-gary@kernel.org>
Date: Thu, 26 Mar 2026 15:20:34 +0100
Message-ID: <87ldfey8nh.fsf@t14s.mail-host-address-is-not-set>
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
> This carries the size information with the pointer type and metadata, makes
> it possible to use I/O projections and paves the way for IO view types.
>
> With this change, minimum size information becomes available through types;
> so `KnownSize::MIN_SIZE` can be used and `IoKnownSize` trait is no longer
> necessary. The trait is kept for compatibility and can be removed when
> users stop using it for bounds.
>
> PCI config space uses only offsets and not pointers like MMIO; for this
> null pointers (with proper size metadata) is used. This is okay as I/O
> trait impl and I/O projections can operate on invalid pointers, and for PCI
> config space we will only use address info and ignore the provenance.
>
> The current safety comment on `io_read`/`io_write` does not cover the topic
> about alignment, although this is guaranteed by checks in `Io`. Add it so
> it can be relied on by implementor of `IoCapable`.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---

<cut>

> +impl<T: Io + ?Sized> IoKnownSize for T {}
>
>  /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
>  macro_rules! impl_mmio_io_capable {
>      ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
>          $(#[$attr])*
>          impl<T: ?Sized> IoCapable<$ty> for $mmio<T> {
> -            unsafe fn io_read(&self, address: usize) -> $ty {
> +            unsafe fn io_read(&self, address: *mut $ty) -> $ty {
>                  // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
>                  unsafe { bindings::$read_fn(address as *const c_void) }

Should we change this to a `cast()`?

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Side question: Can you explain a situation where `IoLoc::offset` is not identity?


Best regards,
Andreas Hindborg


