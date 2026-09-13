Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2748032B13F;
	Sun, 13 Sep 2026 16:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789316520; cv=none; b=nZWyE4l3XUJVyYsxRRZ9OK5foXF00lm5gJ1sPlEAU96Ks5YmvKu4je53hf8Ncq3+2uKLnVjfEtNc5dEHHhoWfGawz/OHB9ysxh0huitcFatCJsU50Yi33FM2yi9JIHWD+Z/LyXNWIPfqQnWhpXVMMnLWkSqSB1KI5zcaJHskhLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789316520; c=relaxed/simple;
	bh=uDYWarSjkmQIeXTUfmv2ZTfx6+NuARYFNNm1vRhQnP0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VbjPZAbd6ou+LIndz8DAqkdD7UW6c/yWmQN8icdsQOXnfAJDbZ4dFyTejSOoGyb/usmfZn2nuJ1/n34SZH3gONEzOjeqzTptDWse13VW10Ichscy3IfPGDQ+JOuSzCJBUwPYYVFfcLgTfZrgY/un2VibBn9A+N+QFQRU+zYm7zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4LCaINw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4LCaINw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14FB71F000FF;
	Sun, 13 Sep 2026 16:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789316518;
	bh=/CZbOVsGkzRLa7fhYQvQsSHw4ByQTxdKv0EzRhQpTRU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V4LCaINw/VDINEuZut01BhlLfe+AL5eFkfVuUeZ9WpFh9syAKq/nnGvLwvAgh/A26
	 InyjNt1Qgk5v328MAQkg3Jw142tISwo2zgBNaFPPckFYyfmWMvxvzkfdvJi7V3fHat
	 wH1mBO/LeD+zLjGdPgvUXBOBiLaTtZ6jW1bIZ6HiIC2kJ0SMIWeaq3W7uk389uO8P7
	 OqribasqwaNnEhehfllS+M9lpM966tjevr+EADTwRSgJvKxz7O2lxd7oTotpM2qclz
	 GJKGYJzvkC76ELNgb5xzftNp92xylKDMIRimRCBeBAfXO9ekuupOR9In5e1a5pOrrn
	 9Io+vCdVYCDQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v25 2/4] rust: leds: add Mode trait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-leds@vger.kernel.org, lee@kernel.org, gary@garyguo.net, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260913-rust_leds-v25-2-1a10371d78c3@posteo.de>
References: <20260913-rust_leds-v25-0-1a10371d78c3@posteo.de>
 <20260913-rust_leds-v25-2-1a10371d78c3@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 16:21:57 +0000
Message-Id: <20260913162158.14FB71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The `core` import uses horizontal formatting instead of the require=
d vertical format.
- [Low] The commit message description is not capitalized, violating the LE=
D subsystem guidelines.
--

commit fc494e48581e40fa3f62db639a08746b74e239f2
Author: Markus Probst <markus.probst@posteo.de>

rust: leds: add Mode trait

This commit adds the Mode trait to allow for other types of led class
devices in LedOps.

> rust: leds: add Mode trait

[Severity: Low]
This isn't a bug, but the commit message description is not capitalized,
violating the LED subsystem guidelines.

The global review guidelines for the LED subsystem mandate that the
description following the commit message prefix must be capitalized.

Should the description start with a capital letter, as in "rust: leds: Add
Mode trait"?

[ ... ]

> diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
> index deda8cc548a8c..7cd8f0504649a 100644
> --- a/rust/kernel/led.rs
> +++ b/rust/kernel/led.rs
> @@ -4,11 +4,7 @@
>  //!
>  //! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
> =20
> -use core::{
> -    marker::PhantomData,
> -    mem::transmute,
> -    ptr::NonNull, //
> -};
> +use core::{marker::PhantomData, mem::transmute, ops::Deref, ptr::NonNull=
};

[Severity: Low]
This isn't a bug, but does this import for the core crate use horizontal
formatting instead of the required vertical format?

The kernel Rust coding guidelines explicitly require using the vertical
import style for non-vendored crates. The commit replaces a multi-line
vertical import block with a single-line horizontal block.

Should this be changed back to the vertical format?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913-rust_leds-=
v25-0-1a10371d78c3@posteo.de?part=3D2
