Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:45982 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755360AbeEIGqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 May 2018 02:46:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 09 May 2018 07:46:14 +0100
From: okaya@codeaurora.org
To: Rajat Jain <rajatja@google.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mayurkumar.patel@intel.com, rajatxjain@gmail.com
Subject: Re: [PATCH] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
In-Reply-To: <20180508230148.121852-1-rajatja@google.com>
References: <20180508230148.121852-1-rajatja@google.com>
Message-ID: <7cdf5fb27cc7650523892389db76e12d@codeaurora.org>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2018-05-09 00:01, Rajat Jain wrote:
> Currently, the linux kernel disables ASPM when a device is
> removed from the kernel. But it is not enabled again when
> a new device is added on that slot even if it was originally
> enabled (by the BIOS) when the system booted up (assuming
> POLICY_DEFAULT).
> 
> This was earlier discussed here:
> https://www.spinics.net/lists/linux-pci/msg60212.html
> 
> And some suggestions from Bjorn here:
> https://www.spinics.net/lists/linux-pci/msg60541.html
> 
> This patch picks up one of the suggestion, to remove the
> CONFIG_PCIEASPM_DEBUG and thus make the code always
> avilable. This provides control to userspace to control
> ASPM on a per slot / device basis using sysfs interface.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>

Reviewed-by: Sinan Kaya <okaya@codeaurora.org>


> ---
>  drivers/pci/pci.h        | 5 -----
>  drivers/pci/pcie/Kconfig | 8 --------
>  drivers/pci/pcie/aspm.c  | 2 --
>  3 files changed, 15 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 023f7cf25bff..383d92a6b0fb 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -365,13 +365,8 @@ static inline void
> pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev 
> *pdev) { }
>  #endif
> 
> -#ifdef CONFIG_PCIEASPM_DEBUG
>  void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
>  void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else
> -static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev 
> *pdev) { }
> -static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev 
> *pdev) { }
> -#endif
> 
>  #ifdef CONFIG_PCIE_PTM
>  void pci_ptm_init(struct pci_dev *dev);
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b12e28b3d8f9..089b9f559d88 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -46,14 +46,6 @@ config PCIEASPM
> 
>  	  When in doubt, say Y.
> 
> -config PCIEASPM_DEBUG
> -	bool "Debug PCI Express ASPM"
> -	depends on PCIEASPM
> -	default n
> -	help
> -	  This enables PCI Express ASPM debug support. It will add per-device
> -	  interface to control ASPM.
> -
>  choice
>  	prompt "Default ASPM policy"
>  	default PCIEASPM_DEFAULT
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c687c817b47d..8ffc13d42baa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1161,7 +1161,6 @@ static int pcie_aspm_get_policy(char *buffer,
> const struct kernel_param *kp)
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
> 
> -#ifdef CONFIG_PCIEASPM_DEBUG
>  static ssize_t link_state_show(struct device *dev,
>  		struct device_attribute *attr,
>  		char *buf)
> @@ -1264,7 +1263,6 @@ void pcie_aspm_remove_sysfs_dev_files(struct
> pci_dev *pdev)
>  		sysfs_remove_file_from_group(&pdev->dev.kobj,
>  			&dev_attr_clk_ctl.attr, power_group);
>  }
> -#endif
> 
>  static int __init pcie_aspm_disable(char *str)
>  {
