Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <54D3404D.90404@citrix.com>
Date: Thu, 5 Feb 2015 10:05:01 +0000
From: David Vrabel <david.vrabel@citrix.com>
MIME-Version: 1.0
To: Jiang Liu <jiang.liu@linux.intel.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Lv Zheng <lv.zheng@intel.com>,
	Tony Luck <tony.luck@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robert Moore <robert.moore@intel.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	David Vrabel <david.vrabel@citrix.com>
CC: <linux-ia64@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<xen-devel@lists.xenproject.org>, <devel@linuxdriverproject.org>,
	<devel@acpica.org>
Subject: Re: [Xen-devel] [Patch v4 01/23] ACPICA: Resources: Provide common
 part for struct acpi_resource_address structures.
References: <1423115089-12904-1-git-send-email-jiang.liu@linux.intel.com> <1423115089-12904-2-git-send-email-jiang.liu@linux.intel.com>
In-Reply-To: <1423115089-12904-2-git-send-email-jiang.liu@linux.intel.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/02/15 05:44, Jiang Liu wrote:
> 
> --- a/drivers/xen/xen-acpi-memhotplug.c
> +++ b/drivers/xen/xen-acpi-memhotplug.c
> @@ -117,8 +117,8 @@ acpi_memory_get_resource(struct acpi_resource *resource, void *context)
>  	list_for_each_entry(info, &mem_device->res_list, list) {
>  		if ((info->caching == address64.info.mem.caching) &&
>  		    (info->write_protect == address64.info.mem.write_protect) &&
> -		    (info->start_addr + info->length == address64.minimum)) {
> -			info->length += address64.address_length;
> +		    (info->start_addr + info->length == address64.address.minimum)) {
> +			info->length += address64.address.address_length;
>  			return AE_OK;
>  		}
>  	}
> @@ -130,8 +130,8 @@ acpi_memory_get_resource(struct acpi_resource *resource, void *context)
>  	INIT_LIST_HEAD(&new->list);
>  	new->caching = address64.info.mem.caching;
>  	new->write_protect = address64.info.mem.write_protect;
> -	new->start_addr = address64.minimum;
> -	new->length = address64.address_length;
> +	new->start_addr = address64.address.minimum;
> +	new->length = address64.address.address_length;
>  	list_add_tail(&new->list, &mem_device->res_list);
>  
>  	return AE_OK;

Xen parts:

Acked-by: David Vrabel <david.vrabel@citrix.com>

David
