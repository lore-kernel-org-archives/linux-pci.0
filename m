Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32C5315D29;
	Mon, 29 Jun 2026 13:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782741332; cv=none; b=YdLzxZQ8vfWVxMSy3QQlm0XwgJNeOot9xvdLwEki359gZY0lP/y+1RfkVdn4qQmQ8M1bXUSpQCVgQxx2DEBhPBnISCM7SsGUlHosi3GpM4/wEYdiwaIQ3dFe/+DojY2uXMw0m5rQXHxiPZvBq0e5Jlc3920tNiUTpSqzmD4PEjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782741332; c=relaxed/simple;
	bh=zfhgZQ+lklW5uKOnV8KyFIxtDF79uDsWqmOuFnPI4jY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kh6fCF64D/fheQl4W6neqpZjuUxzNoqGVXZF0BNh9S+YOI/SSWWNzDpsr7CzDyzooNqEosnFiEbZixNFQGmOzZLZPbXf0RmyZM2kIV1MDCwyR8onLUrfbxo88NENmhRBeEzpfpsqLQc59w2RjNYMwKeCg9IGHxHll5j7VbRja+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9WSCFBS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9WSCFBS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E4FE1F000E9;
	Mon, 29 Jun 2026 13:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782741330;
	bh=fnLjEnvx4SkB9fcCUMiJihUvPbSjNYWxxh1hIomuYDA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a9WSCFBSaCJLrGSalErDKzqd6riyuUB91GsVKxd15WazA6r5VYBIiLXx0H2xEEyc5
	 M32fpbxe4bzkFJuoImk5OIVMJrV8bka5lLSFAX+2aNAEAusb3E9M9lfGkKryYPvp/e
	 z+aH6erIowWV12wJuihaVDhH92tPSOBrfYbySohCWeBfZNRAgEMVAYAGO7pMyGzu8t
	 nxYeEwa5an0+pzKsWxDVQma07cBc8NHGYEUvDmdvglyGGV1YZowC/jg4e8rIoEUVad
	 fWmmZs4McXUgJkeMLsKaIUh8GSK9mpnku37v8aH4C9paBXhcYSTXcu2S9X/OK4EzLc
	 uwhlI/V/dP8ew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v21 3/3] rust: leds: add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org, ojeda@kernel.org
In-Reply-To: <20260629-rust_leds-v21-3-4f0f19579db5@posteo.de>
References: <20260629-rust_leds-v21-0-4f0f19579db5@posteo.de>
 <20260629-rust_leds-v21-3-4f0f19579db5@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 13:55:29 +0000
Message-Id: <20260629135530.4E4FE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Unsynchronized reads of concurrently modified `intensity` and `bri=
ghtness` fields in `MultiColorSubLed` cause a data race and Undefined Behav=
ior in safe Rust.
- [High] Flawed `fwnode` reference counting ownership in `MultiColorDevice`=
 leads to potential Use-After-Free or memory leak.
--

commit 53cb84fc2ecc8ded772da6376e83ccc60f89c50f
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add multicolor classdev abstractions

Implement the abstractions needed for multicolor led class devices.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..2c55140dd37ed
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
> @@ -0,0 +1,460 @@
[ ... ]
> +    /// The intensity of the sub led.
> +    #[inline]
> +    pub const fn intensity(&self) -> u32 {
> +        // SAFETY:
> +        // - `self.intensity.get()` is a valid pointer to `u32`.
> +        // - We don't have exclusive or immutable access to `self.intens=
ity`,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.intensity.get() }

[Severity: High]
Does this unsynchronized raw pointer read risk causing a data race and
Undefined Behavior in safe Rust?

The C multicolor LED core modifies subled_info[i].intensity and brightness
concurrently when a user writes to sysfs attributes. Meanwhile, this safe R=
ust
getter method performs an unsynchronized raw pointer read. Since
MultiColorDevice implements Sync, multiple threads can share
MultiColorSubLed and read these fields at any time.

Should this use core::ptr::read_volatile to ensure soundness?

> +    }
> +
> +    /// The brightness of the sub led.
> +    #[inline]
> +    pub const fn brightness(&self) -> u32 {
> +        // SAFETY:
> +        // - `self.brightness.get()` is a valid pointer to `u32`.
> +        // - We don't have exclusive or immutable access to `self.bright=
ness`,
> +        //   but the alignment should prevent "load tearing".
> +        unsafe { *self.brightness.get() }

[Severity: High]
Similarly, does this unsynchronized read of brightness risk causing a data
race when the C side modifies it concurrently?

Should core::ptr::read_volatile be used here as well?

[ ... ]
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
Does leaking the fwnode reference count to the C subsystem and then trying
to reclaim it in drop() by reading dev.fwnode() risk a Use-After-Free?

If the kernel (e.g. ACPI) assigns a different fwnode to the device after
registration, dev.fwnode() will return this new fwnode. The drop()
implementation below would then incorrectly take ownership of the new
fwnode's reference count and drop it, while permanently leaking the
originally passed fwnode.

Should MultiColorDevice store Option<ARef<FwNode>> locally to ensure it
only manages the exact reference it uniquely owns?

> +
> +                Ok::<_, Error>(())
> +            }),
> +            _p: PhantomData,
> +        })
[ ... ]
> +#[pinned_drop]
> +impl<'bound, T: LedOps<Mode =3D MultiColor> + 'bound> PinnedDrop for Mul=
tiColorDevice<'bound, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let raw =3D self.classdev.get();
> +        // SAFETY: The existence of `self` guarantees that `self.classde=
v.get()` is a pointer to a
> +        // valid `led_classdev_mc`.
> +        let dev: &device::Device =3D unsafe { device::Device::from_raw((=
*raw).led_cdev.dev) };
> +
> +        let _fwnode =3D dev
> +            .fwnode()
> +            // SAFETY: the reference count of `fwnode` has previously be=
en
> +            // incremented in `led::DeviceBuilder::build_multicolor`.
> +            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode))=
 });

[Severity: High]
Is it safe to unconditionally reconstruct an ARef from dev.fwnode() here?

As mentioned above, if dev.fwnode() returns a different fwnode than the one
originally passed to build_multicolor, this will drop a reference it does n=
ot
own, potentially leading to a Use-After-Free, while the originally leaked
reference remains un-dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629-rust_leds-=
v21-0-4f0f19579db5@posteo.de?part=3D3
