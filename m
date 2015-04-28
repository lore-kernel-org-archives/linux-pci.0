Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58375 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbD1IPV (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 04:15:21 -0400
Message-ID: <1430208910.3428.15.camel@pengutronix.de>
Subject: Re: [PATCH Part1 v11 3/5] PCI: designware: Use pci_scan_root_bus()
 for simplicity
From: Lucas Stach <l.stach@pengutronix.de>
To: Yijing Wang <wangyijing@huawei.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-pci@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>,
	Mohit Kumar <mohit.kumar@st.com>,
	linux-arm-kernel@lists.infradead.org, dja@axtens.net
Date: Tue, 28 Apr 2015 10:15:10 +0200
In-Reply-To: <1430204499-19571-4-git-send-email-wangyijing@huawei.com>
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com>
	 <1430204499-19571-4-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Dienstag, den 28.04.2015, 15:01 +0800 schrieb Yijing Wang:
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

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

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

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |

