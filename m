Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BC4657D0
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791574506; cv=none; b=q2lemxB0mzJRljpTQg+EaJOz8KfP8tKmLuJ4cDyjkQNX6GukFKOKowPSaaXFvFdXId/wQxMkbpwOp7Zv0zartX3CtZ4XzYCYakAVMIT5CCG2+Wg1pkLkJnoVJ0okH2BG4V0xd+LVdlgFaalCgXBauvbRcGh3ZO+wBfSPkq2gDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791574506; c=relaxed/simple;
	bh=VI67kK0yf3LLqcqxgJkq+ni7vRqezpZPfa26e3J77hI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODNhXAKaAwEUv/EfD7PfaA2JwDDw2qZvXKXkggpscK4Acosw1R6lL3V6mm4Y83Qle9GYmYTQN9mbD0rwMKRdz2N0eG1X0XEiDnegdqYrhb5VheYPsS6OD3SIVjwoeADFXnM9cVVJexw7J3eX7FPyk3aZItHFIyDrEUXaiJakvk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GI57x5Tm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI57x5Tm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C681F00893;
	Fri,  9 Oct 2026 19:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791574498;
	bh=Zh1QKdnuPHz8qrqKdl99AYPMQl59mLYKBE3KN+d4/c8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GI57x5TmFfYH6PDKcU3zNCUAsZkp3joWoyMnB7PMcAVERkkk0GmvdIecIOyVOYNUR
	 cCx570tn7E+CqWCd5ASJGfob4VaNj91UdKzH5+7vDZu//3QZ5qwpFmaX/lbnv6RBE9
	 BsPkqCp0khQKV5Fe20xIU0oBlQgcfcczMXzrfqrTzAPyC+LIFbQMZzi6UlQGTt/Lco
	 Jcpq+XQDmYzwwOXCot5EU+UJx5owQpvtUkLoGmzvddzV+2lb6dQ/mrbDr4hQMRnk3B
	 XDUwxH7ipfaJaomiipRJhNQMDNe5IDPrTZk62qCYNpmVo1T2pVxTFmaRPgfZJWrk5d
	 427z7s3NgpGjg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7934FF40066;
	Fri,  9 Oct 2026 15:34:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 09 Oct 2026 15:34:56 -0400
X-ME-Sender: <xms:4EHJapYw46TDCmYavX_Zlku59rvB3NWbYr2wZRQbW0gyhnYEXyQk4A>
    <xme:4EHJan7LoejMRpC0vnXTx-rZO3klfW5ymPfdDiNow83SyAjQvudkQnrTpSvUEl_Wl
    YMBIHVWNSQ9awn5-8nQvw6Qo6D-HU8yh2zYEUuLMrRii39_AiwwZjE>
X-ME-Received: <xmr:4EHJaiDvgs_AspjaosMMrtCTnZFeN2CxwSfNIskTyJJ7Z3oai2of62z-Uqr-_fOU_7kOMutXKq4rDgh3ScDZpK88IDBmpQT->
X-ME-Proxy-Cause: dmFkZTEUyPkdXvrjVoBWG6LvMw+yaT3TjlLks69aGJmrjp2hjhjtZcPed+gE0Z5IOa2Csk
    P234AvHh51zOOqwAN/maMbbAxoBOJsAVPiTB4p7pLUwOcXn1VrMrf/PUstxr1rFQEThLPZ
    7ZTCwwlLpivaiuf2zNOCeM4WaLY0r6Kkxk1LLb6YQGaazHX37K6jpg0NBX450XwFwAMCps
    wvpeMLpOEggq42s9ZrPoFH8Mv9M20evVb5HbnZDKQjrcBPufkNyDW2Vhw8BGz0xirS0f5H
    VRZhmPpT+5dbKrdwNuR6pbLEiOJG/qGk28n51DiXtVmU/4YbIBpPDJPsPe6LkKHBsgrJme
    R+LBTlg+jQKscQbzSbtCIIi4vsK6SQZSbv19eZ7TF5qP69BDu36eEb899QSBJzui3glfap
    cluBItNzudmoohF62w+OBdou/HKkxkvmr1v14tFVHtSHIqI9IuDj5f1+Rxl3UJMeFChNot
    OddAO/fuuC9hPOSAG6B2sNosQ1oZRu5ocCOMZqxIUQd55p0HkYrLhxcNLntE6qzblVXXRd
    0JSUu8DV0xURIJDH2j+1lrFWtwS1anmfTN+qlbxCbax6Q9vaMpgW/lFv+I+9avuQb5gbJS
    hFX2x4WsEnbGlJjV8BRzAC6sEGLo0sEr+CoeFgG+mLEkj/MCMW4weX7Uhahw
