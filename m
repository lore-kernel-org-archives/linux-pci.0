Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841B64F5E19
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791571929; cv=none; b=pisHiONOTopULPzsJejqTyIb59JbxfLUwBn6q0REIf6U3SiszOoGRdA1v3HIKOhrr4g6ZH0IuZBwr1JxCisKYQczwEYVm68U29vOuxA7GSDWugMmgBYW9t0eyxpZfQ82QlkEX2fzoZdRJjB0j3uP16n7Dn2oYbPpHMvTFQ7Unrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791571929; c=relaxed/simple;
	bh=CGsSouXbLNX0cRECIXyTMJVcjhnhpLk543IpFYJZEVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLvokrjbZuutv8dNON63mIgk+b9D51NkXktKQ3LnS1WJsgdKgHvYj5cexEoJJ1HJZ+oQy8iNBE4EtLr0nly2/ffVpC5R6gZMCz//b8jn/4MT1Q2y1YfnutN5RQ7pt07etFQnK8yh58lV0U01WdLG3Jdu77of+LYu54OK84ugRdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pw9HgPss; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pw9HgPss"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C02B1F00893;
	Fri,  9 Oct 2026 18:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791571928;
	bh=LEA3p4YPwgQaoGr6H4RcIZE6g5/a+camPePCa7aAZ78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pw9HgPsspP48wV7BVNpVmRR56d68n8WQ55lK/S3rR6goaqLV08BeVhhqBhYE7n6tp
	 appP3/ALXjR1KG/ULAgWLLR9NQenFm5b6Ze8sMy/GugKvMmNj/2fOX/OljDr9B2QVB
	 Jplk8VI14fISzg5nq3mZTl2lXL1zaJ7Qq1ZeIbWtSOvILMWyzXqB+0BUVduOXt3EGQ
	 gR3BQDw0CQQYTxyEbLGZKB1TYLuHfBuNrQoFDky6c85jfpvVKawJ3q0NXmSk7a/BU9
	 y3b0IqpCIaWgbKiMxY5B3AX9ZeicuWsyliUBseviZNO+PWrf45Z2HGAHbPeozTiIwd
	 jbntiXNVq9K3Q==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id A995AF40066;
	Fri,  9 Oct 2026 14:52:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 09 Oct 2026 14:52:06 -0400
X-ME-Sender: <xms:1jfJakpum0cC20jCa4W-Dz0Za_nVbceS9IiEJACnTfUO0Bq2OUbTjQ>
    <xme:1jfJaiLJc7JcAMI_MC6AMq1_kTJ69iQJA6nO3t3MkPJ89POuW7et0SuSbcYWbgWmx
    1hXY4HsNfEwqaSffGGW2aEXK4WR1yHofP6F09laCsD0pazpUFfd2B4>
X-ME-Received: <xmr:1jfJavRF_XIUSd7Sjl-eV3cBxb2Qm0rsqS8-6MS0wLL5FSyHNO4o21aDJ6RigaYZkGd2cOzxNYj9Wx0IBdZQFhhjzgn-etzH>
X-ME-Proxy-Cause: dmFkZTFpqUGWu6p6hPoGOpiRsskvvc3k8f41nkcj5ENIrSq8Ynb4Aw0OOXTw3K1Iw8tu4C
    7lx4kE/mx9ryewefxm5meTOcI98ZqN43LAKkq+qxYAvVZMNcNyhP5r0R5eaSOYgyLEa3jS
    7UZPBh/0wfBQAru08UCKTVkcE+51cRBwMXzpHAeDnwYX2KjWSkta1Bz3pXWehgtTAgr7Oa
    g5fQNzdabEK1H9Es7QQqDLZxPGqQvuo2iI25vtxadjnPWMJxyaBDPOOz8a6rj0pRDgWdxR
    wNIfOW9tknd7//uzN6loAaWKgztgK4tvWdkoXNIbJhIgxvVj+gKAgDpBhWwkwMQQTR3SST
    qMvq2FmDdD3ku0453iDzQi17qDJuIB7KGcrjQ5IxtHZTSyaGyFbFQW9pNIPGN0GW5pWRno
    hqWWzNBtg08SN+D78yHRoxIGS2iBLr1otHsR3pw/ZDzz00AkxuNWsDTfhLSIubq6VCJdHC
    aSSo2KZBlpgtxDCMDMQ68XVKyJnwobxl4BEhccOPDOoYYiXL/ZEH/jD9TPbUADZT2e7RfI
    awnevonEjrhYf+WSExUKeElu+AlU3jU2Fb6lPfHtsVL3UVL6GblRB7As3/zIG6WLe56CFS
    S1VqA7aR8+9JPHwY3B9mSO4Fjm9gJOYlilPNHoffVNxt+JkXSVQpxQs/JJnw
X-ME-Proxy: <xmx:1jfJap8KUefmaYMMluy0Ec75oT4hLqHaqed__w5HSh0vOBMUllDGRg>
    <xmx:1jfJau9ATvd_xHRFppJtjNLdKGbOhQX8bCeIJsZz7dnHXIQfk6xijA>
    <xmx:1jfJav6yH_YMlHq7CpMjJ6vkRkq0pFVCPx8cc5tSbIBepDZom91Zug>
    <xmx:1jfJakdUMnFgV3Zyv4YkTnQX0mKlufYKvBSxgp0tB2UBFEjdxSGpxQ>
    <xmx:1jfJav0v5SlYu3QyfXSQIRBSNWFQLbZRu6ttGTpoKFCzi_WkPXi5AdJ->
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:52:05 -0400 (EDT)
Date: Fri, 9 Oct 2026 11:52:04 -0700
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
Message-ID: <ask31EX01lSL9QJ9@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-rust_leds-v26-3-83837331020e@posteo.de>

