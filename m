Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:52412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752792AbdF0XSM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Jun 2017 19:18:12 -0400
Date: Tue, 27 Jun 2017 18:18:08 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jon Derrick <jonathan.derrick@intel.com>
Cc: linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] pci/vmd: Move srcu cleanup after bus, child device
 removal
Message-ID: <20170627231808.GJ17844@bhelgaas-glaptop.roam.corp.google.com>
References: <1498144542-18122-1-git-send-email-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498144542-18122-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 22, 2017 at 09:15:42AM -0600, Jon Derrick wrote:
> Recent __call_srcu changes have exposed that we need to cleanup srcu
> structures after pci_stop_root_bus calls into vmd_msi_free.
> 
> Fixes: 3906b91844d6 ("PCI: vmd: Use SRCU as a local RCU to prevent
> delaying global RCU")

I re-capitalized the subject to match the one above and applied to
pci/host-vmd for v4.13, thanks!

> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> Acked-by: Keith Busch <keith.busch@intel.com>
> Cc: <stable@vger.kernel.org> # 4.11
> ---
> v1->2 fixed up commit log
> 
>  drivers/pci/host/vmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/vmd.c b/drivers/pci/host/vmd.c
> index e27ad2a..642a182 100644
> --- a/drivers/pci/host/vmd.c
> +++ b/drivers/pci/host/vmd.c
> @@ -733,10 +733,10 @@ static void vmd_remove(struct pci_dev *dev)
>  	struct vmd_dev *vmd = pci_get_drvdata(dev);
>  
>  	vmd_detach_resources(vmd);
> -	vmd_cleanup_srcu(vmd);
>  	sysfs_remove_link(&vmd->dev->dev.kobj, "domain");
>  	pci_stop_root_bus(vmd->bus);
>  	pci_remove_root_bus(vmd->bus);
> +	vmd_cleanup_srcu(vmd);
>  	vmd_teardown_dma_ops(vmd);
>  	irq_domain_remove(vmd->irq_domain);
>  }
> -- 
> 1.8.3.1
> 
