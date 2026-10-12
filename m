Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B2249158B;
	Mon, 12 Oct 2026 14:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791816645; cv=none; b=cUu7a9861PR379syi6hu8MJw4UCFfZN4PIntXGRxdBkz6IRTsMdIVDoZBjnRc94dENuxQ7JcdxIZMyeEMq8BMO5apP6HmH6TW7zw2ExPfdl7TNKmBaG6ZTb8UAjEyasvXCJrHDMn2G0M+7ML4EurtCsUdcybgJQogVJMA1d/+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791816645; c=relaxed/simple;
	bh=9/a4GtDSJgIKnq+PHDcdGLyfvIsIi6jNZ2Wj3gemz9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQzhjjs5dshyYTqcKmBbGUOtDapLHBDy+1+EgM59CJuAGD/Hl+8cA3nu8k1fCWJSahQ4BjiTcVWHfFmgvK/NR7MUgeTmYKjQqsFfpNtgpcfn7hANiWH3388yW4ZJ7nMFL7kPPWn06pw9JoLddgUNhh5sPZc4XjPs8lKa461pnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IEgrSBYa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IEgrSBYa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89281F0089C;
	Mon, 12 Oct 2026 14:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791816644;
	bh=OnMHe5dXcqTc5v2OsRfJDhhba3wwXmp+sAVt9h94tR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEgrSBYa/Cu+FGu4IXUohks7fiOVrMl9oGd+cC+cRLt9nk90c/LtRrC7OsVEzeL+p
	 3oGtXt1PSVmvO5piuRlp/6/wWGZgVS/9tgDt2GlrT1yLGtZCgprfX93EN3Ctk40gQj
	 B0gEsbCNQ/nES4hllcCOWhff8viaq8woPbX/YMeq8ZoVVrLgAKt5zPw3+OEl8TJXMa
	 vdQv/eWb5ff8mPSpM2gucGm944UHJCgoZbKtScc430qd+bC2IWX4Exa3pqzRvNoVpq
	 Ny1cW9DMGtkImCRHkpesBAHqEJtQgy3WyGjXPcKeabIAO+GKxLgFYRdIH/uJstc87H
	 4QtB/XrJFdb+g==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id D38D1F40068;
	Mon, 12 Oct 2026 10:50:42 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 12 Oct 2026 10:50:42 -0400
X-ME-Sender: <xms:wvPMalFsBQ5YGdMWYxVa6QIC6pwu3hgFyIeNuTALRvJVjxkuyrJgrA>
    <xme:wvPMah08Q6gQDvvS_7OH7WF3E-VxJwfYsa7kzUjbYoObG75N-J8-N8gjS0ylYmABP
    J6suPrHXr9eQRiGx90oUzkKsCDqM2sha2vMa_8PX93FSFocl8aEF6qa>
X-ME-Received: <xmr:wvPMatO8AidNv5JLhkEME9vBnyml-fYf5xZ1-1IBKx_4wZqV6Ia58fxStaN3l1NaItcQBHsv6Ym7OlC7jKb1Y7v8kGnsn-I5>
X-ME-Proxy-Cause: dmFkZTEJ5fBHj3ZE/whec/dIgXoSMWDPDe2NuyMizwmDQk/pueXv6evpgNyw+I0Gh43Blh
    I4M5VA/i04E9vIzksBOxpmPwjlx+0vm2O2jxHpWuotQr4QwBx4yhEnwv+0mco2N3V4OfBV
    OPWz8IZGDF95dze9i4BTU4aBJuuvecc9JQNmYbcrkJYmmm2ClQQ3sraLBQA48WMMkX2d6a
    J0KuEGF9necxhBEPOwCVcnIMeQQXK8Q2sowCEW3buLPpNvH32Mi72AamY9MoCuq5ox2Zrs
    MDPWJl7tyMKyQshVplGIwG5Apx3g9vll4Gq1dBpJIZqoEEBS4rAkzG6cfbcufE4f2KcVk7
    Zldf/7Kd7FSM2K/X12Ueg4V8KTDSIeTVmkjFYSh40aNl+drp/RQHzR/AbMpyOI7AN48Dn5
    zH4HoZyu87c1wq+Y52RNHFKEgu3BKA4aaVkvCaC1NmvW1My6uL3L1OajS9q1eJp6Onbm/8
    wqi8sXsjwUXzOLGULteWtBfJHnbrQEcPxJgZnfai6Kz95WKBchi2w1DApgvxyq+AjhF0A2
    NjJheitzwRdMC9fMKeMfivLmvjcD+Og8yohp36aa+GUjkPUGfCsjvefBaaPWRPz/9rfruZ
    puexGXL6DWvqgTblOIa7An7ElJgeYcZtJ8Sm9i7JFqx9PmkCQoovNTsKqjdQ
