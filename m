Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF56372EE9;
	Wed,  2 Sep 2026 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788368556; cv=none; b=gxi4IeTWQpErjnkEagvNnNpLwXu5iBree1UE5FHohBBxaFiEhjbQFj42SCE6qAVcC+7ouNLZCGuNOwE/upAUoRw03n2cz1WLGN0sQqjV1gqPXJM8USV5MeBN5t2FqBpBs+/2OlaeA6BoevlwCSLOnUCShKJWRvemqFbfZs7fP28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788368556; c=relaxed/simple;
	bh=2ps60H3UPkGePyIUY8BslXowLwMg3bBVIE5cYrw8G4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CzBi/VSxkiaBaFUSbxOJkTvdIwlxD88prcrk7hV4s8qn8/GblgOsmkZuBCQSl+wLyrowcmHoJINSau+n5ndKd+P/CWS3Vtz1HjFJQ1yOi4tTSUVZBf5RZDNy/J5J0x3jkD1x6q3DDfrLdFBiB7BreJlEQ9iVVAcO4To45hzdLQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KSwx4Abx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KSwx4Abx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D37F1F00A3A;
	Wed,  2 Sep 2026 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788368554;
	bh=lZM3OVNQpFxKSG+7Gae1Fc30ECjuYgQUff167olyWVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KSwx4Abxuplqx/SHHYbRhp8IoydXqTsXvDhJ1RZNhHsHzmWL0QS4TlgWr7NToHnh5
	 bexXcXXGP2l73TRckdrheEavAEV9MYQYEiXagXKLWxzStkUKX69GYsiM5Fp3Adkjlk
	 LmVApr9cjvW6qw7GqtAxb1ougRuKIKTFOjVtdDQffDUieqJmaQ0aq6FgQTJU6/cnVw
	 bZcdpKgcCejLglgc0gcCgOENPwiya/8gKVa/IqP20O1aivc3ck/dw3Qf0rrOkKjb/y
	 bmGrPjmWgrac0U5VPVNhcIjX0ORRw49l/b938QhnV+EZPj/j55/VpeT3rMHGc2khr5
	 E9UlkXZBhWQDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] PCI: imx6: fix resource leaks in probe error paths
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhijian Han" <hanzhijian1991@gmail.com>
Cc: imx@lists.linux.dev, Frank.Li@kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260902164313.2901302-1-hanzhijian1991@gmail.com>
References: <20260902164313.2901302-1-hanzhijian1991@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 17:02:33 +0000
Message-Id: <20260902170234.6D37F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing DL_FLAG_STATELESS with DL_FLAG_AUTOREMOVE_CONSUMER for d=
evice links to virtual PM domain devices creates managed links that violate=
 the driver core state machine, triggering a WARN_ON during successful prob=
e.
--

commit 36162fbf1662cbc9312c01c7d2c2113d6c77e624
Author: Zhijian Han <hanzhijian1991@gmail.com>

PCI: imx6: fix resource leaks in probe error paths

This commit fixes resource leaks involving pwrctrl devices and power domains
in the imx_pcie_probe() error paths. It adds a devm action to detach the
power domains and replaces the stateless device link flag with an autoremove
consumer flag so links are cleaned up automatically.

Link: https://lore.kernel.org/all/20260822013640.182C01F000E9@smtp.kernel.o=
rg/

> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controll=
er/dwc/pci-imx6.c
> index 39790e66b98dc..ec8339e03d584 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c

[ ... ]

> @@ -655,24 +672,30 @@ static int imx_pcie_attach_pd(struct device *dev)
>  	if (!imx_pcie->pd_pcie)
>  		return 0;
>  	link =3D device_link_add(dev, imx_pcie->pd_pcie,
> -			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
> -			DL_FLAG_RPM_ACTIVE);
> +			DL_FLAG_RPM_ACTIVE |
> +			DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: High]
Does changing this link from stateless to managed violate the driver core
state machine for virtual PM domain devices?

Virtual PM domain devices created on the genpd bus never bind to drivers,
so their driver status remains DL_DEV_NO_DRIVER. Because of this,
device_link_add() will initialize a managed link to DL_STATE_DORMANT.

When the consumer device successfully completes its probe, the driver core
calls device_links_driver_bound(). That function iterates over all managed
supplier links and evaluates:

WARN_ON(link->status !=3D DL_STATE_CONSUMER_PROBE)

Since this link is dormant, won't this trigger the WARN_ON and turn a
successful normal boot sequence into a kernel panic on systems with
panic_on_warn enabled?

>  	if (!link) {
>  		dev_err(dev, "Failed to add device_link to pcie pd\n");
> +		imx_pcie_detach_pd(imx_pcie);
>  		return -EINVAL;
>  	}
> =20
>  	imx_pcie->pd_pcie_phy =3D dev_pm_domain_attach_by_name(dev, "pcie_phy");
> -	if (IS_ERR(imx_pcie->pd_pcie_phy))
> -		return PTR_ERR(imx_pcie->pd_pcie_phy);
> +	if (IS_ERR(imx_pcie->pd_pcie_phy)) {
> +		int ret =3D PTR_ERR(imx_pcie->pd_pcie_phy);
> +
> +		imx_pcie_detach_pd(imx_pcie);
> +		return ret;
> +	}
> =20
>  	link =3D device_link_add(dev, imx_pcie->pd_pcie_phy,
> -			DL_FLAG_STATELESS |
>  			DL_FLAG_PM_RUNTIME |
> -			DL_FLAG_RPM_ACTIVE);
> +			DL_FLAG_RPM_ACTIVE |
> +			DL_FLAG_AUTOREMOVE_CONSUMER);

[Severity: High]
This has the same issue as the pcie power domain link creation above.

Since DL_FLAG_AUTOREMOVE_CONSUMER implies a managed link, should these
links for virtual PM domain devices remain DL_FLAG_STATELESS to avoid
the WARN_ON during device_links_driver_bound()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902164313.2901=
302-1-hanzhijian1991@gmail.com?part=3D1
