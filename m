Return-Path: <linux-acpi-owner@vger.kernel.org>
Date: Thu, 15 Jan 2015 22:30:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jiang Liu <jiang.liu@linux.intel.com>
cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Yinghai Lu <yinghai@kernel.org>,
	Borislav Petkov <bp@alien8.de>, Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: Re: [RFC Patch 16/19] ACPI: Introduce helper function
 acpi_dev_filter_resource_type()
In-Reply-To: <1420684386-5975-17-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <alpine.DEB.2.11.1501152228560.5526@nanos>
References: <1420684386-5975-1-git-send-email-jiang.liu@linux.intel.com> <1420684386-5975-17-git-send-email-jiang.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, 8 Jan 2015, Jiang Liu wrote:

> Introduce helper function acpi_dev_filter_resource_type(), which may
> be used by acpi_dev_get_resources() to filer out resource based on
> resource type.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/acpi/resource.c |   54 +++++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/acpi.h    |    1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 54204ac94f8e..8ea7c26d6915 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -570,3 +570,57 @@ int acpi_dev_get_resources(struct acpi_device *adev, struct list_head *list,
>  	return c.count;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_get_resources);
> +
> +/**
> + * acpi_dev_filter_resource_type - Filter ACPI resource according to resource
> + *				   types
> + * @ares: Input ACPI resource object.
> + * @arg: Valid resource types of IORESOURCE_XXX
> + *
> + * This is a hepler function to support acpi_dev_get_resources(), which filters
> + * ACPI resource objects according to resource types.
> + */
> +int acpi_dev_filter_resource_type(struct acpi_resource *ares, void *arg)

Why is the filter a void pointer instead of an simple unsigned long?
That does not make any sense as you convert it to unsigned long right away:

> +{
> +	unsigned long type = 0, types = (unsigned long)arg;

So this should be:

int acpi_dev_filter_resource_type(struct acpi_resource *ares, unsigned long type_mask)

or something like that.

Thanks,

	tglx
