Return-Path: <linux-acpi-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Aaron Lu <aaron.lu@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: rename _DSM UUID array
Date: Tue, 24 Mar 2015 22:57:35 +0100
Message-ID: <2882393.gnxeIGK6OM@vostro.rjw.lan>
In-Reply-To: <55112899.3000904@intel.com>
References: <54FD4FB9.2060802@intel.com> <13489176.3njQWsGiXL@vostro.rjw.lan> <55112899.3000904@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tuesday, March 24, 2015 05:04:25 PM Aaron Lu wrote:
> According to the PCI firmware spec, there is only one assigned UUID used
> for PCI system so rename the device_label_dsm_uuid to something more
> common as: pci_acpi_dsm_uuid and put it in drivers/pci/pci-acpi.c. Make
> that UUID array extern in the pci-acpi.h so that other code can also
> make use of it.
> 
> This patch shouldn't bring any functional change.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci-acpi.c   |  9 +++++++++
>  drivers/pci/pci-label.c  | 11 ++---------
>  include/linux/pci-acpi.h |  3 +++
>  3 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 489063987325..e0afc94aca01 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -18,6 +18,15 @@
>  #include <linux/pm_qos.h>
>  #include "pci.h"
>  
> +/*
> + * The UUID is defined in the PCI firmware specification available here:
> + * https://www.pcisig.com/members/downloads/pcifw_r3_1_13Dec10.pdf
> + */
> +const u8 pci_acpi_dsm_uuid[] = {
> +	0xd0, 0x37, 0xc9, 0xe5, 0x53, 0x35, 0x7a, 0x4d,
> +	0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d
> +};
> +
>  phys_addr_t acpi_pci_root_get_mcfg_addr(acpi_handle handle)
>  {
>  	acpi_status status = AE_NOT_EXIST;
> diff --git a/drivers/pci/pci-label.c b/drivers/pci/pci-label.c
> index 2ab1b47c7651..024b5c179348 100644
> --- a/drivers/pci/pci-label.c
> +++ b/drivers/pci/pci-label.c
> @@ -31,8 +31,6 @@
>  #include <linux/pci-acpi.h>
>  #include "pci.h"
>  
> -#define	DEVICE_LABEL_DSM	0x07
> -
>  #ifdef CONFIG_DMI
>  enum smbios_attr_enum {
>  	SMBIOS_ATTR_NONE = 0,
> @@ -148,11 +146,6 @@ static inline void pci_remove_smbiosname_file(struct pci_dev *pdev)
>  #endif
>  
>  #ifdef CONFIG_ACPI
> -static const char device_label_dsm_uuid[] = {
> -	0xD0, 0x37, 0xC9, 0xE5, 0x53, 0x35, 0x7A, 0x4D,
> -	0x91, 0x17, 0xEA, 0x4D, 0x19, 0xC3, 0x43, 0x4D
> -};
> -
>  enum acpi_attr_enum {
>  	ACPI_ATTR_LABEL_SHOW,
>  	ACPI_ATTR_INDEX_SHOW,
> @@ -179,7 +172,7 @@ static int dsm_get_label(struct device *dev, char *buf,
>  	if (!handle)
>  		return -1;
>  
> -	obj = acpi_evaluate_dsm(handle, device_label_dsm_uuid, 0x2,
> +	obj = acpi_evaluate_dsm(handle, pci_acpi_dsm_uuid, 0x2,
>  				DEVICE_LABEL_DSM, NULL);
>  	if (!obj)
>  		return -1;
> @@ -219,7 +212,7 @@ static bool device_has_dsm(struct device *dev)
>  	if (!handle)
>  		return false;
>  
> -	return !!acpi_check_dsm(handle, device_label_dsm_uuid, 0x2,
> +	return !!acpi_check_dsm(handle, pci_acpi_dsm_uuid, 0x2,
>  				1 << DEVICE_LABEL_DSM);
>  }
>  
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 24c7728ca681..3801c704a945 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -77,6 +77,9 @@ static inline void acpiphp_remove_slots(struct pci_bus *bus) { }
>  static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
> +extern const u8 pci_acpi_dsm_uuid[];
> +#define DEVICE_LABEL_DSM	0x07
> +
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
