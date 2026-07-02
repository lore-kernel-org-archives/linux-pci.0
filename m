Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F893EDACC
	for <linux-pci@vger.kernel.org>; Thu,  2 Jul 2026 11:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782991336; cv=none; b=Baki8lk0TT5JPVye4DOwYycN1N1o8maP3xg2OLguI1GEtUGMHWmBUEPQ+nAPpXXBXXuwb4XNLcYKiqZ0Exavi4AuYx2ez/0d+i/JXr8pmEAdu2xNP+C20Od3cu91scqBfloqfYf4+hc8L2TE3alpGTNk5TO6BhpXHg6s+k3geLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782991336; c=relaxed/simple;
	bh=h6Hjsd6YIlOqO7foxw2433GlwA8x369rcvFYjko/x58=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=C+zuggKxYq0unMMS7zzbJlatkwVueaJ07+IDo3pip6M008G6lZfKDcgvtnL40A8zLFwOlkY1FRJtFtvMPdZWYksxk7spuefyjlHfACEtxqbIa4HYCXpkadqr9PKYPnbkrBkxSIGGKJSxv4sso9Ifs0yYSAsDEVY1F0Dqq+nauTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Eh2EkCxu; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Eh2EkCxu"
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-470cb859d96so1049964f8f.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Jul 2026 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782991332; x=1783596132; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ABHfhQD3F9b+S3MG2pxSXvPENP4iWnPQjn40BCzCts=;
        b=Eh2EkCxu6qZaJYcrUBXnS9AuMYDsFND6PrC+RoQUbqMBDifg7NevnSTSeHURJQnrur
         OAGxKYr2D+ZGlabR/kgftOQxLFOq+mf7DzZJwYpY2kgKvxDiC44fxLD/9FLcyjgEj+T0
         +0G1Lkbpj/UfJq1T1PqP747p8ea09be5ibpZ8IMxDCnFTtSzKUesLOgL5mbJQY50iiuo
         ux1LYd7LP5X/rNWJptrRvIlansMcf7dJab04zuUstN2M3JSEjxWUYOuUBi4Sqhx0IJrs
         JSluHPP9tv2ibPa8J7VVPCx5blFWBKNyTuK4IkIceXMDAR8T9D+v/Dl59fyREvXQg46P
         9cqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782991332; x=1783596132;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ABHfhQD3F9b+S3MG2pxSXvPENP4iWnPQjn40BCzCts=;
        b=Ci/irwhxgofAf2rTeAtH4vi4mIAq66APbR4fecheKcOP9/KKR61KOGjlqbhBMRrZTg
         iKEgeELOm8iZk1P5FSkIYNYmK2yoDcAG5x7tZ8+GvOjSEnVrz8TYoh8WJkNXHD28QQ8W
         h6X2KbUQGD9j6mOod3jEZhu2CGKp1C9528dsgDnVZ6jzXKh1LrzL//pmdNQc+w2du3S6
         SMithD0zeMj1GvQvdBLKifJeBTCiSBnDmU9khtcanzx+Mesv04ZzHWGlUvxRox9r6HaV
         ramF8BuFOnhbDHmkphfMvtYoUUjD6OwYtBZ2M+ZxBs5aDlKR3mNPciFIO81opa8O5QGr
         zpeA==
X-Forwarded-Encrypted: i=1; AFNElJ/g5hNYVlA7bXwAompjw0wkWfnpYl5xqmzGXnehhkLTWGMmYrzxY6eTfyG78LnrignMiF4F4zjlEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOHCj/L3SFaVrxHH5h7lDL337zohYRiLAxBLve5nKpm3BE+PZ5
	O5B9D6WRPv83mifWjDWT4P6GmOyyQZBC0v0ocLhhTxo7UrZLUWWEOtMUt/fE9EqSOd049NFUy0G
	217vZNwiGl0x/Tndm6g==
