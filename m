Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3536123BD06
	for <linux-pci@vger.kernel.org>; Wed,  8 Jul 2026 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486435; cv=none; b=hS5m1yTz4kpYQVCkAJ0RKK4bVn4TdpTcfQRtSNvotQ59euVkMgGZqkqDtW7YjQL2BVH2J9G7nChDfTKBvfzsea82IrPC+LiUc2kmHVKQS2L8LQDHEq6dLf6HqhENmL+a1WfR0c8tHWams5x3G0qpROcMLBsE3FYOqLWoj5lF42o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486435; c=relaxed/simple;
	bh=cW7Ix/tkCr37LiuIgaKSz6SxHzCDmgSjbLyC7Gew+w8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/z/Lq+jND6CHH/nIpxg7SMuDm9icllGEq5bqke0/6y2B7aEglP+KpzhjbPKuitWKWtfYHAbddw5tdkbzTH3QfSXS0RuAqtYkU8zSk/IXSim+FgNqw44CtleyeqSYBLbDAiHwFUIvHmxAh5dvuKejkmloiufZg4mypGd2TJWGYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Ic/ULLEj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Ic/ULLEj"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493b6f1b14bso630015e9.0
        for <linux-pci@vger.kernel.org>; Tue, 07 Jul 2026 21:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783486431; x=1784091231; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lR6urvfGdrDv+jncCfpvYz8EpWZuaAhkK2ctmUuEaWE=;
        b=Ic/ULLEjULk1FzT+vQm9NQgTegFZcz2nBviPLmhTy2X7RPYRrD6l6QS0c8W+4ceV0X
         npJG8T67LQ1dOTrTeQiwBlqhu/+9vGVSeXG2MC97Sl4AStNQIX1d9i4BJsJ4qctTKnbX
         lcS9cS28WMIpus0jxkLRVDSVvJREFzDToPwH/tWTNHQLd0RBgxi9CEHET8tPGPA/Cb6W
         P1U5FWLbCUv94m5DcrjiDb4tVTPB5wb9i7RnL2mmwnNfkGO1dJfdhaWGoReUG5mUfZpj
         qHeTARSA3hVLS9bA/XdudtMCjMNpIAhmEFQm/riWqB5H1twL87c/af+LYQA2SunUpWDw
         EwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783486431; x=1784091231;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lR6urvfGdrDv+jncCfpvYz8EpWZuaAhkK2ctmUuEaWE=;
        b=Zi0Zi8OZr2Y6J8QregZOUZHoDrL8vJzewbdqAz54gizNcA516+Q16EoGhav83VFewI
         R85ZhZTT/0a/QtxhZGXGvt6x7LroRcxl4gJJSfrvzOVASkJ9YHjA1L5rCEdoQQfv7igw
         jtzW5DzvxRSR4vrqVzb4F3hxvAxpM2T2+gfKQZeqwjaG9a8Zb4Foleqp02l55gWqsOp8
         JT1OXF4QIFP7wEORRY1Du5arzu4r7nL1IY24Y8FCQy1hO6HYSoKd+qjNww5tW9JU7avd
         Nrd4RRy45PuczaCX0oP7fq4LHop4YlsLQM4XNatXtYB0XIwtr7HX0rs0nWZcfo8sAhRJ
         2rNw==
X-Gm-Message-State: AOJu0YwMxk3ovvIZOniA944pd40CE3LxGu43nyctpFpw0LaI4TPOWjaO
	sfB+R5AkN/9IdwwXPD7FS09Jk+OjuJSguUTShRIcQ4TMasYwIrPSwpcLxLaW1eoLsyzVjhdJttC
	ZXxxu
