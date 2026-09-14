Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D583783AE;
	Mon, 14 Sep 2026 17:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407987; cv=none; b=X2kT7AkvPauFrvpqeoPrp5F6pNm6wnuVsIAgMakGEu8YdipNwW5c1YzKwPyRF450mMJ3OQOXnLiLeQNcTZ/mhbAlGfgwDkTsm3LAVKn0DPvFBzUIqxSqvDYQy4EkGllF1RmP+24Jg+RbtvDUKaE7XWu9u3YZ3ADCtSpjUmEJy9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407987; c=relaxed/simple;
	bh=RfKrz7CyP3GicS52QqoYXEjJmcZ5ic6b/2deXmQxvH8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Rb0MpEMZcA7OHpDeLrC6wy0vh8EOnB8dVzysXgcztCh4zvEf7FsI+LaizlQnZhUw783cElJMmoPzXV9TxoAF8DDZ13IHibJ3NvU/L7dhrEX3mKmpjbBPWbm605wsuYInUd5BCUGOoiAyINihyXwtqV/Q+uidWMroDEPHXxAukD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQmv95H3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQmv95H3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E70A81F00893;
	Mon, 14 Sep 2026 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789407986;
	bh=KIjWZGGoWZh0gZK4ApT5Yval8mzow5gEXpN2tX1ePnY=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=YQmv95H3YsARO8qaQe5b7dlcwzOkk0A/A3g51g80aGctxQnpLb8B6lPOT+J0yL2dh
	 8/kh/3VRlWa+wAGzPiVOCKF28bfUB6DO3JQ2BaBadudpD1Yim1tBSbXTjlp9f1hk8y
	 W9yaxlsbctS3QTEuMCTnIqx6NFoU5ZWtFOHxkd3bgAjBTxlR1IyCVl5dIKipxfLoDJ
	 K1oOTJhMae7WJZ882ToVTaMu3HSvpvg1SHV5uYi1j09Yf5ke3w3RqNM5Qd6kvpPdro
	 pn3VUknEpaXcri11QODui+5g+n/x3DDKfItERPxoIdSnr+dbuGoKzb7UsFoiwzIQ/T
	 BcUIxcBi4zl0w==
Date: Mon, 14 Sep 2026 12:46:24 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Semih Baskan <strst.gs@gmail.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	rafal@milecki.pl, zajec5@gmail.com, florian.fainelli@broadcom.com,
	arnd@arndb.de, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	rosenp@gmail.com, rani.hod@gmail.com
Subject: Re: [PATCH] PCI: iproc: Use pci_alloc_host_bridge() on BCMA
Message-ID: <20260914174624.GA663242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912043626.437-1-strst.gs@gmail.com>

