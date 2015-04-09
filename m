Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32780 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbDITVa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 9 Apr 2015 15:21:30 -0400
Received: by oblw8 with SMTP id w8so147175526obl.0
        for <linux-pci@vger.kernel.org>; Thu, 09 Apr 2015 12:21:30 -0700 (PDT)
Date: Thu, 9 Apr 2015 14:21:27 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Matthew Garrett <mjg59@coreos.com>
Cc: linux-pci@vger.kernel.org, rjw@rjwysocki.net, lenb@kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Don't clear ASPM bits when the FADT declares it's
 unsupported
Message-ID: <20150409192127.GJ30967@google.com>
References: <1428430020-29633-1-git-send-email-mjg59@coreos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1428430020-29633-1-git-send-email-mjg59@coreos.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 07, 2015 at 11:07:00AM -0700, Matthew Garrett wrote:
> Communications with a hardware vendor confirm that the expected behaviour on
> systems that set the FADT ASPM disable bit but which still grant full PCIe
> control is for the OS to leave any BIOS configuration intact and refuse to
> touch the ASPM bits. This mimics the behaviour of Windows.
> 
> Signed-off-by: Matthew Garrett <mjg59@coreos.com>

Applied to pci/misc for v4.1, thanks!

> ---
>  drivers/acpi/pci_root.c  | 19 ++++++++-----------
>  drivers/pci/pcie/aspm.c  | 18 ------------------
>  include/linux/pci-aspm.h |  4 ----
>  3 files changed, 8 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 68a5f71..1b5569c 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -423,8 +423,7 @@ out:
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> -static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> -				 int *clear_aspm)
> +static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm)
>  {
>  	u32 support, control, requested;
>  	acpi_status status;
> @@ -495,10 +494,12 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>  		decode_osc_control(root, "OS now controls", control);
>  		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  			/*
> -			 * We have ASPM control, but the FADT indicates
> -			 * that it's unsupported. Clear it.
> +			 * We have ASPM control, but the FADT indicates that
> +			 * it's unsupported. Leave existing configuration
> +			 * intact and prevent the OS from touching it.
>  			 */
> -			*clear_aspm = 1;
> +			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
> +			*no_aspm = 1;
>  		}
>  	} else {
>  		decode_osc_control(root, "OS requested", requested);
> @@ -525,7 +526,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	int result;
>  	struct acpi_pci_root *root;
>  	acpi_handle handle = device->handle;
> -	int no_aspm = 0, clear_aspm = 0;
> +	int no_aspm = 0;
>  	bool hotadd = system_state != SYSTEM_BOOTING;
>  
>  	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
> @@ -584,7 +585,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  
>  	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
>  
> -	negotiate_os_control(root, &no_aspm, &clear_aspm);
> +	negotiate_os_control(root, &no_aspm);
>  
>  	/*
>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
> @@ -607,10 +608,6 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  		goto remove_dmar;
>  	}
>  
> -	if (clear_aspm) {
> -		dev_info(&device->dev, "Disabling ASPM (FADT indicates it is unsupported)\n");
> -		pcie_clear_aspm(root->bus);
> -	}
>  	if (no_aspm)
>  		pcie_no_aspm();
>  
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 820740a..7d4fcdc 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -782,24 +782,6 @@ void pci_disable_link_state(struct pci_dev *pdev, int state)
>  }
>  EXPORT_SYMBOL(pci_disable_link_state);
>  
> -void pcie_clear_aspm(struct pci_bus *bus)
> -{
> -	struct pci_dev *child;
> -
> -	if (aspm_force)
> -		return;
> -
> -	/*
> -	 * Clear any ASPM setup that the firmware has carried out on this bus
> -	 */
> -	list_for_each_entry(child, &bus->devices, bus_list) {
> -		__pci_disable_link_state(child, PCIE_LINK_STATE_L0S |
> -					 PCIE_LINK_STATE_L1 |
> -					 PCIE_LINK_STATE_CLKPM,
> -					 false, true);
> -	}
> -}
> -
>  static int pcie_aspm_set_policy(const char *val, struct kernel_param *kp)
>  {
>  	int i;
> diff --git a/include/linux/pci-aspm.h b/include/linux/pci-aspm.h
> index 8af4610..207c561 100644
> --- a/include/linux/pci-aspm.h
> +++ b/include/linux/pci-aspm.h
> @@ -29,7 +29,6 @@ void pcie_aspm_pm_state_change(struct pci_dev *pdev);
>  void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
>  void pci_disable_link_state(struct pci_dev *pdev, int state);
>  void pci_disable_link_state_locked(struct pci_dev *pdev, int state);
> -void pcie_clear_aspm(struct pci_bus *bus);
>  void pcie_no_aspm(void);
>  #else
>  static inline void pcie_aspm_init_link_state(struct pci_dev *pdev)
> @@ -47,9 +46,6 @@ static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev)
>  static inline void pci_disable_link_state(struct pci_dev *pdev, int state)
>  {
>  }
> -static inline void pcie_clear_aspm(struct pci_bus *bus)
> -{
> -}
>  static inline void pcie_no_aspm(void)
>  {
>  }
> -- 
> 2.3.4
> 
