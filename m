Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0B48A8C9;
	Fri,  9 Oct 2026 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576537; cv=none; b=cURsYq46QnL6V+w3qlxOofYLxISXvdMgx3WTcyoijpnRvPMk0ebP/7E8Om/FGWEAvLqijipj4wjnmA3xutcw6XPJkkBl73rk6tIzZGcPaoIYaFWlRUu9NoXEP+sf+rRWKiOxtIM8ts5e9dQy60G2D1J4W6lTHVrPKqExmpiQc14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576537; c=relaxed/simple;
	bh=99CQKYHm2Qus62p3fyC+Dmg6ACsOSuHHxe/v7QFYVws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDyGu42S/LAOvUo/gpWpmA4/9dEbZbW8pXJJJpwV99vT/mJ0yHL1maLNG0pPVpMJQlSabUAkPbyj59wDjwlx/1P0t/13mOX7M33xYXF7l7/Q9ObliC5baROnmzl600XKUkETHhCKme2HcJd7PhnJ0yNFjcBdQrf4hL0IcWByd8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mk/pQSTz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mk/pQSTz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBCA1F00898;
	Fri,  9 Oct 2026 20:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791576536;
	bh=rhSi77Ef8VNI4Su4MU4HTkB2CI4wMQDvKNGvL97Fgc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mk/pQSTzV5NGfClaDeTIEhaB+aTdX/+k0OGQd/mAJHHyIZn8sCfDOQWr246AXA0mQ
	 H+N0C7ng+crjTZQhPKO5FRz6etCK9rWT/nKpy39oQxrwbOHG1i9hpG6ultFb0gUA+g
	 RIm+eEF9GCnFAsMqJkn1j+vzSVK8jn+2O4zFUEnBxjD7brGXJpB+Yr59toTiCydUeG
	 KyZuNszFynirSF3+yi4A/1XpljzoPCqAbODOh66HVzFnMRVwOgVIDj6PDR8uMtzriH
	 uv9yrOkF+XA0s8xu5c0VAQLmg9BhwaWXbRYo9sejfGKxzoJZlVdgX4sa/8GRSHhuoN
	 O6gaAYuFy+Pvg==
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7D050F40066;
	Fri,  9 Oct 2026 16:08:54 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 09 Oct 2026 16:08:54 -0400
X-ME-Sender: <xms:1knJanmWcovsrDSjG7kIb1YjWvAooPrJXXhrMcPecSuv5ATpofTxVw>
    <xme:1knJaiUffrAZJG2hzY-viIqtSm24B4psbT6pQ-THJndWM8pruhB7DSXEk-hiVATnL
    mXeqSH7EZNudveTVnH1XrORoCS9IvIGSPJLTw_ImnyjC30qzWblDm8>
X-ME-Received: <xmr:1knJajuXbsvv8qE87VDXV12VmmzMeTuUsyxxGPMNftMbHzLd_u8N0C9wDok2ql8EA-DgpAN4yofQTi5-Ej0X70o1trc6YwGd>
X-ME-Proxy-Cause: dmFkZTE4r1+8g8xM2AS9prBXbCbGwrCJmWYEBc9Zqxseka0muJQ5FjWKgchMEwlLQXHKPm
    H1h04NlSoOnzg4lmwcXW5Rl3TM4MZlroNlXVIFDvy4U6FmkgDWWgmtrE5OHH0sAarcUd+z
    A8DBfwO2/DUuZC784Yr1ytaHYfn2kbFfJNOQh1LTYtk9a4yD0fmIysKxj8ha6rYXPVB0rP
    xMsSAWXUm8nhMuyF4ZWVWfcCzMRHpKYLAJXEUvYMP9AL/aYbhOdtsSpwB9ySMY/Uo+ih85
    hTToBOV89q/QedpaNS8QLEnNUMYrtCIITnR+M6y/AdSzKJ6Lz/lbtacU2u92riZGH+0AjQ
    ZVmm5aeSRya6hq0iMEomI5GCrGp/ziEg99e9g8LEyikxWm48mzVgS4IaB1J1JDF7JdX19E
    pdev0IoxTAjPQbnTyYJVrMl5tYT28XeL+VcHuQ07UgrwBfuH2AQUWBg8SKCSiIBpyzCWXv
    13FYyInTk79zwinZDUvWZZRoSywaRPT/zrkVaxk6PwegE30aTgEfaZ+yglWWx5E9kSypYH
    oQTaNjy8oDIvJ7qeW15CRQ3NyYd97AFsOZa/RViFF4PqT48uaezCEtsFOdwHsZLYWza/b/
    Ti3G/rjjQJ2Xv34Avr8Z9pIcd9UhgumaO7lVyydDw2h9wX7hqQ0M6adm5Whg
