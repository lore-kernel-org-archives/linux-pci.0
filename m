Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([119.145.14.66]:37549 "EHLO
	szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932313AbbENIfd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 14 May 2015 04:35:33 -0400
Message-ID: <55545D0E.3080802@huawei.com>
Date: Thu, 14 May 2015 16:30:06 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Yijing Wang <wangyijing@huawei.com>, <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <mjg59@coreos.com>,
	<rwhite@pobox.com>, <alex.williamson@redhat.com>
Subject: Re: [PATCH v2] PCI: Fix NULL pointer when find parent pcie_link_state
References: <1429858791-26331-1-git-send-email-wangyijing@huawei.com>
In-Reply-To: <1429858791-26331-1-git-send-email-wangyijing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Ping... ?

On 2015/4/24 14:59, Yijing Wang wrote:
> https://bugzilla.kernel.org/show_bug.cgi?id=94361 reported
> in ATCA platform, system had unusual pcie topology:
> 
> (root port)   (downstream port)   (upstream port)
> +-1c.0-[02-0a]----00.0-[03-0a]--+-00.0-[04]--
> |                               +-01.0-[05]-- (downstream port)
> |                               +-02.0-[06]--
> |                               +-03.0-[07]--
> |                               +-08.0-[08]--
> |                               +-09.0-[09]--
> |                               \-0a.0-[0a]--
> We assumed root port and downstream port always
> have external link, and downstream port always has a
> upstream port. So in this case, when we allocated
> pcie_link_state for downstream port 02:00.0, it try
> to get parent bus pcie_link_state,
> parent = pdev->bus->parent->self->link_state;
> because root bus self is NULL, system will crash here.
> 
> This patch fix this issue based on the following
> assumption suggested by Bjorn.
> 1. Root port is always on the upstream end of a link.
> 2. The pcie hierarchy should alternate between links
> and internal switch logic, there should be no adjacent
> links or internal buses in pcie tree.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>
> ---
>  drivers/pci/pcie/aspm.c |   23 +++++++++++++++++++++--
>  1 files changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7d4fcdc..61b9d3f 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -546,6 +546,25 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  	return link;
>  }
>  
> +/*
> + * We assume root port is always on the upstream end of
> + * a link, and the pcie hierarchy should alternate
> + * between links and internal switch logic.
> + */
> +static bool pcie_has_external_link(struct pci_dev *pdev)
> +{
> +	if (!pci_is_pcie(pdev))
> +		return false;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
> +		return true;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
> +		if (!pdev->bus->self->link_state)
> +			return true;
> +
> +	return false;
> +}
>  /*
>   * pcie_aspm_init_link_state: Initiate PCI express link state.
>   * It is called after the pcie and its children devices are scanned.
> @@ -561,8 +580,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  
>  	if (!pci_is_pcie(pdev) || pdev->link_state)
>  		return;
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> +
> +	if (!pcie_has_external_link(pdev))
>  		return;
>  
>  	/* VIA has a strange chipset, root port is under a bridge */
> 


-- 
Thanks!
Yijing

