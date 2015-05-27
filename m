Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:38398 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753258AbbE0PsD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 May 2015 11:48:03 -0400
Received: by igbjd9 with SMTP id jd9so2031278igb.1
        for <linux-pci@vger.kernel.org>; Wed, 27 May 2015 08:48:01 -0700 (PDT)
Date: Wed, 27 May 2015 10:47:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, dja@axtens.net,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Tanmay Inamdar <tinamdar@apm.com>
Subject: Re: [PATCH Part1 v11 4/5] PCI: xgene: Use pci_scan_root_bus()
 instead of pci_create_root_bus()
Message-ID: <20150527154758.GU32152@google.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
 <1430204499-19571-5-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430204499-19571-5-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 28, 2015 at 03:01:38PM +0800, Yijing Wang wrote:
> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> Now pci_scan_root_bus() == pci_create_root_bus() +
> pci_scan_child_bus() if busn resource is supplied.
> Xgene added the busn resource to resources list
> in of_pci_get_host_bridge_resources(). So it should be safe
> to use pci_scan_root_bus() instead.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Tanmay Inamdar <tinamdar@apm.com>

Tanmay, any comments on this?

> ---
>  drivers/pci/host/pci-xgene.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-xgene.c b/drivers/pci/host/pci-xgene.c
> index ee082c0..87e3962 100644
> --- a/drivers/pci/host/pci-xgene.c
> +++ b/drivers/pci/host/pci-xgene.c
> @@ -499,12 +499,11 @@ static int xgene_pcie_probe_bridge(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	bus = pci_create_root_bus(&pdev->dev, 0,
> +	bus = pci_scan_root_bus(&pdev->dev, 0,
>  					&xgene_pcie_ops, port, &res);
>  	if (!bus)
>  		return -ENOMEM;
>  
> -	pci_scan_child_bus(bus);
>  	pci_assign_unassigned_bus_resources(bus);
>  	pci_bus_add_devices(bus);
>  
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
