Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:34780 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeFEWQC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jun 2018 18:16:02 -0400
Received: by mail-ot0-f196.google.com with SMTP id i5-v6so4795703otf.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Jun 2018 15:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180508230148.121852-1-rajatja@google.com> <20180510233912.96454-1-rajatja@google.com>
In-Reply-To: <20180510233912.96454-1-rajatja@google.com>
From: Rajat Jain <rajatja@google.com>
Date: Tue, 5 Jun 2018 15:15:25 -0700
Message-ID: <CACK8Z6H0PE-xBiNxhS+-P=-SyqAzKQi87xQoLGzgh6sgyt8zGA@mail.gmail.com>
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To: Bjorn Helgaas <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@codeaurora.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Rajat Jain <rajatxjain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hello Bjorn,

Just checking to see if this one fell through the cracks? It isn't
solving any issues, but providing a tool for ASPM tweaking in user
space, which may be useful.

Thanks,

Rajat
On Thu, May 10, 2018 at 4:39 PM Rajat Jain <rajatja@google.com> wrote:
>
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
> ---
> v2: provide function definitions for !CONFIG_PCIEASPM case
>
>  drivers/pci/pci.h        | 8 ++------
>  drivers/pci/pcie/Kconfig | 8 --------
>  drivers/pci/pcie/aspm.c  | 2 --
>  3 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 023f7cf25bff..b953b2349ca1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -358,17 +358,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev);
>  void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
> +void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> +void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
> -#endif
> -
> -#ifdef CONFIG_PCIEASPM_DEBUG
> -void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev);
> -void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev);
> -#else
>  static inline void pcie_aspm_create_sysfs_dev_files(struct pci_dev *pdev) { }
>  static inline void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev) { }
>  #endif
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index b12e28b3d8f9..089b9f559d88 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -46,14 +46,6 @@ config PCIEASPM
>
>           When in doubt, say Y.
>
> -config PCIEASPM_DEBUG
> -       bool "Debug PCI Express ASPM"
> -       depends on PCIEASPM
> -       default n
> -       help
> -         This enables PCI Express ASPM debug support. It will add per-device
> -         interface to control ASPM.
> -
>  choice
>         prompt "Default ASPM policy"
>         default PCIEASPM_DEFAULT
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index c687c817b47d..8ffc13d42baa 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -1161,7 +1161,6 @@ static int pcie_aspm_get_policy(char *buffer, const struct kernel_param *kp)
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>         NULL, 0644);
>
> -#ifdef CONFIG_PCIEASPM_DEBUG
>  static ssize_t link_state_show(struct device *dev,
>                 struct device_attribute *attr,
>                 char *buf)
> @@ -1264,7 +1263,6 @@ void pcie_aspm_remove_sysfs_dev_files(struct pci_dev *pdev)
>                 sysfs_remove_file_from_group(&pdev->dev.kobj,
>                         &dev_attr_clk_ctl.attr, power_group);
>  }
> -#endif
>
>  static int __init pcie_aspm_disable(char *str)
>  {
> --
> 2.17.0.441.gb46fe60e1d-goog
>
