Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B64FDA64
	for <linux-pci@vger.kernel.org>; Fri,  9 Oct 2026 22:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791583886; cv=none; b=LKzDGlXnX2KLhWdvU4Z1hDxKCvkIMn0ICXhzDyOzeDdg5MfWVxzm3hrwLQ8sk5dE2lADBx9JWcG+P8inKfmdL5DPy4wvWk3m2gEPvwzuaIytoI7lmX9iuxNcYupj5DTr1xSr2pmrqKTCJGo9xC2UsPNupufnhSwkHwKUjSXmyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791583886; c=relaxed/simple;
	bh=+8Pd2kEwbTqrNWCyuUQ1CP2kNPpqhPSRr1YnfV6HsuI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb3WWX4/xq/qTanEzz7+Ub6MNsmeP2LRsz6LSDhqO9l2Yy4HXihxF47ENot8KdX/O9yIFv7m53MpviV7BAY54WHnwF+EvXw7qFMkmrcQLZFMaGmUvX79C8GylrTutGoTvwh5dS3f0lajBNjtYOK0txeO06h3O+djuVICPmVv65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=L8hsZxT5; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="L8hsZxT5"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 9C1C524002A
	for <linux-pci@vger.kernel.org>; Sat, 10 Oct 2026 00:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1791583881;
	bh=N5dL7jTHIc0W/mPlRe2UP0O2mkpgxQBMxpFx4wu2gho=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=L8hsZxT5+MP9QRb6Y33uzWLoevVMU1Jz+dRPQrJE3tYeZ0TswDsPstn/DkzVn8LCw
	 0HW1S5qlOThxJXyCGWput2WNJ3uCp4xp9LxIDEtL2L4TfC1tNsTB8U9ubw92lTCJLa
	 OCH52YYxJaQPL6CxfraEZZtJd9nsnZ16m+uJgdvbhC8zAnFufmxh+fUX05tgP+ymRx
	 lArNLI6nKkPVIDzpa75e0HZI2R6HpomNnnp8oQod9koiKD8DesXl0kjYJBEu9xe1bW
	 7VafsNAGiZAfpsiv57MrM5yARjHXoD76gqAG2uDeX0DjmddjRoblL82ISju8NMiElx
	 gEV3yZB+jZFwg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j1h061c9nz6v1d;
	Sat, 10 Oct 2026 00:11:18 +0200 (CEST)
Message-ID: <1c414e776b56ae215d2d07b73a384ed4542c963e.camel@posteo.de>
Subject: leds: KCSAN report
From: Markus Probst <markus.probst@posteo.de>
To: Boqun Feng <boqun@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Dave Ertman
 <david.m.ertman@intel.com>, Leon Romanovsky	 <leon@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor	 <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>,  =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 "Rafael J. Wysocki"	 <rafael@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Krzysztof =?ISO-8859-1?Q?Wilczy=B4nski?=	
 <kwilczynski@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein	 <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 Ira Weiny <iweiny@kernel.org>, 	rust-for-linux@vger.kernel.org,
 linux-leds@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Date: Fri, 09 Oct 2026 22:11:20 +0000
In-Reply-To: <aslJ1ISONL9ojP-3@tardis.local>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
	 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
	 <ask31EX01lSL9QJ9@tardis.local>
	 <81e1aa92ebc389468eb6f493393a1c58a79373e7.camel@posteo.de>
	 <aslB3lFUKpMEWOiM@tardis.local>
	 <7174e1f95dcbeb8802d9e9c9715afa32784f0c20.camel@posteo.de>
	 <aslJ1ISONL9ojP-3@tardis.local>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-1WJ7yHW5rBGYh6PJ8FMK"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-1WJ7yHW5rBGYh6PJ8FMK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-10-09 at 13:08 -0700, Boqun Feng wrote:
