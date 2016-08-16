Return-Path: <andriy.shevchenko@linux.intel.com>
Return-Path: <andriy.shevchenko@linux.intel.com>
Message-ID: <1471346604.4887.120.camel@linux.intel.com>
Subject: Re: ACPI device using sub-resource of PCI device
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mika Westerberg <mika.westerberg@linux.intel.com>, Aaron Durbin
	 <adurbin@google.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas
 <helgaas@kernel.org>,  "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel
 Maling List <linux-acpi@vger.kernel.org>,  Linux PCI
 <linux-pci@vger.kernel.org>
Date: Tue, 16 Aug 2016 14:23:24 +0300
In-Reply-To: <20160816091502.GB1751@lahna.fi.intel.com>
References: 
	<CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
	 <3103060.86QBTjSLk3@vostro.rjw.lan>
	 <CAE2855sB73=1gznGFonGver_FtaCdoAa4-8Bz8sAXCXuBZvxfg@mail.gmail.com>
	 <3861743.KWBechkp08@vostro.rjw.lan>
	 <CAE2855sk2M_77W7dPUb-G43zaDgiNvH2fwpEUvZKOZCBZ-1UpQ@mail.gmail.com>
	 <CAE2855uNKxtSJSGdF9T7LcGV+F6HzqJhmgDEdgAEwrY=HjPnrQ@mail.gmail.com>
	 <20160816091502.GB1751@lahna.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2016-08-16 at 12:15 +0300, Mika Westerberg wrote:
> On Fri, Aug 12, 2016 at 11:45:30AM -0500, Aaron Durbin wrote:
> > 
> > Was anyone able to take a look into a solution for the current
> > problem?  Again, please feel free to ask if anyone would like help
> > testing potential solutions.
> 
> Below is one proposal for fixing the issue. It is just a prototype and
> I'm not sure if it takes everything needed into account. Would you be
> able to try it out and let us know if it works for you?

Just style comments below.

> --- a/drivers/acpi/acpi_platform.c
> +++ b/drivers/acpi/acpi_platform.c
> @@ -18,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/platform_device.h>
> +#include <linux/pci.h>

I would keep trying to arrange them in alphabetical order, i.e. put
before platform_device.h.

>  
>  #include "internal.h"
>  
> @@ -30,6 +31,35 @@ static const struct acpi_device_id
> forbidden_id_list[] = {
>  	{"", 0},
>  };
>  
> +static struct resource *acpi_find_parent_resource(struct acpi_device
> *adev,
> +						  struct resource
> *res)
> +{
> +	struct device *parent;
> +
> +	parent = acpi_get_first_physical_node(adev->parent);
> +	if (!parent)
> +		return NULL;
> +
> +#if IS_ENABLED(CONFIG_PCI)

Oh.

> +	if (dev_is_pci(parent)) {

Has a stub.

> +		struct pci_dev *pdev = to_pci_dev(parent);

Not needed an ugly define.

> +
> +		if (!pci_is_bridge(pdev)) {

Ditto.

> +			int i;
> +
> +			for (i = 0; i < DEVICE_COUNT_RESOURCE; i++) {

Ditto.

> +				struct resource *r = &pdev-
> >resource[i];
> +
> +				if (r->start && resource_contains(r,
> res))
> +					return r;
> +			}
> +		}
> +	}
> +#endif
> +
> +	return NULL;
> +}
> +


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
