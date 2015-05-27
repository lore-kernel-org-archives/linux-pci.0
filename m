Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34757 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751472AbbE0AMx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 20:12:53 -0400
Received: by igbhj9 with SMTP id hj9so74120254igb.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 17:12:53 -0700 (PDT)
Date: Tue, 26 May 2015 19:12:46 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, dja@axtens.net,
	Arnd Bergmann <arnd@arndb.de>,
	linux-arm-kernel@lists.infradead.org,
	Mohit Kumar <mohit.kumar@st.com>,
	Jingoo Han <jg1.han@samsung.com>,
	Pratyush Anand <pratyush.anand@gmail.com>
Subject: Re: [PATCH Part1 v11 3/5] PCI: designware: Use pci_scan_root_bus()
 for simplicity
Message-ID: <20150527001246.GT32152@google.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
 <1430204499-19571-4-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1430204499-19571-4-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc Pratyush]

On Tue, Apr 28, 2015 at 03:01:37PM +0800, Yijing Wang wrote:
> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> Now pci_scan_root_bus() == pci_create_root_bus() +
> pci_scan_child_bus() if busn resource is supplied.
> Designware added the busn resource to resources list
> in dw_pcie_setup(). So it should be safe to use
> pci_scan_root_bus() instead.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Mohit Kumar <mohit.kumar@st.com>
> CC: Jingoo Han <jg1.han@samsung.com>

Jingoo, Pratyush?

> ---
>  drivers/pci/host/pcie-designware.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-designware.c b/drivers/pci/host/pcie-designware.c
> index 2e9f84f..8c80f38 100644
> --- a/drivers/pci/host/pcie-designware.c
> +++ b/drivers/pci/host/pcie-designware.c
> @@ -728,13 +728,11 @@ static struct pci_bus *dw_pcie_scan_bus(int nr, struct pci_sys_data *sys)
>  	struct pcie_port *pp = sys_to_pcie(sys);
>  
>  	pp->root_bus_nr = sys->busnr;
> -	bus = pci_create_root_bus(pp->dev, sys->busnr,
> +	bus = pci_scan_root_bus(pp->dev, sys->busnr,
>  				  &dw_pcie_ops, sys, &sys->resources);
>  	if (!bus)
>  		return NULL;
>  
> -	pci_scan_child_bus(bus);
> -
>  	if (bus && pp->ops->scan_bus)
>  		pp->ops->scan_bus(pp);
>  
> -- 
> 1.7.1
> 
