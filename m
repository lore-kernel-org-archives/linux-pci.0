Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33627 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752552AbbH1Vbs (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 28 Aug 2015 17:31:48 -0400
Received: by obcid8 with SMTP id id8so4899673obc.0
        for <linux-pci@vger.kernel.org>; Fri, 28 Aug 2015 14:31:48 -0700 (PDT)
Date: Fri, 28 Aug 2015 16:31:45 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Taku Izumi <izumi.taku@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/AER: Cleanup AER error status registers on probing
 devices
Message-ID: <20150828213145.GB27890@google.com>
References: <1438706533-22547-1-git-send-email-izumi.taku@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438706533-22547-1-git-send-email-izumi.taku@jp.fujitsu.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Taku-san,

On Wed, Aug 05, 2015 at 01:42:13AM +0900, Taku Izumi wrote:
> AER uncorrectable or correctable error might be recorded
> when power on devices. These errors can be ignored, so
> BIOS usually clean up these registers ahead of OS's scanning
> devices.
> However, in case of hot-plug PCIe devices, BIOS can't care.

What happens when we power down a device for suspend or because it's idle?
Can we get spurious AER errors when we power the device back up?  This
patch only covers the enumeration path, so we'd need to do more if it can
happen during suspend/resume.

> Currently OS don't clean up AER error status registers on probing
> devices, ignorable AER errors recorded when power-on remains.
> This causes false-positive.
> 
> This patch address this problem by cleaning up
> AER error status registers on probing devices.
> 
> Signed-off-by: Taku Izumi <izumi.taku@jp.fujitsu.com>
> ---
>  drivers/pci/pcie/aer/aerdrv_core.c | 26 ++++++++++++++++++++++++++
>  drivers/pci/probe.c                |  5 +++++
>  include/linux/aer.h                |  5 +++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 9803e3d..9857cc4 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -74,6 +74,32 @@ int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_cleanup_aer_uncorrect_error_status);
>  
> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +{
> +	int pos;
> +	u32 status;
> +	int port_type;
> +
> +	pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +	if (!pos)
> +		return -EIO;
> +
> +	port_type = pci_pcie_type(dev);
> +	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
> +		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, &status);
> +		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_STATUS, status);
> +	}
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_COR_STATUS, &status);
> +	pci_write_config_dword(dev, pos + PCI_ERR_COR_STATUS, status);
> +
> +	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, &status);
> +	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_STATUS, status);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_cleanup_aer_error_status_regs);

Why does this need to be exported?  I see that
pci_cleanup_aer_uncorrect_error_status() above is exported, and it is used
by many drivers, so I see why that needs to be exported.  But there are no
users of pci_cleanup_aer_error_status_regs() outside the PCI core yet.  And
if we wanted to add users outside the core, I would question whether that's
the right thing to do.  AER management seems like something that probably
should be done by the PCI core, not by drivers.

>  /**
>   * add_error_device - list device to be handled
>   * @e_info: pointer to error info
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index cefd636..d660db7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -12,6 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/cpumask.h>
>  #include <linux/pci-aspm.h>
> +#include <linux/aer.h>
>  #include <asm-generic/pci-bridge.h>
>  #include "pci.h"
>  
> @@ -1542,6 +1543,10 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  
>  	/* Enable ACS P2P upstream forwarding */
>  	pci_enable_acs(dev);
> +
> +	/* Cleanup AER error status registerts */
> +	if (pci_is_pcie(dev))
> +		pci_cleanup_aer_error_status_regs(dev);

The other capability init functions check internally for pci_is_pcie(), so
please do the same here.

>  }
>  
>  void pci_device_add(struct pci_dev *dev, struct pci_bus *bus)
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 4fef65e..744b997 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -42,6 +42,7 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
> +int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
>  #else
>  static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
>  {
> @@ -55,6 +56,10 @@ static inline int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  #endif
>  
>  void cper_print_aer(struct pci_dev *dev, int cper_severity,
> -- 
> 1.8.3.1
> 
