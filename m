Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3A35CBD7
	for <linux-pci@vger.kernel.org>; Wed,  6 May 2026 21:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103629; cv=none; b=Iw1HqavpKtK1JqVM/t98Pj9e2JEvQCZVxNkuNcpfH276Lr8jb6wlsgkH0svdGfjrWAt5TXqHJPnJ2V3CfTvrww70xr+zQ/0LaBcajNajobHUn6rBIXMnAxEq2lToloNIPl/lPTSutYxlGhjNXVziqM2SqPr60VVghhJrrdYM274=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103629; c=relaxed/simple;
	bh=ghvcjQYDDoUJJxW4kzkF1Kcvf2f6KZ29v0yyWYiqIh8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R1pvrlPyw2oharC2tz9drg/0Wbp+EpPqHWbMNfiZfLRu7BlNzfdSbvnmiulZGRPD9cEvbTnhi/Dgpu3M2cpr/9OxvJ2C9h5h/6e3GpskSIMuGZQkzlRGMotwfWwYHKunkN5ndPsVCBp8mmZFAZwM8ijT7d5du7Jqfljm0i2DCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkqaZBR8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkqaZBR8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB5DC2BCB0;
	Wed,  6 May 2026 21:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778103629;
	bh=ghvcjQYDDoUJJxW4kzkF1Kcvf2f6KZ29v0yyWYiqIh8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZkqaZBR8sxOLQMNwBwsReFhUHOVS+XgVvmU6YC6EBbJXUVsbl5Yp793ojMowPB1Nc
	 XOd6dEsqa+G73Ae1gKKoVpMxxzQbsy4fFouvNWJY5riW0mcZyUGncqdju3Tb281+GH
	 RbPCbZYytAYVUUImMVJfJ1M81bebP6ff+/yiZc56h9RPX/1Vnei7im2DRe6wsZ/SiR
	 otDEniXJEk1WTaUreSfRZfKTe1kSlS+gNYvCe4IxCV2dMAPPUK8I0w6LVgiUdcdZ1s
	 b3HgwgIhDA4sAlkPEsm+wwMrJK1xeQHa+d7VfwUXkMXXkso6RhEy6jTvOpmC6icVsz
	 eUi2aGq80xsLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/9] soc/tegra: pmc: Create PMC context dynamically
Reply-To: sashiko@lists.linux.dev
To: "Thierry Reding" <thierry.reding@kernel.org>
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20260506-pmc-v1-7-a6de5da7216b@nvidia.com>
References: <20260506-pmc-v1-7-a6de5da7216b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 06 May 2026 21:40:28 +0000
Message-Id: <20260506214029.6BB5DC2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] NULL pointer dereference during probe
- [Critical] State divergence and broken locking (Split-brain)
- [High] Uninitialized mutex `powergates_lock`
- [High] Race condition during `early_pmc->base` remapping
--

commit b6008034a38db1b336e6d5fbf448c51ed73ba6d9
Author: Thierry Reding <treding@nvidia.com>

soc/tegra: pmc: Create PMC context dynamically

For legacy purposes, an early PMC context is needed to support certain
drivers and functionalities. However, when the PMC driver is probed in
the later boot stages, the early context is no longer needed. Allocate
the PMC context dynamically at probe time so that it can be used going
forward.

> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 2ee6539d796a5..50969b07fd8c3 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
[ ... ]
> @@ -1533,7 +1533,7 @@ static int tegra_powergate_add(struct tegra_pmc *pm=
c, struct device_node *np)
> =20
>  bool tegra_pmc_core_domain_state_synced(void)
>  {
> -	return pmc->core_domain_state_synced;
> +	return early_pmc->core_domain_state_synced;
>  }

Will this correctly reflect the synced state?

tegra_pmc_sync_state() sets pmc->core_domain_state_synced =3D true on the
dynamically allocated pmc instance, but this function checks
early_pmc->core_domain_state_synced which appears to remain false.

[ ... ]
> @@ -2009,18 +2009,18 @@ void tegra_pmc_enter_suspend_mode(enum tegra_susp=
end_mode mode)
>  	if (WARN_ON_ONCE(rate =3D=3D 0))
>  		rate =3D 100000000;
> =20
> -	ticks =3D pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
> +	ticks =3D early_pmc->cpu_good_time * rate + USEC_PER_SEC - 1;
>  	do_div(ticks, USEC_PER_SEC);
> -	tegra_pmc_writel(pmc, ticks, PMC_CPUPWRGOOD_TIMER);
> +	tegra_pmc_writel(early_pmc, ticks, PMC_CPUPWRGOOD_TIMER);

