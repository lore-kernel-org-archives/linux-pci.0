Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93B531716B;
	Tue,  1 Sep 2026 01:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788225487; cv=none; b=hYmGXir8V8R9T16gxcqzyteWerZluwUaVQR0wnWWcKGPEP5HCi/gy43Tu+mZawfStVrB9zH+/bvWn+E+bcpaOPogloM1IWtSVQAeqifLMN2BiAURcscg+zlUPavqY519KGcbnyVyya14kJ//wVnS4R7eU23dsXEeBX0z+9V+xYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788225487; c=relaxed/simple;
	bh=1v+YE5bBYWzyzJoESK+DphzwZn4QReDaQH/pWpqqTaI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D3KttxloFaHh+Ya+1STYZ+GVooxn1zDogGptWsg1ex6wscf2BKCoFHoIJ8Z1ws0VO12wRKhoRT/wh9itcMFtM18gQidjFJdMfb4f8g8gs5TnU3vw1kGmhnw9WvyNavv5FRT3RtHbsaAgE/2VQFGUHArsHUAS6QZkLdILLHR0FFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGchelie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGchelie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DF51F00A3D;
	Tue,  1 Sep 2026 01:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788225476;
	bh=0hBx4jRSTZ4LNSvc5F0Cvjn3+Nd29TDzWTgUqOKuslI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GGchelieWCV1nMeJGhiOrZHPISZ2K4pnF2/aiCreNXF1CMDESAxESxL8kwaRdlGy/
	 99Prgff0oBobm6uKWF6OK8hpUMLyVE190pYQ/OOI83tEkW6AqTcsLnTLcBnSBB92KE
	 0SbAxAgDrb1vML14Mpb/ZoMLnp/0Az9V/Zqeaq6DPkCiQvIaCbjpCW/39WhtTp9x1E
	 Gx7iI9BwIhACjBWKHqU6fpgnnn1n3NjIVdUbbM7dxhd9ytRS04whgHuWDXHW6SjYvT
	 UnAz9LypcTVy0c2J5AnCEptO6Ks1WuC9DrHSB9IneIChaGqSvv/SG5S3yE1RUZocf/
	 XY42JJuiVff/w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/21] lib: rspdm: Initial commit of Rust SPDM
Reply-To: sashiko-reviews@lists.linux.dev
To: alistair23@gmail.com
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260901010347.2614656-10-alistair.francis@wdc.com>
References: <20260901010347.2614656-1-alistair.francis@wdc.com>
 <20260901010347.2614656-10-alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 01:17:56 +0000
Message-Id: <20260901011756.96DF51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] RSPDM uses `select` for config options without inheriting their dep=
endencies, leading to unmet dependency warnings.
--

commit 752bdb39dced6672e12844f92653f4013c5aea48
Author: Alistair Francis <alistair@alistair23.me>

lib: rspdm: Initial commit of Rust SPDM

This is the initial commit of the Rust SPDM library.

> diff --git a/lib/Kconfig b/lib/Kconfig
> index 4e6b34c3346d5..b1792db6ddf07 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
[ ... ]
> @@ -588,6 +588,21 @@ config LWQ_TEST
>  	help
>  	  Run boot-time test of light-weight queuing.
> =20
> +config RSPDM
> +	bool "Rust SPDM"
> +	depends on RUST
> +	select ASYMMETRIC_KEY_TYPE
> +	select CRYPTO
> +	select X509_CERTIFICATE_PARSER

[Severity: Low]
Will selecting these config options without inheriting their dependencies
cause Kconfig unmet dependency warnings?

ASYMMETRIC_KEY_TYPE depends on KEYS, and X509_CERTIFICATE_PARSER depends on
ASYMMETRIC_PUBLIC_KEY_SUBTYPE. If a user enables RSPDM without having KEYS
enabled, Kconfig will issue an unmet direct dependency warning and
potentially cause silent build failures.

Should this config add "depends on KEYS" and either depend on or select
ASYMMETRIC_PUBLIC_KEY_SUBTYPE?

> +	help
> +	  The Rust implementation of the Security Protocol and Data Model (SPDM)
> +	  allows for device authentication, measurement, key exchange and
> +	  encrypted sessions.
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901010347.2614=
656-1-alistair.francis@wdc.com?part=3D9
