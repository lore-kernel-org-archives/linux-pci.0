Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89C33BBAF;
	Thu, 10 Sep 2026 07:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025164; cv=none; b=Dnnxi1dQdrIUqLLxzSs1K4dp3KUsOScFkEBvVi1ws3YNb4vsRsKGeWiefuE3MOfqPAZUSNynOnuiQBPhGJLCiRuVJn+N+Ra+g46DiQFQ9VI/P61tS8TjCzr4tqTSShMoEV76wlZqQGkekh6JvDgNWvOXjYTzLiKAtiKqpMlMZAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025164; c=relaxed/simple;
	bh=QpW2vwuRXEqkzwxOGoPAAO/fFSy7uTz8SsrrxaEpe0c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mbh5d98YuV3iNvj3SzvHdaQUC5pE8xjFx9ruBwnKecjQeEycWROMbvByGLRigjd+zzFHCTL+E5k52jxquXrTp66+czvzkw0aCWzf1Iz84a873N7LnzPmIMIj7zChLVyzA5gwtjxfItH4o655PBQbSggGibv1+4yf+ABzogZThJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfJNOrMH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfJNOrMH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0391F00893;
	Thu, 10 Sep 2026 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789025158;
	bh=QnJ2x9KJjFnrBVdcMLNOudCwhner1XHDbeZIr5YDsRA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hfJNOrMHEV4kbkriYN1YcWYFLsHe9p/NVGpgbi3cYiz0qbruCJJsDgLjKP1rdCj1w
	 SI80TqJe7T1TtIUhbFG+yajybIaEKCVK27drRSoAJB4tB0kY+kqJAlgWKymWGwTjeZ
	 10lvgn07xcuEaoDOTbRUI29ZaMGBELG76iTW5e0GrVjD+48hSVywz2mfdXDhWJGT73
	 uAIC5NNWvibfqOg17AS6dG5O9MO1Z+xUlvlZoy+0daJutQKyfZAyAs9f+OckFhjYb+
	 BEYEuygYgX5k847HKvd6UJZrdtaPdRPyDelKaAdcTUfVPuNHCpP4D/yj/6Q7781ylX
	 p8V8/j0YJc/wg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 02/12] cxl: Make HDM commit helpers available to
 reset code
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>
Cc: linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260910070808.1444264-3-smadhavan@nvidia.com>
References: <20260910070808.1444264-1-smadhavan@nvidia.com>
 <20260910070808.1444264-3-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 07:25:58 +0000
Message-Id: <20260910072558.9C0391F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Adding `config CXL_RESET` inside the `if CXL_BUS` block causes a Kc=
onfig unmet direct dependency warning when `CXL_BUS=3Dm`.
--

commit 8c6d2d2149249d98c40c726d32df18f750f68999
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Make HDM commit helpers available to reset code

This commit builds generic HDM resource helpers under CONFIG_CXL_RESET so
PCI reset paths can use them when cxl_core is modular. It exports the
necessary lock and commit entry points consumed by cxl_core.

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 80aeb0d556bd7..9e6fb2290fed1 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -6,6 +6,7 @@ menuconfig CXL_BUS
>  	select FW_UPLOAD
>  	select PCI_DOE
>  	select FIRMWARE_TABLE
> +	select CXL_RESET
>  	select NUMA_KEEP_MEMINFO if NUMA_MEMBLKS
>  	select FWCTL if CXL_FEATURES
>  	help

[ ... ]

> @@ -243,4 +244,7 @@ config CXL_ATL
>  	depends on CXL_REGION
>  	depends on ACPI_PRMT && AMD_NB
> =20
> +config CXL_RESET
> +	bool
> +
>  endif

[Severity: Low]
Will defining config CXL_RESET inside the if CXL_BUS block cause an unmet
direct dependency warning during build when CONFIG_CXL_BUS=3Dm?

Because CXL_BUS uses select CXL_RESET, but CXL_RESET inherently inherits
the if CXL_BUS direct dependency, configuring CONFIG_CXL_BUS=3Dm forces the
boolean target CXL_RESET to y while its direct dependency evaluates to m.

Could this be resolved by moving config CXL_RESET outside the if CXL_BUS
block?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910070808.1444=
264-1-smadhavan@nvidia.com?part=3D2
