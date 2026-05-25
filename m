Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C852926D4E5
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779745480; cv=none; b=qCMImu1W+jU4135OXyYtNeHmhYznJt2mgpC4KALH6U5HcC/ftGbZPTQURI+yNfvae6NZdye0jGvnUmIMMhOOTvEGdYxFRJOsO5UlW5ovniPMz1oSLJ9Ids94oBqT/iVe+eYWtEBaSE55V3pVgFEUT/2qCrhnG/vpcZd4P0mqxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779745480; c=relaxed/simple;
	bh=gf7Oc/qag4SQKqKdANhhBwJka9tQqNgcYhpTz1x8nN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mORJaWivb9txfRAXCGkrZmb9W+7uudFbA1vCySTrJtOBLeeAr+oib6gjMXjqyK7qfjiHOxKnZqvJz8p+2H6Hubw2hl2s8+hjSPix5xQrkAKR9jhOKLu1kF7WKvYhorUaPdwnrBp6mVinDUjpWuUn2cZUMD+LAA/Er9Xf8qgbjOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzOddHm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzOddHm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC3B1F000E9;
	Mon, 25 May 2026 21:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779745479;
	bh=Q2DxrJcsWpwIoMn4LwfLVB6e85eH3NrhRju2gY2KPS0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bzOddHm6Hvn7Cj5xD7cfje4Md3UL3FUIkMCk5dlCEs1fqq3qPrhjj5550EKIPD+vy
	 FuAVIrENZXaOkcpXXJytumTvcnwdijOPPzZnrXxv5fqzQgF/kiX5Clc2pIXTaxAd7Q
	 +19FJQDBfHUEZDDe99m65Nd3k55hLPGNw0F24B05dPxQLaIBhIJuFC3LYc9Sm/GEbf
	 9zRhfPMbPrsZANVgVJWcEZ5Apun4WhFYwhrQKKyrtAmYGCUC2Cl7oy/Uzsp5GYfWXU
	 M7rMyNhdoD2vMjdrysBHW0zdlDIDJDiAL/zGJ4Pa/KVbeVa73xPI52Ro4RjV5P5MLT
	 O1kmZt820b5ig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/24] rust: io: make IoMem and ExclusiveIoMem
 lifetime-parameterized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-20-dakr@kernel.org>
References: <20260525202921.124698-20-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:44:38 +0000
Message-Id: <20260525214438.DAC3B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Incorrect syntax and type mismatch in `try_pin_init!` macro leads =
to a compilation failure in `drivers/pwm/pwm_th1520.rs`.

Pre-existing issues:
- [Low] The struct construction for `ExclusiveIoMem` is missing the mandate=
d `// INVARIANT:` comment.
--

commit 67b598dd02fe735e45135c07185ac5128b22e8d0
Author: Danilo Krummrich <dakr@kernel.org>

rust: io: make IoMem and ExclusiveIoMem lifetime-parameterized

This commit adds a lifetime parameter to IoMem and ExclusiveIoMem, tying
the mapping to the device's lifetime. It mirrors the pci::Bar design and
enables drivers to hold I/O memory mappings directly in their HRT private
data.

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

[Severity: High]
Does this assignment cause a type mismatch in the try_pin_init! macro?

The into_devres() method returns a Result, but the <- operator expects an
expression that implements the PinInit trait. Could this be missing a
trailing ? operator to unwrap the Result before the pin initialization?

>                  clk <- clk,
>              }),
>          )?;

> diff --git a/rust/kernel/io/mem.rs b/rust/kernel/io/mem.rs
> index 51ba347220eea..fc2a3e24f8d5d 100644
> --- a/rust/kernel/io/mem.rs
> +++ b/rust/kernel/io/mem.rs
[ ... ]
> @@ -196,26 +188,29 @@ fn ioremap(resource: &Resource) -> Result<Self> {
>              )
>              .ok_or(EBUSY)?;
> =20
> -        let iomem =3D IoMem::ioremap(resource)?;
> +        let iomem =3D IoMem::ioremap(dev, resource)?;
> =20
> -        let iomem =3D ExclusiveIoMem {
> +        Ok(ExclusiveIoMem {

[Severity: Low]
This isn't a bug introduced by this patch, but ExclusiveIoMem has an
# Invariants documentation section. According to the Rust subsystem coding
guidelines, shouldn't its construction include an // INVARIANT: comment
explaining why the invariants are satisfied?

>              iomem,
>              _region: region,
> -        };
> -
> -        Ok(iomem)
> +        })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D19
