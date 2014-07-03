Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:39060 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965179AbaGCWrH (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Jul 2014 18:47:07 -0400
Received: by mail-ig0-f175.google.com with SMTP id h3so8190069igd.8
        for <linux-pci@vger.kernel.org>; Thu, 03 Jul 2014 15:47:06 -0700 (PDT)
Date: Thu, 3 Jul 2014 16:47:04 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: Re: [PATCH 1/2] PCI: Make resetting secondary bus logic common
Message-ID: <20140703224704.GA25980@google.com>
References: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1403162565-26835-1-git-send-email-gwshan@linux.vnet.ibm.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 19, 2014 at 05:22:44PM +1000, Gavin Shan wrote:
> Commit d92a208d086 ("powerpc/pci: Mask linkDown on resetting PCI bus")
> implemented same logic (resetting PCI secondary bus by bridge's config
> register PCI_BRIDGE_CTL_BUS_RESET) in PCI core and arch-dependent
> code. In order to avoid the duplicate implementation introduced by the
> commit, the patch puts the logic into pci_reset_secondary_bus().
> 
> That commit also missed declaring newly introduced weak function
> pcibios_reset_secondary_bus() in linux/include/pci.h. The patch fixes
> it.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

I applied both of these to pci/virtualization for v3.17.  Ben, if you'd
rather apply the powerpc one [1], let me know and I'll drop that one.

Bjorn

[1] http://patchwork.ozlabs.org/patch/361802/

> ---
>  drivers/pci/pci.c   | 7 ++++++-
>  include/linux/pci.h | 2 ++
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 63a54a3..758f1d8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3193,7 +3193,7 @@ static int pci_pm_reset(struct pci_dev *dev, int probe)
>  	return 0;
>  }
>  
> -void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> +void pci_reset_secondary_bus(struct pci_dev *dev)
>  {
>  	u16 ctrl;
>  
> @@ -3219,6 +3219,11 @@ void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
>  	ssleep(1);
>  }
>  
> +void __weak pcibios_reset_secondary_bus(struct pci_dev *dev)
> +{
> +	pci_reset_secondary_bus(dev);
> +}
> +
>  /**
>   * pci_reset_bridge_secondary_bus - Reset the secondary bus on a PCI bridge.
>   * @dev: Bridge device
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 466bcd1..340529d 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -978,6 +978,8 @@ int pci_try_reset_slot(struct pci_slot *slot);
>  int pci_probe_reset_bus(struct pci_bus *bus);
>  int pci_reset_bus(struct pci_bus *bus);
>  int pci_try_reset_bus(struct pci_bus *bus);
> +void pci_reset_secondary_bus(struct pci_dev *dev);
> +void pcibios_reset_secondary_bus(struct pci_dev *dev);
>  void pci_reset_bridge_secondary_bus(struct pci_dev *dev);
>  void pci_update_resource(struct pci_dev *dev, int resno);
>  int __must_check pci_assign_resource(struct pci_dev *dev, int i);
> -- 
> 1.8.3.2
> 