X-Gm-Gg: AfdE7cmliY26IFU3EzspYp7ogxHOEJbSJdMx2hmA83e/eVG+Coco249Ce3FVipwUg26
	rkFp2JPOcWoF+bPqUpXeM3UMX0YD28xOH0VVuohLsAkVe0t5SB2udMpckNW3fT7p4/vOQxwP8DR
	vzS5zrXFGaz78XrAZAfbDX+ptBHvlm9+Wyzp//F2yvmUgvRb1lHaQKkLEoiOSLDMDP6tXPRE4CM
	wxJxSEXkxS2nQHtgPb27wk23lGplx9XSMjVGNrbMzfxV+GXK9qSC9CqIeazp1S07Zw27aQtG3Hh
	4kYhWKBSs9o/+6pjXtPOffklR76FQhxbTZSRf0E5MHb8/7VlwG4TcAyVYwVVE2cbMa8RY0Y1JfI
	8U6AS7FAMsab+Vvew7UWgmj2WMv1UtKTgxV8cgiiGNutjgUkoZT8/uLI/5eEToNTjmz3yrwAVdN
	P2YL5zlI/NIP7wCLte819/2yMHvKLk52zcB4hkkpUInNivbX7qP0h6Pq6SOg==
X-Received: by 2002:a05:600c:8284:b0:493:c8cf:27bd with SMTP id 5b1f17b1804b1-493e68642c1mr6847545e9.19.1783486431355;
        Tue, 07 Jul 2026 21:53:51 -0700 (PDT)
Received: from localhost (ip-091-089-005-024.um28.pools.vodafone-ip.de. [91.89.5.24])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-493e0f4ef53sm120746745e9.8.2026.07.07.21.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:53:50 -0700 (PDT)
Date: Wed, 8 Jul 2026 06:53:48 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: Update after split of
 <linux/mod_devicetable.h>
Message-ID: <ak3Xc44D5KKn8Ttf@monoceros>
References: <ede7ce64f20e10660ebf6bc1b41836dad750ae3b.1783349758.git.ukleinek@kernel.org>
 <20260706151304.D44521F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="futkkaxv7oliuq6j"
Content-Disposition: inline
In-Reply-To: <20260706151304.D44521F000E9@smtp.kernel.org>


--futkkaxv7oliuq6j
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] Documentation: Update after split of
 <linux/mod_devicetable.h>
MIME-Version: 1.0

Hello,

On Mon, Jul 06, 2026 at 03:13:04PM +0000, sashiko-bot@kernel.org wrote:
> > -.. kernel-doc:: include/linux/mod_devicetable.h
> > +.. kernel-doc:: include/linux/device-id/amba.h
> > +   :internal:
>=20
> [Severity: Low]
> Does this new explicit list of headers miss include/linux/device-id/acpi.=
h?
>=20
> It appears that leaving it out drops the kernel-doc for the ACPI_DEVICE_C=
LASS
> macro from the generated documentation.

This is a change to before the split mod_devicetable.h, but IMHO it's a
good thing that ACPI_DEVICE_CLASS isn't described in the list of
device-id structs.

Best regards
Uwe

--futkkaxv7oliuq6j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmpN17MACgkQj4D7WH0S
/k6sSQgAg2UbkPnq5fCVNEJREJjjG9/Jv6ANnY/8SITChPH2ixON8cQo1bXOCmsG
pR63i+Yq8pY/at+KPNbpIdA9rLNhnVEQP9Snzb1LXk7SVvAYxdBSMBDogepdUKfa
knQ5pyInDjs2FAbN2a5Akpf3zJUiZN33Pg6kNK9G3LKgsGsfzLfpp+Wsl500T53G
LaC4uZVMmnw98scQzNlTP48XoKSJ+1/f/m+/9mf0zIG7jKUnBZG9Uu2K1hXjw5bH
zjKa3Y928b14e5upG+PjW1MkDjg92XMnQRLT02emQvLXHThcgMbCZbS5dEf+kPAZ
F5AQfU2FM3YS0pVmNYQk6ShV3pVCAQ==
=mpmq
-----END PGP SIGNATURE-----

--futkkaxv7oliuq6j--
