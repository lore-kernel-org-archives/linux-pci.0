Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A844A713
	for <linux-pci@vger.kernel.org>; Thu,  7 May 2026 15:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169022; cv=none; b=YfkTsSNREHZzyhx81CH+RfZJ3w0iCEFn5vxVUYo+HYpfcpcoJzFATpAxRa01DtQ6rJmdqM/yn4KC98oalBUiwRJuqgTqr3B0ZfrUevwGjykd7W828vqemvCnOAZWFTsKdjhIQA/NXZYpUgfezlz9iMApqLY9+TId9bqw4mgJN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169022; c=relaxed/simple;
	bh=cui2tLvF7Ivcas9vbvzP8+1b/LA3bYCTQeeA1JNC8UA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CYpNrjfWIwm3TXxUo4iRkEHWR204wB9v9H0NJV2kmHO16gfLiMmodldXj4iFSu5pSs0tkTeh4pQeE/qY9+64947RCRddPah+Kn0N4FPDekNgIZWcL3rOLHE7Pltz8amKRnOQ6VIzD5OWG7cF4b7/4E9uNCvQWfHY2JI0yZbvGz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTGw8R6f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTGw8R6f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39450C2BCB2;
	Thu,  7 May 2026 15:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778169022;
	bh=cui2tLvF7Ivcas9vbvzP8+1b/LA3bYCTQeeA1JNC8UA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sTGw8R6fkmWpFx/YozYv4CWcfHAwVTdunyID+wTg2W4KsKFpNOBeRcRWTiBx/oZGB
	 j1KJ+Dh6j7oyuR1zHrud+25X1qzAtXZVNEmCqc2xVGi8hwkZnuU5YeCO4LdLALhsGY
	 N8Laxkt/0jEF0u+AfODbNA5AkQo2cThlN8e4XrB+UYxW23g09wHm14LQ6x+EqrpUAv
	 HziDIdGzYQ/Hjf4RtZ7YFrDFSsm0rgHL/ZFeuGBWBX7BePxFYprEXY6JiyexmB8PJu
	 /mICHZlN7wNdA79Wug22HaSzSUhLL3LahIrdx/k/hpX//MUkw9/YNGdWsya0wCQAS4
	 NVJEVHiMRekow==
Date: Thu, 7 May 2026 10:50:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manikandan K Pillai <mpillai@cadence.com>,
	Hans Zhang <hans.zhang@cixtech.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-pci@vger.kernel.org,
	wsa+renesas@sang-engineering.com
Subject: Re: [PATCH v8 phy-next 01/31] PCI: cadence: Preserve all error codes
 in cdns_plat_pcie_probe()
Message-ID: <20260507155021.GA972248@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507075957.B787EC2BCB8@smtp.kernel.org>

[+to Manikandan, Hans]

On Thu, May 07, 2026 at 07:59:57AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Type confusion in `cdns_plat_pcie_shutdown()` and PM callbacks causes an out-of-bounds read and kernel crash during system shutdown or suspend.
> - [High] Missing driver `.remove` callback causes severe Use-After-Free and resource leaks upon driver unbind.

Unrelated to Vladimir's patch, but please take a look and see if
we need other changes.

> --
> 
> commit 0bab3a01514eb340ef73b1b934e9dc310bdbfcda
> Author: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> PCI: cadence: Preserve all error codes in cdns_plat_pcie_probe()
> 
> This commit updates the error path in cdns_plat_pcie_probe() to ensure that
> errors from functions like pm_runtime_get_sync() and cdns_pcie_host_setup()
> are properly propagated instead of incorrectly returning success.
> 
> > --- a/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > +++ b/drivers/pci/controller/cadence/pcie-cadence-plat.c
> > @@ -126,7 +126,7 @@ static int cdns_plat_pcie_probe(struct platform_device *pdev)
> >  	while (phy_count--)
> >  		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
> >  
> > -	return 0;
> > +	return ret;
> >  }
> 
> I noticed a potential issue here that predates this patch.
> 
> This driver does not appear to have a .remove callback, nor does it set
> .suppress_bind_attrs = true. If the driver is unbound via sysfs, devres will
> clean up managed allocations like the host bridge, EPC structs, and
> struct cdns_pcie memory.
> 
> However, without a remove callback to call cdns_pcie_host_disable(), does the
> PCI core subsystem remain unaware that the host bridge was removed?
> 
> Could this lead to a use-after-free if the PCI core continues to access the
> freed bridge structure and memory-mapped I/O regions?
> 
> A related leak of PHY device links was noted as fixed by a later commit in
> this series (PCI: Remove device links to PHY), but it appears the missing
> root bus teardown remains unfixed.
> 
> >  
> >  static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
> 
> I also noticed another pre-existing issue related to this function.
> 
> In cdns_plat_pcie_probe(), the platform device's driver data is set to a
> struct cdns_plat_pcie pointer:
> 
> cdns_plat_pcie_probe()
>     cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
>     ...
>     platform_set_drvdata(pdev, cdns_plat_pcie);
> 
> However, cdns_plat_pcie_shutdown() retrieves this and casts it directly to a
> struct cdns_pcie pointer:
> 
> cdns_plat_pcie_shutdown()
>     struct cdns_pcie *pcie = dev_get_drvdata(dev);
>     ...
>     cdns_pcie_disable_phy(pcie);
> 
> Since struct cdns_plat_pcie is just a wrapper containing a pointer to the
> actual struct cdns_pcie, does this incorrect cast cause an out-of-bounds
> read when cdns_pcie_disable_phy() attempts to access pcie->phy_count and
> iterate over the PHY pointers?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260505100523.1922388-1-vladimir.oltean@nxp.com?part=1
