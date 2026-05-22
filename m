Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550112030A
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779408998; cv=none; b=IUnEo8fKTZKeQUccZeWAGecRvvawHLSg/8dCiwv9000jF/nB1gkufE8xNKHge5FN7gMwU4sverjmCc/V0dKymINK1Bei71Vjfd7l53jxOK4lW/Vy3KilwcNea9IhA5ie4UlzjgcWvfeh+QmMYBm87vJrMjOglzhbtKDT8sQwFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779408998; c=relaxed/simple;
	bh=JzsRumwGdly0oO4kh97IQMFlxlAqzXHVfcOsq5BwyL4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K+g0j6RAqeP2LtcGqT3W9SGP5f1UF+Sok9SbQTUOWA2KHAbvtdcOHqH2m7dLGk4EU2S/7easkJ5vjExUzH/dDU84gNSaTWBia/ohL4Bx3EpbyFoZHFqtwldGjK+8EPqnJYhtjAak6q+KlXQiXdvBHxZth1ZMeP0WiLNPeqt3mv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgA4DzZk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgA4DzZk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EE61F000E9;
	Fri, 22 May 2026 00:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779408997;
	bh=3YKIgernD4T/mVBXPooKY9l3wwtyB5bU0k7JH7zS65g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WgA4DzZkDpmFSwQt219oWkw0HSuzIysYwiln0SObNN1SDGIf5VGP8OxAGEsPiAn4i
	 9VzQ2DxZsbhIC4G6XGn2Tc+MYGMOznarOE3RhpvxFYiSRmJ/IR75N/4K23d1ZdRJ6v
	 syxSfHuHHtX23z7C0eT5CHARxKhVPUBps3LrYnagflHtdT6W/zTaCul6wvIF2PEeop
	 I6M062xbDLG0QteSnhxp32hcInfgt2YleHw94Qv/JnhYYa8o2jhZu/xQo2v4T8Nm8d
	 osJZiP1KWDIlcCAgKhYU4sPT73upU3+jZ3BsrpgIfRaS1WeBNBEYkNLYtUc7rVKt0S
	 8mjmme02OF3Nw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/27] rust: usb: implement Sync for Device<Bound>
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-9-dakr@kernel.org>
References: <20260521233501.1191842-9-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:16:36 +0000
Message-Id: <20260522001637.13EE61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The patch completely fails to achieve its stated goal for USB driv=
ers due to subsystem architectural mismatches (private types and missing tr=
ait implementations).
- [Medium] Piecemeal typestate trait implementations for thread-safety inst=
ead of generic blanket implementations.
--

commit f4c2e06f2819d0d1a95f07b0e3275550140ba681
Author: Danilo Krummrich <dakr@kernel.org>

rust: usb: implement Sync for Device<Bound>

This commit implements the Sync trait for Device<Bound> in the USB subsyste=
m.
The goal is to allow drivers to safely store bound USB device references in=
side
their private data structures.

> This is needed for drivers to store &'bound usb::Device<Bound> in their
> private data while remaining Send.

[Severity: High]
Does this change actually allow drivers to store the device in their private
data?

Currently, usb::Device is strictly private to the kernel::usb module, so
external drivers cannot declare fields of this type. Even if it were public,
AsRef<Device> for Interface<Ctx> returns &usb::Device<Normal>, which discar=
ds
the typestate context and prevents drivers from obtaining a Bound reference.

Additionally, drivers in the USB subsystem typically bind to and receive
&usb::Interface rather than usb::Device. Would we also need to add Sync to
usb::Interface<Bound> so that drivers can store the interface they receive?

> diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
> index 88721970afcb7..6c917d8fa8839 100644
> --- a/rust/kernel/usb.rs
> +++ b/rust/kernel/usb.rs

[ ... ]

> @@ -468,6 +468,10 @@ unsafe impl Send for Device {}
>  // allow any mutation through a shared reference.
>  unsafe impl Sync for Device {}
> =20
> +// SAFETY: Same as `Device<Normal>` -- the underlying `struct usb_device=
` is the same;
> +// `Bound` is a zero-sized type-state marker that does not affect thread=
 safety.
> +unsafe impl Sync for Device<device::Bound> {}

[Severity: Medium]
Would it be more robust to use a generic blanket implementation for thread
safety instead of piecemeal implementations for specific contexts?

The thread safety of usb::Device depends on the underlying C pointer rather
than the zero-sized PhantomData marker. By implementing Sync manually for
each context, this omits Send for Device<Bound> and leaves other valid
contexts like Core and CoreInternal without Sync implementations.

Could we use something like this instead?

unsafe impl<Ctx: device::DeviceContext> Sync for Device<Ctx> {}

This would ensure correct system-wide thread safety for all typestates.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D8