> On Fri, Oct 09, 2026 at 07:59:02PM +0000, Markus Probst wrote:
> [..]
> > > > > > +/// The multicolor sub led info representation.
> > > > > > +///
> > > > > > +/// This structure represents the Rust abstraction for a C `st=
ruct mc_subled`.
> > > > > > +#[repr(C)]
> > > > > > +#[derive(Debug)]
> > > > > > +#[non_exhaustive]
> > > > > > +pub struct MultiColorSubLed {
> > > > > > +    /// The color of the sub led
> > > > > > +    pub color: Color,
> > > > > > +    brightness: UnsafeCell<u32>,
> > > > > > +    intensity: UnsafeCell<u32>,
> > > > >=20
> > > > > These should be `Atomic<u32>`, or am I missing something here? Us=
ing
> > > > > `Atomic<u32>` should resolve sashiko's comment on this patch.
> > > > Snippet of the `Atomic::from_ptr` rustdoc:
> > > >=20
> > > > "
> > > > For the duration of 'a, other accesses to *ptr must not cause data
> > > > races (defined by LKMM) against atomic operations on the returned
> > > > reference. Note that if all other accesses are atomic, then this sa=
fety
> > > > requirement is trivially fulfilled.
> > > > "
> > > >=20
> > > > This safety requirement is likely not met if I see this correctly,
> > > > because the led subsystem does not use atomic accesses.
> > > >=20
> > >=20
> > > Then the C side has a data race that needs some fix (or they use
> > > READ_ONCE() or WRITE_ONCE() which are *atomic* to avoid the data race=
).
> > They don't use READ_ONCE or WRITE_ONCE.
> >=20
> > Writes to "intensity" can happen at anytime by `multi_intensity_store`.
> > It does lock the `led_access` mutex on write. It is not locked on read
> > and `grep "READ_ONCE" -r drivers/leds/` has no matches in drivers
> > either.
> >=20
>=20
> I wonder whether KCSAN will report an issue of this (w/o
> CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC).
First of all, thats a pretty noticable performance impact on desktop
here. Gotta recompile my kernel very soon.

Second of all, it does.
(Also like every second reports with something else, e.g. vfs, tty,
_find_next_bit, btrfs and more).

Reproduced with:
- Software to write random values to "multi_intensity":
https://gist.github.com/0xIO32/2ec10e7521fc80e96f700e1f6fe219c4
- Self-written low-quality multicolor led driver (to not overload real
led hardware for this test)
https://gist.github.com/0xIO32/1b46b8965a9d52f6e3ec5355c1f054a7
- the timer led trigger with delay_on =3D 1 and delay_off =3D 1 has been
enabled, so there is concurrent access.

Tainted because nvidia drivers, external module: v4l2loopback.
Gentoo Kernel, running on desktop. Its on 6.18, but as far as I know,
this logic hasn't changed (and fixed would be backported).

[  273.080793] Reported by Kernel Concurrency Sanitizer on:
[  273.080805] CPU: 1 UID: 0 PID: 4070 Comm: write_intensity Tainted: P
O        6.18.54 #1 PREEMPT(lazy)
[  273.080826] Tainted: [P]=3DPROPRIETARY_MODULE, [O]=3DOOT_MODULE
[  273.080836] Hardware name: Micro-Star International Co., Ltd. MS-
7C56/MPG B550 GAMING PLUS (MS-7C56), BIOS 1.K0 09/02/2025
[  273.080847]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  275.913835]
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  275.913855] BUG: KCSAN: data-race in led_mc_calc_color_components /
multi_intensity_store

[  275.913883] write to 0xffff8a84e71d1c70 of 4 bytes by task 4067 on
cpu 8:
[  275.913896]  multi_intensity_store+0x1a4/0x2b0
[  275.913912]  dev_attr_store+0x41/0x60
[  275.913931]  sysfs_kf_write+0x192/0x1d0
[  275.913948]  kernfs_fop_write_iter+0x1cb/0x400
[  275.913964]  vfs_write+0x5ad/0x650
[  275.913977]  __x64_sys_pwrite64+0xaf/0x100
[  275.913992]  x64_sys_call+0x206c/0x24c0
[  275.914006]  do_syscall_64+0x89/0x390
[  275.914022]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  275.914043] read to 0xffff8a84e71d1c70 of 4 bytes by interrupt on
cpu 3:
[  275.914056]  led_mc_calc_color_components+0x87/0xf0
[  275.914072]  led_set_brightness_nopm+0x2f/0xd0
[  275.914093]  led_timer_function+0x1f5/0x2c0
[  275.914106]  call_timer_fn+0x32/0x1e0
[  275.914126]  __run_timer_base+0x7b3/0x980
[  275.914146]  run_timer_softirq+0x31/0x60
[  275.914166]  handle_softirqs+0x157/0x400
[  275.914181]  __irq_exit_rcu+0xb9/0x200
[  275.914195]  sysvec_apic_timer_interrupt+0x7a/0x90
[  275.914212]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  275.914228]  osq_lock+0x121/0x260
[  275.914246]  __mutex_lock+0x172/0xf70
[  275.914261]  __mutex_lock_slowpath+0xf/0x20
[  275.914278]  mutex_lock+0x9f/0xb0
[  275.914293]  kernfs_fop_write_iter+0x11b/0x400
[  275.914310]  vfs_write+0x5ad/0x650
[  275.914322]  __x64_sys_pwrite64+0xaf/0x100
[  275.914337]  x64_sys_call+0x206c/0x24c0
[  275.914351]  do_syscall_64+0x89/0x390
[  275.914367]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  275.914389] value changed: 0x000000f8 -> 0x00000034

Thanks
- Markus Probst

>=20
> > Writes to "brightness" are on the C-side handled by the driver by
> > calling `led_mc_calc_color_components`. This rust abstraction always
> > calles it in `brightness_set_callback`. So on the C-side, this at least
> > is less of an issue, as writes and reads are controlled by the C
> > driver.
> >=20
>=20
> Thank you for taking a look into this.
>=20
> > >=20
> > > The general rule is: if C side has a data race, they should fix it, i=
f C
> > > side doesn't care ("the compiler should not data race on this code"),
> > > then the Rust side treat it as atomic operations. This is the only wa=
y
> > > to better code regarding data races.
> > It probably should use WRITE_ONCE and READ_ONCE, but it also shouldn't
> > create any issues if its not used. There is no load tearing on a 32-bit
> > integer and memory ordering is not required. Not sure if its worth the
>=20
> I think some people would disagree with you on "no load tearing"
> (because data race =3D UB =3D anything can happen), but..
>=20
> > trouble changing every existing multicolor led driver.
> >=20
>=20
> I agree it's probably not worth doing this at the moment.
>=20
> > >=20
> > > > Ofc, this function won't be used, but I think given that the same
> > > > struct is also accessed by the C-side, it should also apply here.
> > > >=20
> > > > Like Sashiko suggests, "core::ptr::read_volatile()" might be a bett=
er
> > > > option to prevent certain compiler optimizations.
> > > >=20
> > >=20
> > > No, please don't over-use read_volatile(). The reason that READ_ONCE(=
)
> > > and WRITE_ONCE() are safe to use for synchronization is because
> > > semantics-wise they are atomic on certain types (if aligned), and the
> > > them being volatile is just an implementation detail.
> > Ok.
> >=20
> > I will need to make .get_mut() const for this.
> >=20
>=20
> Sounds good to me.
>=20
> Regards,
> Boqun
>=20
> > >=20
> > > Regards,
> > > Boqun
> >=20
> > Thanks
> > - Markus Probst
> >=20
> > >=20
> > > > Thanks
> > > > - Markus Probst
> > > >=20
> > > > >=20
> > > > > Regards,
> > > > > Boqun
> > > > >=20
> > > > > > +    /// The maximum supported intensity value.
> > > > > > +    ///
> > > > > > +    /// If None the maximum intensity equals to [`LedOps::MAX_=
BRIGHTNESS`].
> > > > > > +    pub max_intensity: Option<NonZero<u32>>,
> > > > > > +    /// Arbitrary data for the driver to store.
> > > > > > +    pub channel: u32,
> > > > > > +}
> > > > > > +
> > > > > [...]
> > >=20
>=20

--=-1WJ7yHW5rBGYh6PJ8FMK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrJZngbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSjMkQAJwIQc2FYnss1BvBr6pc
1XapqAEqKEkpXGMSoWWOEY7mzmZMIQkncZ+2Po88YpjJ4GTZIez0VzTQFYfkEWHf
EZHJNy4h65JaG6uEXc1oryz+xIk3exEj1u+9zw5mDhaRfCYhMf9as5R66KpRylin
ovGZ63TxjMbo73cczmnlYsgAB3zC0xLzxEziAUpq3skZ1AYV5TfQelb5J5i35iVV
f6LZGOjw/xWuBrg/zDfCwaC4bcIw0d6ByZduvUp7ocY6jREian3z+02rDZPwHkOG
qtUZAWT1YBe03NAXyeheWxZZbwk9Jr7Z9LibzDMwqSHOeIVTRJr9xybXvB9edSJq
4gBqEVMdHlEgnwOOxFAlL4MwaGAW+ItY/o+e6QIlb5OTEYJgpOED9J9lrb5RYDdr
i7ZTn+XdcgPLm8zHyicL8Bo10ts9uBV84DQk5jOxwPBDonRw2c9UOWGgw/kH634Y
/VfspedtiKRqxTTe2HV+AQwcPoyo0KHiziA653qrl04SgsRRLTyBJsd2xTUYw4KO
EpWUWrtqJtsE4r5wi9CDbPr95D9HGUlka+na9aj6qcOsBmKnfE0uJZyCWUkKKnqa
PpyGZXcKoVcGGQO3okwVybTu5zf8uTduEoNvdroGNGmI5BrJVe9IZoeZgB/P1eCq
CVPCSdpM+APMhoGMGduUwBDv
=4GjR
-----END PGP SIGNATURE-----

--=-1WJ7yHW5rBGYh6PJ8FMK--