On Wed, Sep 30, 2026 at 01:05:32PM +0000, Markus Probst wrote:
> Implement the abstractions needed for multicolor led class devices,
> including:
> 
> * `led::MultiColor` - the led mode implementation
> 
> * `MultiColorSubLed` - a safe wrapper arround `mc_subled`
> 
> * `led::MultiColorDevice` - a safe wrapper around `led_classdev_mc`
> 
> * `led::DeviceBuilder::build_multicolor` - a function to register a new
>   multicolor led class device
> 
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/led.rs              |  34 ++-
>  rust/kernel/led/multicolor.rs   | 445 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 479 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 4b31aa7f432f..81a03985322a 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -69,6 +69,7 @@
>  #include <linux/iosys-map.h>
>  #include <linux/jiffies.h>
>  #include <linux/jump_label.h>
> +#include <linux/led-class-multicolor.h>
>  #include <linux/mdio.h>
>  #include <linux/mm.h>
>  #include <linux/miscdevice.h>
> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> index c17f8ef75006..4b66fe41a80c 100644
> --- a/rust/kernel/led.rs
> +++ b/rust/kernel/led.rs
> @@ -30,8 +30,16 @@
>      types::Opaque, //
>  };
>  
> +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> +mod multicolor;
>  mod normal;
>  
> +#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
> +pub use multicolor::{
> +    MultiColor,
> +    MultiColorDevice,
> +    MultiColorSubLed, //
> +};
>  pub use normal::{
>      Device,
>      Normal, //
> @@ -233,7 +241,24 @@ pub enum Color {
>      Violet = bindings::LED_COLOR_ID_VIOLET,
>      Yellow = bindings::LED_COLOR_ID_YELLOW,
>      Ir = bindings::LED_COLOR_ID_IR,
> +    #[cfg_attr(
> +        CONFIG_LEDS_CLASS_MULTICOLOR,
> +        doc = "Use this color for a [`MultiColor`] led."
> +    )]
> +    #[cfg_attr(
> +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> +        doc = "Use this color for a `MultiColor` led."
> +    )]
> +    /// If the led supports RGB, use [`Color::Rgb`] instead.
>      Multi = bindings::LED_COLOR_ID_MULTI,
> +    #[cfg_attr(
> +        CONFIG_LEDS_CLASS_MULTICOLOR,
> +        doc = "Use this color for a [`MultiColor`] led with rgb support."
> +    )]
> +    #[cfg_attr(
> +        not(CONFIG_LEDS_CLASS_MULTICOLOR),
> +        doc = "Use this color for a `MultiColor` led with rgb support."
> +    )]
>      Rgb = bindings::LED_COLOR_ID_RGB,
>      Purple = bindings::LED_COLOR_ID_PURPLE,
>      Orange = bindings::LED_COLOR_ID_ORANGE,
> @@ -274,7 +299,14 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
>  ///
>  /// Each led mode has its own led class device type with different capabilities.
>  ///
> -/// See [`Normal`].
> +#[cfg_attr(
> +    CONFIG_LEDS_CLASS_MULTICOLOR,
> +    doc = "See [`Normal`] and [`MultiColor`]."
> +)]
> +#[cfg_attr(
> +    not(CONFIG_LEDS_CLASS_MULTICOLOR),
> +    doc = "See [`Normal`] and `MultiColor`."
> +)]
>  pub trait Mode: private::Sealed {
>      /// The class device for the led mode.
>      type Device<'bound, T: LedOps<Mode = Self> + 'bound>: Deref<Target = T>;
> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 000000000000..309487bdf38a
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
> @@ -0,0 +1,445 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Led mode for the `struct led_classdev_mc`.
> +//!
> +//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/linux/led-class-multicolor.h)
> +
> +use core::{
> +    cell::UnsafeCell,
> +    num::NonZero,
> +    ptr, //
> +};
> +
> +use crate::types::ScopeGuard;
> +
> +use super::*;
> +
> +/// The led mode for the `struct led_classdev_mc`. Leds with this mode can have multiple colors.
> +pub enum MultiColor {}
> +impl Mode for MultiColor {
> +    type Device<'bound, T: LedOps<Mode = Self> + 'bound> = MultiColorDevice<'bound, T>;
> +}
> +impl private::Sealed for MultiColor {}
> +
> +/// The multicolor sub led info representation.
> +///
> +/// This structure represents the Rust abstraction for a C `struct mc_subled`.
> +#[repr(C)]
> +#[derive(Debug)]
> +#[non_exhaustive]
> +pub struct MultiColorSubLed {
> +    /// The color of the sub led
> +    pub color: Color,
> +    brightness: UnsafeCell<u32>,
> +    intensity: UnsafeCell<u32>,

These should be `Atomic<u32>`, or am I missing something here? Using
`Atomic<u32>` should resolve sashiko's comment on this patch.

Regards,
Boqun

> +    /// The maximum supported intensity value.
> +    ///
> +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNESS`].
> +    pub max_intensity: Option<NonZero<u32>>,
> +    /// Arbitrary data for the driver to store.
> +    pub channel: u32,
> +}
> +
[...]
