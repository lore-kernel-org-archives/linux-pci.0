Return-Path: <linux-kernel-owner@vger.kernel.org>
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V4 2/5] ACPI / bus: Introduce acpi_get_match_data() function
Date: Fri, 01 Dec 2017 14:52:53 +0100
Message-ID: <2290830.PQXLc2Sk7k@aspire.rjw.lan>
In-Reply-To: <1512096776-22883-3-git-send-email-okaya@codeaurora.org>
References: <1512096776-22883-1-git-send-email-okaya@codeaurora.org> <1512096776-22883-3-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Friday, December 1, 2017 3:52:53 AM CET Sinan Kaya wrote:
> OF has of_device_get_match_data() function to extract driver specific data
> structure. Add a similar function for ACPI.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/bus.c   | 12 ++++++++++++
>  include/linux/acpi.h |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d0979e..b271eb1 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -785,6 +785,18 @@ const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>  }
>  EXPORT_SYMBOL_GPL(acpi_match_device);
>  
> +void *acpi_get_match_data(const struct device *dev)
> +{
> +	const struct acpi_device_id *match;
> +
> +	match = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!match)
> +		return NULL;
> +
> +	return (void *)match->driver_data;
> +}
> +EXPORT_SYMBOL_GPL(acpi_get_match_data);
> +
>  int acpi_match_device_ids(struct acpi_device *device,
>  			  const struct acpi_device_id *ids)
>  {
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 502af53..a927260 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -584,6 +584,7 @@ extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *),
>  const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
>  					       const struct device *dev);
>  
> +void *acpi_get_match_data(const struct device *dev);
>  extern bool acpi_driver_match_device(struct device *dev,
>  				     const struct device_driver *drv);
>  int acpi_device_uevent_modalias(struct device *, struct kobj_uevent_env *);
> @@ -755,6 +756,11 @@ static inline const struct acpi_device_id *acpi_match_device(
>  	return NULL;
>  }
>  
> +static inline void *acpi_get_match_data(const struct device *dev)
> +{
> +	return NULL;
> +}
> +
>  static inline bool acpi_driver_match_device(struct device *dev,
>  					    const struct device_driver *drv)
>  {
> 
