Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:38703 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448AbbETTtC (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2015 15:49:02 -0400
Received: by igcau1 with SMTP id au1so48395734igc.1
        for <linux-pci@vger.kernel.org>; Wed, 20 May 2015 12:49:01 -0700 (PDT)
Date: Wed, 20 May 2015 14:48:58 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mjg59@coreos.com, rwhite@pobox.com,
	alex.williamson@redhat.com
Subject: Re: [PATCH] PCI/ASPM: Remove redundant checking for pcie port type
Message-ID: <20150520194858.GA32152@google.com>
References: <1432006894-12203-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432006894-12203-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, May 19, 2015 at 11:41:34AM +0800, Yijing Wang wrote:
> Only pcie root port or downstream port would allocate
> a pcie_link_state when call alloc_pcie_link_state() in
> pcie_aspm_init_link_state(). So when call another ASPM
> functions to configure pcie_link_state, checking
> pdev->link_state is enough, it's no need to check pcie
> port type again in these functions.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

This is excellent simplification!  Applied to pci/aspm for v4.2, thanks!

> ---
>  drivers/pci/pcie/aspm.c |   19 ++++---------------
>  1 files changed, 4 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 8830740..16a1ffb 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -675,10 +675,7 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link = pdev->link_state;
>  
> -	if (aspm_disabled || !pci_is_pcie(pdev) || !link)
> -		return;
> -	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
> +	if (aspm_disabled || !link)
>  		return;
>  	/*
>  	 * Devices changed PM state, we should recheck if latency
> @@ -696,16 +693,12 @@ void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link = pdev->link_state;
>  
> -	if (aspm_disabled || !pci_is_pcie(pdev) || !link)
> +	if (aspm_disabled || !link)
>  		return;
>  
>  	if (aspm_policy != POLICY_POWERSAVE)
>  		return;
>  
> -	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM))
> -		return;
> -
>  	down_read(&pci_bus_sem);
>  	mutex_lock(&aspm_lock);
>  	pcie_config_aspm_path(link);
> @@ -906,9 +899,7 @@ void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link_state = pdev->link_state;
>  
> -	if (!pci_is_pcie(pdev) ||
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
> -	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM) || !link_state)
> +	if (!link_state)
>  		return;
>  
>  	if (link_state->aspm_support)
> @@ -923,9 +914,7 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>  {
>  	struct pcie_link_state *link_state = pdev->link_state;
>  
> -	if (!pci_is_pcie(pdev) ||
> -	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
> -	     pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM) || !link_state)
> +	if (!link_state)
>  		return;
>  
>  	if (link_state->aspm_support)
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
