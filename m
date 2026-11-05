Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793906258;
	b=jhvbwBdc1nd0KQ9BLQB7I6AQJCZcriraQCXIzB6bhd/dqqwCAIzE+/mElBi/wZzCEMRr
	 gYKvS/DTGhJi1dXPlVf0Ziwr8QlGYfoY+ZSJemTJKzgN7CDTL5gThUsMNMzGXy30SaMKg
	 T8jleZx+7jauXg7RTL1ty4W//5bJIzRV64THJAH5iCSV3W33ArVxEpOFVoAuF2Ds7EyE7
	 eWIxpiauBu64mellhOMz52gGMiNLHv07agUFktwLzOoH4NT7aQi5Kf45OfFrrcnGV0myN
	 5YgSAnYlcv2yHbeBwsSerM5T4FLqydKlGVkXuE0jffF3MBgO8doy+D/pWtOxvf++hrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793906258;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kxzvRRq0hY8NQKaQ7NoXxtVRuA7Hyqt/cpmeiG2pXro=;
	b=q/BU87EnS9shd6yazjzKouuiSdjgYI1n1k0wdvhrLbo2aeB5OPcYTRZB82MHW/MPNZI6
	 rguVo/t3xqIix2KG2WE4RlV6IQqZdQY2+RKZ1MPk6iDPos1WDAIUtR3SoSXoTx6AuS711
	 x4uh11ITnzTPGeeIyJp+KE0lZcbs+R9jT2o40DXmWA2Qeb8k3wdb/8G3Vv9Mga9xdDcwa
	 70T1eXdn5dtrU7x/OjUbN9SHpRP+UOaL7PGtsb+dXJUJbM1VC/koUVzVC7iFiDyhKCVdm
	 D9ZahY7Cq3iyf5kPBAUV3WTBXb7yGTR70uaobIbbTFdy8YaoY5OF/4Bmbo6qUxWotfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQJU16yG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1E5606A31B;
	Thu,  5 Nov 2026 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lQJU16yG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA541F000C1;
	Thu,  5 Nov 2026 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793906257;
	bh=kxzvRRq0hY8NQKaQ7NoXxtVRuA7Hyqt/cpmeiG2pXro=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lQJU16yGaDHIKVavi6zFTlguzeM3dLpW3+8OE5dmUqSUxaFd6ykUWmhAltcjU0qWj
	 WzPRZCiJjXw16NCsdF//HcXqdwC11PXptX1DRhsxihqgGojKvRwmFWYxZsK3UFwcCL
	 bSxOwkZYz1Ui5Z/iVkgEdSmeFgBfOPeFf3acZjE3lsPcr6e/8lDi3wgaIuH15xzqY4
	 NW8uiRjb6HPUrE1ephGv2yHU8ZedI8DCFvTimcDmYxt1FZKNCfQuJajhCoV/oVfJKc
	 821rsq1XuvaT0OvFGT2UHEYyzq4VzS6r6IslylZTioS+Vl+qS1T3WkH3OhuIvlL+oq
	 w4Sub03+evmMg==
Message-ID: <sashiko-outbox-199836@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 09/19] cxl: Refresh cached PCI HDM decoder settings
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srirangan Madhavan" <smadhavan@nvidia.com>, linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20261105185917.2667656-10-smadhavan@nvidia.com>
References: <20261105185917.2667656-1-smadhavan@nvidia.com>
 <20261105185917.2667656-10-smadhavan@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 19:17:36 +0000
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Post: <mailto:linux-pci@vger.kernel.org>
List-Help: <mailto:linux-pci+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pci+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] cxl: split declaration and init of __free() variable in cxl_hdm_ref=
resh_decoder()
- [Low] cxl: unused struct cxl_hdm_info forward declaration in include/cxl/=
cxl.h
--

commit 0273d4d08ae78949f901788b93c7db64fb203e17
Author: Srirangan Madhavan <smadhavan@nvidia.com>

cxl: Refresh cached PCI HDM decoder settings

This commit refreshes the cached PCI HDM decoder state when hardware HDM
decoders are enumerated, committed, or reset, and validates the enumerated
decoder count against the cached count.

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 85f9abf58a42b..ec387070d7adb 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -725,6 +725,24 @@ static void cxlsd_set_targets(struct cxl_switch_deco=
der *cxlsd, u64 *tgt)
>  		*tgt |=3D FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
>  }
> =20
> +static void cxl_hdm_refresh_decoder(struct cxl_hdm *cxlhdm,
> +				    struct cxl_decoder *cxld)
> +{
> +	void __iomem *hdm =3D cxlhdm->regs.hdm_decoder;
> +	struct pci_dev *pdev __free(pci_dev_put) =3D NULL;
> +
> +	if (!hdm)
> +		return;
> +	if (!is_endpoint_decoder(&cxld->dev))
> +		return;
> +
> +	pdev =3D cxl_port_get_uport_pci_dev(cxlhdm->port);

[Severity: Low]
As reported by Cheatham, Benjamin on v13 [1], this isn't a bug, but in
cxl_hdm_refresh_decoder() in drivers/cxl/core/hdm.c, pdev is declared with
__free(pci_dev_put) =3D NULL at the top of the function and assigned later =
after
the !hdm and !is_endpoint_decoder(&cxld->dev) early returns.

Should pdev be defined and initialized in a single statement where
cxl_port_get_uport_pci_dev(cxlhdm->port) is called after the early returns,
matching cxl_hdm_check_decoder_count() in drivers/cxl/core/pci.c and the
kernel Cleanup API conventions?

[ ... ]

> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 6d6e564be27a9..341a7c52894ab 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -26,6 +26,7 @@ enum cxl_devtype {
>  };
> =20
>  struct cxl_region;
> +struct cxl_hdm_info;

[Severity: Low]
This isn't a bug, but struct cxl_hdm_info is not referenced anywhere in
include/cxl/cxl.h (it is defined in include/cxl/hdm.h and forward-declared =
in
include/linux/pci.h). Can this forward declaration be dropped from
include/cxl/cxl.h?

[1] https://lore.kernel.org/r/2c37c82b-8db6-44d1-868b-0b98bae57459@amd.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105185917.2667=
656-1-smadhavan@nvidia.com?part=3D9
