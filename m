Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 18 Jan 2018 13:13:26 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Robert Moore <robert.moore@intel.com>,
        Lv Zheng <lv.zheng@intel.com>, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, devel@acpica.org
Subject: Re: [PATCH 1/4] PCI: acpiphp_ibm: prepare for acpi_get_object_info
 no longer returning status
Message-ID: <20180118191326.GJ53542@bhelgaas-glaptop.roam.corp.google.com>
References: <20180118160359.29971-1-hdegoede@redhat.com>
 <20180118160359.29971-2-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180118160359.29971-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 18, 2018 at 05:03:56PM +0100, Hans de Goede wrote:
> acpi_get_object_info is intended for early probe usage and as such should
> not call any methods which may rely on OpRegions, but it used to also call
> _STA to get the status, which on some systems does rely on OpRegions, this
> behavior and the acpi_device_info.current_status member are being removed.
> 
> This commit prepares the acpiphp_ibm code for this by having it get the
> status itself using acpi_bus_get_status_handle. Note no error handling is
> necessary on any errors acpi_bus_get_status_handle leaves the value of
> the passed in current_status at its 0 initialization value.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Please add "()" after function names above, then

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume this will be merged by Rafael along with the rest of the series.

It would be nice to fix the run-on sentences in the changelog as well.

> ---
>  drivers/pci/hotplug/acpiphp_ibm.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
> index 984c7e8cec5a..8472c4a27f70 100644
> --- a/drivers/pci/hotplug/acpiphp_ibm.c
> +++ b/drivers/pci/hotplug/acpiphp_ibm.c
> @@ -399,6 +399,7 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
>  		u32 lvl, void *context, void **rv)
>  {
>  	acpi_handle *phandle = (acpi_handle *)context;
> +	unsigned long long current_status = 0;
>  	acpi_status status;
>  	struct acpi_device_info *info;
>  	int retval = 0;
> @@ -410,7 +411,9 @@ static acpi_status __init ibm_find_acpi_device(acpi_handle handle,
>  		return retval;
>  	}
>  
> -	if (info->current_status && (info->valid & ACPI_VALID_HID) &&
> +	acpi_bus_get_status_handle(handle, &current_status);
> +
> +	if (current_status && (info->valid & ACPI_VALID_HID) &&
>  			(!strcmp(info->hardware_id.string, IBM_HARDWARE_ID1) ||
>  			 !strcmp(info->hardware_id.string, IBM_HARDWARE_ID2))) {
>  		pr_debug("found hardware: %s, handle: %p\n",
> -- 
> 2.14.3
> 
