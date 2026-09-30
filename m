Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C00B3D8903;
	Wed, 30 Sep 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774288; cv=none; b=f/AcnmbbzGTqW/Kn5HLrpr30Djbtfr4EK8OHIgYzXleYIQnek8GNTRCU5N0XWwpKxgUnvOWONVkhvFAQuu6L9xIg+6dMnetAKaTleXF3ZiiA76gvykQQkOAXznjK+Xu4yAl+5IhtWVwlWmjJPmgkz39tLp2U9X/ImU/g+RNNVfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774288; c=relaxed/simple;
	bh=b9iGpl9Qu88g2TfUOUc32E3tEFWW6oLXBR0AFyPfcfY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=okcDVpfL+2QmG6F12QcKBzD1lXDzmN3Wz3crs3SVxOyf8SpIEeOhWv6epL3TevFVEzDQCfZ7fA1A/t5QO5EB7n73gPwGUzxnaTwx3JiW472LweUrp8+XM4koS02PyRzQ8Pn3PI//fmWQdzAlP5nw0nrqktFEcN8Ucn6vSDeO6MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kk0qzxbN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kk0qzxbN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2D51F000FF;
	Wed, 30 Sep 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774269;
	bh=d0x8x9MdBEGMs7hxYGppNur32ZRSg8fD6Ks5yU4MWFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Kk0qzxbNGxfGKaTQ6i6m72LEnSQFWVU9dzlT3Y+J+841HdzEFfzeGimJrex3kaRTv
	 Hy8IuSadaRSzl2Frqh/6insIBfIZHRg0zpmmMx+N9AwpjYanI3zV+CSQpBmzoIjUX0
	 KuBdF4s0FeSrgywoRDD/ehvgYi0ULUWumkyrSdda0r8hL2hCyeZvLed2rzMA4JceVf
	 fHCVG/6LioNdsfnbclR5dHMekL/4i73GNNgY53fMrO086Z0beY1urVfkgI5g3j7c2M
	 cMzj4uN8HmICTyFMFWqV3ttrnpK3tCne8qubEZVPhfjyBssqXiaAZz1Zno+ohc8xVV
	 CjDsq9BhH4xwQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v26 3/4] rust: leds: Add multicolor classdev
 abstractions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org, linux-leds@vger.kernel.org, lee@kernel.org
In-Reply-To: <20260930-rust_leds-v26-3-83837331020e@posteo.de>
References: <20260930-rust_leds-v26-0-83837331020e@posteo.de>
 <20260930-rust_leds-v26-3-83837331020e@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 13:17:48 +0000
Message-Id: <20260930131749.5F2D51F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] rust: leds: data race and UB via plain reads in MultiColorSubLed
--

commit 8041b99a2f954026eb99d9bedff3e1091196ee48
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: Add multicolor classdev abstractions

This commit implements the abstractions needed for multicolor led class
devices. It introduces the led mode implementation, safe wrappers around
mc_subled and led_classdev_mc, and a builder function for registration.

> diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
> new file mode 100644
> index 0000000000000..309487bdf38aa
> --- /dev/null
> +++ b/rust/kernel/led/multicolor.rs
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
Does this unsynchronized plain read introduce a data race and undefined
behavior?

In the Rust memory model, concurrent non-atomic reads and writes constitute
a data race, which is strictly undefined behavior. A sysfs write to
multi_intensity_store can lock led_access and modify
subled_info[i].intensity.

Concurrently, the driver's workqueue (set_brightness_delayed) or an atomic
trigger could execute brightness_set without holding led_access. When this
happens, the Rust driver reads the intensity at the exact same time it is
being written by the C core.

Could we use core::ptr::read_volatile() here to emulate READ_ONCE()
semantics and prevent the compiler from optimizing under the assumption
that the value does not change?

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
Similarly, does this plain read risk the same data race if concurrent
trigger events modify the brightness?

Replacing this read with core::ptr::read_volatile() would emulate
READ_ONCE() and safely mitigate the undefined behavior.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_leds-=
v26-0-83837331020e@posteo.de?part=3D3
