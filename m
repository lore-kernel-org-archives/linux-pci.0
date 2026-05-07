Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6083382F0
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140799; cv=none; b=VBEKBDZ0UFDNUtAtnAU8bCm/QJzuCOGjvEySFccx3KdSopkKgsym0WwcVAdTHUX1Q5MUhZ7BveSOOqRrGIaDde5JirxZZWxkoOi1QdEQSJUWDvYxEKK16BX1mlumJJyXKb0On0YcHi55+G3PYJ9xwlLKRSKz38YUBao+vWwDE5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140799; c=relaxed/simple;
	bh=PAqjXxV0tM+tkJZe+pIS5Ky/Or2uQagGCWjUiJWr/EM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UrTGmIjq/OSfbuQp4wh/H5lxZ+gNM5I1yAiH4TXITfH1sYOolzyHYcvqyE43aaYOcvWW8EuGwUprqQLyulTWuc/GRkA7VENPEJmQZKqxvAmWnhscEh4itv/K1Z0kBUYsRI3C1WxKmjQU9QM1kdgR5tZD+RSUB5JK3Fm8mCyGAJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJuMg55B; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJuMg55B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B787EC2BCB8;
	Thu,  7 May 2026 07:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140797;
	bh=PAqjXxV0tM+tkJZe+pIS5Ky/Or2uQagGCWjUiJWr/EM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=sJuMg55BNEcpWXmaclOJ9iw1FdhU7QAEhGEuvQTco97Efm060tyJx8hAzc4YblWuN
	 z5YyVnQLyjILrAT8S73/UzzTrWQRG/pHRn4NBYp1UUF6KdZgBWTO/vcXZsNrRgbS2p
	 o2BJYDE0nfjD6btE4hxz5XnehB6OZMpGgzYU8+2f9beSp79FYZTdWrZVI5UjOo4Bz8
	 1ai/iGCBR17/ijvngv0WwfdtMasRauJJs01NsUKz+mGNOMLLJLVLa/OTbox/v1NnOo
	 AmRrLvZorAuY4P3/8/lOZ3xn/U50fnav2KR07quPIQ2uM6I4NMq+vhHd2yNKZW1G2d
	 /j+V5dQZWcVfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error
 codes in cdns_plat_pcie_probe()
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: linux-pci@vger.kernel.org, wsa+renesas@sang-engineering.com
In-Reply-To: <20260505100523.1922388-2-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 07:59:57 +0000
Message-Id: <20260507075957.B787EC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Type confusion in `cdns_plat_pcie_shutdown()` and PM callbacks cau=
ses an out-of-bounds read and kernel crash during system shutdown or suspen=
d.
- [High] Missing driver `.remove` callback causes severe Use-After-Free and=
 resource leaks upon driver unbind.
--

commit 0bab3a01514eb340ef73b1b934e9dc310bdbfcda
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()

This commit updates the error path in cdns_plat_pcie_probe() to ensure that
errors from functions like pm_runtime_get_sync() and cdns_pcie_host_setup()
are properly propagated instead of incorrectly returning success.

> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_devic=
e *pdev)
>  	while (phy_count--)
>  		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> =20
> -	return 0;
> +	return ret;
>  }

I noticed a potential issue here that predates this patch.

This driver does not appear to have a .remove callback, nor does it set
.suppress_bind_attrs =3D true. If the driver is unbound via sysfs, devres w=
ill
clean up managed allocations like the host bridge, EPC structs, and
struct cdns_pcie memory.

However, without a remove callback to call cdns_pcie_host_disable(), does t=
he
PCI core subsystem remain unaware that the host bridge was removed?

Could this lead to a use-after-free if the PCI core continues to access the
freed bridge structure and memory-mapped I/O regions?

A related leak of PHY device links was noted as fixed by a later commit in
this series (PCI: Remove device links to PHY), but it appears the missing
root bus teardown remains unfixed.

> =20
>  static void cdns_plat_pcie_shutdown(struct platform_device *pdev)

I also noticed another pre-existing issue related to this function.

In cdns_plat_pcie_probe(), the platform device's driver data is set to a
struct cdns_plat_pcie pointer:

cdns_plat_pcie_probe()
    cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNE=
L);
    ...
    platform_set_drvdata(pdev, cdns_plat_pcie);

However, cdns_plat_pcie_shutdown() retrieves this and casts it directly to a
struct cdns_pcie pointer:

cdns_plat_pcie_shutdown()
    struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
    ...
    cdns_pcie_disable_phy(pcie);

Since struct cdns_plat_pcie is just a wrapper containing a pointer to the
actual struct cdns_pcie, does this incorrect cast cause an out-of-bounds
read when cdns_pcie_disable_phy() attempts to access pcie->phy_count and
iterate over the PHY pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D1