X-ME-Proxy: <xmx:wvPMapIBBW5SbsC8JiFGzTK9dBpoP3MaYgptSA_ZmlQzS7DSbICuJA>
    <xmx:wvPMama40GNRYSWZsOkXRKP0DT6q_gKHQraof0tpCyyvjS2ck3tBxQ>
    <xmx:wvPMaql6tbQoRjHODBnohohMXHzjeuOJWUYE20iP2pkD8B5lsZ4hpQ>
    <xmx:wvPMahb6_4NO-FoZFtW8IZotsYU3HyFaCC9jtCEZiOae-PtwWh7qaw>
    <xmx:wvPMaiDDQEs0VWbkA0JfY8yhf0_bYuH6TfAhV4b8rB53QiAr4lbZ8GIy>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 10:50:41 -0400 (EDT)
Date: Mon, 12 Oct 2026 07:50:40 -0700
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
Subject: Re: leds: KCSAN report
Message-ID: <aszzwEPkfPjAYNLQ@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
 <ask31EX01lSL9QJ9@tardis.local>
 <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
 <aslB3lFUKpMEWOiM@tardis.local>
 <7174e1f95dcbeb8802d9e9c9715afa32784f0c20.camel@posteo.de>
 <aslJ1ISONL9ojP-3@tardis.local>
 <1c414e776b56ae215d2d07b73a384ed4542c963e.camel@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c414e776b56ae215d2d07b73a384ed4542c963e.camel@posteo.de>

On Fri, Oct 09, 2026 at 10:11:20PM +0000, Markus Probst wrote:
> On Fri, 2026-10-09 at 13:08 -0700, Boqun Feng wrote:
> > On Fri, Oct 09, 2026 at 07:59:02PM +0000, Markus Probst wrote:
> > [..]
> > > > > > > +/// The multicolor sub led info representation.
> > > > > > > +///
> > > > > > > +/// This structure represents the Rust abstraction for a C `struct mc_subled`.
> > > > > > > +#[repr(C)]
> > > > > > > +#[derive(Debug)]
> > > > > > > +#[non_exhaustive]
> > > > > > > +pub struct MultiColorSubLed {
> > > > > > > +    /// The color of the sub led
> > > > > > > +    pub color: Color,
> > > > > > > +    brightness: UnsafeCell<u32>,
> > > > > > > +    intensity: UnsafeCell<u32>,
> > > > > > 
> > > > > > These should be `Atomic<u32>`, or am I missing something here? Using
> > > > > > `Atomic<u32>` should resolve sashiko's comment on this patch.
> > > > > Snippet of the `Atomic::from_ptr` rustdoc:
> > > > > 
> > > > > "
> > > > > For the duration of 'a, other accesses to *ptr must not cause data
> > > > > races (defined by LKMM) against atomic operations on the returned
> > > > > reference. Note that if all other accesses are atomic, then this safety
> > > > > requirement is trivially fulfilled.
> > > > > "
> > > > > 
> > > > > This safety requirement is likely not met if I see this correctly,
> > > > > because the led subsystem does not use atomic accesses.
> > > > > 
> > > > 
> > > > Then the C side has a data race that needs some fix (or they use
> > > > READ_ONCE() or WRITE_ONCE() which are *atomic* to avoid the data race).
> > > They don't use READ_ONCE or WRITE_ONCE.
> > > 
> > > Writes to "intensity" can happen at anytime by `multi_intensity_store`.
> > > It does lock the `led_access` mutex on write. It is not locked on read
> > > and `grep "READ_ONCE" -r drivers/leds/` has no matches in drivers
> > > either.
> > > 
> > 
> > I wonder whether KCSAN will report an issue of this (w/o
> > CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC).
> First of all, thats a pretty noticable performance impact on desktop
> here. Gotta recompile my kernel very soon.
> 

:) Yes, but it helps find data races. In general, it should run in a
test environment.

