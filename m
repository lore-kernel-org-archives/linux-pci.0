Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834068;
	b=1U2iCYaomZDZjdRoNeVZkj86WJ2Pjze2eHN+UY9bNgJO3RMvy/c7SbW07UB3HX1gMLmE
	 kRXgCYpZMZWpa3aRc682OLCr/afCDXgHTpgLUR/i5jWmf3qAs7NSBehYH1CtANVg6dEF1
	 oRCACU7l0+NFoMjU0N0ZObRs/seRFpEja5e+6UKKi4Zrz96ZDNP2ovbCkvQSztv5x0E9/
	 spj4lx1IOLjbLZ8e/HrgHgNoVGyy8QH5xd98pLcNZMJgcth/ytCxhfYKtfxEPu/LwENGW
	 8i5TFo+JSsPQ4rDORlvgERKjiVVYsQjflkgtSeeaPeOSl34AYphyqzUlzf0DQllu8+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834068;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Vie7/XBwPUSIruM6K3Am8aeBNqqM1hC+6rhracHSbGY=;
	b=f+CylAf3BKDK/VcXaHk+wQYgMts2lcU1iIHfpdj8gS18rgKLqLYJIJK0JPwTPJ5clyrp
	 2D775dm+7DiSVlAeCekVfuMrz5dDwA9uCDBu5wt39xkzwIIdKKyrzY7slbeNGRMle7JG8
	 gUBpTjKolKhksszP3y+csZ59bkxXj+A5no2DBzQOyeMRA74zNwatOAYm0H8W3N2d41AI0
	 rOMRN96qaHxNvsgCPe75gNWEJ2Fkq2BIalHC5Ta1+MADW16zdxotlYXXLpQ/nfd+JmtIC
	 Ge20vkfZEPofup6ve0eq9FYIitTUV4MpSyv5MMpfTTI9kbt/QpSpwRA1WDgY/O/mHMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVxPIqn+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CC606A31B;
	Wed,  4 Nov 2026 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TVxPIqn+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF9A1F000C1;
	Wed,  4 Nov 2026 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834067;
	bh=Vie7/XBwPUSIruM6K3Am8aeBNqqM1hC+6rhracHSbGY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVxPIqn+AhEz5ydNwmugzcs/6BDfj5mZusM+Zvl5bpqoYfO0Z6vfTQLvtasnZLNG1
	 kGdlbFGB/8WJPneRrS2rN3M9cXPYYZOo54G7eGbviYzsd3rS4/LL6jRDmE38ijciLi
	 uKkdJ1qwHlsw4cJbZ3OSpXWVWninwEqkgs31n0gLB4ijjwegAK84GH/Wd9g2vhz5PV
	 tCNUTGnsvE6nFx8837pbO1yP3yHE2LBs3I2I9YG0a4jF9T8GbBZfBWi4igzqx6Qrzl
	 yddXtP2lSPwQkYu7Txoa2OWXMINNfUUbYClHrYLSlPQuyu9LvGi3sEc/Y1HmaDPWOf
	 OsnJjklzbWGbg==
Message-ID: <sashiko-outbox-198281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/7] rust: pci: rework device enabling API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Danilo Krummrich" <dakr@kernel.org>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?b?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>, "Alexandre
 Courbot" <acourbot@nvidia.com>, =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "Lyude
 Paul" <lyude@redhat.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>
Cc: "John Hubbard" <jhubbard@nvidia.com>, linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-b4-rust-pci-edu-driver-v4-2-20ef027bb707@mailbox.org>
References: <20261105-b4-rust-pci-edu-driver-v4-0-20ef027bb707@mailbox.org>
 <20261105-b4-rust-pci-edu-driver-v4-2-20ef027bb707@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 23:14:25 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: pci: missing #[inline] on DeviceEnableGuard::drop()
--

commit 74e19693f9a2d2ce6a2ed986dc5fdc9a88535014
Author: Maurice Hieronymus <mhi@mailbox.org>

rust: pci: rework device enabling API

This commit replaces Device::enable_device_mem() with
Device::enable_device(), returning a DeviceEnableGuard<'a> that calls
pci_disable_device() on drop to keep the PCI device enable count balanced.
It also updates the nova-core driver to store the guard in NovaCore.

Link: https://lore.kernel.org/rust-for-linux/DJOEYVBS17MJ.1YD3TNGQBWHNK@ker=
nel.org

> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 769d01d234296..75efd5c5ee97f 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -469,6 +469,25 @@ pub fn pci_class(&self) -> Class {
>      }
>  }
> =20
> +/// A guard that keeps the device's I/O and memory resources enabled.
> +///
> +/// # Invariants
> +///
> +/// The device's enable count was incremented once for this guard; dropp=
ing the guard decrements
> +/// it again.
> +#[must_use =3D "if unused, the device will be immediately disabled"]
> +pub struct DeviceEnableGuard<'a> {
> +    dev: &'a Device<device::Bound>,
> +}
> +
> +impl Drop for DeviceEnableGuard<'_> {
> +    fn drop(&mut self) {
> +        // SAFETY: `self.dev.as_raw()` is a valid pointer to a `struct p=
ci_dev`, and by the type
> +        // invariant this guard holds one increment of the device's enab=
le count.
> +        unsafe { bindings::pci_disable_device(self.dev.as_raw()) };
> +    }
> +}

[Severity: Low]
This isn't a bug, but since DeviceEnableGuard::drop() in rust/kernel/pci.rs
is a small non-generic abstraction method in the kernel crate that forwards
directly to bindings::pci_disable_device() when a DeviceEnableGuard is
dropped on driver unbind or probe error unwind, should it be marked with
#[inline] to allow cross-crate inlining into drivers (matching
Device::enable_device() below and IrqVectorRegistration::drop() in
rust/kernel/pci/irq.rs)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-b4-rust-pc=
i-edu-driver-v4-0-20ef027bb707@mailbox.org?part=3D2
