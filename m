Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF6D37AA7E
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140800; cv=none; b=j7TxXNF+sTlYWnqbFsGzNgnZuFhGW+5McFdSSeBmooTqfo7Zea2tFpDnKjrwaoCqvOwyu5m44wXHPVKsEn7eNa/j2/OyKZJ9KrDud3SK3FZ0v3nij5OUkNrSZcCmHr9Om+ynkdF0UaXwFVuwzpgn2rOcbzhHxWkBOzxz2/6itz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140800; c=relaxed/simple;
	bh=TVSu35uwVUU84kaaUUHzbGpIol7cjYWHmARM/A+4SiA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JT9MN9ilm0at7riTG+pm4cKjJs6hJDRT1zyYIjDKpL1Rc6/tuozJ/Mi2fCi/ZTB/OMfaqjGjCqeD2oMIXH4+2uwd4gT1Ye2UTbp1s9xVHLMJpEX1Fyr3qPrMg8S6K2DUi3YemaZaLAoLiPGnNR5b8M7teWS700Gn5TS6Oo5UXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHBVjQO+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHBVjQO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D77C2BCB8;
	Thu,  7 May 2026 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778140799;
	bh=TVSu35uwVUU84kaaUUHzbGpIol7cjYWHmARM/A+4SiA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cHBVjQO+6UM3oMKrPM4eFz7oiRTWog0CVW4Z92erzruq5lrnN9SN8RvXYauE8vAs2
	 N84Zl9oWu1EFokry5P4O4rTCid3Y6xoxI7vjAltjRg030CMuafjG9CJmXT2lDfdd8j
	 W8UtGdqTPSUpib6xnmgmYsfIqpldlNoocNS5XSV9g/xLZjjDJ0ePZhSeljwuvWmWC3
	 n5qvzbS96lpAH5wYCUjvgu/Os2Ilk2DDlbwzIYzezIkEQBFXbSpyBjjjjafpoKwRT6
	 TqzQ62IiTVO0JrDfOAPhHZy7xwgl0fAz34tJpTSTIMNxxjrizJXsjSBifkoWxDECsx
	 Bn+aC++jG2iMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 phy-next 09/31] PCI: Remove device links to PHY
Reply-To: sashiko@lists.linux.dev
To: "Vladimir Oltean" <vladimir.oltean@nxp.com>
Cc: wsa+renesas@sang-engineering.com, linux-pci@vger.kernel.org
In-Reply-To: <20260505100523.1922388-10-vladimir.oltean@nxp.com>
References: <20260505100523.1922388-10-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 07:59:58 +0000
Message-Id: <20260507075959.47D77C2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Critical memory corruption in cdns_plat_pcie_shutdown() due to=
 incorrect pointer cast.
- [High] Asynchronous pm_runtime_put() is called immediately before pm_runt=
ime_disable(), cancelling suspend transitions.
- [High] Shared IRQ handlers access hardware registers without checking PM =
runtime state, causing spurious interrupts or bus errors.
--

commit abda94a24ef1bb0817706ae87aa20f04251c14ad
Author: Vladimir Oltean <vladimir.oltean@nxp.com>

PCI: Remove device links to PHY

This commit removes device links between the PCIe controllers and PHY
providers in the Cadence, DRA7xx, and Keystone drivers. The device links
are now redundant since the PHY core automatically adds device links to
order suspend/resume operations.

> diff --git a/drivers/pci/controller/cadence/pcie-cadence-plat.c b/drivers=
/pci/controller/cadence/pcie-cadence-plat.c
> index 8b12a46b56019..6fd16e09e2444 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> @@ -41,7 +41,6 @@ static int cdns_plat_pcie_probe(struct platform_device =
*pdev)
>  	struct pci_host_bridge *bridge;
>  	struct cdns_pcie_ep *ep;
>  	struct cdns_pcie_rc *rc;
> -	int phy_count;
>  	bool is_rc;
>  	int ret;

In cdns_plat_pcie_probe(), the driver data is initialized to point to a
struct cdns_plat_pcie object:

	cdns_plat_pcie =3D devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
	...
	platform_set_drvdata(pdev, cdns_plat_pcie);

However, in cdns_plat_pcie_shutdown(), the pointer is extracted and cast
directly to struct cdns_pcie *:

static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
{
	struct device *dev =3D &pdev->dev;
	struct cdns_pcie *pcie =3D dev_get_drvdata(dev);
	...
	cdns_pcie_disable_phy(pcie);
}

Since struct cdns_plat_pcie is only 8 bytes large, but the phy_count field
is at an offset of roughly 36 bytes in struct cdns_pcie, does this lead to
an out-of-bounds read and memory corruption when cdns_pcie_disable_phy()
attempts to iterate over the PHYs?

[ ... ]
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/cont=
roller/dwc/pci-keystone.c
> index fe4836925c4e3..cab9fad212add 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
[ ... ]
> @@ -1337,25 +1321,18 @@ static int ks_pcie_probe(struct platform_device *=
pdev)
>  	pm_runtime_disable(dev);
>  	ks_pcie_disable_phy(ks_pcie);
> =20
> -err_link:
> -	while (--i >=3D 0 && link[i])
> -		device_link_del(link[i]);
> -
> +err:
>  	return ret;
>  }
> =20
>  static void ks_pcie_remove(struct platform_device *pdev)
>  {
>  	struct keystone_pcie *ks_pcie =3D platform_get_drvdata(pdev);
> -	struct device_link **link =3D ks_pcie->link;
> -	int num_lanes =3D ks_pcie->num_lanes;
>  	struct device *dev =3D &pdev->dev;
> =20
>  	pm_runtime_put(dev);
>  	pm_runtime_disable(dev);

Does calling pm_runtime_put() immediately before pm_runtime_disable() cancel
the suspend transition?

pm_runtime_put() queues an asynchronous idle or suspend work item, but
calling pm_runtime_disable() immediately afterward cancels this pending
transition via __pm_runtime_barrier().

Could this leave the hardware in an active or incorrect power state from
the controller's perspective? Would it be safer to use synchronous
pm_runtime_put_sync() instead?

This asynchronous put pattern also appears in the error paths of
dra7xx_pcie_probe() and ks_pcie_probe().

While reviewing the power management handling in these drivers, I also
noticed that the shared interrupt handlers read hardware registers directly
without verifying if the device is active:

drivers/pci/controller/dwc/pci-dra7xx.c:dra7xx_pcie_irq_handler() {
	...
	reg =3D dra7xx_pcie_readl(dra7xx, PCIECTRL_DRA7XX_CONF_IRQSTATUS_MAIN);

If another device sharing the same IRQ line triggers an interrupt while the
PCIe controller is runtime suspended, will these handlers attempt to read
powered-down hardware?

Should the handlers check the PM runtime state using
pm_runtime_get_if_active() to prevent spurious interrupts or bus errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260505100523.1922=
388-1-vladimir.oltean@nxp.com?part=3D9