Is early_pmc correctly populated with the suspend parameters?

tegra_pmc_parse_dt() parses the device tree and populates fields like
cpu_good_time, cpu_off_time, and rate into the dynamically allocated pmc
structure, but it looks like tegra_pmc_enter_suspend_mode() is reading
them from early_pmc where they remain 0.

[ ... ]
> @@ -3110,6 +3110,44 @@ static int tegra_pmc_regmap_init(struct tegra_pmc =
*pmc)
>  	return 0;
>  }
> =20
> +static bool tegra_pmc_detect_tz_only(struct tegra_pmc *pmc)
> +{
> +	u32 value, saved;
> +
> +	saved =3D readl(pmc->base + pmc->soc->regs->scratch0);

Could this dereference a NULL pointer during probe?

> +	value =3D saved ^ 0xffffffff;
[ ... ]
> +static void tegra_pmc_init_common(struct tegra_pmc *pmc)
> +{
> +	unsigned int i;
> +
> +	pmc->tz_only =3D tegra_pmc_detect_tz_only(pmc);

tegra_pmc_init_common() is called immediately after pmc is allocated,
before pmc->base has been initialized by devm_platform_ioremap_resource()
below:

> +
> +	/* Create a bitmap of the available and valid partitions */
> +	for (i =3D 0; i < pmc->soc->num_powergates; i++)
> +		if (pmc->soc->powergates[i])
> +			set_bit(i, pmc->powergates_available);
> +}
[ ... ]
> @@ -3128,9 +3166,16 @@ static int tegra_pmc_probe(struct platform_device =
*pdev)
>  	 * register mapping and setup the soc data pointer. If these
>  	 * are not valid then something went badly wrong!
>  	 */
> -	if (WARN_ON(!pmc->base || !pmc->soc))
> +	if (WARN_ON(!early_pmc->base || !early_pmc->soc))
>  		return -ENODEV;
> =20
> +	pmc =3D devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> +	if (!pmc)
> +		return -ENOMEM;

Is the pmc->powergates_lock mutex properly initialized?

It seems it is zero-initialized by devm_kzalloc() but never initialized via
mutex_init(). Later, generic power domain operations like
tegra_pmc_core_pd_set_performance_state() attempt to lock it.

Additionally, does maintaining both early_pmc and pmc break mutual
exclusion?

Exported legacy APIs use early_pmc->powergates_lock while generic domains u=
se
pmc->powergates_lock. Both modify the same hardware registers, which could
lead to data races.

> +
> +	pmc->soc =3D device_get_match_data(&pdev->dev);
> +	tegra_pmc_init_common(pmc);

Here pmc->base is still NULL when tegra_pmc_detect_tz_only(pmc) attempts to
read from it.

> +
>  	err =3D tegra_pmc_parse_dt(pmc, pdev->dev.of_node);
>  	if (err < 0)
>  		return err;
> @@ -3141,14 +3186,14 @@ static int tegra_pmc_probe(struct platform_device=
 *pdev)
>  		return err;
> =20
>  	/* take over the memory region from the early initialization */
> -	base =3D devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(base))
> -		return PTR_ERR(base);
> +	pmc->base =3D devm_platform_ioremap_resource(pdev, 0);

pmc->base is only mapped here.

[ ... ]
> @@ -3271,10 +3316,10 @@ static int tegra_pmc_probe(struct platform_device=
 *pdev)
>  	if (err < 0)
>  		goto cleanup_powergates;
> =20
> -	mutex_lock(&pmc->powergates_lock);
> -	iounmap(pmc->base);
> -	pmc->base =3D base;
> -	mutex_unlock(&pmc->powergates_lock);
> +	mutex_lock(&early_pmc->powergates_lock);
> +	iounmap(early_pmc->base);
> +	early_pmc->base =3D pmc->base;

Can this race with a concurrent lockless accessor?

If a lockless accessor like tegra_pmc_cpu_is_powered() executes during the
window between iounmap() and pointer reassignment, it might dereference an
unmapped I/O address. Assigning early_pmc->base before unmapping the old
address might prevent this.

> +	mutex_unlock(&early_pmc->powergates_lock);
> =20
>  	tegra_pmc_clock_register(pmc, pdev->dev.of_node);
>  	platform_set_drvdata(pdev, pmc);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260506-pmc-v1-0-a=
6de5da7216b@nvidia.com?part=3D7
