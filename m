Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Wed, 12 Apr 2017 18:26:23 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH 2/2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20170412172623.GA11570@red-moon>
References: <20170411163313.18577-1-ard.biesheuvel@linaro.org>
 <20170411163313.18577-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20170411163313.18577-3-ard.biesheuvel@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: catalin.marinas@arm.com, graeme.gregory@linaro.org,
 linux-pci@vger.kernel.org, will.deacon@arm.com, leif.lindholm@linaro.org,
 okaya@codeaurora.org, tn@semihalf.com, bhelgaas@google.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 05:33:13PM +0100, Ard Biesheuvel wrote:
> On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
> hierarchy at boot. This is a departure from what is customary on ACPI
> systems, and may break assumptions in some places (e.g., EFIFB), that
> the kernel will leave BARs of enabled PCI devices where they are.
> 
> Given that PCI already specifies a device specific ACPI method (_DSM)
> for PCI root bridge nodes that tells us whether the firmware thinks
> the configuration should be left alone, let's sidestep the entire
> policy debate about whether the PCI configuration should be preserved
> or not, and put it under the control of the firmware instead.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm64/kernel/pci.c  | 20 ++++++++++++++++++--
>  include/linux/pci-acpi.h |  7 ++++---
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 4f0e3ebfea4b..c88e07e2eb84 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -185,6 +185,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	struct acpi_pci_generic_root_info *ri;
>  	struct pci_bus *bus, *child;
>  	struct acpi_pci_root_ops *root_ops;
> +	union acpi_object *obj;
>  
>  	ri = kzalloc_node(sizeof(*ri), GFP_KERNEL, node);
>  	if (!ri)
> @@ -208,8 +209,23 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>  	if (!bus)
>  		return NULL;
>  
> -	pci_bus_size_bridges(bus);
> -	pci_bus_assign_resources(bus);
> +	/*
> +	 * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +	 * Configuration', which tells us whether the firmware wants us to
> +	 * preserve the configuration of the PCI resource tree for this root
> +	 * bridge.
> +	 */
> +	obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), pci_acpi_dsm_uuid, 1,
> +				IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +	if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
> +		/* preserve existing resource assignment */
> +		pci_bus_claim_resources(bus);

Ok. By the PCI FW specs, we should also assign unassigned resources here
(ie resources that can't be claimed). Furthermore, by the PCI FW spec,
if !obj this is the path we should be taking (PCI firmware specification
Rev 3.1, 4.6.5, Description: 0:)

"...This situation is the same as the legacy situation where this
_DSM is not provided."

which makes me think that the PCI FW specification expects FW set-up
to be claimed on boot, it is my interpretation.

I wonder how many UEFI developers know this _DSM even exists. If we
want to enforce it at least we should mandate its usage at SBSA level,
it is a major change and I want to understand the reasons behind it,
so far, as I said, I may see why this was needed on x86 but on ARM64
I really don't.

Lorenzo

> +	} else {
> +		/* reconfigure the resource tree from scratch */
> +		pci_bus_size_bridges(bus);
> +		pci_bus_assign_resources(bus);
> +	}
> +	ACPI_FREE(obj);
>  
>  	list_for_each_entry(child, &bus->children, node)
>  		pcie_bus_configure_settings(child);
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 7a4e83a8c89c..308111489b83 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -106,9 +106,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>  
>  extern const u8 pci_acpi_dsm_uuid[];
> -#define DEVICE_LABEL_DSM	0x07
> -#define RESET_DELAY_DSM		0x08
> -#define FUNCTION_DELAY_DSM	0x09
> +#define IGNORE_PCI_BOOT_CONFIG_DSM	0x05
> +#define DEVICE_LABEL_DSM		0x07
> +#define RESET_DELAY_DSM			0x08
> +#define FUNCTION_DELAY_DSM		0x09
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
> -- 
> 2.9.3
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
