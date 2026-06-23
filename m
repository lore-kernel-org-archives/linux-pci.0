Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E7954774;
	Tue, 23 Jun 2026 05:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782191362; cv=none; b=qGnkpUh0/tbQ0ibm/363vpNx9Rs2a1Sn3HitmTATgQAxCubGescM6ZhJn4GNKkuoDj4EjfFS0PtzN88Ho4qnc5t0ZEbpqeQed4VYJ8WaZQFXkP5qMUJhQfcJNJRyz0jtPoLp8YAEf0245T37xAVyFVdNS90pbBicEsPUY8jFO+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782191362; c=relaxed/simple;
	bh=h8uTEowAHOX0Xmbx86SeGVcTYrN/pE2IyOnbz76epO4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gvTUBla8jvVdEkYqDoorpHHZgAAC8Zar0/td+BPS1sNwLPCeiinddEvKAONwEsxEwLDtiltTSoK4bCNdWgoe9lw9em2MJxJu/zeOZe0QQ3N+3AGcbKPTb/o+Yd6u6Gq4wafZoHdP+e11DAGdKm6cmO0+Rz3Un5oiPVDIytH3Kn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtGZnWgR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtGZnWgR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68E71F000E9;
	Tue, 23 Jun 2026 05:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782191361;
	bh=y/3yMfIwagNbSLzr8gVBgh/kGnEk1a4UWGvA7ttY1Qk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jtGZnWgRYuEhbkCNbeGevdXHLHFeS4/RjtTO2lcWh+XnK24urmcygDmrls2g337Gr
	 /1//nlyGDw86OfHqCCin92WnotnFijSB9bREq2cMwt2yi1XF9FJSY6xV6Ah5MB01dF
	 143zqMejJ+NwJY09lTYu5BLmepgzN9UTRvXA87baedEHQAbMaDMnL/RlkCUIjPxhcG
	 irCcQVqgZ6biFGoUeI+H8222B7LLN+7gtgw26UhAmoPaGS7E+5XZl0gEBVBIT+sO9M
	 C1r478cq3isuD/OheMTp0BsWCrcTWoQoMLefNiXqy8otK6X6/Z8UORNuz2DU5pZW4o
	 pBzGUg8BEQphg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/21] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-pci@vger.kernel.org, linux-cxl@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260623045406.2589547-10-alistair.francis@wdc.com>
References: <20260623045406.2589547-1-alistair.francis@wdc.com>
 <20260623045406.2589547-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 05:09:20 +0000
Message-Id: <20260623050920.C68E71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The Kconfig symbol `RSPDM` selects `X509_CERTIFICATE_PARSER` but do=
es not inherit its required dependencies, causing an unmet direct dependenc=
ies warning.
--

commit e58dc22b70e82677b92465a9ddd6e228870b413f
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Initial commit of Rust SPDM

This commit introduces the initial implementation of the Rust SPDM library.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 55748b68714e0..aad8439534bfe 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
[ ... ]
> @@ -594,6 +594,20 @@ config LWQ_TEST
>  	help
>  	  Run boot-time test of light-weight queuing.
> =20
> +config RSPDM
> +	bool "Rust SPDM"
> +	depends on RUST
> +	select CRYPTO
> +	select X509_CERTIFICATE_PARSER

[Severity: Low]
Does this selection need to inherit the dependencies of
X509_CERTIFICATE_PARSER?

Selecting a symbol without inheriting its required dependencies can cause an
unmet direct dependencies warning. For example, if a user configures the
kernel with CONFIG_RSPDM=3Dy on a configuration where
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE is not enabled, it could lead to build
warnings or failures.

> +	help
> +	  The Rust implementation of the Security Protocol and Data Model (SPDM)
> +	  allows for device authentication, measurement, key exchange and
> +	  encrypted sessions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623045406.2589=
547-1-alistair.francis@wdc.com?part=3D9
