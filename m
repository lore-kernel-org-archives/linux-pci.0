Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Return-Path: <linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org>
Date: Tue, 3 Oct 2017 13:48:43 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: linux-acpi@vger.kernel.org, Zhou Wang <wangzhou1@hisilicon.com>,
 nwatters@codeaurora.org
Subject: Re: [PATCH v2] ACPI/IORT: Fix PCI ACS enablement
Message-ID: <20171003124843.GA16134@red-moon>
References: <1506965324-5818-1-git-send-email-lorenzo.pieralisi@arm.com>
MIME-Version: 1.0
In-Reply-To: <1506965324-5818-1-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <will.deacon@arm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Hanjun Guo <hanjun.guo@linaro.org>, linux-pci@vger.kernel.org,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+bjorn=helgaas.com@lists.infradead.org
List-ID: <linux-pci.vger.kernel.org>

[+Nate]

Zhou, Nate,

On Mon, Oct 02, 2017 at 06:28:44PM +0100, Lorenzo Pieralisi wrote:
> commit f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> workarounds") removed kernel code that was allowing to initialize
> and probe the SMMU devices early (ie earlier than PCI devices, through
> linker script callback entries) in the boot process because it was not
> needed any longer in that the SMMU devices/drivers now support deferred
> probing.
> 
> Since the SMMUs probe routines are also in charge of requesting global
> PCI ACS kernel enablement, commit f6810c15cf97 ("iommu/arm-smmu: Clean
> up early-probing workarounds") also postponed PCI ACS enablement to
> SMMUs devices probe time, which is too late given that PCI devices needs
> to detect if PCI ACS is enabled to init the respective capability
> through the following call path:
> 
> pci_device_add()
>  -> pci_init_capabilities()
>   -> pci_enable_acs()
> 
> Add code in the ACPI IORT SMMU platform devices initialization path
> (that is called before ACPI PCI enumeration) to detect if there
> exists firmware mappings to map root complexes ids to SMMU ids
> and if so enable ACS for the system.
> 
> Fixes: f6810c15cf97 ("iommu/arm-smmu: Clean up early-probing
> Signed-workarounds")
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Hanjun Guo <hanjun.guo@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Zhou Wang <wangzhou1@hisilicon.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> ---
> v1 -> v2:
> 
> - Reworked ACS enablement logic and based on root complex to SMMU
>   ids firmware mapping detection
> - Rebased against v4.14-rc3
> 
> v1: https://marc.info/?l=linux-acpi&m=150584059818925&w=2
> 
>  drivers/acpi/arm64/iort.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

I have reworked the enablement logic wrt v1, dou you mind testing it
please, I would like to get it merged since I have 4.15 patches depending
on it.

Thanks,
Lorenzo

> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 9565d57..de56394 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1178,12 +1178,44 @@ static int __init iort_add_smmu_platform_device(struct acpi_iort_node *node)
>  	return ret;
>  }
>  
> +static bool __init iort_enable_acs(struct acpi_iort_node *iort_node)
> +{
> +	if (iort_node->type == ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
> +		struct acpi_iort_node *parent;
> +		struct acpi_iort_id_mapping *map;
> +		int i;
> +
> +		map = ACPI_ADD_PTR(struct acpi_iort_id_mapping, iort_node,
> +				   iort_node->mapping_offset);
> +
> +		for (i = 0; i < iort_node->mapping_count; i++, map++) {
> +			if (!map->output_reference)
> +				continue;
> +
> +			parent = ACPI_ADD_PTR(struct acpi_iort_node,
> +					iort_table,  map->output_reference);
> +			/*
> +			 * If we detect a RC->SMMU mapping, make sure
> +			 * we enable ACS on the system.
> +			 */
> +			if ((parent->type == ACPI_IORT_NODE_SMMU) ||
> +				(parent->type == ACPI_IORT_NODE_SMMU_V3)) {
> +				pci_request_acs();
> +				return true;
> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static void __init iort_init_platform_devices(void)
>  {
>  	struct acpi_iort_node *iort_node, *iort_end;
>  	struct acpi_table_iort *iort;
>  	struct fwnode_handle *fwnode;
>  	int i, ret;
> +	bool acs_enabled = false;
>  
>  	/*
>  	 * iort_table and iort both point to the start of IORT table, but
> @@ -1203,6 +1235,9 @@ static void __init iort_init_platform_devices(void)
>  			return;
>  		}
>  
> +		if (!acs_enabled)
> +			acs_enabled = iort_enable_acs(iort_node);
> +
>  		if ((iort_node->type == ACPI_IORT_NODE_SMMU) ||
>  			(iort_node->type == ACPI_IORT_NODE_SMMU_V3)) {
>  
> -- 
> 2.4.12
> 

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