On Sat, Sep 12, 2026 at 07:36:26AM +0300, Semih Baskan wrote:
> The BCMA driver takes its register base and, since commit 552aa843e4c5
> ("PCI: iproc: Use the EROM outbound window on BCMA"), its outbound
> window from what bcma read out of the enumeration ROM. It still
> allocates its host bridge with devm_pci_alloc_host_bridge(), which since
> commit 669cbc708122 ("PCI: Move DT resource setup into
> devm_pci_alloc_host_bridge()") parses ranges, dma-ranges and bus-range
> from the device's OF node and requests the windows it finds. None of
> that reaches the hardware here: need_ob_cfg is only ever set by the
> platform driver, so iproc_pcie_setup() never maps the parsed windows,
> and the EROM commit above had to throw them away again to keep them
> from colliding with its own window.
> 
> Allocate the bridge with pci_alloc_host_bridge() instead, so nothing
> from the devicetree is requested or handed to the PCI core, and free it
> on the error paths and in remove(). The driver now sets
> bridge->dev.parent itself, as devm_pci_alloc_host_bridge() did, since
> the wifi nodes under pcie_bridge0 in bcm4709-netgear-r8000.dts are
> resolved through the root bus. The window request
> moves from devm to request_resource() and release_resource() because
> the resource lives inside the bridge allocation and has to be released
> before the bridge is freed.
> 
> The ranges property is still read, but only to compare. bcm-ns.dtsi
> describes the same window for the platform driver, and on core revision
> 0x01 it points at an address the hardware does not decode. The warning
> from the EROM commit stays for that reason: a wrong dts is visible on
> BCMA boots, where nothing else would show it. Without bus-range the
> root bus also logs "No busn resource found for root bus, will use
> [bus 00-ff]" again, which changes nothing else.
> 
> With PCIE_IPROC_PLATFORM and PCIE_IPROC_BCMA both enabled, the platform
> driver binds the same nodes first and claims the devicetree window. On
> core revision 0x07 that is the EROM window, so this driver's request
> still fails and the probe backs out as before. On revision 0x01 the
> devicetree window is elsewhere, so this driver now probes as well, next
> to a platform driver instance whose window the hardware does not decode.
> That instance does not work either; the only difference is that the
> second probe is no longer stopped by the collision.

I guess this goes back to 767012397976 ("ARM: dts: BCM5301X: Describe
PCIe controllers fully"), but I'm confused about this.  Why are two
incompatible devices (rev 0x01 and 0x07) described with the same DT
with address ranges that are wrong for rev 0x01?  I thought DT was
supposed to be matched with the hardware in the box?

And I guess I missed this part about the platform and the bcma drivers
both trying to claim the same device.  That seems like something that
should be solved somewhere in the bus drivers (platform, bcma), not in
pcie-iproc-bcma.c and pcie-iproc-platform.c.

Why is this not a problem for other BCMA devices (bgmac_bcma_driver,
b43_bcma_driver, brcms_bcma_driver, bcma_hcd_driver)?

Is this another consequence of using a DT that describes
"brcm,iproc-pcie" controllers that don't match the hardware?  Why
don't we have different DTs for these two kinds of hardware?

> Tested on an ASUS RT-N18U (BCM47081, core revision 0x01): the warning
> lines are identical to the applied version, /proc/iomem and the
> enumerated devices are unchanged.
> 
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Link: https://lore.kernel.org/r/20260911191429.GA549927@bhelgaas/
> Signed-off-by: Semih Baskan <strst.gs@gmail.com>
> ---
>  drivers/pci/controller/pcie-iproc-bcma.c | 70 +++++++++++++++++-------
>  1 file changed, 49 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-iproc-bcma.c b/drivers/pci/controller/pcie-iproc-bcma.c
> index 06a471f4a..fcae83ed5 100644
> --- a/drivers/pci/controller/pcie-iproc-bcma.c
> +++ b/drivers/pci/controller/pcie-iproc-bcma.c
> @@ -11,6 +11,7 @@
>  #include <linux/phy/phy.h>
>  #include <linux/bcma/bcma.h>
>  #include <linux/ioport.h>
> +#include <linux/of_address.h>
>  
>  #include "pcie-iproc.h"
>  
> @@ -31,18 +32,42 @@ static int iproc_bcma_pcie_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
>  	return bcma_core_irq(bdev, 5);
>  }
>  
> +static void iproc_bcma_pcie_check_dt_window(struct iproc_pcie *pcie)
> +{
> +	struct device_node *np = pcie->dev->of_node;
> +	struct of_pci_range_parser parser;
> +	struct of_pci_range range;
> +	struct resource res;
> +
> +	if (!np || of_pci_range_parser_init(&parser, np))
> +		return;
> +
> +	for_each_of_pci_range(&parser, &range) {
> +		if ((range.flags & IORESOURCE_TYPE_BITS) != IORESOURCE_MEM)
> +			continue;
> +
> +		if (of_pci_range_to_resource(&range, np, &res))
> +			continue;
> +
> +		if (res.start != pcie->mem.start || res.end != pcie->mem.end)
> +			dev_warn(pcie->dev, "DT window %pR does not match EROM window %pR, using EROM\n",
> +				 &res, &pcie->mem);
> +	}
> +}
> +
>  static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  {
>  	struct device *dev = &bdev->dev;
>  	struct iproc_pcie *pcie;
>  	struct pci_host_bridge *bridge;
> -	struct resource_entry *win, *tmp;
>  	int ret;
>  
> -	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
> +	bridge = pci_alloc_host_bridge(sizeof(*pcie));
>  	if (!bridge)
>  		return -ENOMEM;
>  
> +	bridge->dev.parent = dev;
> +
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> @@ -51,7 +76,8 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  	pcie->base = bdev->io_addr;
>  	if (!pcie->base) {
>  		dev_err(dev, "no controller registers\n");
> -		return -ENOMEM;
> +		ret = -ENOMEM;
> +		goto err_free_bridge;
>  	}
>  
>  	pcie->base_addr = bdev->addr;
> @@ -60,37 +86,39 @@ static int iproc_bcma_pcie_probe(struct bcma_device *bdev)
>  	pcie->mem.end = bdev->addr_s[0] + SZ_128M - 1;
>  	pcie->mem.name = "PCIe MEM space";
>  	pcie->mem.flags = IORESOURCE_MEM;
> -
> -	resource_list_for_each_entry_safe(win, tmp, &bridge->windows) {
> -		if (resource_type(win->res) != IORESOURCE_MEM)
> -			continue;
> -
> -		if (win->res->start != pcie->mem.start ||
> -		    win->res->end != pcie->mem.end)
> -			dev_warn(dev, "DT window %pR does not match EROM window %pR, using EROM\n",
> -				 win->res, &pcie->mem);
> -
> -		devm_release_resource(dev, win->res);
> -		resource_list_destroy_entry(win);
> -	}
> -
> +	iproc_bcma_pcie_check_dt_window(pcie);
>  	pci_add_resource(&bridge->windows, &pcie->mem);
> -	ret = devm_request_resource(dev, &iomem_resource, &pcie->mem);
> -	if (ret)
> -		return ret;
> +	ret = request_resource(&iomem_resource, &pcie->mem);
> +	if (ret) {
> +		dev_err(dev, "can't claim %pR\n", &pcie->mem);
> +		goto err_free_bridge;
> +	}
>  
>  	bridge->map_irq = iproc_bcma_pcie_map_irq;
>  
>  	bcma_set_drvdata(bdev, pcie);
>  
> -	return iproc_pcie_setup(pcie, &bridge->windows);
> +	ret = iproc_pcie_setup(pcie, &bridge->windows);
> +	if (ret)
> +		goto err_release_mem;
> +
> +	return 0;
> +
> +err_release_mem:
> +	release_resource(&pcie->mem);
> +err_free_bridge:
> +	pci_free_host_bridge(bridge);
> +	return ret;
>  }
>  
>  static void iproc_bcma_pcie_remove(struct bcma_device *bdev)
>  {
>  	struct iproc_pcie *pcie = bcma_get_drvdata(bdev);
> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
>  
>  	iproc_pcie_remove(pcie);
> +	release_resource(&pcie->mem);
> +	pci_free_host_bridge(bridge);
>  }
>  
>  static const struct bcma_device_id iproc_bcma_pcie_table[] = {
> -- 
> 2.43.0
> 
