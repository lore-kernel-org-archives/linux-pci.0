Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94A3F23A6
	for <linux-pci@vger.kernel.org>; Wed,  1 Apr 2026 10:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039863; cv=pass; b=qKrPX1pRhW8P7gxGayiE6GDj4AlEF91/bldVIIDQU38hKSUCtcu6N+Nsu75AP1MB1w5sYfesIRoogi7cxbPbJo1komth0I3P42fiETakD0E+UuUrrX9OeLnDarZb3y1IBo1RY7FP42ozvh5NKHSMLBHAiHUWaLP5MIHy0u9MGts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039863; c=relaxed/simple;
	bh=NB7IgTsm5fAY1HRxukcTkg282cMT+NcIa7BPVwXaI4g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hGnqeafJ17rLqldTmlF8C3hPD+oqKArVOsY9ZmOriG646pyQmOZcSVvdjWTzENMNAFB1tuI/Bdv2SOf+YE0RK0CoVylW9COM0SIYFb8wtbrLrO672imF5H+L8k1/YtIGTSmwl4L1mXHd1IqRqhIfLXk59fa4AUpVLKi/8B5kggo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PV4MJZUe; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV4MJZUe"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a2bf521011so207665e87.2
        for <linux-pci@vger.kernel.org>; Wed, 01 Apr 2026 03:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775039859; cv=none;
        d=google.com; s=arc-20240605;
        b=d9PUtezmyhWlxVEAn+NuNsOnCfVSixQRThUta5m4KoTOf1PLAXqJaXEb+mGmbKTqd+
         XXVBHE4Df6IpxMLjqKtOJ1kecbjt8bcIwopnVFUNyfi5ZX7daluf71GWOSQp1+JYh+Ld
         cAC60lKvgHh1t2rQNe5X5tdxut7cmIxzbALDiR68ZBxwsMBdGeacGkL8DBR9lX5TVOug
         8dgTqwxv9eaz02b3LouMXGKmHq9iQJ8Xssm2grA1IgZFyhWH46WQsVPuB2gadKeiDsyz
         9eQLormH3RpdR/hpj1xfYfwiBZX2chFEYX6R6vkfDX/saglF8iVPxHerWoCVvxQUWa2R
         T8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        fh=by9GKWRBsy0tY4g2c+OxVRms4ubEGg7+LEQTRN9jWIY=;
        b=MHXEOV1Cl0RtejnonJxik5TmljNI5LBLaGc2MMYIoRdo8OlL4AoqfOHwVK1fMIsyTy
         gzyEyECWiXx7mzqz9GdkPpArHG+3fZXfE1MNXdzTgw/CAZBqn2OfmnKGsWvmHZctO6S/
         IZ4k2avLBcS0eW1+jtrlESw30ECdBmpogkYzUgxIHG5CnLARWHk+qD9lt7a3trveHrPr
         cLax9IzA20J91hYyRL+1WAt2uHvw3A7BEJgn+id5WGdNDmKUXqDPq7Q1H0+GxIh5RQQG
         fQfQ2qrGf9ZVDUQN9Jr1szFY3ySjgxGrnl+3OUjh42Zae1RCqjfYP11a5gsxazIhWi2c
         uRuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775039859; x=1775644659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        b=PV4MJZUe6fk484cZO4W/xaPmqcNtTaWfVnuaPvOycgHWLcjwfiVSFv2g01d5SgmkGY
         cG8c7ck+6drc11/+l9jE2IUVKfo9LeNaHp7M7pReSwj4N6o9tm0VSVtcVRBbr9Fk+k75
         T5aHs7N7Bf0bnfCIlOBMMv266XqCQHj1z/ZZbTxTLppyAZj8w8V9JStkAZKeRmEL7AyJ
         Gm0UxLN/3rwmZvRnRonxAcNCcixLoXmE9raVWYd1jPMeKAAFNXppSaKHfIt0krHlGs6i
         Ag4MpoICZkTddJ9vJ3DQRg/6G5mB7MZ1KS02KblwcHxj7v/Q1i8nMlgZx7fmjD/zRBzx
         X+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775039859; x=1775644659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VOv6sQrE1pMcWIiRRePCMC/GRfEX8gOaFbZKQ7PwRiA=;
        b=tWGwju5K6tsCHUseh6RF1PkI8pMWn8f+H6eiwl84OtxY0zx7k8KGQF+LCAVQhX8DV5
         u4B7/s159/tauAEglu7uMyr83F4+VkvEjF+92syXKX5SK9hBl+3WKWmkI6PgyO7AYG74
         IPjckPbUzJIB5rWNH64jcIO2OpDgHjWyzXvnz9KsqUK9aAjjcq+WMz4xmGpiSAvEq5OL
         yCt6Vd7e1gg5kAb8ixooX9Dmvh3r/iRoTD2N5txaJerIDJkj+9hixHDlBHk7sUvcTz6Y
         LXYjkVg5M8OLucVedT4RFZlYSwEecyEaqxsm8fcNBipoOa0p2bTa1NNhF61ox827MzGS
         A/mw==
