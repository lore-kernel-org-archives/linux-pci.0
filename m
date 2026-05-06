Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2683B368299
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778107035; cv=none; b=H8LY8Yc2hllkQ6FPoXeU4di3gw/HCih2PSUZjoeDeSYLESQGaA6ONyUVOWz29/tG4F3rEh2300x8FqkXOuzXSLHqKJUyc3O3pL+YbZnfAW9Gyxhhs9N8M4yUyIT35pmPt0pvu9xEeF3OtMVqa3VkyTroU33j1HV+bHYRR7p13Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778107035; c=relaxed/simple;
	bh=jZ/YEXuiVXP2Q21uWF56EImvQlJOw7P4qVosh009zvM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=M5GyuoW8cmSccrU7HVn4uWR8dYxbXAudx8B3hR8g6e+j19EGJdIVC/eCopSlJnU16Y19toavvb5Ju5RRfxDCW/KwwP3HUcLZRRiS7Hq9w3aqw+6G92qnnzA5gWsonAjmaiAb3dXEZz1vIf5Gjy6+Qa7gAhN/IGZaNmMkd6+RtH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxDGXHkU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxDGXHkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F71C2BCB0;
	Wed,  6 May 2026 22:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778107034;
	bh=jZ/YEXuiVXP2Q21uWF56EImvQlJOw7P4qVosh009zvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=XxDGXHkUQiILnM6vQUHdiyaZiXwPjrQ2Fl2ieFOEXNl/VPJFpUcspYzYrkmJez0mj
	 vM3CnqJFu5iBHTrvfc8cbWcvOlY+oxz43x/u40oI8xy0zZuQfWIzBQLW1NNikMwlmF
	 G13xiOAbDW/cDpatAF065qoc+rCJKqF5pHrHOtvcQlzmBk3aQtqBZqts8nt8sigqye
	 OARKYpcpLhXx6xH1cPDDFVYpj6GBLzI0p57hz38/AZJkFndh3L8Z3in806c2lmrH+G
	 Ilv3FpZdKTSmJHc1YFngiZBVgbZvU68U1icG880q8NiVCpzgkUfmuCXSMZhbTpEBo1
	 Ssk48L86UXTeA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 9/9] soc/tegra: pmc: Move legacy code behind CONFIG_ARM
 guard
Reply-To: sashiko@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-pmc-v1-9-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-9-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 22:37:13 +0000
Message-Id: <20260506223714.A7F71C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving `tegra_pmc_early_init()` entirely behind `#if defined(CONFI=
G_ARM)` drops critical interrupt polarity configuration on 64-bit ARM platf=
orms.
--

commit 3d33d60e285505a610396bfade1e54d01280574f
Author: Thierry Reding <treding@nvidia.com>

soc/tegra: pmc: Move legacy code behind CONFIG_ARM guard

This commit wraps legacy power management controller (PMC) code in a
CONFIG_ARM preprocessor guard. This separates legacy code from code needed
on modern 64-bit ARM platforms.

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c

[ ... ]

> @@ -4833,6 +4721,125 @@ static struct platform_driver tegra_pmc_driver =
=3D {
>  };
>  builtin_platform_driver(tegra_pmc_driver);
> =20
> +#if defined(CONFIG_ARM)

[ ... ]

> @@ -4911,3 +4918,4 @@ static int __init tegra_pmc_early_init(void)
>  	return 0;
>  }
>  early_initcall(tegra_pmc_early_init);
> +#endif /* CONFIG_ARM */

Will wrapping tegra_pmc_early_init() entirely behind CONFIG_ARM prevent
interrupt polarity configuration on 64-bit ARM platforms?

Since CONFIG_ARM is only defined for 32-bit ARM (64-bit uses CONFIG_ARM64),
this skips the early initialization entirely on modern systems.

However, tegra_pmc_early_init() is the exclusive caller of
pmc->soc->setup_irq_polarity() after parsing the nvidia,invert-interrupt
device tree property.

Several 64-bit ARM SoCs (such as Tegra186, Tegra194, and Tegra234) define
and rely on this callback to configure the Wake AOWAKE control registers.

Does bypassing this initialization leave the hardware in a default state
that could cause system wake functionality from suspend to behave
incorrectly?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-pmc-v1-0-a=
6de5da7216b@nvidia.com?part=3D9
