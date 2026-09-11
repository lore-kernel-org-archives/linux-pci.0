Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17B3442384;
	Fri, 11 Sep 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154085; cv=none; b=CH5nbEWNFfZl2wQkyqmuAwtwtsPUy6s5lcZQbxFUj9yTf7jnDR6YHUaigRB8ifxcI3IktXwawEqGZwGEFDOeOeGcQp441jZ5uUzGp3sXcEnDmBUXm/xjSyPM+kr99gsbWBbYNeQg2buFUxb1cnXRh5EH75WBShi9L1sqvhCh3UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154085; c=relaxed/simple;
	bh=dpc7anxfP2ZPPTeVcg35RlsGI7X0Ls2XyqXjTybPouY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=uJrjWtqzWViyLqSiMklWvdSyFk93Z9wLdGc7wuMpuCpg4oiN8vdV9LkTplUNrWTt42cLqMhMhHh4LBYLxblaUM9s3AnXDeTAAfUgQF0kDfJcRVilJa8IKUcL8Izm/qUuZQ3+bky7qmToq1igewAAklRXxukELk2W+U/z01qfylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEalvI/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEalvI/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5731F000FF;
	Fri, 11 Sep 2026 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789154070;
	bh=6dBTiX4xAO3JV4ryYMi2B6agwtg8EoTxOEevYmBg6jY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=KEalvI/2bEBdkDuKN4fDoYIKLX7rAzEfZt8bke8EBvHnfyzM7P2NknWBSV2RDem7Q
	 nhaUbLczJcFxoJ2dWu9IENtTm3GibRW0LJjdgS+08etBmUihh9/mu3OrOuss+dmBk8
	 5ywqAybM2Oes8BjZDd5OendLHvt7KVyTiPdnapbIF1HjYXhC8LMf/lmyuJx3wKgJSz
	 94NeaGgX75Ry5f+8KjxF/nthw1h2JoGfRDyarbp7DU2eXY4rvxW+Ai+7oVxL22fjW2
	 zbE261wRJJnNpV/wDW8to41BavEmjVlRTfgeYlESIwNN6TDpN/5HpdiHXEyQVKoou6
	 8bRA/EtABB+QA==
Date: Fri, 11 Sep 2026 14:14:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, florian.fainelli@broadcom.com, arnd@arndb.de,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH v3] PCI: iproc: Use the EROM outbound window on BCMA
Message-ID: <20260911191429.GA549927@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260807160526.379-1-strst.gs@gmail.com>

[+to Rafał; probably same as rafal@milecki.pl, but MAINTAINERS lists
zajec5@gmail.com for BCMA]

On Fri, Aug 07, 2026 at 07:05:26PM +0300, Semih Baskan wrote:
> The PCIe outbound window base on Northstar depends on the PCIe Gen2 core
> revision. Revision 0x01 uses 0x08000000, 0x40000000 and 0x48000000 for
> controllers 0 to 2, while revision 0x07 (NS-B0) uses 0x08000000,
> 0x20000000 and 0x28000000. Broadcom's own driver branches on the core
> revision for exactly this reason.
> 
> bcm-ns.dtsi is shared by every Northstar SoC, so it cannot carry a value
> that is correct on both. Commit 767012397976 ("ARM: dts: BCM5301X:
> Describe PCIe controllers fully") gave the controllers a ranges property.
> The commit shipped in v7.1.
> 
> With that property present, two things go wrong with this driver:
> 
>  - devm_pci_alloc_host_bridge() parses those ranges and requests them,
>    then this driver adds its own window and requests the whole list a
>    second time, so every controller fails to probe with -EBUSY.
> 
>  - The DT window itself is only correct on core revision 0x07. On
>    revision 0x01 it points at an address the hardware does not decode,
>    and the first MMIO access to a BAR takes an imprecise external
>    abort.
> 
> The enumeration ROM reports the correct base for the revision actually
> present, and bcma already provides it as addr_s[0]. Drop any memory
> window that came from the device tree and use that instead, requesting
> only the window this driver owns. This makes the driver correct whether
> or not the DT describes a window.
> 
> When a dropped window does not match what the EROM reports, print a
> warning naming both. The mismatch means the devicetree describes a
> window the hardware does not decode, and that should be fixed in the
> dts rather than ignored silently.
> 
> The same commit also added compatible = "brcm,iproc-pcie", so these
> nodes now match pcie-iproc-platform. With CONFIG_PCIE_IPROC_PLATFORM
> enabled, which is the default on ARCH_BCM_IPROC, that driver binds them
> first and this driver's probe fails inside devm_pci_alloc_host_bridge().
> This patch fixes the configurations where the BCMA driver is the one in
> use; OpenWrt builds that way, with PCIE_IPROC_PLATFORM disabled. The
> platform path takes the DT window as-is and has the same wrong address
> on core revision 0x01, so that side needs a devicetree fix either way.
> 
> Tested on an ASUS RT-N18U (BCM47081) and a Linksys EA9200 (BCM4709),
> both core revision 0x01.
> 
> Fixes: 767012397976 ("ARM: dts: BCM5301X: Describe PCIe controllers fully")
> Tested-by: Rani Hod <rani.hod@gmail.com>
> Cc: stable@vger.kernel.org # v7.1+
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---
> v2 -> v3: format the two problem descriptions as bullet points.
> Requested by Bjorn Helgaas.
> 
> v1 -> v2: print a warning for every devicetree memory window that does
> not match the EROM window. Requested by Arnd Bergmann:
> https://lore.kernel.org/all/d05ffeca-f289-42dd-b454-5a7c7741c6d5@app.fastmail.com/
> 
> v2: https://lore.kernel.org/all/20260807035726.387-1-strst.gs@gmail.com/
> v1: https://lore.kernel.org/all/20260727140939.389-1-strst.gs@gmail.com/
> 
>  drivers/pci/controller/pcie-iproc-bcma.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index 593418c2b..06a471f4a 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -36,6 +36,7 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  	struct device *dev = &bdev->dev;
>  	struct iproc_pcie *pcie;
>  	struct pci_host_bridge *bridge;
> +	struct resource_entry *win, *tmp;
>  	int ret;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> @@ -59,8 +60,22 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
>  	pcie->mem.name = "PCIe MEM space";
>  	pcie->mem.flags = IORESOURCE_MEM;
> +
> +	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
> +		if (resource_type(win->res) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (win->res->start != pcie->mem.start ||
> +		    win->res->end != pcie->mem.end)
> +			dev_warn(dev, "DT window %pR does not match EROM window %pR, using EROM\n",
> +				 win->res, &pcie->mem);
> +
> +		devm_release_resource(dev, win->res);
> +		resource_list_destroy_entry(win);
> +	}
> +
>  	pci_add_resource(&bridge->windows, &pcie->mem);
> -	ret = devm_request_pci_bus_resources(dev, &bridge->windows);
> +	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);

If the EROM supplies the information the driver needs, why does this
BCMA driver use DT at all?

AFAICS, pcie-iproc-bcma.c doesn't use any of the information from DT.
devm_pci_alloc_host_bridge() *looks* in DT, parses it, and fills in
bridge->windows, and requests those windows, but I don't think
iproc-bcma ever uses them.

iproc_bcma_pcie_probe() passes &bridge->windows to iproc_pcie_setup(),
where I think it's ignored because pcie->need_ob_cfg is never set for
iproc_bcma.

It looks like iproc_bcma_pcie_probe() should just call
pci_alloc_host_bridge() directly and skip devm_pci_alloc_host_bridge()
and the DT things it does.

>  	if (ret)
>  		return ret;
>  
> -- 
> 2.43.0
> 