X-ME-Proxy: <xmx:4EHJaluax36GZksC_XyQW41YZDGbj4emMi1CpFS3GJZyDy4BJYplQQ>
    <xmx:4EHJavtbPINhkQQ611QdTLN-tR_SotG3jf5xYAa0qrvb9cJtOkB8qQ>
    <xmx:4EHJahr_3c1oACNTSu3RZ0C_TAfBdrlvIwIUvHWBTlLShsX-cTo5-g>
    <xmx:4EHJajPkabcyG6vyNLUGXC3rJaAW4uZamitMEVvJdoEsBXTZHUfH7A>
    <xmx:4EHJanl_a1Al7ScvTryBEJ8Y0pqrIKa0xeEErrXLPN2Ux4fpcHvHn9mN>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 15:34:55 -0400 (EDT)
Date: Fri, 9 Oct 2026 12:34:54 -0700
From: Boqun Feng <boqun@kernel.org>
To: Markus Probst <markus.probst@posteo.de>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Ira Weiny <iweiny@kernel.org>, rust-for-linux@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v26 3/4] rust: leds: Add multicolor classdev abstractions
Message-ID: <aslB3lFUKpMEWOiM@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
 <ask31EX01lSL9QJ9@tardis.local>
 <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>

On Fri, Oct 09, 2026 at 07:18:16PM +0000, Markus Probst wrote:
> On Fri, 2026-10-09 at 11:52 -0700, Boqun Feng wrote:
> > On Wed, Sep 30, 2026 at 01:05:32PM +0000, Markus Probst wrote:
> > > Implement the abstractions needed for multicolor led class devices,
> > > including:
> > > 
> > > * `led::MultiColor` - the led mode implementation
> > > 
> > > * `MultiColorSubLed` - a safe wrapper arround `mc_subled`
> > > 
> > > * `led::MultiColorDevice` - a safe wrapper around `led_classdev_mc`
> > > 
> > > * `led::DeviceBuilder::build_multicolor` - a function to register a new
> > >   multicolor led class device
> > > 
> > > Signed-off-by: Markus Probst <markus.probst@posteo.de>
> > > ---
> > >  rust/bindings/bindings_helper.h |   1 +
> > >  rust/kernel/led.rs              |  34 ++-
> > >  rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 479 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > > index 4b31aa7f432f..81a03985322a 100644
> > > --- a/rust/bindings/bindings_helper.h
> > > +++ b/rust/bindings/bindings_helper.h
> > > @@ -69,6 +69,7 @@
> > >  #include <linux/iosys-map.h>
> > >  #include <linux/jiffies.h>
> > >  #include <linux/jump_label.h>
> > > +#include <linux/led-class-multicolor.h>
> > >  #include <linux/mdio.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/miscdevice.h>
> > > diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> > > index c17f8ef75006..4b66fe41a80c 100644
> > > --- a/rust/kernel/led.rs
> > > +++ b/rust/kernel/led.rs
> > > @@ -30,8 +30,16 @@
> > >      types::Opaque, //
> > >  };
> > >  
> > > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > > +mod multicolor;
> > >  mod normal;
> > >  
> > > +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> > > +pub use multicolor::{
> > > +    MultiColor,
> > > +    MultiColorDevice,
> > > +    MultiColorSubLed, //
> > > +};
> > >  pub use normal::{
> > >      Device,
> > >      Normal, //
> > > @@ -233,7 +241,24 @@ pub enum Color {
> > >      Violet = bindings::LED_COLOR_ID_VIOLET,
> > >      Yellow = bindings::LED_COLOR_ID_YELLOW,
> > >      Ir = bindings::LED_COLOR_ID_IR,
> > > +    #[cfg_attr(
> > > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > > +        doc = "Use this color for a [`MultiColor`] led."
> > > +    )]
> > > +    #[cfg_attr(
> > > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > +        doc = "Use this color for a `MultiColor` led."
> > > +    )]
> > > +    /// If the led supports RGB, use [`Color::Rgb`] instead.
> > >      Multi = bindings::LED_COLOR_ID_MULTI,
> > > +    #[cfg_attr(
> > > +        CONFIG_LEDS_CLASS_MULTICOLOR,
> > > +        doc = "Use this color for a [`MultiColor`] led with rgb support."
> > > +    )]
> > > +    #[cfg_attr(
> > > +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > +        doc = "Use this color for a `MultiColor` led with rgb support."
> > > +    )]
> > >      Rgb = bindings::LED_COLOR_ID_RGB,
> > >      Purple = bindings::LED_COLOR_ID_PURPLE,
> > >      Orange = bindings::LED_COLOR_ID_ORANGE,
> > > @@ -274,7 +299,14 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
> > >  ///
> > >  /// Each led mode has its own led class device type with different capabilities.
> > >  ///
> > > -/// See [`Normal`].
> > > +#[cfg_attr(
> > > +    CONFIG_LEDS_CLASS_MULTICOLOR,
> > > +    doc = "See [`Normal`] and [`MultiColor`]."
> > > +)]
> > > +#[cfg_attr(
> > > +    not(CONFIG_LEDS_CLASS_MULTICOLOR),
> > > +    doc = "See [`Normal`] and `MultiColor`."
> > > +)]
> > >  pub trait Mode: private::Sealed {
> > >      /// The class device for the led mode.
> > >      type Device<'bound, T: LedOps<Mode = Self> + 'bound>: Deref<Target = T>;
> > > diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> > > new file mode 100644
> > > index 000000000000..309487bdf38a
> > > --- /dev/null
> > > +++ b/rust/kernel/led/multicolor.rs
> > > @@ -0,0 +1,445 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +//! Led mode for the `struct led_classdev_mc`.
> > > +//!
> > > +//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/linux/led-class-multicolor.h)
> > > +
> > > +use core::{
> > > +    cell::UnsafeCell,
> > > +    num::NonZero,
> > > +    ptr, //
> > > +};
> > > +
> > > +use crate::types::ScopeGuard;
> > > +
> > > +use super::*;
> > > +
> > > +/// The led mode for the `struct led_classdev_mc`. Leds with this mode can have multiple colors.
> > > +pub enum MultiColor {}
> > > +impl Mode for MultiColor {
> > > +    type Device<'bound, T: LedOps<Mode = Self> + 'bound> = MultiColorDevice<'bound, T>;
> > > +}
> > > +impl private::Sealed for MultiColor {}
> > > +
> > > +/// The multicolor sub led info representation.
> > > +///
> > > +/// This structure represents the Rust abstraction for a C `struct mc_subled`.
> > > +#[repr(C)]
> > > +#[derive(Debug)]
> > > +#[non_exhaustive]
> > > +pub struct MultiColorSubLed {
> > > +    /// The color of the sub led
> > > +    pub color: Color,
> > > +    brightness: UnsafeCell<u32>,
> > > +    intensity: UnsafeCell<u32>,
> > 
> > These should be `Atomic<u32>`, or am I missing something here? Using
> > `Atomic<u32>` should resolve sashiko's comment on this patch.
> Snippet of the `Atomic::from_ptr` rustdoc:
> 
> "
> For the duration of 'a, other accesses to *ptr must not cause data
> races (defined by LKMM) against atomic operations on the returned
> reference. Note that if all other accesses are atomic, then this safety
> requirement is trivially fulfilled.
> "
> 
> This safety requirement is likely not met if I see this correctly,
> because the led subsystem does not use atomic accesses.
> 

Then the C side has a data race that needs some fix (or they use
READ_ONCE() or WRITE_ONCE() which are *atomic* to avoid the data race).

The general rule is: if C side has a data race, they should fix it, if C
side doesn't care ("the compiler should not data race on this code"),
then the Rust side treat it as atomic operations. This is the only way
to better code regarding data races.

> Ofc, this function won't be used, but I think given that the same
> struct is also accessed by the C-side, it should also apply here.
> 
> Like Sashiko suggests, "core::ptr::read_volatile()" might be a better
> option to prevent certain compiler optimizations.
> 

No, please don't over-use read_volatile(). The reason that READ_ONCE()
and WRITE_ONCE() are safe to use for synchronization is because
semantics-wise they are atomic on certain types (if aligned), and the
them being volatile is just an implementation detail.

Regards,
Boqun

> Thanks
> - Markus Probst
> 
> > 
> > Regards,
> > Boqun
> > 
> > > +    /// The maximum supported intensity value.
> > > +    ///
> > > +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNESS`].
> > > +    pub max_intensity: Option<NonZero<u32>>,
> > > +    /// Arbitrary data for the driver to store.
> > > +    pub channel: u32,
> > > +}
> > > +
> > [...]


