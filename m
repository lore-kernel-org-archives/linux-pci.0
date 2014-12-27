Return-Path: <linux-acpi-owner@vger.kernel.org>
Message-ID: <1419711478.20894.5.camel@perches.com>
Subject: Re: [Intel-gfx] 3.19-rc1 errors when opening LID
From: Joe Perches <joe@perches.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
	nick <xerofoify@gmail.com>,
	Daniel Vetter <daniel.vetter@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	David Airlie <airlied@linux.ie>,
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Sat, 27 Dec 2014 12:17:58 -0800
In-Reply-To: <1818900.MY9q0yfluC@vostro.rjw.lan>
References: <201412241951.48652@pali> <549C4278.5080707@gmail.com>
	 <201412270919.49540@pali> <1818900.MY9q0yfluC@vostro.rjw.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Sat, 2014-12-27 at 21:22 +0100, Rafael J. Wysocki wrote:
[]
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -589,7 +589,8 @@ static inline u32 acpi_target_system_sta
>  
>  static inline bool acpi_device_power_manageable(struct acpi_device *adev)
>  {
> -	return adev->flags.power_manageable;
> +	return adev->flags.power_manageable
> +		&& (adev->status.present || adev->status.functional);

Most code in the kernel has these logical
continuations at the end of the previous line.

> +++ linux-pm/drivers/acpi/device_pm.c
[]
> @@ -361,7 +362,7 @@ bool acpi_bus_power_manageable(acpi_hand
>  	int result;
>  
>  	result = acpi_bus_get_device(handle, &device);
> -	return result ? false : device->flags.power_manageable;
> +	return result ? false : acpi_device_power_manageable(device);

This might read better as:

	if (acpi_bus_get_device(handle, &device))
		return false;

	return acpi_device_power_manageable(device);


