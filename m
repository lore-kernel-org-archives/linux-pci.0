Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81F2F0680
	for <linux-pci@vger.kernel.org>; Wed,  7 Oct 2026 05:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791352045; cv=none; b=Xsw9PduJue8mCbeHBS6iYEoNU6kdJKsrXaRplAuLaquPP6ADClID1V0xdaiMOG4/A5meGIyqzlxA60cXdWYna887CS3n7/E/WVOs2jXSydIGxV7J3U7PHvplOuHAenqfJRmxP9IEQpa3KnzwJRDFdjizj7wtjy4p25qfw+/C2IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791352045; c=relaxed/simple;
	bh=cDvLzSKbZUBYDIXHVCmG8Y95jU2qrungqw465rIK3Sc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=cer0qSXgBl+ydtlNReyLZ50nQLHSLhjWpJsFu4kU8OerHiaAi1JtOO8xv6A0jepEiqGdc0yD5qpwI8agpFZQqwYw9xttvNTou/74Tb0HKpLBjc87WdWmOr4PUyr5aDriEfR9m/BXee0m01GVNDrVZS3mnr0hoqcbkFIAZ20P8YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWEEIh/T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWEEIh/T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F7C1F0089B;
	Wed,  7 Oct 2026 05:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791352044;
	bh=qsycE+OIxNv/pLqZPRaafpbkarjcrNTPyG/TV9mOhP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MWEEIh/TeFFPm3rq12MxVnfKeetdA4sgk+hfTCp3P6wGkVzhK+NvUiHBN2pxTQbHw
	 vK/CB5ES65nukjfQD1lN/xZIxXhel/cck73Q3MgTnwm0v0kL9V9Dl6+icdshuZR6xd
	 ebhmqdKkDBtxSGW+r340Vv+pWSkoH2eMnZL5izspqKA2NDgmajGfSquUkpbwtAAS8H
	 6IGQ221i8whR/Y51E6BGdoBOhXHnXsCqs49sQdjZlvoRYHJVhkhxBXnF19+GmiRSLe
	 4EfOH4iw6tMXSAjY+bq/VQCFAxruJ61fxRwANPoWaeaURXgiTHfut3xzJnO0fR//mZ
	 6ms80jatuc68A==
Message-ID: <sashiko-outbox-162648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] PCI: rzg3s-host: Move host configuration code
 together
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudiu Beznea" <claudiu.beznea@kernel.org>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20261007053645.1391545-5-claudiu.beznea@kernel.org>
References: <20261007053645.1391545-1-claudiu.beznea@kernel.org>
 <20261007053645.1391545-5-claudiu.beznea@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 05:47:23 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] cleanup: mixing goto and __free() in rzg3s_pcie_probe
--

commit 58c1ad45841aacf58a73f4caada04798bba4e7e2
Author: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

PCI: rzg3s-host: Move host configuration code together

This commit rearranges the host configuration functions together to prepare=
 for
hotplug support. It also adjusts the error handling paths and labels in the
probe and suspend/resume routines.

> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/contr=
oller/pcie-rzg3s-host.c
> index 077cfb0834b37..3ecada2384023 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c

[ ... ]

> @@ -1902,12 +1893,16 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>  	if (ret)
>  		goto rpm_disable;
> =20
> +	ret =3D rzg3s_pcie_power_resets_deassert(host);
> +	if (ret)
> +		goto rpm_put;
> +

[Severity: Medium]
Does this error handling violate the cleanup subsystem requirements?

The rzg3s_pcie_probe() function declares sysc_np using __free(device_node):

    struct device_node *sysc_np __free(device_node) =3D
        of_parse_phandle(np, "renesas,sysc", 0);

However, the function also heavily uses manual goto rollback labels, and
this patch modifies those paths. According to include/linux/cleanup.h,
mixing goto-based cleanup labels and scope-based __free() in the same
function is not permitted due to the risk of confusing ownership semantics.

Should this function either be converted entirely to scope-based cleanups
or avoid __free() entirely?

>  	raw_spin_lock_init(&host->hw_lock);
> =20
>  	ret =3D rzg3s_pcie_host_setup(host, rzg3s_pcie_init_irqdomain,
>  				    rzg3s_pcie_teardown_irqdomain);
>  	if (ret)
> -		goto rpm_put;
> +		goto power_resets_assert;
> =20
>  	bridge->sysdata =3D host;
>  	bridge->ops =3D &rzg3s_pcie_root_ops;
> @@ -1922,12 +1917,13 @@ static int rzg3s_pcie_probe(struct platform_devic=
e *pdev)
>  	clk_disable_unprepare(host->port.refclk);
>  	rzg3s_pcie_teardown_irqdomain(host);
>  	host->data->config_deinit(host);
> +power_resets_assert:
> +	reset_control_bulk_assert(host->data->num_power_resets,
> +				  host->power_resets);
>  rpm_put:
>  	pm_runtime_put_sync(dev);
>  rpm_disable:
>  	pm_runtime_disable(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007053645.1391=
545-1-claudiu.beznea@kernel.org?part=3D4
