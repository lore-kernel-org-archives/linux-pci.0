Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ABE38AC6E;
	Thu, 16 Jul 2026 18:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226109; cv=none; b=TQaCOgTGJwx8JA6AT3Aqfdjd75ZPS7rTdVw/Hhpf37B/NIpNVQCru0qDPgIyw//FD0aBPJkDjHJ1BNfWXBzwLDdsoDtws4MI2wIAFULSe5PtqgG/ztuT0s+qUYt91PzfWPn+5sp+w1B72E61Myhig4DR135mAt1vW6bxixo22Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226109; c=relaxed/simple;
	bh=NagWJFz2vbQl1gPqkazisMumiIEyyzwyAk7xB/mapN0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ll0pgkeH6w8EdfVMvjzD1jC/8MjfN3cJIetSTlNqWReOwUEyBleCXvFNyKNwm5HEFFveYXIFz34ZSQRPho+eZsioGCaENEvwSjeZhYCWM50a+bi8CCGxF5Y3l2HrqkZy74mejguAMzUEil0VP+H+1VnjrmzgYEt6FJ3J5KzpEy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAAg8BB8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAAg8BB8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2E8E1F000E9;
	Thu, 16 Jul 2026 18:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784226100;
	bh=8r6tmW3e8KLhwoexnYedDNzR/NqE8tVr9iptKW3MkLk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NAAg8BB8Bp7dnWFsF3rCN7J8w8ebwndq4v8RKXloOyO0pRZbIVYbVXq3Qnz+aTdJe
	 LkhfkwZLFBmRNEJo/oFSzEXE/2v2okRYL0mIol0DflbInlw1ecJFGe8rYFZbmK+PQD
	 ZTa0BKb7lX88hNtUpdd60xhIQ5OXA88ykSEcqK1mE/0YdodbxzPlCQkfGfF+tCODQQ
	 llWqvFawP74CtaP6hNvcve+02AStAb+8snDDwlymA/rH8MpbJKIhFh+AOrjvvCzPVX
	 5jfn5mGpjfSOC5F51hSY74q8RGGeNfFU1QX1L4OMHLe0e9CPWL0jYfpaVZrjz4qeJM
	 YhpBEajW2rR2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v23 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260716-rust_leds-v23-3-e91f5b608b56@posteo.de>
References: <20260716-rust_leds-v23-0-e91f5b608b56@posteo.de>
 <20260716-rust_leds-v23-3-e91f5b608b56@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:21:39 +0000
Message-Id: <20260716182139.E2E8E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Safe methods `brightness()` and `intensity()` in `MultiColorSubLed=
` perform non-synchronized plain reads of an `UnsafeCell`, causing Undefine=
d Behavior due to data races with concurrent C subsystem modifications.
- [High] Fragile `fwnode` reference management in `DeviceBuilder::build_mul=
ticolor` and `MultiColorDevice::drop` causes `ARef<FwNode>` leaks or invali=
d refcount decrements.
--

--- Patch [3]: [PATCH v23 3/3] rust: leds: add multicolor classdev abstract=
ions ---
commit 6c4e554be24453ed9f19eef4d69cdcd8cacfc0d1
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

Implement the abstractions needed for multicolor led class devices,
including MultiColor, MultiColorSubLed, MultiColorDevice, and=20
DeviceBuilder::build_multicolor to register new class devices.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..82fe96fd5273b
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs

[ ... ]

> +    /// The intensity of the sub led.
> +    #[inline]
> +    pub const fn intensity(&self) -> u32 {
> +        // SAFETY:
> +        // - self.intensity.get() is a valid pointer to u32.
> +        // - We don't have exclusive or immutable access to self.intensi=
ty,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.intensity.get() }

[Severity: High]
Does this unsynchronized plain load introduce a data race? If a driver calls
this safe method from an interrupt handler or background thread while the C
subsystem concurrently updates the value via sysfs (which holds a C mutex
the Rust side does not take), could this trigger undefined behavior?

> +    }
> +
> +    /// The brightness of the sub led.
> +    #[inline]
> +    pub const fn brightness(&self) -> u32 {
> +        // SAFETY:
> +        // - self.brightness.get() is a valid pointer to u32.
> +        // - We don't have exclusive or immutable access to self.brightn=
ess,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.brightness.get() }

[Severity: High]
Similarly, could reading brightness() here cause undefined behavior due to
concurrent sysfs modifications?

[ ... ]

> +                // SAFETY:
> +                // - parent.as_ref().as_raw() is guaranteed to be a poin=
ter to a valid
> +                //    device.
> +                // - ptr is guaranteed to be a pointer to an initialized=
 led_classdev_mc.
> +                to_result(unsafe {
> +                    bindings::led_classdev_multicolor_register_ext(
> +                        parent.as_ref().as_raw(),
> +                        ptr,
> +                        if self.name.is_none() {
> +                            &raw mut init_data
> +                        } else {
> +                            core::ptr::null_mut()
> +                        },
> +                    )
> +                })?;
> +
> +                subled_guard.dismiss();
> +
> +                core::mem::forget(self.fwnode); // keep the reference co=
unt incremented

[Severity: High]
Does this unconditionally leak the fwnode reference when self.name is set?

If self.name is Some, the C registration function is passed a NULL pointer =
for
init_data, meaning the device fwnode is never set. By calling forget()
unconditionally here, the reference count is incremented but the fwnode is
not stored in the C device, which might permanently leak the reference.

[ ... ]

> +#[pinned_drop]
> +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> PinnedDrop for Mul=
tiColorDevice<'bound, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of self guarantees that self.classdev.g=
et() is a pointer to a
> +        // valid led_classdev_mc.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).led_cdev.dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of fwnode has previously been
> +            // incremented in led::DeviceBuilder::build_multicolor.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Can this cause a use-after-free or double-free on an unrelated fwnode?

If self.fwnode was None during builder initialization, but the C subsystem
later assigns an unrelated fwnode to the device, it seems this code would
incorrectly wrap it in an ARef and decrement its refcount.

Alternatively, if dev.fwnode() returns None because init_data was NULL earl=
ier,
the previously forgotten fwnode refcount is never decremented, leaking it.
It appears this same pattern may also affect normal device builders.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-rust_leds-=
v23-0-e91f5b608b56@posteo.de?part=3D3
