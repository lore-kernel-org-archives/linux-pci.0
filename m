Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([119.145.14.64]:57236 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755325Ab2KAMzQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 1 Nov 2012 08:55:16 -0400
Message-ID: <509270D2.7060505@huawei.com>
Date: Thu, 1 Nov 2012 20:53:38 +0800
From: Jiang Liu <jiang.liu@huawei.com>
MIME-Version: 1.0
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<wangyijing@huawei.com>, Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Fix regression introduced by commit 2dcfaf85
References: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com>
In-Reply-To: <20121031095148.75dbb6e8.izumi.taku@jp.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-1"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Taku,
	It's a mistake introduced by that patch, thanks for fix it.
	Reviewed-by: <jiang.liu@huawei.com>

On 2012-10-31 8:51, Taku Izumi wrote:
> 
> PCI/portdrv: Fix regression introduced by commit 2dcfaf85
> 
> After commit 2dcfaf85, hotplug slots for port devices 
> w/o slot implementation come to be created.  
> This patch fixes this problem.
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/pci/pcie/portdrv_core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Index: pci/drivers/pci/pcie/portdrv_core.c
> ===================================================================
> --- pci.orig/drivers/pci/pcie/portdrv_core.c
> +++ pci/drivers/pci/pcie/portdrv_core.c
> @@ -272,7 +272,8 @@ static int get_port_device_capability(st
>  	}
>  
>  	/* Hot-Plug Capable */
> -	if (cap_mask & PCIE_PORT_SERVICE_HP) {
> +	if ((cap_mask & PCIE_PORT_SERVICE_HP) &&
> +	    dev->pcie_flags_reg & PCI_EXP_FLAGS_SLOT) {
>  		pcie_capability_read_dword(dev, PCI_EXP_SLTCAP, &reg32);
>  		if (reg32 & PCI_EXP_SLTCAP_HPC) {
>  			services |= PCIE_PORT_SERVICE_HP;
> 
> 
> 


