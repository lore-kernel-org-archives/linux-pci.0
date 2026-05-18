Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136D93C5540;
	Mon, 18 May 2026 06:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779087361; cv=none; b=ERjy8wBKImCuCGxshEPyi259aQUHjCGuGXsjSHOScrg4qwwhrgZ1Hd7UeaKbu+aaJZZwia1xuS//hCT653LVCFroaJ7htaguXxV2vcuVXO2U+uwxu7BlA+v86ywuFg1zcd22V46DPD2C61geR4Kw8TqEEtHCj5XmXXqE0vmbXoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779087361; c=relaxed/simple;
	bh=o7dvWOoDxJoqk2pHywtA9JSXlbLLMaNNcTzFjnfj+Jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzyr2yXrYaogmwid2AOD2OqYSFLcQEOiSc2YPcUkdSBYycIp6RgNJTva6uMujVnhV76pHkQ0S4Lv8i5G3HKhuVcBWC7MOPCm+q4KFk8wzIWTwp+ZRxJJJ1/YHBxuqx8CP2eGrVoZanWYpdVQ7LJGRCRlEbQx/rHyNGis6XWAsJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBEAy425; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBEAy425"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94F3C2BCB7;
	Mon, 18 May 2026 06:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779087360;
	bh=o7dvWOoDxJoqk2pHywtA9JSXlbLLMaNNcTzFjnfj+Jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nBEAy425sh60FdXG3PK9Hl5HHmR4JhLGLkssLELCmAl6bLVf2uoZT9DlFjrBdwUOr
	 iPfrb/zNRGIbEw5MvkdWEHn8q9hpCzXM89p5Eh0zCbZWYKLA5OQFQDbLaGF4DiqNsx
	 zJKMRlYVC5OMdTqQz0LhOSYUJpWk1ykdqIsnUjH9EeY5aVmMnsIak3HhyAh2Zwj230
	 XNquFayYEnkmYsxqti+gH/xiwDlCZHDReM+yHYJXq7nqnJbiS2qeiIQytSvEmXNEAw
	 41STb/iOBY3qwPcjq8FwSnfB1RrgHS3q3+J3DY9cymgBqa5YCBmuBqY6sLXjcMgzsR
	 3JaQQwY6GZZ2A==
Date: Mon, 18 May 2026 08:55:58 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-doc@vger.kernel.org, devicetree@vger.kernel.org, 
	workflows@vger.kernel.org, linux-arch@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org, netdev@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-csky@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>, 
	Hu Haowen <2023002089@link.tyut.edu.cn>, Dinh Nguyen <dinguyen@kernel.org>, Kees Cook <kees@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Dave Penkler <dpenkler@gmail.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH] nios2: remove the architecture
Message-ID: <agq3nMVq5x4SyBAV@monoceros>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="v3mrrmanqdjd4jn4"
Content-Disposition: inline
In-Reply-To: <20260518042833.272221-1-enelsonmoore@gmail.com>


--v3mrrmanqdjd4jn4
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] nios2: remove the architecture
MIME-Version: 1.0

Hello,

On Sun, May 17, 2026 at 09:28:33PM -0700, Ethan Nelson-Moore wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 6f3147518376..d8145f369ec3 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -131,7 +131,7 @@ config PWM_ATMEL_TCB
> =20
>  config PWM_AXI_PWMGEN
>  	tristate "Analog Devices AXI PWM generator"
> -	depends on MICROBLAZE || NIOS2 || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTE=
L_SOCFPGA || COMPILE_TEST
> +	depends on MICROBLAZE || ARCH_ZYNQ || ARCH_ZYNQMP || ARCH_INTEL_SOCFPGA=
 || COMPILE_TEST
>  	select REGMAP_MMIO
>  	help
>  	  This enables support for the Analog Devices AXI PWM generator.
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index 5a40252b8334..edc8c96d91b6 100644

Acked-by: Uwe Kleine-K=F6nig <ukleinek@kernel.org> # for pwm

Best regards
Uwe

--v3mrrmanqdjd4jn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoKt+8ACgkQj4D7WH0S
/k6D+wf/c3PPUzT+ilOfvLDq6xQ9mwqwWCSp0mpgj+sKStF3zLW22/Jxh8uQfgJz
ZxNzeVpp3RcvofNMMm9NFY7fAJ1PB+bqLcKvHzxUCFe5c6VAocZOm+H+6jrnvcGM
tKehUuFKbRlgdS1XjOXmRn9CuXP4HU7Jm0kFysqDtNt0Zl8gGYQgubZ2Z34XrBIu
msmr1l3QT1BMbE7uRR5crgqH4HHvMpZqR0RehrX2/c1VY8HWEujhEkufhcMZMrvx
Vmuf0f4bdeu4oIwwFMXmijr6ySoxRBKluXwjFOMUa8ZqhyhLFSr6lOhX8pXD+rOr
+brUNxnEjv3MpJArRnZswn7AfSGXWw==
=83W7
-----END PGP SIGNATURE-----

--v3mrrmanqdjd4jn4--