X-Forwarded-Encrypted: i=1; AJvYcCUaeYQCnCsmV09ODERB3enoqmpwHsdEQjBB5AYMR2Do1a8b8LFJotfif7GEDI0RDMz/3wG7QvTEtQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXP+dXpg71cUYmpQA/sIPTH7v5MAWy8JH/iOMAtntOcEZY0W0b
	Q0JzDmEXDuC5hrtwFe0x6BCYutCcqj9H3pCHrW4upb57DyMRfcWrlYeY4VCHhmy1sG3n2nO84Ak
	IEPSAc4n9gYKa2SHPuTPWwXcMNdAn1hQ=
X-Gm-Gg: ATEYQzwKnSiwii122zbULqcJtPuuw+j9n8ZVqRhbpPG9RsDH+Pcv4M297U00BDkZ6Op
	PstrVPst+4lxAfh7M0+BWbpO/dRggMuc3BVPOfqAELmR9H7cRprO9EwshOUZ7ho3Ax1SvjciTzL
	kPX4LdjT5VFaC7hMhI6U4d5kiGrXt/i1eeqH4mwhwm+jf20EfgELqEHC/f8k/3MNJVUcuRtmdqX
	7kcSR16RJ0Ul/T1DKpK/lEsE8Ql1NmGfktDLDj65OpknqqT38n49T/3H+AOD7ypr/BuLPHjH893
	EPIOqzckETG7Ai2DTuWCLfkyYgY/7aeiLRlJCVv7OC6nVsz/B8C/J6K9Vf4L8ZIBgMEzDR9NEiz
	ORME/dLCnyeHNWz4GCRbraTU=
X-Received: by 2002:a05:6512:1093:b0:5a1:2ec0:7442 with SMTP id
 2adb3069b0e04-5a2c1ca6ad7mr571822e87.0.1775039858363; Wed, 01 Apr 2026
 03:37:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211032935.2705841-1-alistair.francis@wdc.com>
 <20260211032935.2705841-23-alistair.francis@wdc.com> <20260303150040.00007458@huawei.com>
 <CAKmqyKM6CBucDEo0aKZVWrKtozbT_ddk0PaZFtHyEMMMx558JA@mail.gmail.com>
 <CANiq72nOt1E8=GYdh2T5BWNvG7J8sZRF+60taghoxKm8fkadHg@mail.gmail.com> <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPa5fDmo1A6OzF0ROn7iTrBrhV1Q2L=1Wkb=o27f5fDSQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 1 Apr 2026 12:37:23 +0200
X-Gm-Features: AQROBzCtb7kxhE58oOSjFtnvKeq8ygzpCG4EYIkaMQYWrhFl3CKqeEv1E8oqMJc
Message-ID: <CANiq72nV3ArhtQoQYbX-cRKM5JjnqVtzP79c43q+eJjbANgONA@mail.gmail.com>
Subject: Re: [RFC v3 22/27] lib: rspdm: Support SPDM certificate validation
To: Alistair Francis <alistair23@gmail.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, bhelgaas@google.com, lukas@wunner.de, 
	rust-for-linux@vger.kernel.org, akpm@linux-foundation.org, 
	linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, alex.gaynor@gmail.com, benno.lossin@proton.me, 
	boqun.feng@gmail.com, a.hindborg@kernel.org, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	wilfred.mallawa@wdc.com, aliceryhl@google.com, 
	Alistair Francis <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 3:48=E2=80=AFAM Alistair Francis <alistair23@gmail.c=
om> wrote:
>
> I think it's Rust-ier as it uses the fact that
>  * if statements can be used as expressions, which is a cool feature of R=
ust

Sure, but a feature being nice doesn't mean it is idiomatic to apply
it in every context.

More generally, regarding cool features (whether in C or C++ or Rust
etc.), I would say one should strive to keep code as simple as
possible, i.e. we use fancy features when they buy us something, not
just because we can. The kernel applies this principle too.

>  * Rust is explicit about comparisons being bools (no `if (value)` for ex=
ample)

Yes, but I am not sure how this is related.

> So I find the if statement expression returning explicit bools very
> Rust-y and easier to read

If you mean that that seeing `true` and `false` may be clearer because
it is more explicit, then that sounds OK (whether someone agrees or
not), but it is a different argument than being idiomatic.

In any case, I replied initially because the code should be
Clippy-clean, and currently we have that lint enabled -- does it not
trigger in your particular case? i.e. even if you have removed the
code, it would be nice to know why it didn't trigger, or if you were
not testing with `CLIPPY=3D1`.

Anyway, if you think it is idiomatic Rust, then I would suggest
discussing it with the Clippy folks, because they have it as a warning
by default.

Thanks!

Cheers,
Miguel
