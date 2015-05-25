Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:18659 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751503AbbEYBpv (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Sun, 24 May 2015 21:45:51 -0400
Message-ID: <55627DE2.3090902@huawei.com>
Date: Mon, 25 May 2015 09:41:54 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
CC: Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] PCI/ASPM: Drop __pci_disable_link_state() useless "force"
 parameter
References: <20150522145807.27123.6007.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150522145807.27123.6007.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2015/5/22 22:58, Bjorn Helgaas wrote:
> After 387d37577fdd ("PCI: Don't clear ASPM bits when the FADT declares it's
> unsupported"), the "force" parameter to __pci_disable_link_state() is
> always "false".
> 
> Remove the "force" parameter and assume it's always false.

It looks good to me.

> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pcie/aspm.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7d4fcdc..f90d8f2 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -714,8 +714,7 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  	up_read(&pci_bus_sem);
>  }
>  
> -static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
> -				     bool force)
> +static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  {
>  	struct pci_dev *parent = pdev->bus->self;
>  	struct pcie_link_state *link;
> @@ -737,7 +736,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
>  	 * a similar mechanism using "PciASPMOptOut", which is also
>  	 * ignored in this situation.
>  	 */
> -	if (aspm_disabled && !force) {
> +	if (aspm_disabled) {
>  		dev_warn(&pdev->dev, "can't disable ASPM; OS doesn't have ASPM control\n");
>  		return;
>  	}
> @@ -763,7 +762,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
>  
>  void pci_disable_link_state_locked(struct pci_dev *pdev, int state)
>  {
> -	__pci_disable_link_state(pdev, state, false, false);
> +	__pci_disable_link_state(pdev, state, false);
>  }
>  EXPORT_SYMBOL(pci_disable_link_state_locked);
>  
> @@ -778,7 +777,7 @@ EXPORT_SYMBOL(pci_disable_link_state_locked);
>   */
>  void pci_disable_link_state(struct pci_dev *pdev, int state)
>  {
> -	__pci_disable_link_state(pdev, state, true, false);
> +	__pci_disable_link_state(pdev, state, true);
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> 
> 
> 


-- 
Thanks!
Yijing

