Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D185281369
	for <linux-pci@vger.kernel.org>; Fri, 22 May 2026 00:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779410723; cv=none; b=padLt6fBGrU3sf2HqyZbNfZmXg2kPKY4twFUd6P7KRseYiw8c3iUTcOTEuZrfzBeDl1D1m91kKl7xrhbciGy47EPz7pV25zk3bhySSMbTz4aIQx9IITi/Tm4uSzNLihihEeXO0EETDZY4S5iImJN1mF9FOVd30JSpP8TN5srex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779410723; c=relaxed/simple;
	bh=mobAdmJFfydRIKKMOXa5IDo0Q/36L8g5tPqNfgYCcNE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dQhDT8c6RXo4Uzx0EZvPq6+U2QhETpzNEFQUrsz4346oNHnX6AVRIWkbJ3F/JOTXpaIjxvyu/3AZJKLIo3AaBnUc2p9z9inY9AUPcCaxK2SVnvd4ZPZDmGkqKoGbwFzdlZPKoph2vX22Ra7REtwf4wiGVytMzZ4SIzv5H2afKCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6/We+SS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6/We+SS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7082F1F000E9;
	Fri, 22 May 2026 00:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779410721;
	bh=qJf7cIn3HMHOzMbpY49jbnJWEVys98g+DJY/6GThRq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W6/We+SSQEWosBtj6oOz8Nsy2kTGMqYCee/riTKaOlERd/YhAahGHejsvvrwY16t3
	 ov9RNxysizYSnb6e7CSrsHj9mVBiUa0dKPe3k0EJJOjmmbwsUgQQRmiypqsiSdcos5
	 AlLMpDguuQ9NdDFS2/r/I1otg31wFXiy8nzLgGvg4MCMA9oGMVdtbycmY0VoZ1rQip
	 ONglzAFJlQgPhgNb/+ZDLrFfhy1Za0XRUlgQ3ZcmqcxP1XDZvuIMi0iCYxpFyM/Kkp
	 YZ1ORLUrEDB3D+vgIri5H5i8MGYEgTHm43cE4FDYKTa0oEHaI5MSnONCJiAk7y2nme
	 WT2DOwtyx0GTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 18/27] rust: io: make IoMem and ExclusiveIoMem
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260521233501.1191842-19-dakr@kernel.org>
References: <20260521233501.1191842-19-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 22 May 2026 00:45:21 +0000
Message-Id: <20260522004521.7082F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Casting the `IoMem` lifetime to `'static` in `into_devres` byp=
asses the borrow checker, allowing I/O memory mappings to outlive the devic=
e and causing a Use-After-Free / Kernel Oops.
- [Low] Build failure in `pwm_th1520.rs` due to incorrect pin initializatio=
n syntax and missing error propagation.
--

commit 3931a89b7b114b4dfff952a928271744f2309ac3
Author: Danilo Krummrich <dakr@kernel.org>
Subject: rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized

This patch adds a lifetime parameter to IoMem and ExclusiveIoMem to tie the
mapping to the device's lifetime. It also introduces into_devres() for
callers needing device-managed revocation.

> diff --git a/drivers/pwm/pwm_th1520.rs b/drivers/pwm/pwm_th1520.rs
> index 6c5b791f31530..48808cd80737a 100644
> --- a/drivers/pwm/pwm_th1520.rs
> +++ b/drivers/pwm/pwm_th1520.rs
[ ... ]
> @@ -352,7 +352,7 @@ fn probe<'bound>(
>              dev,
>              TH1520_MAX_PWM_NUM,
>              try_pin_init!(Th1520PwmDriverData {
> -                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>(),
> +                iomem <- request.iomap_sized::<TH1520_PWM_REG_SIZE>()?.i=
nto_devres(),
>                  clk <- clk,
>              }),
>          )?;

[Severity: Low]
Will this compile correctly? The refactored into_devres() method returns a
Result<Devres<IoMem<'static, SIZE>>> rather than an impl PinInit.

Since the <- operator in try_pin_init! requires the right-hand side to
evaluate to an impl PinInit, should this use the : operator instead to
initialize it by value? Also, it looks like a trailing ? is missing here to
unwrap the Result.

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 51ba347220eea..fc2a3e24f8d5d 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
[ ... ]
> @@ -269,28 +265,33 @@ fn ioremap(resource: &Resource) -> Result<Self> {
[ ... ]
> -    /// Creates a new `IoMem` instance from a previously acquired [`IoRe=
quest`].
> -    pub fn new<'a>(io_request: IoRequest<'a>) -> impl PinInit<Devres<Sel=
f>, Error> + 'a {
> -        let dev =3D io_request.device;
> -        let res =3D io_request.resource;
> -
> -        Devres::new(dev, Self::ioremap(res))
> +    /// Consume the `IoMem` and register it as a device-managed resource.
> +    ///
> +    /// The returned `Devres<IoMem<'static, SIZE>>` can outlive the orig=
inal
> +    /// lifetime `'a`. Access to the I/O memory is revoked when the devi=
ce
> +    /// is unbound.
> +    pub fn into_devres(self) -> Result<Devres<IoMem<'static, SIZE>>> {
> +        // SAFETY: Casting to `'static` is sound because `Devres` guaran=
tees the `IoMem` does not
> +        // actually outlive the device -- access is revoked and the reso=
urce is released when the
> +        // device is unbound.
> +        let iomem: IoMem<'static, SIZE> =3D unsafe { core::mem::transmut=
e(self) };
> +        let dev =3D iomem.dev;
> +        Devres::new(dev, iomem)
>      }
>  }

[Severity: Critical]
Does casting the IoMem lifetime to 'static bypass the borrow checker's
protections?

Returning a Devres<IoMem<'static, SIZE>> allows safe Rust code to move this
value into an Arc (as done in the tyr driver changes) and share it with
background threads or workqueues.

Since devres only unmaps the memory (via iounmap) when the device unbinds,
but cannot forcefully destroy the Rust object residing in an Arc on another
thread, could a background thread still safely call read32() on it?

This would result in a direct read from unmapped memory, potentially causing
a use-after-free or kernel oops, since IoMem and MmioRaw do not perform any
runtime revocation state checks or locking during access.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521233501.1191=
842-1-dakr@kernel.org?part=3D18
