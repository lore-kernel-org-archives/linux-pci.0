Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36094 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbbEZX6q (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 19:58:46 -0400
Received: by igbpi8 with SMTP id pi8so71777042igb.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 16:58:46 -0700 (PDT)
Date: Tue, 26 May 2015 18:58:42 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: linux-pci@vger.kernel.org
Cc: Yijing Wang <wangyijing@huawei.com>,
	Matthew Garrett <mjg59@coreos.com>
Subject: Re: [PATCH] PCI/ASPM: Drop __pci_disable_link_state() useless
 "force" parameter
Message-ID: <20150526235842.GQ32152@google.com>
References: <20150522145807.27123.6007.stgit@bhelgaas-glaptop2.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522145807.27123.6007.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 22, 2015 at 09:58:08AM -0500, Bjorn Helgaas wrote:
> After 387d37577fdd ("PCI: Don't clear ASPM bits when the FADT declares it's
> unsupported"), the "force" parameter to __pci_disable_link_state() is
> always "false".
> 
> Remove the "force" parameter and assume it's always false.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied to pci/aspm for v4.2.

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