X-ME-Proxy: <xmx:1knJatpvCt6IfjWLA2Uwmm-noa0YdKYHrn19TuqReFRX-lIXCm5d3g>
    <xmx:1knJag5dlRFEa-6QAYlzctv_3RcDVxwczHQzK-zhSa0ZUyi7Gmr-TQ>
    <xmx:1knJajGGPth_wSLlaGGAnnRicIm2tYiMsg9rFpKyxqwP3eQ_GhWVPw>
    <xmx:1knJav4SFlezYTwrGScJI8PdVOUtb9j3RFnbGTcx70Bbb8qvq1HD3Q>
    <xmx:1knJaujN6Sv_ofThGaq08CGRzNxz7hrBcXI7ktrfbdiLcG570b-cAQ51>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 16:08:53 -0400 (EDT)
Date: Fri, 9 Oct 2026 13:08:52 -0700
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
Message-ID: <aslJ1ISONL9ojP-3@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
 <ask31EX01lSL9QJ9@tardis.local>
 <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
 <aslB3lFUKpMEWOiM@tardis.local>
 <7174e1f95dcbeb8802d9e9c9715afa32784f0c20.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7174e1f95dcbeb8802d9e9c9715afa32784f0c20.camel@posteo.de>

On Fri, Oct 09, 2026 at 07:59:02PM +0000, Markus Probst wrote:
[..]
> > > > > +/// The multicolor sub led info representation.
> > > > > +///
> > > > > +/// This structure represents the Rust abstraction for a C `struct mc_subled`.
> > > > > +#[repr(C)]
> > > > > +#[derive(Debug)]
> > > > > +#[non_exhaustive]
> > > > > +pub struct MultiColorSubLed {
> > > > > +    /// The color of the sub led
> > > > > +    pub color: Color,
> > > > > +    brightness: UnsafeCell<u32>,
> > > > > +    intensity: UnsafeCell<u32>,
> > > > 
> > > > These should be `Atomic<u32>`, or am I missing something here? Using
> > > > `Atomic<u32>` should resolve sashiko's comment on this patch.
> > > Snippet of the `Atomic::from_ptr` rustdoc:
> > > 
> > > "
> > > For the duration of 'a, other accesses to *ptr must not cause data
> > > races (defined by LKMM) against atomic operations on the returned
> > > reference. Note that if all other accesses are atomic, then this safety
> > > requirement is trivially fulfilled.
> > > "
> > > 
> > > This safety requirement is likely not met if I see this correctly,
> > > because the led subsystem does not use atomic accesses.
> > > 
> > 
> > Then the C side has a data race that needs some fix (or they use
> > READ_ONCE() or WRITE_ONCE() which are *atomic* to avoid the data race).
> They don't use READ_ONCE or WRITE_ONCE.
> 
> Writes to "intensity" can happen at anytime by `multi_intensity_store`.
> It does lock the `led_access` mutex on write. It is not locked on read
> and `grep "READ_ONCE" -r drivers/leds/` has no matches in drivers
> either.
> 

I wonder whether KCSAN will report an issue of this (w/o
CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC).

> Writes to "brightness" are on the C-side handled by the driver by
> calling `led_mc_calc_color_components`. This rust abstraction always
> calles it in `brightness_set_callback`. So on the C-side, this at least
> is less of an issue, as writes and reads are controlled by the C
> driver.
> 

Thank you for taking a look into this.

> > 
> > The general rule is: if C side has a data race, they should fix it, if C
> > side doesn't care ("the compiler should not data race on this code"),
> > then the Rust side treat it as atomic operations. This is the only way
> > to better code regarding data races.
> It probably should use WRITE_ONCE and READ_ONCE, but it also shouldn't
> create any issues if its not used. There is no load tearing on a 32-bit
> integer and memory ordering is not required. Not sure if its worth the

I think some people would disagree with you on "no load tearing"
(because data race = UB = anything can happen), but..

> trouble changing every existing multicolor led driver.
> 

I agree it's probably not worth doing this at the moment.

> > 
> > > Ofc, this function won't be used, but I think given that the same
> > > struct is also accessed by the C-side, it should also apply here.
> > > 
> > > Like Sashiko suggests, "core::ptr::read_volatile()" might be a better
> > > option to prevent certain compiler optimizations.
> > > 
> > 
> > No, please don't over-use read_volatile(). The reason that READ_ONCE()
> > and WRITE_ONCE() are safe to use for synchronization is because
> > semantics-wise they are atomic on certain types (if aligned), and the
> > them being volatile is just an implementation detail.
> Ok.
> 
> I will need to make .get_mut() const for this.
> 

Sounds good to me.

Regards,
Boqun

> > 
> > Regards,
> > Boqun
> 
> Thanks
> - Markus Probst
> 
> > 
> > > Thanks
> > > - Markus Probst
> > > 
> > > > 
> > > > Regards,
> > > > Boqun
> > > > 
> > > > > +    /// The maximum supported intensity value.
> > > > > +    ///
> > > > > +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNESS`].
> > > > > +    pub max_intensity: Option<NonZero<u32>>,
> > > > > +    /// Arbitrary data for the driver to store.
> > > > > +    pub channel: u32,
> > > > > +}
> > > > > +
> > > > [...]
> > 


