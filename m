Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B37C2BE031;
	Mon, 16 Feb 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261484; cv=none; b=apYEHKH+PHXa981INVazxFarcRUUNGdeQK2qjb8FCTyoVO8zC0IKw14xN69cAKMpHoB175OYrghVd3t+Lnpr/bWCM+EEEIRwrEXQ+hPAOo300YLmn+KWJ5CuT21r25JEeYNZNRY7on4AxvVdceIPIa8buAtPhHSsg1rxY/9Im+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261484; c=relaxed/simple;
	bh=fN5JjLCjpdCRGL8UVVcChKscU8oAZ1nIYRtQqGpg8DE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=Cz+dZA2JRtcZrj+EJygvn9O3LAWlNibxkBwA1U177wZZsCEzTtrFWl8eqHsXdfAWLYtZ0OLflxey6+hEO13vFC7knFLsZftq3VIEi6TKPBSla5ZlyL/56JNeG+4IfWIyCIbS4J16zeE/wptCXgdMEJefGwJYx6tbJdvad+cAZHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDsemPcM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDsemPcM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F211C116C6;
	Mon, 16 Feb 2026 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261483;
	bh=fN5JjLCjpdCRGL8UVVcChKscU8oAZ1nIYRtQqGpg8DE=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=SDsemPcMW0lEMvqG9LwpxHJwmCqbET1DVGEncInMhtOmczQqTgv0/1Wiu6pEp+LVl
	 faBM25oavIloFAALlOR1DOrlqWVEUnvNm694S/AfsFxdLrQqXkMhw1tbXwfpZoqqHK
	 UntJeOG5Z7lQoIF7csP84Tu6Wfl9Q8jKv1dFVQJ386yyFFbWbsja3fFH5QmOwpoiRh
	 p9OFsWBQOMbHV70TvznVOPh1wVENde8qP27/l66yuCGfzI8nBjdgY62iYENsDCXx6L
	 DANxy/CzvbwT+F3a3y+Ok+MDzjJe/KDuvqGIzHxCEoTmkOelOIgzEtAno/Nno9Fxkz
	 qM2cAwgwqQCmg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Feb 2026 18:04:38 +0100
Message-Id: <DGGJSHVZB6U5.2V8OMF5N3KZNZ@kernel.org>
Cc: "Gary Guo" <gary@garyguo.net>, <lyude@redhat.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun.feng@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 1/6] rust: io: turn IoCapable into a functional trait
References: <20260206-io-v2-0-71dea20a06e6@nvidia.com>
 <20260206-io-v2-1-71dea20a06e6@nvidia.com>
 <97fc6c36933522eaf75f34f8fcd445715432fde4.camel@redhat.com>
 <DGCYWK1UF76I.A565AK23DZXS@nvidia.com>
 <DGD1LDCXJZR6.32S0Z7EHGYDUN@garyguo.net>
 <DGD2GXAFO99J.1Y3BA26PBVTAC@kernel.org>
 <DGGD4JTGJYXR.3THD2I3AA61PN@nvidia.com>
 <DGGDHY4582D1.1GZGZ7P98OKWO@kernel.org>
 <DGGF65JPF8S6.268LR7YDPTWMQ@nvidia.com>
In-Reply-To: <DGGF65JPF8S6.268LR7YDPTWMQ@nvidia.com>

On Mon Feb 16, 2026 at 2:27 PM CET, Alexandre Courbot wrote:
> It doesn't - here is the implementation of Io for Mmio:
>
>     impl<const SIZE: usize> Io for Mmio<SIZE> {
>         /// Returns the base address of this mapping.
>         #[inline]
>         fn addr(&self) -> usize {
>             self.0.addr()
>         }
>
>         /// Returns the maximum size of this mapping.
>         #[inline]
>         fn maxsize(&self) -> usize {
>             self.0.maxsize()
>         }
>     }
>
> Now what prevents me from doing this:
>
>     impl<const SIZE: usize> Io for YoloMmio<SIZE> {
>         fn addr(&self) -> usize {
>             self.0.addr()
>         }
>
>         fn maxsize(&self) -> usize {
>             self.0.maxsize() + 0x10000
>         }
>     }
>
> With that, I have allowed callers to invoke the unsafe methods of
> `IoCapable` on an extra 0x10000 bytes of I/O I don't own, without any
> unsafe code.

I don't think you did, as you only present half of your counter example; yo=
u
left out the IoCapable part.

I.e. with what you have above cannot uphold the safety justification in the
corresponding IoCapable implementation:

This is the invariant on struct Mmio:

	/// # Invariant
	///
	/// `addr` is the start and `maxsize` the length of valid I/O mapped memor=
y region of size
	/// `maxsize`.

And in impl_mmio_io_capable!() you refer to this invariant:

	macro_rules! impl_mmio_io_capable {
	    ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:iden=
t) =3D> {
	        $(#[$attr])*
	        impl<const SIZE: usize> IoCapable<$ty> for $mmio<SIZE> {
	            unsafe fn io_read(&self, address: usize) -> $ty {
	                // SAFETY: By the trait invariant `address` is a valid add=
ress for MMIO operations.
	                unsafe { bindings::$read_fn(address as *const c_void) }
	            }
=09
	            unsafe fn io_write(&self, value: $ty, address: usize) {
	                // SAFETY: By the trait invariant `address` is a valid add=
ress for MMIO operations.
	                unsafe { bindings::$write_fn(value, address as *mut c_void=
) }
	            }
	        }
	    };
	}

But your YoloMmio implementation doesn't provide this invariant (because it
can't).

So, how do you justify the unsafe call to bindings::$write_fn and
bindings::$read_fn now that you have to call impl_mmio_io_capable!() for
YoloMmio?

Again, you can't justify it, which proves that it doesn't matter what YoloM=
mio
returns, it matters how you can justify it in io_read() and io_write().
