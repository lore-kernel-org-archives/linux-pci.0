Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <54164699.9020906@huawei.com>
Date: Mon, 15 Sep 2014 09:53:29 +0800
From: Yijing Wang <wangyijing@huawei.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	Joerg Roedel <joro@8bytes.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Yinghai Lu <yinghai@kernel.org>,
	"Bjorn Helgaas" <bhelgaas@google.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Vinod Koul" <vinod.koul@intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
CC: Ashok Raj <ashok.raj@intel.com>, Tony Luck <tony.luck@intel.com>,
	<iommu@lists.linux-foundation.org>, <linux-pci@vger.kernel.org>,
	<linux-hotplug@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dmaengine@vger.kernel.org>
Subject: Re: [Patch Part3 V5 4/8] iommu/vt-d: Search for ACPI _DSM method
 for DMAR hotplug
References: <1410487848-6027-1-git-send-email-jiang.liu@linux.intel.com> <1410487848-6027-5-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1410487848-6027-5-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 2014/9/12 10:10, Jiang Liu wrote:
> According to Intel VT-d specification, _DSM method to support DMAR
> hotplug should exist directly under corresponding ACPI object
> representing PCI host bridge. But some BIOSes doesn't conform to
> this, so search for _DSM method in the subtree starting from the
> ACPI object representing the PCI host bridge.

Reviewed-by: Yijing Wang <wangyijing@huawei.com>

> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/iommu/dmar.c |   35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index e77b5d3f2f5c..df2c2591c1a6 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1926,21 +1926,48 @@ static int dmar_hotplug_remove(acpi_handle handle)
>  	return ret;
>  }
>  
> -static int dmar_device_hotplug(acpi_handle handle, bool insert)
> +static acpi_status dmar_get_dsm_handle(acpi_handle handle, u32 lvl,
> +				       void *context, void **retval)
> +{
> +	acpi_handle *phdl = retval;
> +
> +	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
> +		*phdl = handle;
> +		return AE_CTRL_TERMINATE;
> +	}
> +
> +	return AE_OK;
> +}
> +
> +int dmar_device_hotplug(acpi_handle handle, bool insert)
>  {
>  	int ret;
> +	acpi_handle tmp = NULL;
> +	acpi_status status;
>  
>  	if (!dmar_in_use())
>  		return 0;
>  
> -	if (!dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD))
> +	if (dmar_detect_dsm(handle, DMAR_DSM_FUNC_DRHD)) {
> +		tmp = handle;
> +	} else {
> +		status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle,
> +					     ACPI_UINT32_MAX,
> +					     dmar_get_dsm_handle,
> +					     NULL, NULL, &tmp);
> +		if (ACPI_FAILURE(status)) {
> +			pr_warn("Failed to locate _DSM method.\n");
> +			return -ENXIO;
> +		}
> +	}
> +	if (tmp == NULL)
>  		return 0;
>  
>  	down_write(&dmar_global_lock);
>  	if (insert)
> -		ret = dmar_hotplug_insert(handle);
> +		ret = dmar_hotplug_insert(tmp);
>  	else
> -		ret = dmar_hotplug_remove(handle);
> +		ret = dmar_hotplug_remove(tmp);
>  	up_write(&dmar_global_lock);
>  
>  	return ret;
> 


-- 
Thanks!
Yijing

