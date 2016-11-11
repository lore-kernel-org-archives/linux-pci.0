Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935938AbcKKUv0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Nov 2016 15:51:26 -0500
Date: Fri, 11 Nov 2016 14:51:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Wang Sheng-Hui <shhuiw@foxmail.com>
Cc: yu.zhao@intel.com, jbarnes@virtuousgeek.org,
        alex.williamson@redhat.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: move cfg space size (256/4096) macros to pci_regs.h
Message-ID: <20161111205119.GB9868@bhelgaas-glaptop.roam.corp.google.com>
References: <1474506346-20873-1-git-send-email-shhuiw@foxmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1474506346-20873-1-git-send-email-shhuiw@foxmail.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Sep 22, 2016 at 09:05:46AM +0800, Wang Sheng-Hui wrote:
> This is a cleanup that moves PCI configuration space size
> macros (PCI_CFG_SPACE_SIZE and PCI_CFG_SPACE_EXP_SIZE) from
> drivers/pci/pci.h to include/uapi/linux/pci_regs.h
> 
> So that the macros can be used by more drivers and eliminate
> potential duplicate definition.
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw@foxmail.com>

Applied to pci/misc for v4.10, thanks!

I updated the comment to include PCI-X details, since the extended config
space applies to PCI-X Mode 2 devices as well as to PCIe devices:

+ * Conventional PCI and PCI-X Mode 1 devices have 256 bytes of
+ * configuration space.  PCI-X Mode 2 and PCIe devices have 4096 bytes of
+ * configuration space.

> ---
>  drivers/pci/pci.h                  | 3 ---
>  drivers/vfio/pci/vfio_pci_config.c | 2 --
>  include/uapi/linux/pci_regs.h      | 7 +++++++
>  3 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9730c47..12d651a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1,9 +1,6 @@
>  #ifndef DRIVERS_PCI_H
>  #define DRIVERS_PCI_H
>  
> -#define PCI_CFG_SPACE_SIZE	256
> -#define PCI_CFG_SPACE_EXP_SIZE	4096
> -
>  #define PCI_FIND_CAP_TTL	48
>  
>  extern const unsigned char pcie_link_speed[];
> diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
> index 688691d..8dc8a5a 100644
> --- a/drivers/vfio/pci/vfio_pci_config.c
> +++ b/drivers/vfio/pci/vfio_pci_config.c
> @@ -31,8 +31,6 @@
>  
>  #include "vfio_pci_private.h"
>  
> -#define PCI_CFG_SPACE_SIZE	256
> -
>  /* Fake capability ID for standard config space */
>  #define PCI_CAP_ID_BASIC	0
>  
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 4040951..a07c53c 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -23,6 +23,13 @@
>  #define LINUX_PCI_REGS_H
>  
>  /*
> + * Under PCI, each device has 256 bytes of configuration address space.
> + * Under PCIe, each device has 4096 bytes of configuration address space.
> + */
> +#define PCI_CFG_SPACE_SIZE	256
> +#define PCI_CFG_SPACE_EXP_SIZE	4096
> +
> +/*
>   * Under PCI, each device has 256 bytes of configuration address space,
>   * of which the first 64 bytes are standardized as follows:
>   */
> -- 
> 2.7.4
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
