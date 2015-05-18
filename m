Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:33292 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751134AbbERRGQ (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Mon, 18 May 2015 13:06:16 -0400
Received: by igbpi8 with SMTP id pi8so87051409igb.0
        for <linux-pci@vger.kernel.org>; Mon, 18 May 2015 10:06:16 -0700 (PDT)
Date: Mon, 18 May 2015 12:06:13 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mjg59@coreos.com, rwhite@pobox.com,
	alex.williamson@redhat.com
Subject: Re: [PATCH v2] PCI: Fix NULL pointer when find parent pcie_link_state
Message-ID: <20150518170613.GN31666@google.com>
References: <1429858791-26331-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1429858791-26331-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 24, 2015 at 02:59:51PM +0800, Yijing Wang wrote:
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

I like the idea of this, but I'd rather not bury it inside ASPM and I'd
rather not have it depend on ASPM data (the link_state pointer).  I think
it would be better if we had a real PCI interface, maybe using a bit in
struct pci_dev that we could set in set_pcie_port_type().

We should also look for other cases that might not work on this topology.
The following functions test for PCI_EXP_TYPE_DOWNSTREAM and I think most
of them assume that the Downstream Port has a link on its secondary side,
which is not the case in this topology:

  reset_link()
  alloc_pcie_link_state()
  pcie_aspm_pm_state_change()
  pcie_aspm_powersave_config_link()
  __pci_disable_link_state()
  pcie_aspm_create_sysfs_dev_files()
  pcie_aspm_remove_sysfs_dev_files()
  only_one_child()
  quirk_apple_wait_for_thunderbolt()
  pci_vc_enable()

"has_external_link" doesn't seem very descriptive to me -- I'm not sure how
to interpret "external."  "has_downstream_link" suggests a link on the
downstream (secondary) side, which is more what we're getting at, although
it might be confusing that an Upstream Port can have a downstream link.  Or
maybe "has_secondary_link" or "secondary_is_link".

Bjorn

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
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
