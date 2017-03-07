Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755649AbdCGUlT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 7 Mar 2017 15:41:19 -0500
Date: Tue, 7 Mar 2017 14:15:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, clsoto@us.ibm.com
Subject: Re: [PATCH] PCI: Disable IOV before pcibios_sriov_disable()
Message-ID: <20170307201529.GF21358@bhelgaas-glaptop.roam.corp.google.com>
References: <1488154712-8354-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1488154712-8354-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Gavin,

On Mon, Feb 27, 2017 at 11:18:32AM +1100, Gavin Shan wrote:
> The PowerNV platform is the only user of pcibios_sriov_disable().
> The IOV BAR could be shifted by pci_iov_update_resource(). The
> warning message in the function is printed if the IOV capability
> is in enabled (PCI_SRIOV_CTRL_VFE && PCI_SRIOV_CTRL_MSE) state.
> 
>    pci_disable_sriov
>    sriov_disable
>    pnv_pci_sriov_disable
>    pnv_pci_vf_resource_shift
>    pci_update_resource
>    pci_iov_update_resource
> 
> This fixes the issue by disabling IOV capability before calling
> pcibios_sriov_disable(). With it, the disabling path matches with
> the enabling path: pcibios_sriov_enable() is called before the
> IOV capability is enabled.

I'm vaguely uncomfortable about this path:

  pci_disable_sriov
    sriov_disable
      pcibios_sriov_disable           # powerpc version
	pnv_pci_sriov_disable
	  pnv_pci_vf_resource_shift
	    res = &dev->resource[i + PCI_IOV_RESOURCES]
	    res->start += size * offset
	    pci_update_resource
	      pci_iov_update_resource
	  pnv_pci_vf_release_m64

1) "res" is already in the resource tree, so we shouldn't be changing
   its start address, because that may make the tree inconsistent,
   e.g., the resource may no longer be completely contained in its
   parent, it may conflict with a sibling, etc.

2) If we update "res->start", shouldn't we update "res->end"
   correspondingly?

It seems like it'd be better if we didn't update the device resources
in the enable/disable paths.  If we could do the resource adjustments
earlier, somewhere before we give the device to a driver, it seems
like it would avoid these issues.

We might have talked about these questions in the past, so I apologize
if you've already explained this.  If that's the case, maybe we just
need some comments in the code to help the next confused reader.

> Reported-by: Carol L Soto <clsoto@us.ibm.com>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Tested-by: Carol L Soto <clsoto@us.ibm.com>
> ---
>  drivers/pci/iov.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index 2479ae8..138830f 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -331,7 +331,6 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	while (i--)
>  		pci_iov_remove_virtfn(dev, i, 0);
>  
> -	pcibios_sriov_disable(dev);
>  err_pcibios:
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
> @@ -339,6 +338,8 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
>  	ssleep(1);
>  	pci_cfg_access_unlock(dev);
>  
> +	pcibios_sriov_disable(dev);
> +
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> @@ -357,14 +358,14 @@ static void sriov_disable(struct pci_dev *dev)
>  	for (i = 0; i < iov->num_VFs; i++)
>  		pci_iov_remove_virtfn(dev, i, 0);
>  
> -	pcibios_sriov_disable(dev);
> -
>  	iov->ctrl &= ~(PCI_SRIOV_CTRL_VFE | PCI_SRIOV_CTRL_MSE);
>  	pci_cfg_access_lock(dev);
>  	pci_write_config_word(dev, iov->pos + PCI_SRIOV_CTRL, iov->ctrl);
>  	ssleep(1);
>  	pci_cfg_access_unlock(dev);
>  
> +	pcibios_sriov_disable(dev);
> +
>  	if (iov->link != dev->devfn)
>  		sysfs_remove_link(&dev->dev.kobj, "dep_link");
>  
> -- 
> 2.7.4
> 