> Second of all, it does.
> (Also like every second reports with something else, e.g. vfs, tty,
> _find_next_bit, btrfs and more).
> 
> Reproduced with:
> - Software to write random values to "multi_intensity":
> https://gist.github.com/0xIO32/2ec10e7521fc80e96f700e1f6fe219c4
> - Self-written low-quality multicolor led driver (to not overload real
> led hardware for this test)
> https://gist.github.com/0xIO32/1b46b8965a9d52f6e3ec5355c1f054a7
> - the timer led trigger with delay_on = 1 and delay_off = 1 has been
> enabled, so there is concurrent access.
> 
> Tainted because nvidia drivers, external module: v4l2loopback.
> Gentoo Kernel, running on desktop. Its on 6.18, but as far as I know,
> this logic hasn't changed (and fixed would be backported).
> 

Right, so generally, this data races should be fixed (via marked
accesses [1]). See also [2].

In practice whether these need to be fixed usually depends on the
maintainers, and back to my original point, we should at least make Rust
side "data race free" if C side can be treated as "data race free".

[1]: tools/memory-model/Documentation/access-marking.txt
[2]: tools/memory-model/Documentation/explanation.txt (Section 25. PLAIN
     ACCESS AND DATA RACES).

Regards,
Boqun

> [  273.080793] Reported by Kernel Concurrency Sanitizer on:
> [  273.080805] CPU: 1 UID: 0 PID: 4070 Comm: write_intensity Tainted: P
> O        6.18.54 #1 PREEMPT(lazy)
> [  273.080826] Tainted: [P]=PROPRIETARY_MODULE, [O]=OOT_MODULE
> [  273.080836] Hardware name: Micro-Star International Co., Ltd. MS-
> 7C56/MPG B550 GAMING PLUS (MS-7C56), BIOS 1.K0 09/02/2025
> [  273.080847]
> ==================================================================
> [  275.913835]
> ==================================================================
> [  275.913855] BUG: KCSAN: data-race in led_mc_calc_color_components /
> multi_intensity_store
> 
> [  275.913883] write to 0xffff8a84e71d1c70 of 4 bytes by task 4067 on
> cpu 8:
> [  275.913896]  multi_intensity_store+0x1a4/0x2b0
> [  275.913912]  dev_attr_store+0x41/0x60
> [  275.913931]  sysfs_kf_write+0x192/0x1d0
> [  275.913948]  kernfs_fop_write_iter+0x1cb/0x400
> [  275.913964]  vfs_write+0x5ad/0x650
> [  275.913977]  __x64_sys_pwrite64+0xaf/0x100
> [  275.913992]  x64_sys_call+0x206c/0x24c0
> [  275.914006]  do_syscall_64+0x89/0x390
> [  275.914022]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  275.914043] read to 0xffff8a84e71d1c70 of 4 bytes by interrupt on
> cpu 3:
> [  275.914056]  led_mc_calc_color_components+0x87/0xf0
> [  275.914072]  led_set_brightness_nopm+0x2f/0xd0
> [  275.914093]  led_timer_function+0x1f5/0x2c0
> [  275.914106]  call_timer_fn+0x32/0x1e0
> [  275.914126]  __run_timer_base+0x7b3/0x980
> [  275.914146]  run_timer_softirq+0x31/0x60
> [  275.914166]  handle_softirqs+0x157/0x400
> [  275.914181]  __irq_exit_rcu+0xb9/0x200
> [  275.914195]  sysvec_apic_timer_interrupt+0x7a/0x90
> [  275.914212]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
> [  275.914228]  osq_lock+0x121/0x260
> [  275.914246]  __mutex_lock+0x172/0xf70
> [  275.914261]  __mutex_lock_slowpath+0xf/0x20
> [  275.914278]  mutex_lock+0x9f/0xb0
> [  275.914293]  kernfs_fop_write_iter+0x11b/0x400
> [  275.914310]  vfs_write+0x5ad/0x650
> [  275.914322]  __x64_sys_pwrite64+0xaf/0x100
> [  275.914337]  x64_sys_call+0x206c/0x24c0
> [  275.914351]  do_syscall_64+0x89/0x390
> [  275.914367]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> [  275.914389] value changed: 0x000000f8 -> 0x00000034
> 
> Thanks
> - Markus Probst
> 
> > 
> > > Writes to "brightness" are on the C-side handled by the driver by
> > > calling `led_mc_calc_color_components`. This rust abstraction always
> > > calles it in `brightness_set_callback`. So on the C-side, this at least
> > > is less of an issue, as writes and reads are controlled by the C
> > > driver.
> > > 
> > 
> > Thank you for taking a look into this.
> > 
> > > > 
> > > > The general rule is: if C side has a data race, they should fix it, if C
> > > > side doesn't care ("the compiler should not data race on this code"),
> > > > then the Rust side treat it as atomic operations. This is the only way
> > > > to better code regarding data races.
> > > It probably should use WRITE_ONCE and READ_ONCE, but it also shouldn't
> > > create any issues if its not used. There is no load tearing on a 32-bit
> > > integer and memory ordering is not required. Not sure if its worth the
> > 
> > I think some people would disagree with you on "no load tearing"
> > (because data race = UB = anything can happen), but..
> > 
> > > trouble changing every existing multicolor led driver.
> > > 
> > 
> > I agree it's probably not worth doing this at the moment.
> > 
> > > > 
> > > > > Ofc, this function won't be used, but I think given that the same
> > > > > struct is also accessed by the C-side, it should also apply here.
> > > > > 
> > > > > Like Sashiko suggests, "core::ptr::read_volatile()" might be a better
> > > > > option to prevent certain compiler optimizations.
> > > > > 
> > > > 
> > > > No, please don't over-use read_volatile(). The reason that READ_ONCE()
> > > > and WRITE_ONCE() are safe to use for synchronization is because
> > > > semantics-wise they are atomic on certain types (if aligned), and the
> > > > them being volatile is just an implementation detail.
> > > Ok.
> > > 
> > > I will need to make .get_mut() const for this.
> > > 
> > 
> > Sounds good to me.
> > 
> > Regards,
> > Boqun
> > 
> > > > 
> > > > Regards,
> > > > Boqun
> > > 
> > > Thanks
> > > - Markus Probst
> > > 
> > > > 
> > > > > Thanks
> > > > > - Markus Probst
> > > > > 
> > > > > > 
> > > > > > Regards,
> > > > > > Boqun
> > > > > > 
> > > > > > > +    /// The maximum supported intensity value.
> > > > > > > +    ///
> > > > > > > +    /// If None the maximum intensity equals to [`LedOps::MAX_BRIGHTNESS`].
> > > > > > > +    pub max_intensity: Option<NonZero<u32>>,
> > > > > > > +    /// Arbitrary data for the driver to store.
> > > > > > > +    pub channel: u32,
> > > > > > > +}
> > > > > > > +
> > > > > > [...]
> > > > 
> > 


