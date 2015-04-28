Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:27588 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030288AbbD1QiR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2015 12:38:17 -0400
Message-ID: <553FB772.1000202@broadcom.com>
Date: Tue, 28 Apr 2015 09:38:10 -0700
From: Ray Jui <rjui@broadcom.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <dja@axtens.net>,
	Arnd Bergmann <arnd@arndb.de>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH Part1 v11 5/5] PCI: iproc: Use pci_scan_root_bus() instead
 of pci_create_root_bus()
References: <1430204499-19571-1-git-send-email-wangyijing@huawei.com> <1430204499-19571-6-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1430204499-19571-6-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>


Hi Yijing,

On 4/28/2015 12:01 AM, Yijing Wang wrote:
> Pci_bus_add_devices() was ripped out of pci_scan_root_bus().
> Now pci_scan_root_bus() == pci_create_root_bus() +
> pci_scan_child_bus() if busn resource is supplied.
> iproc added the busn resource to resources list
> in of_pci_get_host_bridge_resources(). So it should be safe
> to use pci_scan_root_bus() instead.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> CC: Ray Jui <rjui@broadcom.com>
> ---
>  drivers/pci/host/pcie-iproc.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/host/pcie-iproc.c b/drivers/pci/host/pcie-iproc.c
> index 329e1b5..9622ebf 100644
> --- a/drivers/pci/host/pcie-iproc.c
> +++ b/drivers/pci/host/pcie-iproc.c
> @@ -210,10 +210,10 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  
>  	pcie->sysdata.private_data = pcie;
>  
> -	bus = pci_create_root_bus(pcie->dev, 0, &iproc_pcie_ops,
> +	bus = pci_scan_root_bus(pcie->dev, 0, &iproc_pcie_ops,
>  				  &pcie->sysdata, pcie->resources);
>  	if (!bus) {
> -		dev_err(pcie->dev, "unable to create PCI root bus\n");
> +		dev_err(pcie->dev, "unable to scan PCI root bus\n");
>  		ret = -ENOMEM;
>  		goto err_power_off_phy;
>  	}

iproc_pcie_check_link is called here by using the 'bus' structure
returned from pci_create_root_bus. In iproc_pcie_check_link, we
configure root bus class to PCI_CLASS_BRIDGE_PCI and validate to ensure
a stable link between RC and EP can be detected.

> @@ -227,7 +227,6 @@ int iproc_pcie_setup(struct iproc_pcie *pcie)
>  
>  	iproc_pcie_enable(pcie);

Here we enable INTx support for our RC controller.

>  
> -	pci_scan_child_bus(bus);

Here, if pci_scan_child_bus is moved to before iproc_pcie_check_link, I
don't think it would work (although I have not tested this).

An alternative is to use a dummy bus structure to feed into
iproc_pcie_check_link, and call iproc_pcie_check_link and
iproc_pcie_enable before pci_scan_root_bus. But the reason I put the
link check code in between pci_create_root_bus and pci_scan_child_bus
was to avoid using a dummy bus structure, :)

>  	pci_assign_unassigned_bus_resources(bus);
>  	pci_fixup_irqs(pci_common_swizzle, of_irq_parse_and_map_pci);
>  	pci_bus_add_devices(bus);
> 

Thanks,

Ray
