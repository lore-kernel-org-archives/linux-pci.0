Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:36141 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756229AbbEVTmL (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 22 May 2015 15:42:11 -0400
Received: by igbpi8 with SMTP id pi8so43749667igb.1
        for <linux-pci@vger.kernel.org>; Fri, 22 May 2015 12:42:11 -0700 (PDT)
Date: Fri, 22 May 2015 14:42:07 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Yijing Wang <wangyijing@huawei.com>
Cc: linux-pci@vger.kernel.org, mjg59@coreos.com, rwhite@pobox.com,
	alex.williamson@redhat.com
Subject: Re: [PATCH v4 2/3] PCI/ASPM: Fix NULL pointer when find parent
 pcie_link_state
Message-ID: <20150522194207.GI32152@google.com>
References: <1432191904-16451-1-git-send-email-wangyijing@huawei.com>
 <1432191904-16451-2-git-send-email-wangyijing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432191904-16451-2-git-send-email-wangyijing@huawei.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 21, 2015 at 03:05:03PM +0800, Yijing Wang wrote:
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
> ---
>  drivers/pci/pcie/aspm.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 7d4fcdc..8830740 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
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
> @@ -723,8 +723,7 @@ static void __pci_disable_link_state(struct pci_dev *pdev, int state, bool sem,
>  	if (!pci_is_pcie(pdev))
>  		return;
>  
> -	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM)
> +	if (pdev->has_secondary_link)
>  		parent = pdev;
>  	if (!parent || !parent->link_state)
>  		return;

I think we also have a problem here:

   517  static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
   518  {
   519          struct pcie_link_state *link;
   520  
   521          link = kzalloc(sizeof(*link), GFP_KERNEL);
   522          if (!link)
   523                  return NULL;
   524          INIT_LIST_HEAD(&link->sibling);
   525          INIT_LIST_HEAD(&link->children);
   526          INIT_LIST_HEAD(&link->link);
   527          link->pdev = pdev;
   528          if (pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM) {
   529                  struct pcie_link_state *parent;
   530                  parent = pdev->bus->parent->self->link_state;
   531                  if (!parent) {
   532                          kfree(link);
   533                          return NULL;
   534                  }
   535                  link->parent = parent;
   536                  list_add(&link->link, &parent->children);
   537          }

Before your patch, we could only see Root Ports or Downstream Ports at line
528.  Now we may also see Upstream Ports, so I think that test should be
changed to "if (pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)".

Without this change, I think we would allocate pcie_link_state for the
03:00.0 Upstream Port in your example, but it would not be connected to the
tree of links starting at the 00:1c.0 Root Port.

Do you agree?

Bjorn
