Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DFA282F3A
	for <linux-pci@vger.kernel.org>; Mon, 25 May 2026 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744244; cv=none; b=roeN5xdzcjNQ1GlVYNeCtTFzVKjDNKnSXdK8i8RlmJStk3ysQUuhGtVb3xp7qfofrdjVt2VmxiaYb5T/2C/9Zb9eqdwy9kMdYj93+bjT1PSFM+BWrTSaTYDhDXjzGrlYV815MdPPfsuUtYIz52wTjWSON7uSuu2bX/tzija25IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744244; c=relaxed/simple;
	bh=UOEEzK55L1Vb/KCw7tIChpiZbigEJmluHZbetBc8txc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ivqidAlg2ZVYMsY+z5EoFDQncSpenk01DcmfDMDi0/Nygb5pbxBfnl8kWZK0XETSG3pEteAAw01p8wrjt5CA+ppP5fImj4YGSAbdm3SCdMaO/pvHTUT08XUxSN9gKsjymL7/asPdKcqbWtZknGJaw2FHkeI6ifnsYJwn16wzg88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3fzzkoW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3fzzkoW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CCA71F000E9;
	Mon, 25 May 2026 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744243;
	bh=TFgzgSU85aVQ90Ld5TnIz8uDMSJl1UtzTY/ob9EG24U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n3fzzkoWBQN6k5qC6PhHoGz2e4fp0cEaxnYrXeBEvuukWfcez16lvSSe0/fDVurrp
	 0jS8GIIP7pJrRwRLSRbgURKoGuUPuID/qMyLEIoH4eITlidv5Xv5Gi7760Ev4h4FhS
	 nDBKrCCPlNz6WSLTJliPJQyHaGfPgBVFO7YCFqjEci+MFu6n/xfg/gvF6HHmR1oqTZ
	 bVZ8uhWZrt4SOuJEbC7M90mFV1Haz8hykOot0eI8FlDFC80hvVAlmOP0dD70VaA0Nf
	 KomM6DVinOQvrLUl/AypWk2bIsXWvYOdl0d+AoSiRXVJCt3H1mCI7XAX0zs+y1I6CZ
	 +tEQr7LqDG33Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 24/24] samples: rust: rust_driver_auxiliary: showcase
 lifetime-bound registration data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260525202921.124698-25-dakr@kernel.org>
References: <20260525202921.124698-25-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 May 2026 21:24:02 +0000
Message-Id: <20260525212403.7CCA71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Struct field initialization causes a compilation error due to misma=
tched types (missing Deref coercion).
--

commit 7dde6b480c3cf8bc2ec8ee3a89c129ed25216a30
Author: Danilo Krummrich <dakr@kernel.org>
Subject: samples: rust: rust_driver_auxiliary: showcase lifetime-bound regi=
stration data

This commit makes the Data struct lifetime-parameterized by storing a
reference to the parent pci::Device. It also updates the connect method
to retrieve the parent PCI device directly from the registration data.

> diff --git a/samples/rust/rust_driver_auxiliary.rs b/samples/rust/rust_dr=
iver_auxiliary.rs
> index e3e811a14110c..2c1351040e45e 100644
> --- a/samples/rust/rust_driver_auxiliary.rs
> +++ b/samples/rust/rust_driver_auxiliary.rs
[ ... ]
> @@ -81,33 +82,44 @@ fn probe<'bound>(
>          _info: &'bound Self::IdInfo,
>      ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>          Ok(ParentData {
> -            _reg0: auxiliary::Registration::new(
[ ... ]
> +            _reg0: unsafe {
> +                auxiliary::Registration::new_with_lt(
> +                    pdev.as_ref(),
> +                    AUXILIARY_NAME,
> +                    0,
> +                    MODULE_NAME,
> +                    Data {
> +                        index: 0,
> +                        parent: pdev,

[Severity: Low]
Will this compile cleanly without an explicit dereference?=20

In Rust, struct field initializations do not trigger implicit Deref coercio=
ns
in the same way that function arguments do. Since the parent field expects a
&pci::Device<Bound> but pdev is being provided directly, does this cause a
mismatched types error during the build?=20

It might be necessary to explicitly dereference it here, perhaps using &**p=
dev
or a similar construct, to ensure the types match. This also applies to the
_reg1 initialization below.

> +                    },
> +                )?
> +            },
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260525202921.1246=
98-1-dakr@kernel.org?part=3D24