X-Received: from wmby21.prod.google.com ([2002:a05:600c:c055:b0:493:bd67:3b3e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:524a:b0:493:af0d:484c with SMTP id 5b1f17b1804b1-493c3df2fb5mr67180355e9.34.1782991332107;
 Thu, 02 Jul 2026 04:22:12 -0700 (PDT)
Date: Thu, 2 Jul 2026 11:22:10 +0000
In-Reply-To: <9e020dbc48fa9f209248864cdd1b7b9ebf2eecc4.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260629-rust_leds-v21-0-4f0f19579db5@posteo.de>
 <20260629-rust_leds-v21-1-4f0f19579db5@posteo.de> <akZBsBrMlxd4qbBl@google.com>
 <9e020dbc48fa9f209248864cdd1b7b9ebf2eecc4.camel@posteo.de>
Message-ID: <akZJ4l3LzX4dEBOe@google.com>
Subject: Re: [PATCH v21 1/3] rust: leds: add basic led classdev abstractions
From: Alice Ryhl <aliceryhl@google.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman <david.m.ertman@intel.com>, 
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Ira Weiny <iweiny@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Jul 02, 2026 at 11:00:30AM +0000, Markus Probst wrote:
> On Thu, 2026-07-02 at 10:47 +0000, Alice Ryhl wrote:
> > On Mon, Jun 29, 2026 at 01:10:28PM +0000, Markus Probst wrote:
> > > Implement the core abstractions needed for led class devices, including:
> > > 
> > > * `led::LedOps` - the trait for handling leds, including
> > >   `brightness_set`, `brightness_get` and `blink_set`
> > > 
> > > * `led::DeviceBuilder` - the builder for the led class device
> > > 
> > > * `led::Device` - a safe wrapper around `led_classdev`
> > > 
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  MAINTAINERS               |   8 ++
> > >  rust/kernel/led.rs        | 288 ++++++++++++++++++++++++++++++++++++++++++++++
> > >  rust/kernel/led/normal.rs | 230 ++++++++++++++++++++++++++++++++++++
> > >  rust/kernel/lib.rs        |   1 +
> > >  4 files changed, 527 insertions(+)
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 15011f5752a9..ceb2285366ff 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -14662,6 +14662,14 @@ F:	drivers/leds/
> > >  F:	include/dt-bindings/leds/
> > >  F:	include/linux/leds.h
> > >  
> > > +LED SUBSYSTEM [RUST]
> > > +M:	Markus Probst <markus.probst@posteo.de>
> > > +L:	linux-leds@vger.kernel.org
> > > +L:	rust-for-linux@vger.kernel.org
> > > +S:	Maintained
> > > +F:	rust/kernel/led.rs
> > > +F:	rust/kernel/led/
> > > +
> > >  LEGO MINDSTORMS EV3
> > >  R:	David Lechner <david@lechnology.com>
> > >  S:	Maintained
> > > diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> > > new file mode 100644
> > > index 000000000000..c92d99d68497
> > > --- /dev/null
> > > +++ b/rust/kernel/led.rs
> > > @@ -0,0 +1,288 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Abstractions for the leds driver model.
> > > +//!
> > > +//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> > > +
> > > +use core::{
> > > +    marker::PhantomData,
> > > +    mem::transmute,
> > > +    ptr::NonNull, //
> > > +};
> > > +
> > > +use crate::{
> > > +    container_of,
> > > +    device::{
> > > +        self,
> > > +        property::FwNode,
> > > +        AsBusDevice,
> > > +        Bound, //
> > > +    },
> > > +    error::{
> > > +        from_result,
> > > +        to_result,
> > > +        VTABLE_DEFAULT_ERROR, //
> > > +    },
> > > +    macros::vtable,
> > > +    prelude::*,
> > > +    str::CStrExt,
> > 
> > CStrExt is in the prelude. Please check for unnecessary imports.
> There is a
> `use super::*;` in rust/kernel/led/normal.rs and
> rust/kernel/led/multicolor.rs, which both make use of CStrExt.
> The latter being in patch 3.

I understand that you are using it. However, it's still unnecessary
because you also imported prelude::*.

> > > diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
> > > new file mode 100644
> > > index 000000000000..2769f690bb24
> > > --- /dev/null
> > > +++ b/rust/kernel/led/normal.rs
> > > @@ -0,0 +1,230 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Led mode for the `struct led_classdev`.
> > > +//!
> > > +//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> > > +
> > > +use super::*;
> > > +
> > > +/// The led class device representation.
> > > +///
> > > +/// This structure represents the Rust abstraction for a led class device.
> > > +#[pin_data(PinnedDrop)]
> > > +pub struct Device<'bound, T: LedOps + 'bound> {
> > > +    #[pin]
> > > +    ops: T,
> > > +    #[pin]
> > > +    classdev: Opaque<bindings::led_classdev>,
> > > +    _p: PhantomData<&'bound ()>,
> > > +}
> > > +
> > > +impl<'a, S: DeviceBuilderState> DeviceBuilder<'a, S> {
> > > +    /// Registers a new [`Device`].
> > > +    pub fn build<'bound: 'a, T: LedOps + 'bound>(
> > > +        self,
> > > +        parent: &'bound T::Bus,
> > > +        ops: impl PinInit<T, Error> + 'a,
> > > +    ) -> impl PinInit<Device<'bound, T>, Error> + 'a {
> > 
> > I think it would be useful to separate out the two lifetimes more
> > clearly. You have two sets of lifetimes:
> > 
> > * 'bound which is the duration in which the bus device is bound.
> > * 'a which is the duration in which the `name`/`devicename` fields are
> >   valid.
> > 
> > And these have different constraints because 'bound is much larger than
> > 'a. The 'bound lifetime is longer than the entire Device struct, but the
> > 'a lifetime only needs to last for the duration of the initialization
> > because (I assume) the strings are copied by `led_classdev_register_ext`
> > 
> > So under that logic, I would rename 'a to 'name or something like that
> > to indicate what it's the lifetime of.
> Preferably 'init, which can be used in other class device abstractions
> as well if needed.

Sounds good.

> > 
> > Note that if I'm wrong about the lifetime of the name strings, then this
> > code should be changed accordingly. It looks like you're actually
> > stashing the pointers in the led_classdev, and if that outlives this
> > initializer, then the current lifetimes are wrong, and Device must also
> > be annotated with 'name to indicate this additional lifetime.
> name and devicename only need to be valid for the duration of
> `led_classdev_register_ext`.

Great.

Alice
