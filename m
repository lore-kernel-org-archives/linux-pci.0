Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38446 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbbE0ABd (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2015 20:01:33 -0400
Received: by igcau1 with SMTP id au1so1779783igc.1
        for <linux-pci@vger.kernel.org>; Tue, 26 May 2015 17:01:33 -0700 (PDT)
Date: Tue, 26 May 2015 19:01:29 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mjg59@coreos.com, rwhite@pobox.com,
	alex.williamson@redhat.com
Subject: Re: [Update][PATCH v4 2/3] PCI/ASPM: Fix NULL pointer when find
 parent pcie_link_state
Message-ID: <20150527000129.GR32152@google.com>
References: <1432517673-1982-1-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432517673-1982-1-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, May 25, 2015 at 09:34:33AM +0800, Yijing Wang wrote:
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
> Use pdev->has_secondary_link(introduced in previous patch)
> to fix this issue.
> 
> Signed-off-by: Yijing Wang <wangyijing@huawei.com>

Applied to pci/aspm for v4.2, thanks!

It's easier if:

  - You include a [0/3] cover letter.  Then I can respond once there to say
    I've applied the series.

  - You post a complete v5 instead of an "[Update][PATCH v4 2/3]".  In this
    case, with only three patches and no further iterations, it's not a big
    deal, but it does make it harder for me to make sure I have the right
    version of everything.

Bjorn

> ---
>  drivers/pci/pcie/aspm.c |    9 ++++-----
>  1 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 4e1af76..942bf97 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -525,7 +525,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  	INIT_LIST_HEAD(&link->children);
>  	INIT_LIST_HEAD(&link->link);
>  	link->pdev = pdev;
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
> +	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) {
>  		struct pcie_link_state *parent;
>  		parent = pdev->bus->parent->self->link_state;
>  		if (!parent) {
> @@ -561,8 +561,8 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  
>  	if (!pci_is_pcie(pdev) || pdev->link_state)
>  		return;
> -	if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT &&
> -	    pci_pcie_type(pdev) != PCI_EXP_TYPE_DOWNSTREAM)
> +
> +	if (!pdev->has_secondary_link)
>  		return;
>  
>  	/* VIA has a strange chipset, root port is under a bridge */
> @@ -715,8 +715,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem)
>  	if (!pci_is_pcie(pdev))
>  		return;
>  
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
> +	if (pdev->has_secondary_link)
>  		parent = pdev;
>  	if (!parent || !parent->link_state)
>  		return;
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
